Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA715CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:14:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB22220862
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB22220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPahB-0005Y6-J9
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 19:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iPaUU-0000p3-H5
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iPaUT-0004tG-F4
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:01:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50072)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iPaUS-0004qH-K0
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:01:29 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 150725AFE9
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 23:01:26 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id x186so261163qke.13
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 16:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NIZIUZQMHD8MQB75aibzuLlMw0b/3b/p/eZpRql+nWE=;
 b=ijRtHMUrTxZaF3yJYcr3lPG8YXay/0DNcP0k1+vfjr0PUnDSIVQOMW+NkqsoaSZSEM
 6pX4FBVGzhxmmLfkfrP7X+ExQoYtt/NKcRNWkC+/FE+udsSq0nUFSjFlDPdh5ojGzzh+
 Wmuxi4PjMBD4Qmz6WfhG8G/wY8qBDNbPvAfSINrGrwQLyD8m7eDSExYD3sYduLiLpJnZ
 otb4KaicTDJmTtbCRRhpssw36bndGpB/S5X+5a5o+XQnuKIPRw7YkunPhjMVlZAWxsFb
 au+dVQpqjY0EiZ4WJA71gdF/RkvP+U+uk5E7Zc39bdTFdSv9WfwszLezcu5257a0h+nn
 lLYQ==
X-Gm-Message-State: APjAAAVsXYa2GJd8If9th1WWxrOkq9TwVUvkoyHro4+SKfTo+xtnZ3ro
 EX+PgvyRIi0Yj5ZAX976db9iY2+TrFuZCFKHuMfgnY+m6XA5SnmaVjTjEsTUqq7yHx9wzhZkCTN
 GwN3rkZmnwUJd6nU=
X-Received: by 2002:a0c:fb06:: with SMTP id c6mr20324531qvp.249.1572390084808; 
 Tue, 29 Oct 2019 16:01:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxC6H2Qf4NmNRdcd8gqruKRp5YmZ2ttJ49a9YfOjoFugY3dZMfZ635m5NGqJxx7hqHjdZSqzQ==
X-Received: by 2002:a0c:fb06:: with SMTP id c6mr20324510qvp.249.1572390084599; 
 Tue, 29 Oct 2019 16:01:24 -0700 (PDT)
Received: from redhat.com (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id w131sm487444qka.85.2019.10.29.16.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 16:01:23 -0700 (PDT)
Date: Tue, 29 Oct 2019 19:01:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/14] virtio_net: use RCU_READ_LOCK_GUARD
Message-ID: <20191029225932.14585-14-mst@redhat.com>
References: <20191029225932.14585-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029225932.14585-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Use RCU_READ_LOCK_GUARD rather than the manual rcu_read_(un)lock call.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20191025103403.120616-3-dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 314f365e7c..97a5113f7e 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1490,12 +1490,9 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
 static ssize_t virtio_net_do_receive(NetClientState *nc, const uint8_t *buf,
                                   size_t size)
 {
-    ssize_t r;
+    RCU_READ_LOCK_GUARD();
 
-    rcu_read_lock();
-    r = virtio_net_receive_rcu(nc, buf, size);
-    rcu_read_unlock();
-    return r;
+    return virtio_net_receive_rcu(nc, buf, size);
 }
 
 static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,
-- 
MST


