Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841F0C2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 03:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E67020708
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 03:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E67020708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jN79W-0002G6-AN
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 23:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jN77k-0008HX-Ih
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 23:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1jN77j-0004ii-9w
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 23:48:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:21812)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1jN77j-0004c4-2i
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 23:48:03 -0400
IronPort-SDR: 6OhTH1+zAHU/s8VIHlNYEpWMrvY3nQ2bvDYhkzwTsNZV25IzalioGV79drotW0JQjBfFvjbcrK
 bTWOnzOLbSow==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2020 20:47:56 -0700
IronPort-SDR: Ye86VTGOXlF0h8x7lUd3o4oigxRU0K/Ar3mN/ChhX4bHEllVMRhVuqKpTWc6BnMcxmtXkHxbPl
 0omecEp+Ya0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,368,1580803200"; d="scan'208";a="276368264"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by fmsmga004.fm.intel.com with ESMTP; 10 Apr 2020 20:47:54 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>,
	qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH 2/2] qemu-options.hx: Clean up and fix typo for colo-compare
Date: Sat, 11 Apr 2020 11:38:24 +0800
Message-Id: <20200411033824.19389-3-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200411033824.19389-1-chen.zhang@intel.com>
References: <20200411033824.19389-1-chen.zhang@intel.com>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.126
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
Cc: Zhang Chen <chen.zhang@intel.com>, Zhang Chen <zhangckid@gmail.com>
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
index 107ff3e71b..84368f15be 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4616,24 +4616,24 @@ SRST
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


