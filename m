Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A260FC55179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 10:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30F92087E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 10:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhuxUEXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30F92087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaz7v-0005sN-TM
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 05:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kaz74-0005LA-0n
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 05:36:58 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kaz72-0003wV-51
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 05:36:57 -0500
Received: by mail-wm1-x343.google.com with SMTP id v5so888476wmh.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 02:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=c0Kjw6nsoZXGdc/tg3cNix4DWFnyoJPxU38FOBeLYTU=;
 b=FhuxUEXCu1Qci9Gga8/CCo460iOcAaGjQ+1xPRKqcEbArDIJz0gTppyAiwH2d/aZ9A
 0518hwUhrGqdcEuj9nqNHO5pKBJF6BiQ6mEVX6AoDFskrSZ4BA6pjPV/7c6Ure5CL7CL
 m2FFkfcx9+08d0sxEvlGi4qtcpxX8t0ZK+aXzSr5oiPKjqcF/qPc6JiW2RZr8fDjMN6Z
 eq9ILaltyAOU4hLfp6IaLM7J7rBal9iPfNIOZHKtCuCi5FzaMGF6BvnXofaWLk/MmgXD
 qg4Z7zVsltY9EhEuUfulnJ37/3sJeEl3DZgnsAp+5Yn9Z/V99mmgWBTdFDE6I/iF4q5n
 pKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=c0Kjw6nsoZXGdc/tg3cNix4DWFnyoJPxU38FOBeLYTU=;
 b=QDMeYCDAhcEVlOm0qpxPC5oNzpIj03aXGJ3ToRVQsEpZT4TbLxnl4is3Zb8pRc9kY3
 dTHz+Cl2GDYpvvmuSHO0ro1ETCbON7eqAX0VFz2trcdLMjvzRLV0uQYwKMfFHra08Rtz
 XAeUhbAFW3A9PH2lR00/tQJq2aEH7pzdfzVBoZL7C0yBHKgoZwnQu8ZI574lzWyL5e+U
 fk5/oCfqke+eDsm+X/9uRFYEdOHuldhtkdVLhKlq19BUaDdKhOOgscSX7CsPAA8bC/Jw
 fEHhTXgPixaFm6C3FftgzsH/pjBO689251UfIEo6AT8bQWG5AkafsKPUTSB7COF00kXD
 7NUw==
X-Gm-Message-State: AOAM533Rjm02GWESU7dAT2uzR3ZHr5I4v2/+S5Q9cUHiRFVrX0dgq3Ff
 NlBK5B4JYdUxIux5ezQtu0f4ng==
X-Google-Smtp-Source: ABdhPJwX4ZeJJeCRzWvb90G97n2jO+xo09R+iPdEkn9suFwYCdK/R5EQLIKlnUO8EjCg8N3xWM31fQ==
X-Received: by 2002:a1c:f209:: with SMTP id s9mr1640847wmc.115.1604659013499; 
 Fri, 06 Nov 2020 02:36:53 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w1sm1421515wro.44.2020.11.06.02.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 02:36:52 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A84691FF7E;
 Fri,  6 Nov 2020 10:36:51 +0000 (GMT)
References: <CAKmqyKNoUg9f-NdgAoGrq_DuBwWv_ZgusArvOobxEYM1mpzbRA@mail.gmail.com>
 <mhng-5ca93c0e-3134-4384-915f-23c4aed71712@palmerdabbelt-glaptop1>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: Emulation for riscv
In-reply-to: <mhng-5ca93c0e-3134-4384-915f-23c4aed71712@palmerdabbelt-glaptop1>
Date: Fri, 06 Nov 2020 10:36:51 +0000
Message-ID: <87y2jeai0s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair23@gmail.com, qemu-devel@nongnu.org, moyarrezam@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Palmer Dabbelt <palmer@dabbelt.com> writes:

> On Thu, 22 Oct 2020 17:56:38 PDT (-0700), alistair23@gmail.com wrote:
>> On Thu, Oct 22, 2020 at 4:58 PM Moises Arreola <moyarrezam@gmail.com> wr=
ote:
>>>
>>> Hello everyone, my name is Moses and I'm trying to set up a VM for a ri=
sc-v processor, I'm using the Risc-V Getting Started Guide and on the final=
 step I'm getting an error while trying to launch the virtual machine using=
 the cmd:
>>
>> Hello,
>>
>> Please don't use the RISC-V Getting Started Guide. Pretty much all of
>> the information there is out of date and wrong. Unfortunately we are
>> unable to correct it.
>>
>> The QEMU wiki is a much better place for information:
>> https://wiki.qemu.org/Documentation/Platforms/RISCV
>
> Ya, everything at riscv.org is useless.  It's best to stick to the open s=
ource
> documentation, as when that gets out of date we can at least fix it.  Usi=
ng a
> distro helps a lot here, the wiki describes how to run a handful of popul=
ar
> ones that were ported to RISC-V early but if your favorite isn't on the l=
ist
> then it may have its own documentation somewhere else.

Even better if you could submit some .rst pages for QEMU's git:

  docs/system/target-riscv.rst
  docs/system/riscv/virt.rst (and maybe the other models)

then we could improve the user manual where RiscV is currently a little
under-represented. A number of the systems have simple example command
lines or explain the kernel support needed for the model.

>
>>> sudo qemu-system-riscv64 -nographic -machine virt \
>>> -kernel linux/arch/riscv/boot/Image -append "root=3D/dev/vda ro console=
=3DttyS0" \
>>> -drive file=3Dbusybox,format=3Draw,id=3Dhd0 \
>>> -device virtio-blk-device,drive=3Dhd0
>>>
>>> But what I get in return is a message telling me that the file I gave w=
asn't the right one, the actual output is:
>>>
>>> qemu-system-riscv64: -drive file=3Dbusybox,format=3Draw,id=3Dhd0: A reg=
ular file was expected by the 'file' driver, but something else was given
>>>
>>> And I checked the file busybox with de cmd "file" and got the following=
 :
>>> busybox: ELF 64-bit LSB executable, UCB RISC-V, version 1 (SYSV), dynam=
ically linked, interpreter /lib/ld-linux-riscv64-lp64d.so.1, for GNU/Linux =
4.15.0, stripped
>>
>> That looks like an ELF, which won't work when attached as a drive.
>>
>> How are you building this rootFS?
>>
>> Alistair
>>
>>>
>>> So I was wondering if the error message was related to qemu.
>>> Thanks in advance for answering any suggestions are welcome


--=20
Alex Benn=C3=A9e

