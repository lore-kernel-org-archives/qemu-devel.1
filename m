Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F887C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157DC22CE3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fsNRya6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157DC22CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i06DK-0000ST-40
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 11:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i06CQ-00085W-NH
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i06CO-0007H9-FI
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:37:30 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:44343)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i06CK-0007C2-KE
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:37:26 -0400
Received: by mail-pl1-x62d.google.com with SMTP id t14so2931609plr.11
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FEPjUes7hfZi6RO/qUnuWklRHzyDNyFVWExGaL2NwFg=;
 b=fsNRya6svY9Mm501zu177tYwz8pOmN2hxSay28Oo85o8oErfPVSmlSSvQDLCj+kDpi
 lQgy/n9YyS0dHUIM0IrIhiCM02C6W62dsEwxqoj8pftZUWe929T/0GKbF4MVg9epHrLH
 neBtrBoea9ROdFFWd5NFrWX5GQnFet4CSET67D21ndU5ukcNkREaxVwQbQkKeNVHlSub
 zCNL4Lq+k4ol4kyEocvy/DQaHermnGlUO+s3rhuEx7QTBtAfjGA1x1bG/d+0AGCnZPjg
 YH/8ZcnmrlbaroEfaLcZfFeikfoDmABLQaGE+zq19uhtDLqmogebCRw4y9RO8pXJuDel
 CcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FEPjUes7hfZi6RO/qUnuWklRHzyDNyFVWExGaL2NwFg=;
 b=XRSvSG6gW31Rlug/2nruvv04/cwqBMUQYYAlCmQ7GvL2w09qQXhZrF9wS/MIrMBWMD
 C/Eok/TWKhvs0NNShFb5Nz+V5bF7N0U5jfs6XVTwJRRWUd6w77SREoFvsfqkb7U+muAq
 pJt5zkzQQL5tYF9+Or+F789zXjVRZVto5NV50MY46M2xnX2q43Rsvf2GEBCNrsuF+Ig/
 KwzaBG18HWkul+Gu60C5EVSYtV4g+hPoiEio0SdT+rvBn+ytwhIJYb8PWZ1Hmku9/g8U
 ap55htHCrGm13mWnUwLcbkZS1vLfZLEZaKAIFkhp/JDKcmJs84h0YfKWuYifTGMG83HY
 WMHQ==
X-Gm-Message-State: APjAAAVIwGoTUjzR3gob7F45KOjcIG5IS3DHskF2ETirDhwoziRctbtW
 nAPmtMVoxKremmP4ge6xdD2aXA==
X-Google-Smtp-Source: APXvYqzffk8rtg51RvRfD7f00j2f7YzmdlMCMA4Vi0dQUwbuwXSFuFpRMqCkfsGw3jQcjkLU7/zbTg==
X-Received: by 2002:a17:902:ff05:: with SMTP id
 f5mr27895993plj.116.1566315441564; 
 Tue, 20 Aug 2019 08:37:21 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id e7sm21092425pfn.72.2019.08.20.08.37.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Aug 2019 08:37:20 -0700 (PDT)
To: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <BN6PR2201MB1251511E7694854909AFEEB4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CAFEAcA9UJGXOdNUD49bxmrdoZ5FEv4VLqAvyzDw66MOGsGB=wg@mail.gmail.com>
 <BN6PR2201MB1251C78A16D557867586FFD4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1fc18db5-abd4-80be-11ee-209dfd4a55f4@linaro.org>
Date: Tue, 20 Aug 2019 08:37:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB1251C78A16D557867586FFD4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62d
Subject: Re: [Qemu-devel] [EXTERNAL]Re: Proposal for amending TCG interface
 naming scheme
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
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/19 6:49 AM, Aleksandar Markovic wrote:
>> From: Peter Maydell <peter.maydell@linaro.org>
>> On Tue, 20 Aug 2019 at 13:50, Aleksandar Markovic
>> <amarkovic@wavecomp.com> wrote:
>>> The idea is to provide significant "lexicographic" distance between those > groups of functions, rather than having the similar name (wiht common root > "ext) for all of them.
>>
>> The current naming of the extract/sextract TCG ops is intended to keep
>> them in line with the extract32/sextract32/extract64/sextract64 utility
>> functions in bitops.h. I think those ones are reasonably named. The
>> other ops are a bit more ad-hoc in naming, admittedly...
>>
> 
> How about
> 
> tcg_gen_extract2_i32
> tcg_gen_extract2_i64
> tcg_gen_extract2_tl
> tcg_gen_extrl_i64_i32
> tcg_gen_extrh_i64_i32
> tcg_gen_ext_i32_i64
> tcg_gen_extu_i32_i64
> 
> to
> 
> tcg_gen_gather_i32
> tcg_gen_gather_i64
> tcg_gen_gather_tl

I'm not sure how "gather" applies.  To me this sounds like a vector
scatter/gather operation, where N different addresses are used to load the N
elements of the vector.

When extract2 was named, I was only thinking "extract" because of how the
AArch64 instruction that implements this operation is named (EXTR), and "extr"
itself was already taken.  We did ask for naming suggestions at the time, but
no better ideas were floated...

Would it be clearer to use the x86 instruction name: SHRD (SHift Right Doubleword)?

> tcg_gen_pick_l_i64_i32
> tcg_gen_pick_h_i64_i32

Hmm, "pick" doesn't mean anything to me.  Which makes it better than "gather",
but only just.

We do have a couple of related operations: tcg_gen_trunc_i64_tl and
tcg_gen_trunc_tl_i32.  It's easy to see tcg_gen_extrl_i64_i32 as "truncate",
because that's what it does.  But it's harder to see tcg_gen_extrh_i64_i32 as
"truncate high".  Is tcg_gen_shr32_trunc_i64_i32 too unwieldy?

Or perhaps we could leave these alone.  Changing the others gives us the
desired (or at least increased) lexicographic distance.

> tcg_gen_extend_s_i32_i64
> tcg_gen_extend_0_i32_i64

These should not drift too far from the other extension names,

    tcg_gen_ext{8,16}{u,s}_i32
    tcg_gen_ext{8,16,32}{u,s}_i64

What if we use the AArch64 mnemonics: zxt (zero-extend) and sxt (sign-extend)?
 This would give us

    tcg_gen_zxt8_i32
    tcg_gen_sxt8_i32
    (etc)
    tcg_gen_zxt_i32_i64
    tcg_gen_sxt_i32_i64


r~

