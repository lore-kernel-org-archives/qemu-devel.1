Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BA5C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 02:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A57E20714
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 02:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A57E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkend-00052d-Jo
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 22:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <like.xu@linux.intel.com>)
 id 1jken5-0004Yu-8S
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 22:24:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:36335)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <like.xu@linux.intel.com>)
 id 1jken3-0003WB-96
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 22:24:02 -0400
IronPort-SDR: Xb0r+Lzf6SRtVv5w6wtnkqZ6kHGa0Z4jO8oaOs4ntAeait1XlTqatJQxyb6CoU72XwQuaeQgrA
 0nvrmQqgRuLQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2020 19:23:58 -0700
IronPort-SDR: nfsMJYilhEsxVnrYZD70PDe1rv/NNT9xr1iUQlwL79nMxK1HVCCRlQJNhSOznlI0xel1vnq431
 6sCZd6DGWbVQ==
X-IronPort-AV: E=Sophos;i="5.73,513,1583222400"; d="scan'208";a="449123185"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.255.31.41])
 ([10.255.31.41])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2020 19:23:57 -0700
Subject: Re: [PATCH 1/2] migration/colo: fix typo in the COLO Framework module
To: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20200614084510.7917-1-like.xu@linux.intel.com>
 <17a0016f32fb471fa57e4f0c21ecb19d@huawei.com>
From: Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <0d30a6ce-6641-dc82-10e5-cd748dbf104a@linux.intel.com>
Date: Mon, 15 Jun 2020 10:23:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <17a0016f32fb471fa57e4f0c21ecb19d@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=134.134.136.24;
 envelope-from=like.xu@linux.intel.com; helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/14 22:23:58
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/6/15 9:36, Zhanghailiang wrote:
> Hi Like,
> 
> Please check this patch, It seems that you didn't use git format-patch command to generate this patch,
> It is in wrong format.

I rebase the patch on the top commit of
7d3660e79830a069f1848bb4fa1cdf8f666424fb,
and hope it helps you.

> 
> Thanks,
> Hailiang

 From 15c19be9be07598d4264a4a84b85d4efa79bff9d Mon Sep 17 00:00:00 2001
From: Like Xu <like.xu@linux.intel.com>
Date: Mon, 15 Jun 2020 10:10:57 +0800
Subject: [PATCH 1/2] migration/colo: fix typo in the COLO Framework module

Cc: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
  docs/COLO-FT.txt | 8 ++++----
  migration/colo.c | 2 +-
  2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt
index c8e1740935..fdc0207cff 100644
--- a/docs/COLO-FT.txt
+++ b/docs/COLO-FT.txt
@@ -10,7 +10,7 @@ See the COPYING file in the top-level directory.
  This document gives an overview of COLO's design and how to use it.

  == Background ==
-Virtual machine (VM) replication is a well known technique for providing
+Virtual machine (VM) replication is a well-known technique for providing
  application-agnostic software-implemented hardware fault tolerance,
  also known as "non-stop service".

@@ -103,7 +103,7 @@ Primary side.

  COLO Proxy:
  Delivers packets to Primary and Secondary, and then compare the responses 
from
-both side. Then decide whether to start a checkpoint according to some rules.
+both sides. Then decide whether to start a checkpoint according to some rules.
  Please refer to docs/colo-proxy.txt for more information.

  Note:
@@ -146,12 +146,12 @@ in test procedure.

  == Test procedure ==
  Note: Here we are running both instances on the same host for testing,
-change the IP Addresses if you want to run it on two hosts. Initally
+change the IP Addresses if you want to run it on two hosts. Initially
  127.0.0.1 is the Primary Host and 127.0.0.2 is the Secondary Host.

  == Startup qemu ==
  1. Primary:
-Note: Initally, $imagefolder/primary.qcow2 needs to be copied to all hosts.
+Note: Initially, $imagefolder/primary.qcow2 needs to be copied to all hosts.
  You don't need to change any IP's here, because 0.0.0.0 listens on any
  interface. The chardev's with 127.0.0.1 IP's loopback to the local qemu
  instance.
diff --git a/migration/colo.c b/migration/colo.c
index ea7d1e9d4e..80788d46b5 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -632,7 +632,7 @@ out:
      /*
       * It is safe to unregister notifier after failover finished.
       * Besides, colo_delay_timer and colo_checkpoint_sem can't be
-     * released befor unregister notifier, or there will be use-after-free
+     * released before unregister notifier, or there will be use-after-free
       * error.
       */
      colo_compare_unregister_notifier(&packets_compare_notifier);
-- 
2.21.3



