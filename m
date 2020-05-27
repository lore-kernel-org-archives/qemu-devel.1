Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF258C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:15:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7472020787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vYVwyxA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7472020787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdyiV-0002nM-Li
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 12:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdyhc-0002CV-80
 for qemu-devel@nongnu.org; Wed, 27 May 2020 12:14:48 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdyha-0003I3-W4
 for qemu-devel@nongnu.org; Wed, 27 May 2020 12:14:47 -0400
Received: by mail-wm1-x342.google.com with SMTP id n5so3665763wmd.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 09:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=r8qHJIgWhppAFYzAUdm3/h/5yqURBHPwJMJOPlqcDok=;
 b=vYVwyxA2hKwfSaCjuaqmHjF1R3W8XoTfrf5ifvgynJ77ZijqR6a8vUXDudkAbhgdNm
 wW0QjiDy9mabTzziZHQKgjoAKqXNNJLW1BCYobiW98cwAhzgY1BU5zWPlVPviNrHGMYX
 HSxCiyVeVR5U/Pr1mAlk6ebuS6gH95duhipHS8THMcrdfnwV63nyXUDnywREfdQFlc5K
 PPw8xQWERZ5OSW8iV1DKdhQADkJE7mllmRwxL9pYMELIN6KF3oF4RNBYFS89GvrEZqc+
 l0Cadarsu3WEIIiUR0NvMjIt10Z0Axx88rGMVRFhhLaJsGAZSUuvpAQFQ7twK+EwUYJR
 p7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=r8qHJIgWhppAFYzAUdm3/h/5yqURBHPwJMJOPlqcDok=;
 b=WWQ+iUz4m+3hQBtpq0sg89KYeSZQS6PzBNa/YzxlG+B0jAwVReIdoHi1BOTY0RohZV
 AZf92jZJ2Z4J0JkmG8KnDfScwvrA0znjrUGYfi60tEwpOItFAw3tWTp+t3xZ1qAL+xPh
 TLLiur8nIJa+dua5xdF1D1jx3fyZN9u4zF1Z9K5UnkFEhQrc4Ma2jGQlbNvWqBAaYpEw
 M36BTIhv7d9gyiRelBxa9ppaJpCxsZi2nNoXElTUD8fC64JOb8ZJ1ejTprCg/EJjw/73
 RKxn2BfcHnHDBDxCEILhhZuCa39hgx9w1k+31roKfSwhr5BefDc/RHhDbfeXem3hS6CO
 lUWQ==
X-Gm-Message-State: AOAM5326ZE9FBbG1OLPPsuwerWOarJYX86u/3HFh1H22Jpajs44eSDQw
 IC5MKZ18tOqSEOe8iB1Ct+ytEw==
X-Google-Smtp-Source: ABdhPJxXyk7Hykq+74h27qZMVFMOouFma2isjlhuj+K/DmeRFycu6Jhra6Do5UQZQSEOJPl4Oaha7g==
X-Received: by 2002:a1c:f207:: with SMTP id s7mr4904348wmc.123.1590596085420; 
 Wed, 27 May 2020 09:14:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l5sm3080420wml.27.2020.05.27.09.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 09:14:43 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 430821FF7E;
 Wed, 27 May 2020 17:14:43 +0100 (BST)
References: <20200527100546.29297-1-alex.bennee@linaro.org>
 <20200527100546.29297-3-alex.bennee@linaro.org>
 <CAHiYmc7EJVxKXZ4G96cL-Bm3tT8UR_dgr7y3oisUMnuJ0u3zaw@mail.gmail.com>
 <CAHiYmc7TYHMcitiG9ELxfz-EC8DSG1b7FeFsxXxTbu-7FSih=Q@mail.gmail.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [PATCH v1 2/3] linux-user: deal with address wrap for
 ARM_COMMPAGE on 32 bit
In-reply-to: <CAHiYmc7TYHMcitiG9ELxfz-EC8DSG1b7FeFsxXxTbu-7FSih=Q@mail.gmail.com>
Date: Wed, 27 May 2020 17:14:43 +0100
Message-ID: <87pnap5p8s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bug 1880225 <1880225@bugs.launchpad.net>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> writes:

> =D1=81=D1=80=D0=B5, 27. =D0=BC=D0=B0=D1=98 2020. =D1=83 14:05 Aleksandar =
Markovic
> <aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>
>> =D1=81=D1=80=D0=B5, 27. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:07 Alex Benn=
=C3=A9e <alex.bennee@linaro.org> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>> >
>> > We rely on the pointer to wrap when accessing the high address of the
>> > COMMPAGE so it lands somewhere reasonable. However on 32 bit hosts we
>> > cannot afford just to map the entire 4gb address range. The old mmap
>> > trial and error code handled this by just checking we could map both
>> > the guest_base and the computed COMMPAGE address.
>> >
>> > We can't just manipulate loadaddr to get what we want so we introduce
>> > an offset which pgb_find_hole can apply when looking for a gap for
>> > guest_base that ensures there is space left to map the COMMPAGE
>> > afterwards.
>> >
>> > This is arguably a little inefficient for the one 32 bit
>> > value (kuser_helper_version) we need to keep there given all the
>> > actual code entries are picked up during the translation phase.
>> >
>> > Fixes: ee94743034b
>> > Bug: https://bugs.launchpad.net/qemu/+bug/1880225
>>
>> For the scenario in this bug report, for today's master, before and after
>> applying this patch:
>>
>
> I am not sure how significant is this info, but I executed the test
> without applying patch 1/3, so only 2/3 was applied in the case
> "AFTER".

That is expected. The other fix only affects binaries run inside a
/proc-less chroot and the final patch is a test case for COMMPAGE
support.

--=20
Alex Benn=C3=A9e

