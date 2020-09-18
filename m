Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB9EC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 193702076B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghaU170U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193702076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJJUD-0001JR-48
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJJ89-0005OG-Mi
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:21:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27109)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJJ83-0005m2-Ot
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600446040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i2TiZHENdC+GX0K3cObev7mdt5+URJTuRvO6etG6pyY=;
 b=ghaU170Uw6p+2d7e5dxs16eaAv2rBUIUEQzRDZsW8VMRssGTv44ET6+NXKnbYamaVdn1eS
 Vl/3MjZfcNea92Wrv8UQmQh0hHJ5RmakBRl25Eo4YBfTB/CHBM0g1AQ/beWPnad3tlZQe4
 mCkka3J050HJC4goBaVIfXlvwlk2DfE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-gLdt7khWNymnJM5iwNrzfQ-1; Fri, 18 Sep 2020 12:20:36 -0400
X-MC-Unique: gLdt7khWNymnJM5iwNrzfQ-1
Received: by mail-wm1-f70.google.com with SMTP id y18so1625125wma.4
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 09:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=i2TiZHENdC+GX0K3cObev7mdt5+URJTuRvO6etG6pyY=;
 b=n+a2mtOF7cSeRX/CReSvdrCZsasPp2D6NIDW4i327IWmnKQ1cpoa96KqVRQgz9kv2M
 pit7uc2k2ILTBNwTui6STinDT7tFsTT9ieypGJZbCJuKcrknD4VOPVk7jURNJtp0Es6j
 U7MXgxzp4eo77yxyokvQz0gSOQXZ3/SSNnacgLtcDfbh32sPkg0ba7aDifyp1I5LktE/
 oleFjwUXWg938iIgUdDx2cCCQLfwkolJgvy4qa+iaA74behrMLp8T6MLkg07u4G4EIn+
 /qZ3mSBCVWpgOFZDgn+1Y/CuknyRZ9yVOwiaLn4BJ83D1usZtKUF57iX2A3aJLjp5Auz
 sVkQ==
X-Gm-Message-State: AOAM532SsyhL8ea9Op+B9/HBBMtuzTa1leWmeQiFNilZ9ZVUDmxgJRFF
 k28WcMs47K0VHp4vTK+yC5g7pj5yhCZT1g/FYqH+c4Nbv9gA0XnZe3U00F6qj2oNZSssnfe9orJ
 FERzeDVpU6KB3Lx0=
X-Received: by 2002:adf:f082:: with SMTP id n2mr38107375wro.35.1600446033579; 
 Fri, 18 Sep 2020 09:20:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydDGfWgXaZOGcplo5mq0ekzKO+rpCtFqJJhffC1f+xqP7yF7KGkDUHJ88vT3inQBcAnbWZBg==
X-Received: by 2002:adf:f082:: with SMTP id n2mr38107357wro.35.1600446033426; 
 Fri, 18 Sep 2020 09:20:33 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id m10sm5575903wmi.9.2020.09.18.09.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 09:20:32 -0700 (PDT)
Date: Fri, 18 Sep 2020 12:20:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 12/15] tests/qtest/vhost-user-test: enable the reconnect
 tests
Message-ID: <20200918161836.318893-13-mst@redhat.com>
References: <20200918161836.318893-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918161836.318893-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Dima Stepanov <dimastep@yandex-team.ru>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dima Stepanov <dimastep@yandex-team.ru>

For now a QTEST_VHOST_USER_FIXME environment variable is used to
separate reconnect tests for the vhost-user-net device. Looks like the
reconnect functionality is pretty stable, so this separation is
deprecated.
Remove it and enable these tests for the default run.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
Message-Id: <9fee5b17c7940f9126ba7cc014b09106c98118db.1599813294.git.dimastep@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/vhost-user-test.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index 4b715d385e..4b9631249d 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -1140,20 +1140,17 @@ static void register_vhost_user_test(void)
                  "virtio-net",
                  test_migrate, &opts);
 
-    /* keeps failing on build-system since Aug 15 2017 */
-    if (getenv("QTEST_VHOST_USER_FIXME")) {
-        opts.before = vhost_user_test_setup_reconnect;
-        qos_add_test("vhost-user/reconnect", "virtio-net",
-                     test_reconnect, &opts);
+    opts.before = vhost_user_test_setup_reconnect;
+    qos_add_test("vhost-user/reconnect", "virtio-net",
+                 test_reconnect, &opts);
 
-        opts.before = vhost_user_test_setup_connect_fail;
-        qos_add_test("vhost-user/connect-fail", "virtio-net",
-                     test_vhost_user_started, &opts);
+    opts.before = vhost_user_test_setup_connect_fail;
+    qos_add_test("vhost-user/connect-fail", "virtio-net",
+                 test_vhost_user_started, &opts);
 
-        opts.before = vhost_user_test_setup_flags_mismatch;
-        qos_add_test("vhost-user/flags-mismatch", "virtio-net",
-                     test_vhost_user_started, &opts);
-    }
+    opts.before = vhost_user_test_setup_flags_mismatch;
+    qos_add_test("vhost-user/flags-mismatch", "virtio-net",
+                 test_vhost_user_started, &opts);
 
     opts.before = vhost_user_test_setup_multiqueue;
     opts.edge.extra_device_opts = "mq=on";
-- 
MST


