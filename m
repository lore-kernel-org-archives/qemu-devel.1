Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBBAC49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A1C21479
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A1C21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7mCT-0005Fw-3g
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 15:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sean.j.christopherson@intel.com>) id 1i7m5Y-0005y4-0u
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sean.j.christopherson@intel.com>) id 1i7m5W-000594-Ew
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:46:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:45239)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sean.j.christopherson@intel.com>)
 id 1i7m5W-00056C-7K
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:46:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Sep 2019 12:45:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,490,1559545200"; d="scan'208";a="189448727"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.41])
 by orsmga006.jf.intel.com with ESMTP; 10 Sep 2019 12:45:57 -0700
Date: Tue, 10 Sep 2019 12:45:57 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Larry Dewey <ldewey@suse.com>
Message-ID: <20190910194556.GC11151@linux.intel.com>
References: <20190806185649.2476-1-sean.j.christopherson@intel.com>
 <20190806185649.2476-4-sean.j.christopherson@intel.com>
 <0be06fee919426129b2f379609f76bd260fba49c.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be06fee919426129b2f379609f76bd260fba49c.camel@suse.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
Subject: Re: [Qemu-devel] [RFC PATCH 03/20] vl: Add "sgx-epc" option to
 expose SGX EPC sections to guest
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 06, 2019 at 09:49:44PM +0000, Larry Dewey wrote:
> I was playing with the new objects, etc, and found if the user
> specifies -sgx-epc, and a memory device, but does not specify -cpu
> host, +sgx, the vm runs without any warnings, while obviously not doing
> anything to the memory. Perhaps some warnings if not everything which
> is required is provided?

Yeah, I waffled on what to do in this scenario.  Ditto for the opposite
scenario of having SGX enabled without EPC.   I agree a warning or error
would be helpful for EPC-without-SGX.  The SGX-without-EPC case at least
makes some sense, e.g. to mimic BIOS not partitioning EPC, and doesn't
waste resources.

