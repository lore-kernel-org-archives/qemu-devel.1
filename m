Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA09C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD30206E7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="unYkWqbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD30206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCNQV-0003zu-Tf
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 08:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jandryuk@gmail.com>) id 1jCNNz-0000Md-2v
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jandryuk@gmail.com>) id 1jCNNy-000728-5J
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:56:26 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:33713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1jCNNy-00071v-1W
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:56:26 -0400
Received: by mail-qk1-x741.google.com with SMTP id p62so5938039qkb.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 05:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UG4m6nBY/x3HnWJceuhcnmoPek0jkN3T0AxBQPCCNJM=;
 b=unYkWqbGENx7v41jlgwEIRmjv9vnQwnTcK4ladC9SrgfjhuL+j+Kslv1n5JihcBJts
 OWXPPFF8F503nlDUMLxewYMaxDE58Af/bsBA0WO3OiOKPnK2KJ4lso6aIN/jkp9ZvzJe
 Fruca1m6xTk7BTw0wKqvxPx4ZNo+VNIFHdE0n+JN8DVq2+mG1lh9xmMTBlMSXY3qOfwB
 LaD5PHvi+rjv3oB8hA+N53s/yE9ib+34WGLwMLa7CNEbqexwxoGwBYVvcktm2EDptYTM
 hPkKT++zzlJW1JCmrXU2+qeQ2uYzQOnTQg/jadnz+594SVaAar4KTRw17GjMny4+5zz8
 PW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UG4m6nBY/x3HnWJceuhcnmoPek0jkN3T0AxBQPCCNJM=;
 b=uFcT1/fu1Eel9gxVJQOOsK+fC75ze+7ag4oAFa8NUWGWpHBg/mnK1KlhT+y3MiT/i6
 YYyZbJ+RmvXXwycFKcHZJSNUtnsanvSNge4OMz1CM9PVznw4GzJcnDnCz88SPY0UCmgU
 L0s+/HqANIWJirFuV2qQEoAUjUZ0xqcSRxQ5L7DiOQnbUlz9Xn0L+1i5Lfn9PjDyGO0v
 oxvA/d5nTDniKz8r/WHlPdew8WHvoWB9+bZ3wAs4xJ+siFXVbkMwdP99W40hg6tw4Vgf
 0OtopSgZJSzFVQZpscaeiiZrmPdhgBTkNnZGo9RaIS6Qi6naGwcn7Ce7yOGyDKTpcszt
 CIyg==
X-Gm-Message-State: ANhLgQ1kiRYhDxTu1+qh/2dcd+kl+Z3F2eSpDMq4cloAF6gmGuciGC0X
 fa4sn2tIzGLsMiHyO6QhByE=
X-Google-Smtp-Source: ADFU+vtna1WHnqmIguikH2v/QI7VNUzznH+3AWOmsv6ISJAYhfhxKuYj/v4swd8HKvCgj4+GP/AOAQ==
X-Received: by 2002:a05:620a:1210:: with SMTP id
 u16mr7511441qkj.493.1584017785554; 
 Thu, 12 Mar 2020 05:56:25 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:ba27:ebff:fee8:ce27])
 by smtp.gmail.com with ESMTPSA id
 u3sm8001236qkc.4.2020.03.12.05.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 05:56:24 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 3/4] usb-serial: Increase receive buffer to 496
Date: Thu, 12 Mar 2020 08:55:22 -0400
Message-Id: <20200312125524.7812-4-jandryuk@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200312125524.7812-1-jandryuk@gmail.com>
References: <20200312125524.7812-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: qemu-devel@nongnu.org, Jason Andryuk <jandryuk@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A FTDI USB adapter on an xHCI controller can send 512 byte USB packets.
These are 8 * ( 2 bytes header + 62 bytes data).  A 384 byte receive
buffer is insufficient to fill a 512 byte packet, so bump the receive
size to 496 ( 512 - 2 * 8 ).

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 hw/usb/dev-serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 96b6c34202..ef33bcd127 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -29,7 +29,7 @@ do { printf("usb-serial: " fmt , ## __VA_ARGS__); } while (0)
 #define DPRINTF(fmt, ...) do {} while(0)
 #endif
 
-#define RECV_BUF 384
+#define RECV_BUF (512 - (2 * 8))
 
 /* Commands */
 #define FTDI_RESET		0
-- 
2.24.1


