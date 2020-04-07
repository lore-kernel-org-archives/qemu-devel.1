Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9859FC2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 03:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B6F0206BE
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 03:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6F0206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLesD-0005ZW-A3
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 23:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jLerc-00052h-IF
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 23:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jLera-0006YI-KR
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 23:25:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:32957)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jLera-0006UZ-CX
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 23:25:22 -0400
IronPort-SDR: /Bvy9T/cySDXBy7ls68VmkOHimXyRFaJMRPHk8/Dwd4iU2sIIQSbxz4QrFie7WUfzdI5CuR7Dv
 o5ga7MLs+7UQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2020 20:25:14 -0700
IronPort-SDR: Hl3XwBLtmvtHMXGP723w3XE8/mZdrvIYzW/ikUXZrgu/sp5Hb9wQOegxU7Q37S2J4+kSIeuEXB
 KV/VIbHx33QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,353,1580803200"; d="scan'208";a="243651301"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga008.fm.intel.com with ESMTP; 06 Apr 2020 20:25:12 -0700
Date: Mon, 6 Apr 2020 23:15:37 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 0/3] drop writes to read-only ram device & vfio regions
Message-ID: <20200407031537.GB10586@joy-OptiPlex-7040>
References: <20200403165657.20566-1-yan.y.zhao@intel.com>
 <CAFEAcA8F9AUo+2VfbB-YaJxRfE+TPb76fppWfWm6c+XfQV560A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8F9AUo+2VfbB-YaJxRfE+TPb76fppWfWm6c+XfQV560A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.120
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Zeng, Xin" <xin.zeng@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 03, 2020 at 08:53:12PM +0800, Peter Maydell wrote:
> On Fri, 3 Apr 2020 at 09:13, Yan Zhao <yan.y.zhao@intel.com> wrote:
> >
> > patch 1 modifies handler of ram device memory regions to drop guest writes
> > to read-only ram device memory regions
> >
> > patch 2 modifies handler of non-mmap'd read-only vfio regions to drop guest
> > writes to those regions
> >
> > patch 3 let mmap'd read-only vfio regions be able to generate vmexit for
> > guest write. so, without patch 1, host qemu would crash on guest write to
> > this read-only region. with patch 1, host qemu would drop the writes.
> 
> Just FYI, there seems to be a minor clock or timezone issue with
> however you're sending these emails: the Date header you
> sent reads "Date: Fri, 3 Apr 2020 16:56:57 +0000" but that
> time in the UTC +0000 timezone is (as I write this) still several
> hours in the future. This isn't a big deal but you probably want
> to look into fixing it.
> 
> (Noticed because the wrong-date makes your patches stick to
> the top of the https://patchew.org/QEMU/ list even after other
> patches arrive after them.)
>
thanks for informing of it! will pay attention to it.
Thanks
Yan

