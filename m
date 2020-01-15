Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DF8C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8327624679
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HXxC8Zl0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8327624679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iriap-0001N9-U4
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 08:20:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1iriWM-0006P7-AE
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:15:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1iriWI-0007JC-5r
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:15:42 -0500
Received: from mout.gmx.net ([212.227.15.15]:52633)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1iriWH-0007Hi-NT
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:15:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1579094131;
 bh=7rMloQxfTONr+Ip7fDqtWzl7kWYk2nEhEz2lY1Zas0Y=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=HXxC8Zl0BHCN5vN0/ugAzykzQvxE4qfo+Nbw+WF/sqVjPSp92J66flabdlWOM9qgo
 rD5bOdd5J9G1H2f28qewfgy5SMgQBQSLkr7LmTi3ETCoXjirkT8pQOwuUUvl/gNYA4
 lK1nLtF1FwQC6NwCrD1XEzd2BD/K3RbBmah/Q1Kg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbRk3-1jOaUt3rz7-00boMj; Wed, 15
 Jan 2020 14:15:31 +0100
Subject: Re: [PATCH 0/4] Implements the NetBSD Virtual Machine Monitor
 accelerator
To: qemu-devel@nongnu.org
References: <20200107125401.18126-1-n54@gmx.com>
From: Kamil Rytarowski <n54@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Message-ID: <7f786d62-fafb-13d1-df1a-5a706ad4a665@gmx.com>
Date: Wed, 15 Jan 2020 14:14:52 +0100
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200107125401.18126-1-n54@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mNeOW42JNWQ2LtO10nkaeGvEfP4x72ccP"
X-Provags-ID: V03:K1:LbwdgvYkgTPRWDSQ2EGZjNw8yIOm4fFQFL71gQZg+o+Oo1mruT7
 GQKbevm7vRVy+I/aw8jbwobdPAwZPY1Qa8hSFo80W/xOC9kukwomrRjCBjxkxHKkR8jliWI
 xVUrj26U91iyXPffgGqY03rXGPQ1EVfs3VHX6gR7BgHM3KN2EuRocWzxYbrTsqWrlYzDWl3
 2e01ipLwe92USGexJhuNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Twex7BnEvo8=:8pZSILnu+jmTuFnRf/hZnR
 HTVM/68VTTTK1z3F5++AXelinAYkwwZV+u/pt0RU68wsBl6Wq0sbtammx+5VsqojePpUldhz5
 /gJiXd8zkljcWRnLlPo694Rw6asV0+ARb/b+HHCnF/ey6/LTqUdO75OlojjRCVGUJM0CAW79Q
 ZN2ySulK91kcgGqegxZPAMY9lrnwDozbhQz+IXaTIqG7nfprnKgbysfrq19eYrC2m+KRD7xm0
 jEk2ZteE2UaIbVmaoJ4YOkuKJjf8jZimUqMwrGIv6D7b/btdMCpGlp7xkf7xBDRG3QBsdwKSL
 lIa2T0vN2kntkjwWNq+WlCcsvfau6pXklwTEkxCVbWoddFRiFg1sy+Db84obU2jeD+eQZo7JL
 QoAPjNJYEnRQ5HwPoMswgeW06K1DEEUb/TtU3WRFztC8c24koDZSjQt2KxNjzc/1XecaLkWhb
 yFiGqIxQ/9kTWMAXP6fF3S7RGwgc1rFQtvTzgWoPDgK8TPXVQrmQ41DRc129TtqRBQ9xjZ0cd
 nUahMuEp55d9U75cG/ae36EbonaThBfhIoTqp36xeFd+F4mZYmyJg++L8DYFZ0AN6KoYOMRYI
 5JkbpEhF+ZIDUEZHCHIzBDi+yUJjUEYyVvrVrHaRLbEldPYcAFTZbdf2RN7bv5zCF2nErYQHU
 h1diPMaT9ShE24DTF8mrfUezt93YCzWXCkE6wGlYKwZ90YncghVczq24yd3pTyIEMyUpO1uuu
 dLktqGuXnr4PhG9mHEsGbYH3tp37pRmuz74h5jY+n0kVjynZ0Q0j5+oygkK3gLjtbC1fesWlL
 HuIwgiE1+mrIYV2Uid2foLx3/Z1svqYI3dCuG31kRfVTO7TGl1X6wYHsYt2UhnwEAH2uIaEPY
 drRK9pnRmvrZykXpWLLNV5PozAxzxt2XcnTOhS19aJtK/PnI0LVUXvA8y1bSvyfPnCxeJ1eA0
 +hslRnSzXV8SToOMvebRcNpsu50c/8nJ1PJhSpqrYbDepukdAJH477btIqrRh9xduFq1IWJhy
 HwsFkdiILEXjcNaf9q2GuosWUJLk0Ev8nOUHKgoXK93MYvq/cytMfXRVlT1QfDLnwYv2l2nMx
 4jigUQfbrwnEP7lCcYGw714T1ETZIZdAf9ci5choAbSSoEYGEBf8CXAK0Tq/+MseBu4wJJ38y
 arpj0hJOI3UdkND1PZMp1HKjnfF2GWjHSZjjKmsAxYXRS35xoYFxhLRyHiEKbRFAbHv8krrSF
 EqvLSdgUfoHCNTLya6HTbalBk7H7vKsVwHjm1Vw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.15
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
Cc: pbonzini@redhat.com, Maxime Villard <maxv@netbsd.org>,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mNeOW42JNWQ2LtO10nkaeGvEfP4x72ccP
Content-Type: multipart/mixed; boundary="Fyzsk3iBQaJjsaYL9TmDoGO98BRwRhvH5";
 protected-headers="v1"
