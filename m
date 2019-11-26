Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6124C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7097320748
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/YUucEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7097320748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZXzu-0006V0-DJ
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 05:23:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXsH-0005e4-03
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXmy-0003TG-W6
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:09:45 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38917)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prashantbhole.linux@gmail.com>)
 id 1iZXmy-0003Sy-Qd
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:09:44 -0500
Received: by mail-pg1-x542.google.com with SMTP id b137so6441943pga.6
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 02:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pUc8XgU3PRUIYnmGD1sk4dmdkx2zuWhcKZo2RCjAbj4=;
 b=V/YUucEhcvTyJgZSWsi5RwLlFSOkklklct0nM4joSGWaIR7na/no+LPxPiWVwQxxt3
 MZTId0BfvRrcBB5cS/xNn6YkR/nR/a/oFs+qoKWNnr42ZGOZSgTJb1F9wGQ/O7rl4ool
 fqDK2tc6OlvGgzuoLOzoJUJQHilZeQPmXpSCsMF/iAGRQPq1estAj8ZW+DJ3zXLxs0I/
 Q9QpB8OHiq3d1Lt0nQ7YBRWLpuxJLuJe9KhDCvCcZTqb9EKaythXaA5hLTcRTjhHTcg0
 Zmy8SaIL9vFHoxTDHybOLMp6I58SLo01Hd5rnDgBZPghb4JF9K2no8TAUZxDYsM3NvAV
 RVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pUc8XgU3PRUIYnmGD1sk4dmdkx2zuWhcKZo2RCjAbj4=;
 b=jMNcuoOQnCmYdov24pN7V2oJ46oqbX41e4TM1RCFcYmeR/tqYtcV5fKjCN4TMVAEbB
 aOcg4GJWdvp5AvOYaeunmzSfKJJk2VXu+0rfrmoVHKj36ktNUNFvoe8voyWNMtlG2z9q
 PFGdEyMhOAC1V5ph0smtj4blFdgpjG1KR4mLdb0ntyI/TuLBezQRPf+VydJL6hgzdZZ4
 yPKXFrIZCeGts8TIU2O0rnCD7E8wAugg1tVeuxAeYTFt1HfIsKfdrnXYYcfUThVq4X/+
 IhHw7hVsfH7+QQ1C5Gr66BfrHV25lF2qbJk+f/VeJDaIyjz6VYPPMM5GanTCxtJUE00n
 ysyA==
X-Gm-Message-State: APjAAAW7DUpe16K0jZIlpeTGOOzjwKOS+B+GMof4j4az0QnJBM03e9ru
 gtRnkfvyEWPyoDNzZJ+EBOs=
X-Google-Smtp-Source: APXvYqyXGcO2rx/7HpN4RNXvapDE7gQDbHTJMsH1+iqGmKXZYJEaN21RZ6AzcvVf5dFk+Y1nNp9XGQ==
X-Received: by 2002:a63:6b87:: with SMTP id
 g129mr29081453pgc.438.1574762984061; 
 Tue, 26 Nov 2019 02:09:44 -0800 (PST)
Received: from localhost.localdomain ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id s24sm11848485pfh.108.2019.11.26.02.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 02:09:43 -0800 (PST)
From: Prashant Bhole <prashantbhole.linux@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [RFC net-next 16/18] bpf: export function __bpf_map_get
Date: Tue, 26 Nov 2019 19:07:42 +0900
Message-Id: <20191126100744.5083-17-prashantbhole.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Song Liu <songliubraving@fb.com>,
 Jakub Kicinski <jakub.kicinski@netronome.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, qemu-devel@nongnu.org,
 Prashant Bhole <prashantbhole.linux@gmail.com>, kvm@vger.kernel.org,
 Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
 Martin KaFai Lau <kafai@fb.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Wang <jasowang@redhat.com>

__bpf_map_get is necessary to get verify whether an fd corresponds
to a bpf map, without adding a refcount on that map. After exporting
it can be used by a kernel module.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Prashant Bhole <prashantbhole.linux@gmail.com>
---
 kernel/bpf/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e3461ec59570..e524ab1e7c64 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -737,6 +737,7 @@ struct bpf_map *__bpf_map_get(struct fd f)
 
 	return f.file->private_data;
 }
+EXPORT_SYMBOL(__bpf_map_get);
 
 void bpf_map_inc(struct bpf_map *map)
 {
-- 
2.20.1


