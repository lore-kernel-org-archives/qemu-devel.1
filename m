Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A206C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 18:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3490420737
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 18:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puwTqf8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3490420737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAzq0-0002p9-GS
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 14:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kAzpQ-0002Ok-4R
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 14:07:20 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:36549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kAzpO-00051X-JA
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 14:07:19 -0400
Received: by mail-lj1-x243.google.com with SMTP id t23so3442009ljc.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 11:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pIuzeq1Sfx3g4c4F8h8ET1Jq2X1Amplz5V/3pz49bwc=;
 b=puwTqf8RpXvruWYITPz6U52trI2I9ROe5MsYPjFgcqSJ93c3tz88i5Et2GDxiuRV8E
 eULs0M59onKipCJBj2BpSgXSPgwNLckZ+k5xL5g2W+MMpDDefXlcvRSRZMjtEfGMLNmm
 Igzm0KrMsoH47KRG96cjhb/DanS82hgeVdg8MdCKpzjiwNp2nFvpNCgw/ESuATXyyc4K
 5KZ2nNwOzk5w+3X74TBUNju0bhK5OqYcz4vWCkd6UdlredPiXIpBylz4glf6WvNkCC+K
 eDYgMLvxI6cnzSYS6ACq1M7yQG2UVm9jW7Mjan7H1TXsBP28euryO0i1O1VlCZUWQsMs
 By1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pIuzeq1Sfx3g4c4F8h8ET1Jq2X1Amplz5V/3pz49bwc=;
 b=YMD7lonh7VADmGGQQuPVusGt/B4hPX47DKk22z7hFpwie8Wjz7r76glubfJKE4YSAk
 0BgCTwscudb9zToDMyrVsuhCngjng04I8yP4REpGUH7hm6X/Vay82FJBgcdHHDw3F0Dz
 bIcGgx3W4h24XPSbdFlUGYKRgB9hkNe2ES05IGE98Kwa/eQqeD/j2+txesLIfyR3Fg53
 eKL72CV9Yb8sDTxY9wR/8cyeBeJQgVj7XRWNPtBucn044+qqeiN5Lxf0F3sHDMruzSzx
 sb0mxjSt7tR8zWF88mx7ea31ndqTLz1d+lNDksTWwiVNnyychy0AWAe3llyxcmnJUmsc
 XhIQ==
X-Gm-Message-State: AOAM531yCi2BR/sbwPu2L8420YwyzW2u1xVBY9/c82Y2Oz0PasEP4t2+
 TbLjo1yIrgJDYVSX6Rusup0=
X-Google-Smtp-Source: ABdhPJyvT/ACS/O6NcCX/+07r9Ab+hr54djH/XNh42R7IXgIAugjc+oE9TWxabIh4nThCc+vUe+gdA==
X-Received: by 2002:a2e:9a15:: with SMTP id o21mr7896949lji.419.1598465236864; 
 Wed, 26 Aug 2020 11:07:16 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id x17sm670096ljm.0.2020.08.26.11.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 11:07:16 -0700 (PDT)
Date: Wed, 26 Aug 2020 20:07:15 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 00/77] target/microblaze improvements
Message-ID: <20200826180715.GI2954729@toto>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.066, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 01:58:33PM -0700, Richard Henderson wrote:
> Well, this is larger than I expected.
> 
> I started off thinking conversion to decodetree would be quick,
> after I reviewed the mttcg patches last week.  Then I realized
> that this could also use conversion to the generic translation loop.
> Then I realized that there were a number of bugs, and some
> inefficiencies, that could be fixed by using tcg exception unwind
> properly.
> 
> Hopefully most of these are small and easy to understand.
> 
> I begin by adding enough stuff to test/tcg to make use of a
> self-built musl cross-environment.  I'll note that linuxtest
> does not pass before or after this patch set -- I think that
> linux-user/microblaze/signal.c needs work -- but that the
> other tests do work.
> 
> I also have an old copy of a microblaze system test image,
> which I think used to be hosted on our wiki.  After basic kernel
> boot, it contains a "selftest" script which runs a bunch of
> user-land isa tests.  That still works fine too.
> 
> HOWEVER: That's not nearly complete.  There are cpu config options
> that aren't default and I don't know how to change or test.
> 
> In addition, the manual is really not clear on what's supposed to
> happen under various edge conditions, especially with MSR[EE] unset.
> E.g. unaligned access: Does the insn get nop-ed out?  Do the low
> bits of the address get ignored?  Right now (before and after) the
> access simply happens unaligned, which doesn't seem correct.
> I assume the reason for having this configure option is to reduce
> the size of the FPGA so that the unaligned access handling hw
> simply isn't present.

Yes, I verified with the RTL designers and this particular case will
result in the core issuing the load/store with the lower address bits
ignored.

Cheers,
Edgar


