Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2265CC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 09:26:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8FB621670
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 09:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FB621670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5RYW-0000FM-6N
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 05:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tiwei.bie@intel.com>) id 1i5RXc-0008Ce-B0
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 05:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tiwei.bie@intel.com>) id 1i5RXa-0004pB-P8
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 05:25:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:12100)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1i5RXa-0004nP-Gs
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 05:25:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Sep 2019 02:25:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,465,1559545200"; d="scan'208";a="383403513"
Received: from dpdk-virtio-tbie-2.sh.intel.com (HELO ___) ([10.67.104.71])
 by fmsmga006.fm.intel.com with ESMTP; 04 Sep 2019 02:25:22 -0700
Date: Wed, 4 Sep 2019 17:22:55 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20190904092254.GA15001@___>
References: <20190904065021.1360-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190904065021.1360-1-johannes@sipsolutions.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: introduce and use
 vu_has_protocol_feature()
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Johannes Berg <johannes.berg@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 04, 2019 at 09:50:21AM +0300, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This simplifies the various has_feature() checks, we already
> have vu_has_feature() but it checks features, not protocol
> features.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)


If this helps:
Reviewed-by: Tiwei Bie <tiwei.bie@intel.com>

Thanks!
Tiwei

