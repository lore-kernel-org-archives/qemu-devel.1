Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93759C468B1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 20:47:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239AF20883
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 20:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ganzDE+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239AF20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55304 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hanIf-0001Qk-El
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 16:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46673)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mrolnik@gmail.com>) id 1hanHl-0000te-R6
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 16:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1hanHi-0000bH-TX
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 16:22:25 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:38858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hanHi-0000Zt-AU
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 16:22:22 -0400
Received: by mail-qk1-x742.google.com with SMTP id a27so8536724qkk.5
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 13:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b654qf6o1kQ/BHQRHHPI2NGFBXWrAW+e6u/sfxvntjA=;
 b=ganzDE+Y9NY+QBYceW4BUlk6vqOdBKIUMMRfQzWqtzp5XWYIHtUc3dYD6H8MdZPbj6
 0aeWMm+1FO/xeEbrt6y0uLXvMkOcjIYmCKehZfmKgkQhPa8bMFUXtnj32l4Mv7/n0fDX
 VHjwePsoLLGWSzw8OA3jejQw98GUHcz5x98gH8vxHRvsDKr3zouOL2uRyqA5w680neKK
 XJcUBScfmaW/gU3sOn0tVJAG2o9crGQZk6ghEQuaztjFiVCvUSoo2VoAQ/ssmEPM9IwE
 4+PcIWgmRW25H7+HhvBRjTBjlpMOEYnn6m2sdh2Kvsgc1pG3hz74ZDWi628aSHinTdLQ
 Y0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b654qf6o1kQ/BHQRHHPI2NGFBXWrAW+e6u/sfxvntjA=;
 b=EWZuhFT5XTzLG2RddziOUJCmYeDxFuXhgJ505uAtfvEULMwy0P6Hi/NH13Zcv0em/0
 tJhj2keCd3dQ/a71489URK1LeygEAUGmnX+zIDHKYaYuISguzuPaqxDStEWqPCBIlyjg
 Z8GDyfOrJIXW3jlQi/e+SrSU6CqoV6ysHWZi9LjckwndZYYsJzDQ/Wv6B2QOdnV6tPQ2
 yhfSl4SjK29sLNsYoILjAigJHrwT7CU517V0vCFnMWcjWcX25je3xPrHlIwHIC8mj/Li
 icFfBFRxFm0eFjDX7cVLRGqvXgURYLVS/nchqMuEntIJ9jbgPbKUwr8ESWesozvWaC5S
 Fc+w==
X-Gm-Message-State: APjAAAUSPvm3TNPsEOqJP7wB2BOekQThOQje7VzO97ecywhZiTgaoD7J
 l1dF4ILUSnMAtJ770X0OQb8FG29WGOcSa+/po3o=
X-Google-Smtp-Source: APXvYqxBnbg2sD5HOKBXDJYtb4eA243uBkXyWqSPjJVX9LygH2u1jniWnaOUkHFxgqjV3qaPXZifyBUU/ixbYxrF5tk=
X-Received: by 2002:a37:4152:: with SMTP id o79mr34356657qka.276.1560284540235; 
 Tue, 11 Jun 2019 13:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190606193012.37715-1-mrolnik@gmail.com>
 <20190606193012.37715-5-mrolnik@gmail.com>
 <9c74618e-eb1e-0225-11dc-fe51e634d265@linaro.org>
In-Reply-To: <9c74618e-eb1e-0225-11dc-fe51e634d265@linaro.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Tue, 11 Jun 2019 23:21:43 +0300
Message-ID: <CAK4993gLwXopG=EFNePsHJYmTZ5uU7EgbGe3Ad4ofOdCxQX-Mg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v21 4/7] target/avr: Add instruction
 translation
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard.

I merged all you fixes and I get an assert(use_icount) in cpu_loop_exec_tb
function, it happens on an instruction following SBRC.
what might cause it?

On Tue, Jun 11, 2019 at 12:20 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 6/6/19 12:30 PM, Michael Rolnik wrote:
> > +        if (ctx.check_skip > 0) {
> > +            TCGLabel *skip = gen_new_label();
> > +            TCGLabel *done = gen_new_label();
> > +
> > +            tcg_gen_brcondi_tl(TCG_COND_NE, cpu_skip, 0, skip);
> > +                translate(&ctx);
> > +                tcg_gen_br(done);
> > +            gen_set_label(skip);
> > +                tcg_gen_movi_tl(cpu_skip, 0);
> > +                tcg_gen_movi_tl(cpu_pc, ctx.npc);
> > +            gen_set_label(done);
> > +            ctx.check_skip--;
> > +        } else {
> > +            translate(&ctx);
> > +        }
>
> In future, do not indent code like this.
>
> I had been thinking of a slightly more complex solution that does not
> require
> every TB to begin with a conditional branch testing cpu_skip.  This also
> has
> the property that we almost never write to cpu_skip at all -- the
> condition is
> consumed immediately within host registers without being written back to
> ENV.
> The only time we do write to cpu_skip is for debugging, single-stepping, or
> when we are forced to break the TB for other unusual reasons.
>
> The following implements this solution.  It's based on some other cleanups
> that
> I have made, and commented upon here.  The full tree can be found at
>
>   https://github.com/rth7680/qemu/commits/review/avr-21
>
>
> r~
>


-- 
Best Regards,
Michael Rolnik
