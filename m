Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7604C4740A
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE32222C5
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE32222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGs9B-0007Uo-Es
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 18:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iGs4k-0004ey-4S
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iGs4f-0003us-Gn
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:58:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52658)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iGs4d-0003sj-E6
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:58:48 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 01B7083F3F
 for <qemu-devel@nongnu.org>; Sat,  5 Oct 2019 21:58:44 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id x77so10632006qka.11
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 14:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Asma7aOsUO5IaZvjQCTA17/p6jaQsKt2LdKUPKs3Sdk=;
 b=BcRJHF8gZgNyOx+a/ZXICn0tBBPTQXmV0qX0CKLWQ/2YEcx3pD7Q9t2oqnd422Jg+j
 JPAi+9U2z9bhYL1llsyWBwUTuPVE6tczy9V8ltCT47GDXSy8AjrggmbCZ5cvp7O/XxJL
 PSA9rL2jt4CbkcZpR7pLDW03bDXMoA8gFfIzSWd7FxRs+ePPPNvNl6zNxSlpPyfX8YVc
 +ow7NV1c2Hv6ud1Jfl46saq4PeWJZk8ZbRgEhg9+oDP6MiPu36JEc5dkJsdpVDzNfgOm
 Fis6ppDDwZneGxEcp6umrJLXPrkknW4kMFBtohGKwUU+c+1bWlM6NC6/tduHjxiq9+na
 Mh8w==
X-Gm-Message-State: APjAAAW268DXecMEULGjE9FL/GBdEyY967bvmNnqBqN3d5JgAB9FTuGk
 AL2xhrLq1gFtqQW6At9RV661tlUEMtIXtFxJnDx3QqYWyVRgyoreRbxg7kwrTRqK0x41SOSuNv7
 ekKiJNyg3gM3QIb8=
X-Received: by 2002:a37:c405:: with SMTP id d5mr17288307qki.309.1570312722777; 
 Sat, 05 Oct 2019 14:58:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx2SMak6B0haZ4fZn1W1gvkVNRI+e5Df5ejac3pahLfqOVdn+SysHRzeUZkvZbhlHlpqDZFXQ==
X-Received: by 2002:a37:c405:: with SMTP id d5mr17288288qki.309.1570312722575; 
 Sat, 05 Oct 2019 14:58:42 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 k17sm8033678qtk.7.2019.10.05.14.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 14:58:41 -0700 (PDT)
Date: Sat, 5 Oct 2019 17:58:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/19] vhost-user: save features if the char dev is closed
Message-ID: <20190924162044.11414-1-amorenoz@redhat.com>
References: <20191005215508.28754-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20191005215508.28754-1-mst@redhat.com>
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
 qemu-stable@nongnu.org, ddstreet@canonical.com, Pei Zhang <pezhang@redhat.com>,
 Adrian Moreno <amorenoz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20191005215837.opz_UtxFnWRk26cqS5wozRLJCzU8LTAr5PCb6Jgqtv0@z>

From: Adrian Moreno <amorenoz@redhat.com>

That way the state can be correctly restored when the device is opened
again. This might happen if the backend is restarted.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1738768
Reported-by: Pei Zhang <pezhang@redhat.com>
Fixes: 6ab79a20af3a ("do not call vhost_net_cleanup() on running net from char user event")
Cc: ddstreet@canonical.com
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
Message-Id: <20190924162044.11414-1-amorenoz@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-user.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index 51921de443..014199d600 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -235,6 +235,10 @@ static void chr_closed_bh(void *opaque)
 
     s = DO_UPCAST(NetVhostUserState, nc, ncs[0]);
 
+    if (s->vhost_net) {
+        s->acked_features = vhost_net_get_acked_features(s->vhost_net);
+    }
+
     qmp_set_link(name, false, &err);
 
     qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, net_vhost_user_event,
-- 
MST


