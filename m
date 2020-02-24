Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09579C3567B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 07:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C906820714
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 07:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C906820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j67r1-0005JF-0U
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 02:08:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.hu@linux.intel.com>) id 1j67qQ-0004uF-F9
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 02:07:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.hu@linux.intel.com>) id 1j67qP-0006bm-77
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 02:07:58 -0500
Received: from mga17.intel.com ([192.55.52.151]:21926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
 id 1j67qO-0006WS-Uf
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 02:07:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Feb 2020 23:07:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,479,1574150400"; d="scan'208";a="225886827"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by orsmga007.jf.intel.com with ESMTP; 23 Feb 2020 23:07:47 -0800
Message-ID: <160d077042713fc46b36650946712a43e6e89b51.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] util: add util function buffer_zero_avx512()
From: Robert Hoo <robert.hu@linux.intel.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, laurent@vivier.eu, philmd@redhat.com,
 berrange@redhat.com
Date: Mon, 24 Feb 2020 15:07:46 +0800
In-Reply-To: <ee2ef44a-737b-e989-7f20-18a69e19d430@linaro.org>
References: <1581580379-54109-1-git-send-email-robert.hu@linux.intel.com>
 <1581580379-54109-3-git-send-email-robert.hu@linux.intel.com>
 <ee2ef44a-737b-e989-7f20-18a69e19d430@linaro.org>
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

Thanks Richard:-)
Sorry for late reply.
On Thu, 2020-02-13 at 10:20 -0800, Richard Henderson wrote:
> On 2/12/20 11:52 PM, Robert Hoo wrote:
> > And initialize buffer_is_zero() with it, when Intel AVX512F is
> > available on host.
> > 
> > This function utilizes Intel AVX512 fundamental instructions which
> > perform over previous AVX2 instructions.
> 
> Is it not still true that any AVX512 insn will cause the entire cpu
> package,
> not just the current core, to drop frequency by 20%?
> 
> As far as I know one should only use the 512-bit instructions when
> you can
> overcome that frequency drop, which seems unlikely in this
> case.  That said...
> I don't think so. AVX512 has been applied in various places.
> > +    if (unlikely(len < 64)) { /*buff less than 512 bits,
> > unlikely*/
> > +        return buffer_zero_int(buf, len);
> > +    }
> 
> First, len < 64 has been eliminated already in select_accel_fn.
> Second, len < 256 is not handled properly by the code below...
> 
Right. I'm going to fix this in v2.
> 
> > +    /* Begin with an unaligned head of 64 bytes.  */
> > +    t = _mm512_loadu_si512(buf);
> > +    p = (__m512i *)(((uintptr_t)buf + 5 * 64) & -64);
> > +    e = (__m512i *)(((uintptr_t)buf + len) & -64);
> > +
> > +    /* Loop over 64-byte aligned blocks of 256.  */
> > +    while (p < e) {
> > +        __builtin_prefetch(p);
> > +        if (unlikely(_mm512_test_epi64_mask(t, t))) {
> > +            return false;
> > +        }
> > +        t = p[-4] | p[-3] | p[-2] | p[-1];
> > +        p += 4;
> > +    }
> > +
> > +    t |= _mm512_loadu_si512(buf + len - 4 * 64);
> > +    t |= _mm512_loadu_si512(buf + len - 3 * 64);
> > +    t |= _mm512_loadu_si512(buf + len - 2 * 64);
> > +    t |= _mm512_loadu_si512(buf + len - 1 * 64);
> 
> ... because this final sequence loads 256 bytes.
> 
> Rather than make a second test vs 256 in buffer_zero_avx512, I wonder
> if it
> would be better to have select_accel_fn do the job.  Have a global
> variable
> buffer_accel_size alongside buffer_accel so there's only one branch
> (mis)predict to worry about.
> 
Thanks Richard, very enlightening!
Inspired by your suggestion, I'm thinking go further: use immediate
rather than a global variable, so that saves 1 memory(/cache) access. 

#ifdef CONFIG_AVX512F_OPT   
#define OPTIMIZE_LEN    256
#else
#define OPTIMIZE_LEN    64
#endif
> FWIW, something that the compiler should do, but doesn't currently,
> is use
> vpternlogq to perform a 3-input OR.  Something like
> 
>     /* 0xfe -> orABC */
>     t = _mm512_ternarylogic_epi64(t, p[-4], p[-3], 0xfe);
>     t = _mm512_ternarylogic_epi64(t, p[-2], p[-1], 0xfe);
> 
Very enlightening. Yes, seems compiler doesn't do this.
I tried explicitly use this, however, looks it will have more
instructions generated, and unit test shows it performs less than then
conventional code.
Let me keep the conventional code for this moment, will ask around and
dig further outside this patch.

> 
> r~


