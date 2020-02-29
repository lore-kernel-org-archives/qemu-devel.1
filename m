Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC24C3F2D2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 03:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5200246A2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 03:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5200246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7sON-0000gS-QM
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 22:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.hu@linux.intel.com>) id 1j7sNg-0000E3-PF
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 22:01:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.hu@linux.intel.com>) id 1j7sNf-00059U-PB
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 22:01:32 -0500
Received: from mga02.intel.com ([134.134.136.20]:63362)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
 id 1j7sNf-00058S-EJ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 22:01:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Feb 2020 19:01:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,498,1574150400"; d="scan'208";a="437624162"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by fmsmga005.fm.intel.com with ESMTP; 28 Feb 2020 19:01:23 -0800
Message-ID: <758fb5f324a449e6ff62dd71b689c4c498e931d0.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/2] util: add util function buffer_zero_avx512()
From: Robert Hoo <robert.hu@linux.intel.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, laurent@vivier.eu, philmd@redhat.com,
 berrange@redhat.com
Date: Sat, 29 Feb 2020 11:01:22 +0800
In-Reply-To: <f8a87ddf-7d51-c9e4-6122-a9e3c1b84c29@linaro.org>
References: <1582856696-45663-1-git-send-email-robert.hu@linux.intel.com>
 <1582856696-45663-3-git-send-email-robert.hu@linux.intel.com>
 <f8a87ddf-7d51-c9e4-6122-a9e3c1b84c29@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-5.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
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
Cc: robert.hu@intel.com, chao.p.peng@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2020-02-28 at 18:09 -0800, Richard Henderson wrote:
> On 2/27/20 6:24 PM, Robert Hoo wrote:
> >              if ((bv & 6) == 6 && (b & bit_AVX2)) {
> >                  cache |= CACHE_AVX2;
> >              }
> > +            if ((bv & 6) == 6 && (b & bit_AVX512F)) {
> > +                cache |= CACHE_AVX512F;
> > +            }
> 
> Oh, one more thing I missed -- we have to ensure that the 512-bit
> registers are
> enabled.  I believe the minimum is bits 6 and 7 enabled (ZMM_Hi256,
> Hi16_ZMM),
> since we don't know that the compiler won't allocate registers from
> zmm16-31.
> 
> So: (bv & 0xc6) == 0xc6.
> 
> You'd be right that some comments would be helpful on these
> lines.  :-P
> 
Oh, right, thank you very much for remind.

SDM's recommended detection on AVX512F support procedure is
1. Detect CPUID.1:ECX.OSXSAVE[bit 27] = 1 (XGETBV enabled for
application use).
2. Execute XGETBV and verify that XCR0[7:5] = 111b (OPMASK state, upper
256-bit of ZMM0-ZMM15 and ZMM16-ZMM31 state are enabled by OS) and that
XCR0[2:1] = 11b (XMM state and YMM state are enabled by OS).
3. Detect CPUID.0x7.0:EBX.AVX512F[bit 16] = 1.

I'm going to send v4 to address this.

> With that,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~