From: Kamil Rytarowski <n54@gmx.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 Maxime Villard <maxv@netbsd.org>
Message-ID: <7f786d62-fafb-13d1-df1a-5a706ad4a665@gmx.com>
Subject: Re: [PATCH 0/4] Implements the NetBSD Virtual Machine Monitor
 accelerator
References: <20200107125401.18126-1-n54@gmx.com>
In-Reply-To: <20200107125401.18126-1-n54@gmx.com>

--Fyzsk3iBQaJjsaYL9TmDoGO98BRwRhvH5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Ping?

On 07.01.2020 13:53, Kamil Rytarowski wrote:
> Hello QEMU Community!
>=20
> Over the past year the NetBSD team has been working hard on a new user-=
mode API
> for our hypervisor that will be released as part of the upcoming NetBSD=
 9.0.
> This new API adds user-mode capabilities to create and manage virtual m=
achines,
> configure memory mappings for guest machines, and create and control ex=
ecution
> of virtual processors.
>=20
> With this new API we are now able to bring our hypervisor to the QEMU
> community! The following patches implement the NetBSD Virtual Machine M=
onitor
> accelerator (NVMM) for QEMU on NetBSD 9.0 and newer hosts.
>=20
> When compiling QEMU for x86_64 passing the --enable-nvmm flag will comp=
ile the
> accelerator for use. At runtime using the '-accel nvmm' should see a
> significant performance improvement over emulation, much like when usin=
g 'hax'
> on NetBSD.
>=20
> The documentation for this new API is visible at https://man.netbsd.org=
 under
> the libnvmm(3) and nvmm(4) pages.
>=20
> NVMM was designed and implemented by Maxime Villard.
>=20
> Thank you for your feedback.
>=20
> Maxime Villard (4):
>   Add the NVMM vcpu API
>   Add the NetBSD Virtual Machine Monitor accelerator.
>   Introduce the NVMM impl
>   Add the NVMM acceleration enlightenments
>=20
>  accel/stubs/Makefile.objs |    1 +
>  accel/stubs/nvmm-stub.c   |   43 ++
>  configure                 |   36 ++
>  cpus.c                    |   58 ++
>  include/sysemu/hw_accel.h |   14 +
>  include/sysemu/nvmm.h     |   35 ++
>  qemu-options.hx           |    4 +-
>  target/i386/Makefile.objs |    1 +
>  target/i386/helper.c      |    2 +-
>  target/i386/nvmm-all.c    | 1222 +++++++++++++++++++++++++++++++++++++=

>  10 files changed, 1413 insertions(+), 3 deletions(-)
>  create mode 100644 accel/stubs/nvmm-stub.c
>  create mode 100644 include/sysemu/nvmm.h
>  create mode 100644 target/i386/nvmm-all.c
>=20
> --
> 2.24.0
>=20



--Fyzsk3iBQaJjsaYL9TmDoGO98BRwRhvH5--

--mNeOW42JNWQ2LtO10nkaeGvEfP4x72ccP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAl4fEFIACgkQS7MI6bAu
dmyMbA//VzeSFIPJ4J8oiKdrBY6An4mTyQllLmsjhIbrhOdIS3zA3W1mPe5cYF5o
0f2QJbFo984TEOned1tc9w4PYrpGefbzHfe01A1sxd6Z6S6F/6edpeU8asHdZNwC
LMhZSVzobGso8UmIdPPOoJqXkQCMT0NFVC57nYC1++WnJi1IXGANYWbygBuvGjJN
QJsI2//AwN5xSWJuCNTINoJVkCaVI8zyd7eNrSD+1dY3ZqbFgfBHYNLmnCUsavfm
6SGwzFoT92i5ijtK9WxUpbHspyHlXg25yD9wTbbXd49lsFFqMVsc3NN0+y4vEnGQ
UoBkc2TktS1qYiA6/5D9iFxfp+8ahku37I9aIfIookxatvp2KTHLj/bNnt+1L3zW
shy+K9rdj9c57eMb1Du/lLnScdEGeLgWiFp0S9f/+MVDKJskkaLfD/kAs1+IbVZf
u6Ormqsh9WcgmZSca8QQSm6cJWJSGjJHIgQCYJG7jX5n9/awucLeuea2siew9MtG
cXPbORbXD8W/eYqNKar2Ex50ml70Uh2HTm4VRy+dhj51tFiU/gTk7z7hIucTyW7U
hYHnlDkZm63FWx9YZ963cvVdk3+PtavuK17TYuDbgpQ6f5MCsZm2tP7CXf1speK/
wJr/ZE2JHFlf66uSFVVedVWyqakcoIgvv59smIhfRh8V/YRRRLg=
=S3xC
-----END PGP SIGNATURE-----

--mNeOW42JNWQ2LtO10nkaeGvEfP4x72ccP--

