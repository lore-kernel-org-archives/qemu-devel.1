Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D27C35DF8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 07:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A80521556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 07:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A80521556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Ujw-0006e8-HI
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 02:34:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.hu@linux.intel.com>) id 1j6UjN-0006D3-UX
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:34:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.hu@linux.intel.com>) id 1j6UjM-0000pC-TA
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:34:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:57294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
 id 1j6UjM-0000jy-Jq
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:34:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 23:34:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,483,1574150400"; d="scan'208";a="350093404"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2020 23:34:08 -0800
Message-ID: <1c4cf8366513c96063d7f6e2bc9d2e959ad08d6c.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] util: add util function buffer_zero_avx512()
From: Robert Hoo <robert.hu@linux.intel.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, laurent@vivier.eu, philmd@redhat.com,
 berrange@redhat.com
Date: Tue, 25 Feb 2020 15:34:07 +0800
In-Reply-To: <7b8fd7a0-9cb8-aab8-0f1b-4a77dd7a6378@linaro.org>
References: <1581580379-54109-1-git-send-email-robert.hu@linux.intel.com>
 <1581580379-54109-3-git-send-email-robert.hu@linux.intel.com>
 <ee2ef44a-737b-e989-7f20-18a69e19d430@linaro.org>
 <160d077042713fc46b36650946712a43e6e89b51.camel@linux.intel.com>
 <7b8fd7a0-9cb8-aab8-0f1b-4a77dd7a6378@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-5.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
Cc: robert.hu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-02-24 at 08:13 -0800, Richard Henderson wrote:
> On 2/23/20 11:07 PM, Robert Hoo wrote:
> > Inspired by your suggestion, I'm thinking go further: use immediate
> > rather than a global variable, so that saves 1 memory(/cache)
> > access. 
> > 
> > #ifdef CONFIG_AVX512F_OPT   
> > #define OPTIMIZE_LEN    256
> > #else
> > #define OPTIMIZE_LEN    64
> > #endif
> 
> With that, the testing in tests/test-bufferiszero.c, looping through
> the
> implementations, is invalidated.  Because once you start compiling
> for avx512,
> you're no longer testing sse2 et al with the same inputs.
> 
Right. Thanks pointing out. I didn't noticed that.
More precisely, it would cause no longer testing sse2 et al with < 256
length.

> IF we want to change the length to suit avx512, we would want to
> change it
> unconditionally.  And then you could also tidy up avx2 to avoid the
> extra
> comparisons there.
Considering the length's dependency on sse2/sse4/avx2/avx512 and the
algorithms, as well as future's possible changes, additions, I'd rather
roll back to your original suggestion, use a companion variable with
each accel_fn(). How do you like it?

> 
> 
> r~


