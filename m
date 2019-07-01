Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8C2C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:30:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A31B52064A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31B52064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhyiU-0000la-7P
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 11:59:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50312)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sameo@linux.intel.com>) id 1hhyby-0002jW-AT
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sameo@linux.intel.com>) id 1hhybw-0001al-Rg
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:52:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:30958)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sameo@linux.intel.com>)
 id 1hhybo-0001CT-MX; Mon, 01 Jul 2019 11:52:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Jul 2019 08:52:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,439,1557212400"; d="scan'208";a="157332526"
Received: from tcouniha-mobl.ger.corp.intel.com (HELO caravaggio)
 ([10.251.80.81])
 by orsmga008.jf.intel.com with ESMTP; 01 Jul 2019 08:52:08 -0700
Date: Mon, 1 Jul 2019 17:51:30 +0200
From: Samuel Ortiz <sameo@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190701155130.GA4424@caravaggio>
References: <20190701132516.26392-1-philmd@redhat.com>
 <CAFEAcA93x6zkbHe1hdg0c8cbo9ErSByP+g6UvwZefxn-6346zg@mail.gmail.com>
 <6222de8e-5b4e-db05-a453-ae4920c2002a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6222de8e-5b4e-db05-a453-ae4920c2002a@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
Subject: Re: [Qemu-devel] [PATCH v3 00/27] Support disabling TCG on ARM
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
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <drjones@redhat.com>, Rob Bradford <robert.bradford@intel.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 01, 2019 at 05:44:58PM +0200, Philippe Mathieu-Daudé wrote:
> On 7/1/19 5:41 PM, Peter Maydell wrote:
> > On Mon, 1 Jul 2019 at 14:25, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> >>
> >> Paolo motived me to salvage this (other!) previous series fromi
> >> Samuel Ortiz (NEMU project).
> >>
> >> v1 cover from Samuel [1]:
> >>
> >>   This patchset allows for building and running ARM targets with TCG
> >>   disabled. It splits the target/arm/helper.c file into logical TCG and
> >>   non TCG dependent files so that one can build and run QEMU binaries with
> >>   or without TCG enabled.
> >>
> >>   The rationale behind this work comes from the NEMU project where we're
> >>   trying to only support x86 and ARM 64-bit architectures, without
> >>   including the TCG code base. We can only do so if we can build and run
> >>   ARM binaries with TCG disabled.
> > 
> > I have applied to target-arm.next:
> >  1-12
> >  14-17
> >  19-21
> > 
> > I had comments about 13 and 18. 22 has a conflict when I try to apply it:
> > I think this is just accidental because the functions it's moving are
> > next to changes in patch 13 so there's a minor textual conflict, so it
> > would be fine with a fixed-up version of patch 13.
> > 23-27 are still RFC status so I think best left for the next release.
> 
> Thanks a LOT!
Indeed, thanks a bunch!

Cheers,
Samuel.

