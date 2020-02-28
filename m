Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334EDC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 19:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E87552469F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 19:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+Ndgn01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87552469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7lCp-0002aR-5r
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 14:21:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j7lBm-0001tC-TZ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:20:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j7lBl-0003mE-CJ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:20:46 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j7lBl-0003kx-3v
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:20:45 -0500
Received: by mail-wm1-x342.google.com with SMTP id z12so4403637wmi.4
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 11:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=V25sqS5vpwDOoxYFwsGqEP8HZVrsLTz5jgw6HtEJp48=;
 b=N+Ndgn01ihXFmwgl6Ek/qv7VHMdAYsCYGNhkmTzapNNKiOHvEK/mjxY2ZxO/4HNrZb
 UThG6HmnwdDLUWwG1ya1vxQRH+GX4ojIjZcF4jlEp4aMCdqMJSGwBBKVLeLOz5Q2hyIy
 A991tLGetvPA/3TB4Ag2Peja/TyLFFpQM43MzLuNjccHYnvNaJJGKiyiXkbV8xxytfnO
 etJBJ5Pb6T73MW+oKLAHkN75XdIM51na1Y/RHhdQX20PBUY33oXyP+hVXeNDwe92PvWu
 pvoJlSSFCQDJK35jedhHfoFzDao+10FeEd29LiOCM8H6KTn89ML5/JAWWgd8QcG5VfAK
 C7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=V25sqS5vpwDOoxYFwsGqEP8HZVrsLTz5jgw6HtEJp48=;
 b=KHomoMPmY2OQ6gF3QYTJM0fVhOstgWoQm9QU5dPLU24JkMOPiAGx74LeQ0mTunwk8P
 agISunoAHcV9JbN2PlcuXXPj/v+8vXIz2XO5LUqQtfrZRdubh1mvIl6BwV037HbhVMX0
 6n4I+ezdTQrupy4AdlIz8/clPLPsYeiizc/PAPc3FAG5g9rbYJiSVy1k8MKKRMAkscro
 z/7YOc6OFKfTqEL/Q+hKhO45OeFWgbRj286fxpsuKCq09I4N8WP1vsn5f1fUcLBZtaq1
 yr55foW5U9ich5PTKupCkZRZ6U1keZMNaM7Zx63vHdjv2m7tfPZ7Sqek95To0Ju9+i4w
 ghfA==
X-Gm-Message-State: APjAAAVTxPNBACbJJfe6PgcTQ/Evzh0rI+mjrO5eyd+2/NFH3H1SmDQ9
 iVyD1HoXTb6WYaW/KmZx3gxzEw==
X-Google-Smtp-Source: APXvYqzFlfg8oo+TKsSMMyzJbHzfLLLGJaJBflmpLlNitp8vrdWia5jfar4OL+7qrs661PuJlziEhw==
X-Received: by 2002:a1c:7907:: with SMTP id l7mr5942081wme.37.1582917641846;
 Fri, 28 Feb 2020 11:20:41 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f1sm13929798wro.85.2020.02.28.11.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 11:20:40 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C053C1FF87;
 Fri, 28 Feb 2020 19:20:39 +0000 (GMT)
References: <20200226181020.19592-1-alex.bennee@linaro.org>
 <20200226181020.19592-5-alex.bennee@linaro.org>
 <2ca7b55b-5674-370d-5c4d-dc8b7782ca64@linaro.org>
 <87pne0w6rt.fsf@linaro.org>
 <56f5e355-9357-e212-e92b-9db1d8424dea@linaro.org>
 <CAPan3WrSRm986EfwJdXV2MduNLE5BS+QmCv0Bo5-BD+QfT-=dg@mail.gmail.com>
 <20200228084729.3bb8bf11@redhat.com>
User-agent: mu4e 1.3.8; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v1 4/4] accel/tcg: increase default code gen buffer size
 for 64 bit
In-reply-to: <20200228084729.3bb8bf11@redhat.com>
Date: Fri, 28 Feb 2020 19:20:39 +0000
Message-ID: <875zfqwmbc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Igor Mammedov <imammedo@redhat.com> writes:

> On Thu, 27 Feb 2020 20:07:24 +0100
> Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
>
>> Hi Richard,
>>=20
>> On Thu, Feb 27, 2020 at 1:57 PM Richard Henderson <
>> richard.henderson@linaro.org> wrote:=20=20
>>=20
>> > On 2/27/20 4:31 AM, Alex Benn=C3=A9e wrote:=20=20
>> > >> It does not make sense for a linux-user chroot, running make -jN, o=
n=20=20
>> > just about=20=20
>> > >> any host.  For linux-user, I could be happy with a modest increase,=
 but=20=20
>> > not all=20=20
>> > >> the way out to 2GiB.
>> > >>
>> > >> Discuss.=20=20
>> > >
>> > > Does it matter that much? Surely for small programs the kernel just
>> > > never pages in the used portions of the mmap?=20=20
>> >
>> > That's why I used the example of a build under the chroot, because the
>> > compiler
>> > is not a small program.
>> >
>> > Consider when the memory *is* used, and N * 2GB implies lots of paging,
>> > where
>> > the previous N * 32MB did not.
>> >
>> > I agree that a lower default value probably is safer until we have mor=
e=20=20
>> proof that a larger value does not give any issues.
>>=20
>>=20
>> > I'm saying that we should consider a setting more like 128MB or so, si=
nce
>> > the
>> > value cannot be changed from the command-line, or through the environm=
ent.
>> >=20=20
>>=20
>> Proposal: can we then introduce a new command line parameter for this?
>> Maybe in a new patch?
>
> linux-user currently uses 32Mb static buffer so it probably fine to
> leave it as is or bump it to 128Mb regardless of the 32/64bit host.
>
> for system emulation, we already have tb-size option to set user
> specified buffer size.
>
> Issue is with system emulation is that it sizes buffer to 1/4 of
> ram_size and dependency on ram_size is what we are trying to get
> rid of. If we consider unit/acceptance tests as main target/user,
> then they mostly use default ram_size value which varies mostly
> from 16Mb to 1Gb depending on the board. So used buffer size is
> in 4-256Mb range.
> Considering that current CI runs fine with max 256Mb buffer,
> it might make sense to use it as new heuristic which would not
> regress our test infrastructure and might improve performance
> for boards where smaller default buffer was used.

I've dropped it from 2gb to 1gb for system emulation. For the acceptance
tests I doubt we'll even fill the buffer but the mmap memory should
overcommit fine.

>
>
>> Since the size of the code generation buffer appears to have an impact on
>> performance,
>> in my opinion it would make sense to make it configurable by the user.
>>=20
>> Regards,
>>=20
>>=20
>> >
>> >
>> > r~
>> >
>> >=20=20
>>=20


--=20
Alex Benn=C3=A9e

