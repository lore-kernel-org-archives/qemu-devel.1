Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB239C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 01:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1084206EB
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 01:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1084206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnuIX-0001Va-TY
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 21:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jnuH1-0000Ep-L3
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 21:32:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:58215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jnuGz-0002a3-Uo
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 21:32:23 -0400
IronPort-SDR: nKoUSOM9ofhw6yPCKt39dV8rZX9mbHrDeLVyxZT/z3piRvXkwA4LldgwfH5wouSjK/2QA9WvwF
 K9L5C3hv04BQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="144319744"
X-IronPort-AV: E=Sophos;i="5.75,273,1589266800"; d="scan'208";a="144319744"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2020 18:32:15 -0700
IronPort-SDR: rLJ+ITA6vmTLSKuaxhDYCLDvWvbmE3Kv9BG7xsl6nDH8Bv3xN5qP/tBn4Swy9m5Uz3ThMQ7ZPc
 M6PTN1rEIwfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,273,1589266800"; d="scan'208";a="301458060"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by fmsmga004.fm.intel.com with ESMTP; 23 Jun 2020 18:32:14 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V2 2/2] qemu-options.hx: Clean up and fix typo for colo-compare
Date: Wed, 24 Jun 2020 09:20:42 +0800
Message-Id: <20200624012042.29355-3-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624012042.29355-1-chen.zhang@intel.com>
References: <20200624012042.29355-1-chen.zhang@intel.com>
Received-SPF: pass client-ip=134.134.136.65; envelope-from=chen.zhang@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 21:32:13
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, FROM_ADDR_WS=1,
 FROM_WSP_TRAIL=1, HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Zhang Chen <chen.zhang@intel.com>, qemu-dev <qemu-devel@nongnu.org>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

Fix some typo and optimized some descriptions.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 qemu-options.hx | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 3ee19a4b0d..aa7ffb34db 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4640,24 +4640,24 @@ SRST
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
2.17.1


