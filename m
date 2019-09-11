Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6FAC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:16:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2239D206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FAXYuYAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2239D206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i82UM-0002p7-16
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 09:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i82Sc-0001ab-09
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:15:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i82Sa-0003Ju-Eb
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:15:01 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36324)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i82Sa-0003JY-7S
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:15:00 -0400
Received: by mail-wr1-x441.google.com with SMTP id y19so24525620wrd.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 06:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Tt17W8SjSdrHCnv+gdnh1e2BbNeEHnUakLSF7X1aRus=;
 b=FAXYuYAGF8Oiq/0LHb7caIM29DtxKdSAgeoK0NUhQ6z0SwyFzwnv123KawYuw+ymd6
 SEU8aKaIxDPT3bXgtvbY2RsNW9XMRWfvEAkaUm6EeSdIjKxDsDLHNhFSGI7v/kFXDILZ
 rmZCSRcNt2IfD6K3bkBNI974yZFcqWCNm8i4lCYPS6RVi48KL8Dn/pbotuQT7eHs5OrF
 K/kY5lbTigb4ceFY9sSr8s0oFol2E2JNzLa9abiihwy7PMwDxTPPWwQ3KLrd1UvmBQCI
 j+8NruBOt3CWA5bsLYvLZl43+HcFH9qr8j9G3JGtshUXLJIQvoSLH0eeRbDLGMYQ4iiB
 hqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Tt17W8SjSdrHCnv+gdnh1e2BbNeEHnUakLSF7X1aRus=;
 b=kc9EXLRw23hBfUhJBfW+L3pEVbOvh7v9dq4VQsXK+j3HZhScP8qGvyFFgIi+lRkvuW
 oNjjckst1hJFm0uKXBr0uW5/lTJT81z/3RyVw8Lt8gGyvKT2PNBLKpPiazTUKW0CduMC
 0A204+JihJtfImf8OpEOUtCmHgofJlT94ZbxwtShAQifj7EsPIkyoow/1di5ssoppLfs
 sKavKUbgqPFXbyAMIa0Ajqzhgx/MhLCfp/JqlrOfeRFD3KSoWUzWAfjRAHarsajHoyQS
 MNDZOe3HNSz8/KmwM0uLJe+drOY7ku+TWEfMfob1zoenXkoYHhiMS04t/cu3TGJ3Vzrm
 JM9g==
X-Gm-Message-State: APjAAAXxE4yb2KYe42/dMgYZZawvYKcX8GR9CZidiYYbEl+lYW6zEnSl
 Xz2VbMJ3ZtvyWb8Xyn7GCCXpLQ==
X-Google-Smtp-Source: APXvYqz1pEdSep0S9ZKlikmCcpmH2moe8wen+qfO3yd8bHJeH2SY/rwzOiE3M+ehsVZY19ykt4YdFA==
X-Received: by 2002:a05:6000:1632:: with SMTP id
 v18mr33306970wrb.61.1568207698503; 
 Wed, 11 Sep 2019 06:14:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b7sm2441545wrj.28.2019.09.11.06.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 06:14:57 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 26A601FF87;
 Wed, 11 Sep 2019 14:14:57 +0100 (BST)
References: <20190906202636.28642-1-alex.bennee@linaro.org>
 <CAFEAcA-DQ0Zq40Xnw5wkA6ojOUCf67xfX83nMEoKW_UrysJhjQ@mail.gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA-DQ0Zq40Xnw5wkA6ojOUCf67xfX83nMEoKW_UrysJhjQ@mail.gmail.com>
Date: Wed, 11 Sep 2019 14:14:56 +0100
Message-ID: <871rwn0yb3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v4 0/4] semihosting at translate time fixes
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 6 Sep 2019 at 21:26, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> Hi Peter,
>>
>> Hopefully this is the final version of the semihosting at translate
>> time patches. I've applied Richard's IS_USER changes and gated the SVN
>> for !M profile.
>>
>> Alex Benn=C3=A9e (3):
>>   target/arm: handle M-profile semihosting at translate time
>>   target/arm: handle A-profile semihosting at translate time
>>   target/arm: remove run time semihosting checks
>
> Hi. I've just been looking at these, and I noticed that
> they seem to accidentally extend the "no semihosting
> in user mode" check that is currently for softmmu only
> to also cover linux-user mode (where it would amount
> to "never provide semihosting").

I misread Richard's comments - he only actually said to drop the #ifndef
CONFIG_USER while using !IS_USER for M profile. I'll return the #ifndef
CONFIG_USER for A-profile.

It does seem a bit weird that userspace linux-user does do semihosting
whereas EL0 in softmmu doesn't. Is that because we are effectively
short-circuiting what a real ARM kernel would be doing for EL0?

> This is because we used
> to do the check in the helper.c code which is only used
> by softmmu, and not in the linux-user/arm/cpu_loop.c
> equivalent that linux-user uses. But now we do the check
> in translate.c, which is common to both.
>
> There's also some missed cleanup in that the linux-user
> code can also have the "maybe EXCP_BKPT/EXCP_SWI is a semihosting
> call" checks deleted.

I'll have a look at that.

>
>> Emilio G. Cota (1):
>>   atomic_template: fix indentation in GEN_ATOMIC_HELPER
>
> I've taken the atomic_template fix into target-arm.next,
> since it's unrelated.
>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

