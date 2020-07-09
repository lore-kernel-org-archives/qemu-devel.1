Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62030C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 05:16:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316762053B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 05:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tki0SDVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316762053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtOvA-0003SZ-7t
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 01:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtOtm-0002d6-U1
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 01:15:06 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:36684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtOtl-0000Ns-BF
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 01:15:06 -0400
Received: by mail-pj1-x1042.google.com with SMTP id md7so574147pjb.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 22:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6QKuRsvBfN66D+Tii8VF03pSQjB2XwfOXT0VLFb8lzU=;
 b=tki0SDVR/x59ZE/vty826viHnX5delRK54pR41/4XIQD5Va5h0GwJXBcqhuFg0ZWOs
 U95aKsWolPu3bOAIAV8LsGKmrnFM1oA+emlztzlGGIqdx/62sxFekdQbdxymXep67VDz
 zolrkVROmNFi8Z262e1ldJpeyojH6Vi6Rs6NMlDIOyMuhobHsmhAf91lFZxLR/Ht+mL/
 +rBRpaqJ4L2mofdGFE7OUBdUrTAradrxCfaWi4Jo7aty7Eq06UbyuPZ/HyATqmgg/jsm
 gkOvxzb7pbXuwlZkrptVJ5I8sBk5nzcSo3pVR6eGOGJlL5bEw/B4D4f0l/3jt7Gjsqs1
 in8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6QKuRsvBfN66D+Tii8VF03pSQjB2XwfOXT0VLFb8lzU=;
 b=A2Df+W1gBDz9uUf/kNWyfROvAOCy6xh4xlNcxW7BRlnjwzLdvbjlENP9dsBcQBE+Lr
 IXSUFMbQRhcb4ikWKKxXVymVeXaKGqNRQtfO6Lz4og+qjto6L9HCI3+fU/4yGbyIworX
 ZDUKFh3aAH3OD9ObJkUlnI8lPhyLW42XIAyTvyMGWOoK8p4UBd2G+8t4o/Cj8HjebTNk
 uhZ5yoparrIFFflwlYMVDcDvRbVogxVFXfxlB8mk7vj65pJoQ41qzCf/TuoF9zXMdiRP
 6uaWn2SwsiOWXNaEQNxHkdfEHKE4tHhxNZ6akPJ0ZdTw7RZgVivdNbo4AFN6roPplzS/
 NbqQ==
X-Gm-Message-State: AOAM5324ulk8OQplIxOvwBPPHeivfxnr9kkWlJKmnBDsQm6uNecDWuyF
 NDAbkQiv02EC4PUv+RkoH/88M7ZB3Qh2AFAmD40=
X-Google-Smtp-Source: ABdhPJyKK39VDVC2HKM9c9Y7j9P0uJuQeRVLU4lhVHJlpvXt+0iUHbyx/rIC+pMEcJkDn8RXWxaIrTmp4PKA75zdpiU=
X-Received: by 2002:a17:90b:1045:: with SMTP id
 gq5mr13062664pjb.30.1594271703853; 
 Wed, 08 Jul 2020 22:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
 <20200706234737.32378-10-jcmvbkbc@gmail.com>
 <4fc60414-4b04-2402-3e72-50e77a7854b6@linaro.org>
 <CAMo8BfKLbHrJBfz64vO9Mtyz6fWL8+ZekiOzvpdYVhg58_PxpQ@mail.gmail.com>
 <26e7179e-692c-9467-b2d2-c04c6f03b0db@linaro.org>
In-Reply-To: <26e7179e-692c-9467-b2d2-c04c6f03b0db@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 8 Jul 2020 22:14:52 -0700
Message-ID: <CAMo8BfLtJsfOA+8b2usmZ-SMwBW6nd0TdWzT9Ck_B6xRLP3W5w@mail.gmail.com>
Subject: Re: [PATCH 09/21] target/xtensa: add DFP option, registers and opcodes
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 8, 2020 at 5:19 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
> Do I read that right,
[...]
> means that if DFP is present, float64 has use_first_nan, but float32 does not?!?

That's correct. And float64 madd.d/msub.d again don't have it.

> What in the world is going on?

My thoughts exactly. What I've found out is that at least
it wasn't meant to be like that. But also it is not specified
in any official documentation, and that I guess is one of
the reasons why it's like that. There are also no plans to
change it.

> >> E.g. the translator could remember the previous setting within the TB, only
> >> changing when necessary.  E.g. if env->config->use_first_nan, then set it
> >> during reset and never change it again.  Similarly if DFP is not enabled.
> >
> > This thought crossed my mind too, but then set_use_first_nan only
> > sets one variable in the float_status and gets inlined.
> > Is it worth the trouble?
>
> You have a point that the operation I'm trying to avoid is trivial, and
> probably not worth much.  But I had hoped that a given cpu would stick with one
> method and not change it.

CPU with only a single precision FPU (either FPU2000 or DFPU)
could do it, but apparently not one with a full DFPU.
We could give full DFPU its own implementations of single precision
helpers and choose appropriate helper at translation time.
I just felt that it would neither simplify the code nor have any
performance impact.

-- 
Thanks.
-- Max

