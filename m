Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E94C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 12:53:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B976218B8
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 12:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B976218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqGlo-0002TS-LH
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 08:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56641)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yang.zhong@intel.com>) id 1hqGle-000250-Iu
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 08:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yang.zhong@intel.com>) id 1hqGlZ-00052X-Mh
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 08:53:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:11067)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yang.zhong@intel.com>)
 id 1hqGlZ-0004rq-2u
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 08:53:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Jul 2019 05:53:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,302,1559545200"; d="scan'208";a="163836345"
Received: from yangzhon-virtual.bj.intel.com (HELO localhost) ([10.238.145.78])
 by orsmga008.jf.intel.com with ESMTP; 24 Jul 2019 05:52:58 -0700
Date: Wed, 24 Jul 2019 20:47:45 +0800
From: Yang Zhong <yang.zhong@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190724124745.GB3369@yangzhon-Virtual>
References: <7A85DF989CAE8F42902CF7B31A7D94A1487D6D13@shsmsx102.ccr.corp.intel.com>
 <93e3762a-d906-6d6b-9a5f-7497af188f94@redhat.com>
 <20190724065513.GA3369@yangzhon-Virtual>
 <c158d398-8049-7e9c-d3be-573ff5b032d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c158d398-8049-7e9c-d3be-573ff5b032d3@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
Subject: Re: [Qemu-devel] The WCE issue in guest when i enable WCE in Qemu
 side.
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
Cc: yang.zhong@intel.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 24, 2019 at 10:57:30AM +0200, Paolo Bonzini wrote:
> On 24/07/19 08:55, Yang Zhong wrote:
> > 
> > The SPDK code i am using is latest version, So, i feel we should
> > enable WCE feature in SPDK side by default. thanks for your help!
> 
> Note that enabling the CONFIG_WCE feature has some consequences.
> According to the spec:
> 
> - if the VIRTIO_BLK_F_CONFIG_WCE feature was negotiated and the
> writeback field in configuration space was 0 all the time between the
> submission of the write and its completion, the device MUST ensure that
> stable writes are committed to persistent storage before reporting
> completion of the write.  This means using FUA writes or something like that
> 
> - the device MUST offset VIRTIO_BLK_F_FLUSH if they offer
> VIRTIO_BLK_F_CONFIG_WCE
> 
> - if VIRTIO_BLK_F_CONFIG_WCE is negotiated but VIRTIO_BLK_F_FLUSH is
> not, the device MUST initialize writeback to 0
>
  Paolo, thanks for your reminder, these info are very helpful to me:),
  thanks, Yang.

> Paolo

