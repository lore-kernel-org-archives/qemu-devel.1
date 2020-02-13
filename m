Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83451C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 11:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA7E222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 11:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA7E222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2D9W-0008QA-Hk
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 06:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.hu@linux.intel.com>) id 1j2D8R-000715-7U
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.hu@linux.intel.com>) id 1j2D8P-0000j6-4A
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:58:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:15179)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
 id 1j2D8O-0000ge-Qt
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:58:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Feb 2020 03:58:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,436,1574150400"; d="scan'208";a="222625273"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by orsmga007.jf.intel.com with ESMTP; 13 Feb 2020 03:58:17 -0800
Message-ID: <20bacabb27179111fdd517593e7ae44729aa3118.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] util: add util function buffer_zero_avx512()
From: Robert Hoo <robert.hu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 laurent@vivier.eu, philmd@redhat.com, berrange@redhat.com
Date: Thu, 13 Feb 2020 19:58:16 +0800
In-Reply-To: <dfc22e0f-79db-25d7-ccd8-26db1353c3b6@redhat.com>
References: <1581580379-54109-1-git-send-email-robert.hu@linux.intel.com>
 <1581580379-54109-3-git-send-email-robert.hu@linux.intel.com>
 <dfc22e0f-79db-25d7-ccd8-26db1353c3b6@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-5.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
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

On Thu, 2020-02-13 at 11:30 +0100, Paolo Bonzini wrote:
> On 13/02/20 08:52, Robert Hoo wrote:
> > +
> > +}
> > +#pragma GCC pop_options
> > +#endif
> > +
> > +
> >  /* Note that for test_buffer_is_zero_next_accel, the most
> > preferred
> >   * ISA must have the least significant bit.
> >   */
> > -#define CACHE_AVX2    1
> > -#define CACHE_SSE4    2
> > -#define CACHE_SSE2    4
> > +#define CACHE_AVX512F 1
> > +#define CACHE_AVX2    2
> > +#define CACHE_SSE4    4
> > +#define CACHE_SSE2    6
> 
> This should be 8, not 6.
> 
> Paolo

Thanks Paolo, going to fix it in v2.
> 
> >  
> >  /* Make sure that these variables are appropriately initialized
> > when
> >   * SSE2 is enabled on the compiler command-line, but the compiler
> > is
> > @@ -226,6 +268,11 @@ static void init_accel(unsigned cache)
> >          fn = buffer_zero_avx2;
> >      }
> >  #endif
> > +#ifdef CONFIG_AVX512F_OPT
> > +    if (cache & CACHE_AVX512F) {
> > +        fn = buffer_zero_avx512;
> > +    }
> > +#endif
> >      buffer_accel = fn;
> >  }
> >  
> > @@ -255,6 +302,9 @@ static void __attribute__((constructor))
> > init_cpuid_cache(void)
> >              if ((bv & 6) == 6 && (b & bit_AVX2)) {
> >                  cache |= CACHE_AVX2;
> >              }
> > +            if ((bv & 6) == 6 && (b & bit_AVX512F)) {
> > +                cache |= CACHE_AVX512F;
> > +            }
> >          }
> 
> 


