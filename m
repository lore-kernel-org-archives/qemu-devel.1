Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9832BC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DDF120657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JylMIGuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDF120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvhtN-0007mA-MW
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 09:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jvhr2-000380-Lf
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:53:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33687
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jvhr1-0005MN-0K
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594821226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=Lq9mQPyQwbSn+iqpXBcaFyj2QHswrHoP5SMMuUcrpeY=;
 b=JylMIGuoIMYzbdfUx01QKCFkdV/bs5jtMQsXeniEuFQn8ZWmiCu5Ay4XZLMY0IanoLCAgs
 JmR7DSq+eo4rm/spP6gSN8wBkLmmZh37UUQhY0Df9bsBnYVpguHR2yOgI3Wfc5B+q1mkoM
 nVf08s/g3mvzOLgSuVcQ1QYPWWBmxxA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-yLVPSY96OGyzBOuIFvmulw-1; Wed, 15 Jul 2020 09:53:42 -0400
X-MC-Unique: yLVPSY96OGyzBOuIFvmulw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DCF880BCAD;
 Wed, 15 Jul 2020 13:53:41 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-28.pek2.redhat.com
 [10.72.12.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63C2E5C57D;
 Wed, 15 Jul 2020 13:53:38 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 4/7] qemu-options.hx: Clean up and fix typo for colo-compare
Date: Wed, 15 Jul 2020 21:53:18 +0800
Message-Id: <1594821201-3708-5-git-send-email-jasowang@redhat.com>
In-Reply-To: <1594821201-3708-1-git-send-email-jasowang@redhat.com>
References: <1594821201-3708-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

Fix some typo and optimized some descriptions.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 qemu-options.hx | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 310885c..65147ad 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4696,24 +4696,24 @@ SRST
         tools such as tcpdump or Wireshark.
 
     ``-object colo-compare,id=id,primary_in=chardevid,secondary_in=chardevid,outdev=chardevid,iothread=id[,vnet_hdr_support][,notify_dev=id][,compare_timeout=@var{ms}][,expired_scan_cycle=@var{ms}][,max_queue_size=@var{size}]``
-        Colo-compare gets packet from primary\_inchardevid and
-        secondary\_inchardevid, than compare primary packet with
-        secondary packet. If the packets are same, we will output
-        primary packet to outdevchardevid, else we will notify
-        colo-frame do checkpoint and send primary packet to
-        outdevchardevid. In order to improve efficiency, we need to put
-        the task of comparison in another thread. If it has the
-        vnet\_hdr\_support flag, colo compare will send/recv packet with
-        vnet\_hdr\_len. Then compare\_timeout=@var{ms} determines the
-        maximum delay colo-compare wait for the packet.
-        The expired\_scan\_cycle=@var{ms} to set the period of scanning
-        expired primary node network packets. The max\_queue\_size=@var{size}
-        is to set the max compare queue size depend on user environment.
-        If you want to use Xen COLO, will need the notify\_dev to
+        Colo-compare gets packet from primary\_in chardevid and
+        secondary\_in, then compare whether the payload of primary packet
+        and secondary packet are the same. If same, it will output
+        primary packet to out\_dev, else it will notify COLO-framework to do
+        checkpoint and send primary packet to out\_dev. In order to
+        improve efficiency, we need to put the task of comparison in
+        another iothread. If it has the vnet\_hdr\_support flag,
+        colo compare will send/recv packet with vnet\_hdr\_len.
+        The compare\_timeout=@var{ms} determines the maximum time of the
+        colo-compare hold the packet. The expired\_scan\_cycle=@var{ms}
+        is to set the period of scanning expired primary node network packets.
+        The max\_queue\_size=@var{size} is to set the max compare queue
+        size depend on user environment.
+        If user want to use Xen COLO, need to add the notify\_dev to
         notify Xen colo-frame to do checkpoint.
 
-        we must use it with the help of filter-mirror and
-        filter-redirector.
+        COLO-compare must be used with the help of filter-mirror,
+        filter-redirector and filter-rewriter.
 
         ::
 
-- 
2.5.0


