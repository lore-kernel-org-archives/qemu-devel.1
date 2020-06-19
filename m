Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5AEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B741C207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ds+CdKGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B741C207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKxX-0001hs-1a
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmKrF-0007e3-Pq
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:31:18 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:37616)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmKrE-0008Oj-0K
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:31:17 -0400
Received: by mail-ot1-x336.google.com with SMTP id v13so7882771otp.4
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 10:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LOFyaqR3gy6+6oh/8bmMt9YI9rXcVEBThTR/aopUDRM=;
 b=Ds+CdKGvbjK1tKfPzS1JXzRUMELjFm/WfhXnqnJ2aJzePJ+PyECd06/hetRNWr+Hn0
 2OX1T14brLyAlKQLoIKXwB+XjLCQV9pDNLhJJpTadR1KGy3sy9WLzsI/EvZamrjlPXhl
 1S/ux/cUvKOnpnD1pf9ewt8y+j4BNTayuEvIcgyT5g2rSkh9DugR8Bz++tytYF4MdkKS
 hxFLnw+6Qcf0z9wXbxCS68zJYZ8Tlf4SxHsBNThHopIlgQNRizTRoAtxt9QLajTn9CyV
 XqHYU6tJqeGNW5P48Uq8sjnyhh0HjxS2DDOjoCry3HktzqrhRMgUxt/I3dF+sQY4/VYs
 e5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LOFyaqR3gy6+6oh/8bmMt9YI9rXcVEBThTR/aopUDRM=;
 b=GW8IU7VlVQvehhoTgolhNf2bT1zhOxm74e70/NfecMyk5plZjVVLNanfZwEDoLMIIp
 YRq4zukgBSXj/77GPSL0Ga7Zared25+7xOFjxBPQNirxZ+Mv8XMvJBNTwkcwlrYKBmIi
 7tUqD0LrvOBroAW2pga8pOylpxQaaG21ej1lQaUuFlLGi18mZbrgaVGGUPcO6hFiVtUe
 ghY40NSCEB74eLVonVWEcaIrQ/4ZiakS4LXO5HghNFL5VxdQcBOgGKqnUKwv7EcPcdSX
 uMYJCM5j2z3mQp10Bwjikn+wIdCvndMNLLbFsD0aix5WiB9I//WkOm5qrdntyjWcn+Xn
 a1uQ==
X-Gm-Message-State: AOAM533lWcd3l6LMOrfQ3ODKm5qG1VFolJJLzgVH12X5vOeaLxbsS3tY
 MIYLOwW5SWrMuErOc9hgloQjSruwGpfA5VM0fwW70w==
X-Google-Smtp-Source: ABdhPJyYyv3M7fSGh2FgMJAdzRBc1yYrm2TlO6drM6+P5YfO2uzmOR3XQuwH9k9tIFR3A8J4ADoJCPN7PSZ5VQgpBQo=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr3897627oto.91.1592587874744; 
 Fri, 19 Jun 2020 10:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200617201309.1640952-1-richard.henderson@linaro.org>
 <20200617201309.1640952-7-richard.henderson@linaro.org>
 <c5a6e38c-0365-a695-8bbb-c61b381c668e@linaro.org>
In-Reply-To: <c5a6e38c-0365-a695-8bbb-c61b381c668e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 18:31:03 +0100
Message-ID: <CAFEAcA9rtVzZ8VQNQdEquZzHPrU-BugZdaEDYAy32sC97RJdGA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] qht: Fix threshold rate calculation
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "Emilio G . Cota" <cota@braap.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 17 Jun 2020 at 21:59, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/17/20 1:13 PM, Richard Henderson wrote:
> > -        *threshold = rate * UINT64_MAX;
> > +        *threshold = (rate * 0xffff000000000000ull)
> > +                   + (rate * 0x0000ffffffffffffull);
>
> Well, while this does silence the warning, it produces the exact same results
> as before, since the intermediate double result still only has 53 bits of
> precision.
>
> We're probably be better off with the nextafter(0x1p64, 0.0) form that we've
> used elsewhere.

Yeah, the code does look a bit odd. I'm going to apply this one to master
as well just to suppress all the patchew nagmails, but we should
figure out the correct thing to do here.

thanks
-- PMM

