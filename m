Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85255C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12945204EC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12945204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw6f4-0005Zn-KU
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 11:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46750)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rebecca@bsdio.com>) id 1hw6eT-00052q-O8
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rebecca@bsdio.com>) id 1hw6eS-0007fP-TA
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:17:57 -0400
Received: from muon.bsdio.com ([65.103.231.193]:55648)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rebecca@bsdio.com>)
 id 1hw6eS-0007eN-Jy; Fri, 09 Aug 2019 11:17:56 -0400
Received: from muon.bsdio.com (localhost [127.0.0.1])
 by muon.bsdio.com (Postfix) with ESMTP id DEBAF8286F;
 Fri,  9 Aug 2019 09:17:55 -0600 (MDT)
Received: from muon.bsdio.com ([127.0.0.1])
 by muon.bsdio.com (muon.bsdio.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Errg4ILl3tyV; Fri,  9 Aug 2019 09:17:55 -0600 (MDT)
Received: from photon.int.bluestop.org (unknown [10.0.10.120])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by muon.bsdio.com (Postfix) with ESMTPSA;
 Fri,  9 Aug 2019 09:17:54 -0600 (MDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org
References: <20190809041952.57302-1-rebecca@bsdio.com>
 <57083e0b-2853-7f5b-16ec-83bc22f237fa@linaro.org>
From: Rebecca Cran <rebecca@bsdio.com>
Openpgp: preference=signencrypt
Autocrypt: addr=rebecca@bsdio.com; keydata=
 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 DtU=
Message-ID: <71dd9613-491f-bad3-c31e-231bf51df115@bsdio.com>
Date: Fri, 9 Aug 2019 09:17:54 -0600
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <57083e0b-2853-7f5b-16ec-83bc22f237fa@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 65.103.231.193
Subject: Re: [Qemu-devel] [PATCH] Update the avx2 configure test to be
 compatible with clang
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

On 2019-08-08 23:22, Richard Henderson wrote:
>
> No, this means we're not testing what we need:
>
> We need to compile exactly one function using avx2.
>
> The other functions should be compiled with sse4 and sse2, respectively, and we
> choose between them by testing cpuid bits at startup.  If you supply -mavx2 to
> the entire compilation, then the routine that is supposed to use only sse2 will
> in fact use avx2, and then the runtime selection is moot.


Oh, sorry, I hadn't fully realized there's runtime selection. Fixing
this would require significant rework in that case, so I'll just build
with GCC instead for now!


-- 
Rebecca Cran


