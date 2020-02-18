Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948F5C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:12:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F031206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbEtEPzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F031206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42g3-0002n2-Jp
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j42Uz-0002Dx-Lf
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:01:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j42Uy-0000r7-De
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:01:13 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26626
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j42Uy-0000qL-9Z
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582030871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A/PEQ/BQYEoO84xp7bUNwJiZKcwSvIp5AEb/fWos3Lk=;
 b=hbEtEPzxAJhZA5j410YS9aWmeBZRdTt0C4Mqul6SgPs1VFqQCm6aW/ijj0+5Kl1ZtIoDi5
 Yftdc1i14G8wV6jgKZi4KvE9bVbZqhYqPAcjiHrEYrqfYPa5JoFUlrYUePnu4VY/IsNtD1
 CGBi2TfCzNt3SLFkH2Q3AhvA480PeXA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-z1exmOS3MAmoEWBGSkiBDA-1; Tue, 18 Feb 2020 08:01:02 -0500
Received: by mail-wr1-f69.google.com with SMTP id d8so10719843wrq.12
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 05:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZNoIJKcRoHyoZU50osJDMxBPX5ITqrXD/I+VU9z75js=;
 b=PrGEsVBvEkR4pZj2qT4202Ul7BAlHGn5ZIFN0SEytf9blbtM9CO4HKj0ZfRqk8LER6
 pfY7/hZFy9u3IPTZZwC1XO781siSGYp9hJiET2tAYUO9mw8ZlfnRGXfc+yDC1VUV+8Vh
 q51Kljc4iiTD4QMLnW7mbmrqqch4ej9NovL/9NqpDsoyWI/lFmoxpr6ZpmVnpQBpMg90
 DJU/kNNXsWIgmM36oOxM1Iw12YUrTWGRugqNM3HKfl1JPOPHhGZGGk77bh8mBGi/qMN3
 sYlMyyGTEolXhlw1iW5FUoiDY7Piew0/jt0ecZm7COyqF+ObcAx9vnMhAmHgrpTqj310
 mF0Q==
X-Gm-Message-State: APjAAAXiWhtN+ZTXYHXgD9EUdijQiDCx22uurYDVXHAi37YM/GjhojGO
 ZAFtlasXguGYY+fT+gqPpz8Wt0OI1yq4LuZjQ8GeuR63wNKD7zIbMLUTFprcuvHLNzY3Ih73hLn
 Xr5rhrwwFm+ROYco=
X-Received: by 2002:adf:f012:: with SMTP id j18mr28853593wro.314.1582030861252; 
 Tue, 18 Feb 2020 05:01:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqyg7pylGx9W+ptwNYL64XmN24qk5Jnu86wu+PCM2uHavmwuGtdcnqvmgfg2h4jtF74pQ2wodQ==
X-Received: by 2002:adf:f012:: with SMTP id j18mr28853563wro.314.1582030861036; 
 Tue, 18 Feb 2020 05:01:01 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id t128sm3582130wmf.28.2020.02.18.05.00.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 05:01:00 -0800 (PST)
Subject: Re: [PATCH 00/22] linux-user: generate syscall_nr.sh
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20200217223558.863199-1-laurent@vivier.eu>
 <80c66cb5-3f04-5066-8be4-a53ece4f500f@redhat.com>
 <d2d57fb3-7b9f-71e7-57be-ae6b37cd47a1@vivier.eu>
 <CAL1e-=hwcTXcAOapivTYD8HFONRnhdHnSGWPwT6530SkCuYCbg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6493e4b0-2759-2f58-a7dd-69d390d49b5d@redhat.com>
Date: Tue, 18 Feb 2020 14:00:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hwcTXcAOapivTYD8HFONRnhdHnSGWPwT6530SkCuYCbg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: z1exmOS3MAmoEWBGSkiBDA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/18/20 12:51 PM, Aleksandar Markovic wrote:
> On Tuesday, February 18, 2020, Laurent Vivier <laurent@vivier.eu=20
> <mailto:laurent@vivier.eu>> wrote:
>=20
>     Le 18/02/2020 =C3=A0 07:13, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=
=C2=A0:
>      > On 2/17/20 11:35 PM, Laurent Vivier wrote:
>      >> This series copies the files syscall.tbl from linux v5.5 and
>     generates
>      >> the file syscall_nr.h from them.
>      >>
>      > [...]
>      >> Laurent Vivier (22):
>      >> =C2=A0=C2=A0 linux-user: introduce parameters to generate syscall=
_nr.h
>      >> =C2=A0=C2=A0 linux-user,alpha: add syscall table generation suppo=
rt
>      >> =C2=A0=C2=A0 linux-user,hppa: add syscall table generation suppor=
t
>      >> =C2=A0=C2=A0 linux-user,m68k: add syscall table generation suppor=
t
>      >> =C2=A0=C2=A0 linux-user,xtensa: add syscall table generation supp=
ort
>      >> =C2=A0=C2=A0 linux-user,sh4: add syscall table generation support
>      >> =C2=A0=C2=A0 linux-user,microblaze: add syscall table generation =
support
>      >> =C2=A0=C2=A0 linux-user,arm: add syscall table generation support
>      >> =C2=A0=C2=A0 linux-user,ppc: split syscall_nr.h
>      >> =C2=A0=C2=A0 linux-user,ppc: add syscall table generation support
>      >> =C2=A0=C2=A0 linux-user,s390x: remove syscall definitions for !TA=
RGET_S390X
>      >> =C2=A0=C2=A0 linux-user,s390x: add syscall table generation suppo=
rt
>      >> =C2=A0=C2=A0 linux-user,sparc,sparc64: add syscall table generati=
on support
>      >> =C2=A0=C2=A0 linux-user,i386: add syscall table generation suppor=
t
>      >> =C2=A0=C2=A0 linux-user,x86_64: add syscall table generation supp=
ort
>      >> =C2=A0=C2=A0 linux-user,mips: add syscall table generation suppor=
t
>      >> =C2=A0=C2=A0 linux-user,mips64: split syscall_nr.h
>      >> =C2=A0=C2=A0 linux-user,mips64: add syscall table generation supp=
ort
>      >> =C2=A0=C2=A0 linux-user,scripts: add a script to update syscall.t=
bl
>      >> =C2=A0=C2=A0 linux-user: update syscall.tbl from linux 0bf999f9c5=
e7
>      >> =C2=A0=C2=A0 linux-user,mips: move content of mips_syscall_args
>      >> =C2=A0=C2=A0 linux-user,mips: update syscall-args-o32.c.inc
>      >
>      > I suppose the patch subject was generated and you meant to use
>      > "linux-user/" instead of "linux-user,". Is that right?
>      >
>=20
>     No, the idea is they touch "linux-user" subsystem and "ARCH" subsyste=
m,
>     not especially the "linux-user/ARCH" directory
>=20
>=20
> I think Laurent's marks are appropriate, in fact, very useful for these=
=20
> areas of code. Elsewhere,,for example, one could use "softfoat,mips" for=
=20
> changes in softfloat affecting mips only.

Good example, thanks!

>=20
> Regards,
> Aleksandar
>=20
>     Thanks,
>     Laurent
>=20


