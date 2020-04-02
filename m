Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4636C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 10:49:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB4F206F5
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 10:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLc30K/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB4F206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJxPI-0000cu-QM
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 06:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJxNR-0007Pw-6l
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJxNO-0003jM-VT
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:47:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56334
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJxNO-0003iz-R1
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585824429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dzHj197saK/0eDH3hOWccORj8eyuxSFs83S9o+OmaPE=;
 b=ZLc30K/xuoiE1Vjzo6aRW89H6Q2SKOanHJcZaMaYsA1m+Cgj0cMRvLrNdFjlZFfd9Bwwev
 XQ4WO6CUrAm0ReaalsBf5eKdpdQT5JBt/V7rQ2jxK4hmi7Bbw0eFr0cZLThrkBUAnc6dMM
 Fy/g4G+RxaAnKvYrX5EWm8FDngGlVAM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-X6P7rZsaM5CnUJ-dpc7tRg-1; Thu, 02 Apr 2020 06:47:03 -0400
X-MC-Unique: X6P7rZsaM5CnUJ-dpc7tRg-1
Received: by mail-ed1-f70.google.com with SMTP id a3so2397117edy.8
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 03:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oN2/vNc6k/QjTjF2nb92U5EzkCCDY/gkJXTg0h/LnBI=;
 b=Lb0Gs4a0OeK/7h6EPWkvevgyYh3MnhDmJN8KW3QMhuCSc3WW+mJlYFk3kzX2TEcErF
 4sj24qaln060lpqmBCjnqMOZgNZI7cX8M1Cl8DNwKqxve1YCLuUYpIRJIn+55CG3gk6+
 7SPqP3qlgGddWFh7hR/pcAsQ6/TJigE+2zLJGv2bTIiJT0qSd/NSxOrjkdZKszlQ7/1x
 +9k0VGIqURZo5u0FNVXXGqheZxXDPx5SCZaftgGCep8l7jOb6hXmMPYhIwn0np3TJ+dn
 f8fBZACnzG67HE4J2wiVRtPxNoNGK9pBuibDgIpHrcaWY89UDxu1T/hjRe22yulTFdKv
 ahbA==
X-Gm-Message-State: AGi0PuacaqaUSgDYZbgr/WGqJN7kxtyEXifbvWGkh3BGgHralFwEmI58
 OmvumrP7Wb79W13Zs3yjwU2DOxfEQhU9l+q2jNw5ivEA11nuTVI7niRkl5NmAmZEDDluGG6Ov3I
 foiS6WpoxwdMmt+A=
X-Received: by 2002:a17:906:d8b0:: with SMTP id
 qc16mr2672136ejb.64.1585824422004; 
 Thu, 02 Apr 2020 03:47:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypL0tm/a3yuavkQiWbSiq1ERR0imV/HNseywRqOeMw4s0lZxP+csTKwHLlWSp3Up+mj/E1SC7g==
X-Received: by 2002:a17:906:d8b0:: with SMTP id
 qc16mr2672121ejb.64.1585824421697; 
 Thu, 02 Apr 2020 03:47:01 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f17sm862814edj.86.2020.04.02.03.47.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2020 03:47:01 -0700 (PDT)
Subject: Re: qemu-system-ppc 5.0 rc1 crashing on Windows
To: Howard Spoelstra <hsp.cat7@gmail.com>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>, qemu-ppc
 <qemu-ppc@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
References: <CABLmASEaKJKzDdvKGv+iWfp=0vdr9bupM76zvLZZ6sZFAPkuRg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6ad7d2d1-658c-04db-4ce0-77c498efbba4@redhat.com>
Date: Thu, 2 Apr 2020 12:47:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CABLmASEaKJKzDdvKGv+iWfp=0vdr9bupM76zvLZZ6sZFAPkuRg@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing the persons referenced in the commit you referred,
who happened to be chatting about this issue few hours ago on IRC.

On 4/2/20 11:28 AM, Howard Spoelstra wrote:
> Hi,
>=20
> I just compiled qemu-system-ppc for Windows, using native msys2 on=20
> Windows 10 64 bit and the 64 bit mingw cross compiler on Fedora 31. Both=
=20
> create executables that crash:
>=20
> qemu-system-ppc.exe -L pc-bios -boot c -m 512 -M mac99,via=3Dpmu -h
> da C:\Mac-disks\9.2.img
> Exception code=3D0xc0000005 flags=3D0x0 at 0x00007FFB2A602078. Access=20
> violation - attempting to write data at address 0x00000000034C76EC
>=20
> I bisected this down to:
>=20
> d2cd29e30736afd4a1e8cac3cf4da360bbc65978 is the first bad commit
> commit d2cd29e30736afd4a1e8cac3cf4da360bbc65978
> Author: Richard Henderson <richard.henderson@linaro.org=20
> <mailto:richard.henderson@linaro.org>>
> Date: =C2=A0 Tue Dec 17 13:47:37 2019 -1000
>=20
>  =C2=A0 =C2=A0 configure: Do not force pie=3Dno for non-x86
>=20
>  =C2=A0 =C2=A0 PIE is supported on many other hosts besides x86.
>=20
>  =C2=A0 =C2=A0 The default for non-x86 is now the same as x86: pie is use=
d
>  =C2=A0 =C2=A0 if supported, and may be forced via --enable/--disable-pie=
.
>=20
>  =C2=A0 =C2=A0 The original commit (40d6444e91c) said:
>=20
>  =C2=A0 =C2=A0 =C2=A0 "Non-x86 are not changed, as they require TCG chang=
es"
>=20
>  =C2=A0 =C2=A0 but I think that's wrong -- there's nothing about PIE that
>  =C2=A0 =C2=A0 affects TCG one way or another.
>=20
>  =C2=A0 =C2=A0 Tested on aarch64 (bionic) and ppc64le (centos 7) hosts.
>=20
>  =C2=A0 =C2=A0 Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org=20
> <mailto:alex.bennee@linaro.org>>
>  =C2=A0 =C2=A0 Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org=20
> <mailto:alex.bennee@linaro.org>>
>  =C2=A0 =C2=A0 Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m=20
> <mailto:philmd@redhat.com>>
>  =C2=A0 =C2=A0 Signed-off-by: Richard Henderson <richard.henderson@linaro=
.org=20
> <mailto:richard.henderson@linaro.org>>
>=20
> Please note that I tried again after applying patch=20
> https://patchwork.ozlabs.org/patch/1265368/ However, this has not solved=
=20
> my issue.
>=20
> Best,
> Howard
>=20
>=20


