Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6C6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:06:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A315206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dRiGVSRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A315206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw6tv-000227-HC
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 11:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1iw6qZ-0008Ti-0N
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:02:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1iw6qX-00081G-TC
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:02:42 -0500
Received: from mout.gmx.net ([212.227.17.21]:55523)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1iw6qX-0007zy-FP
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1580140949;
 bh=UQDIRZOUUL9w3Mf0tALUps1kgp20Xa2aiqp+sG/NrCg=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=dRiGVSRZtLXyz/dz1IHiQWiKu4Z9LgD2byU66Upj5Tfwy44FuSIBpzOpIN/ztyyc2
 XqQ564emNiE0AwR4Q1YQlSPWssDUIhXJah+K7iFloRQVDUdB5fiK6ulYlWsKFuT0NE
 m6sUgyA8qW0Cs5AIhue9N8BfI2ImVIewL/+psh7Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ma20q-1j8Kjw3Dca-00VvwD; Mon, 27
 Jan 2020 17:02:28 +0100
Subject: Re: [PATCH 0/4] Implements the NetBSD Virtual Machine Monitor
 accelerator
From: Kamil Rytarowski <n54@gmx.com>
To: qemu-devel@nongnu.org
References: <20200107125401.18126-1-n54@gmx.com>
 <7f786d62-fafb-13d1-df1a-5a706ad4a665@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Message-ID: <2c986674-ba87-885a-ccb3-787e7aededee@gmx.com>
Date: Mon, 27 Jan 2020 17:01:41 +0100
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7f786d62-fafb-13d1-df1a-5a706ad4a665@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="e1JpJWfvnKK38AgOlqUWqo0qjW08EPlu3"
X-Provags-ID: V03:K1:1Rt17XP+zB8owl+HGLtZV/Vhr02uOB1YsNxK1uAaRiwVrEfT8oM
 Zwlw4Crqo7H2qEoFNfGNE5umCU3MJ1EkmjhSVpTQ27sYOYVg4qebxCSYzKkuB7HHPswdXS8
 You6bnpY1aWHn46CdRP4gf4IoU9982qTu0jkCqVur5fXbAa6KhR+2jSo/zBxuPn/Z/fOPC6
 gKr0mRC0lb1Ln+A7T7iUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0STxjNcz6Yc=:+g4AhDsIb6b1NGjNZBEodi
 X0Aujl4N79HYKyvOinmU7UkRzK3D8gq/PNFepixb7yN+6OKbWUUAU5nvvbwxzxpsFSOlDQ2bt
 HjTRs9OQM56uUbpq2lXPNjec8RD4OGEV4yN56d0AY1ZgZ8QgatLXcllIKNgQtEpule6U1LpQe
 ZmclWwR4aFUx+/5Uwod0UCBs29n6mKvlbY+Py/pocVZqOpkrMzflIuXjuMxbYrBwePkCy3I7w
 IUihvvXmqIjwl/xB7hc2E0OluuNIJGnC5nufx1JnXTnMxz0lAKj0PC68bJPmdd1ILnR9eOOhy
 rOsJNW9P5uQgdaGpQOKiBq4LxdTjrkRO+rtFJpPMiCYx9TM/xwf5bS7beEAIUYN2soK9rC2xN
 2REZQq0vfOyMpwLLHBnMyRgJ8jQK1Sp8W8uVkSf4ZzugC9o8n35W7eOPejpM6a/Q+cuiqkd6p
 /8CBWgkX+w7aLRwtIfrQ5fupxg9EDVPRWhS3zrRWwOCGwxfDORfPUpHSinb9ss7lvDukRpgZX
 Jr621ANbZxSxpFyG+8PDedFT66V5FiqOi21kGZGZkoSP0BQT4k9gnzojy+Q8zmK6DzResyqoe
 5hl9esm5Qfmxnis/Wiiy3xLGkH2WU5vq//US5T7jgG8rheUAVE0rAvkfS4Q8reIiyNRMjqQ8A
 HdUBHpEHD71hX6S7A4wQKN9InUSL9jH2ReC5/tmvdroSiYdsIs1NEqpJTzzrLMhCXPddPgdO4
 m8bMmeruFc2I97pEsUjodfyTeUnm6jhzAASI0jrwXk2zuSSOFshPwHAG1DgSROpiBQfTLwtuI
 oV4Pa6D83+JlwKT8yofuUxBgGG3737FmuGBBIBBL0E+7pTDgz+Va2W4LoLyhWTsSV06EQH5PN
 4Lhk9M9Bn6/VFJ4GpK3Mnyl+1XGo3mFhwJL9tal2/vlFfaVMZbdNgeRQhjSeXcavNg6WOVY5O
 BZYDy6XCiDufwWk3cmj82nAMY4zNcd+a/sIIRL9LAIdUcOgRXZSuSs04CaD/nBbJPz/n5q8d1
 jqWM1Dv48qKzqpEU02uHpb+VBzfuVQe/8fXyrf6mmkD5aKcOwyKbfEXjrzJ/uk77cN0AlPeiz
 8MdhAfCzzlOZFFgyOhw5EuhcfcLrYIXgu5KLmgbESEs8L4tLiUSurlftbpPcfvRQpbe6fZyrU
 hLugRVYaASP5iUcAGfcawniR2TE7hLYBw9S5xw2+nvk2v85Cj5EMoFX7Uv6I/yY/QaqiQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.21
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
--e1JpJWfvnKK38AgOlqUWqo0qjW08EPlu3
Content-Type: multipart/mixed; boundary="in89QeMdSgpvpVTFC6acuvXBaNlx44mUk";
 protected-headers="v1"
From: Kamil Rytarowski <n54@gmx.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 Maxime Villard <maxv@netbsd.org>
Message-ID: <2c986674-ba87-885a-ccb3-787e7aededee@gmx.com>
Subject: Re: [PATCH 0/4] Implements the NetBSD Virtual Machine Monitor
 accelerator
References: <20200107125401.18126-1-n54@gmx.com>
 <7f786d62-fafb-13d1-df1a-5a706ad4a665@gmx.com>
In-Reply-To: <7f786d62-fafb-13d1-df1a-5a706ad4a665@gmx.com>

--in89QeMdSgpvpVTFC6acuvXBaNlx44mUk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Ping? 2x

On 15.01.2020 14:14, Kamil Rytarowski wrote:
> Ping?
>=20
> On 07.01.2020 13:53, Kamil Rytarowski wrote:
>> Hello QEMU Community!
>>
>> Over the past year the NetBSD team has been working hard on a new user=
-mode API
>> for our hypervisor that will be released as part of the upcoming NetBS=
D 9.0.
>> This new API adds user-mode capabilities to create and manage virtual =
machines,
>> configure memory mappings for guest machines, and create and control e=
xecution
>> of virtual processors.
>>
>> With this new API we are now able to bring our hypervisor to the QEMU
>> community! The following patches implement the NetBSD Virtual Machine =
Monitor
>> accelerator (NVMM) for QEMU on NetBSD 9.0 and newer hosts.
>>
>> When compiling QEMU for x86_64 passing the --enable-nvmm flag will com=
pile the
>> accelerator for use. At runtime using the '-accel nvmm' should see a
>> significant performance improvement over emulation, much like when usi=
ng 'hax'
>> on NetBSD.
>>
>> The documentation for this new API is visible at https://man.netbsd.or=
g under
>> the libnvmm(3) and nvmm(4) pages.
>>
>> NVMM was designed and implemented by Maxime Villard.
>>
>> Thank you for your feedback.
>>
>> Maxime Villard (4):
>>   Add the NVMM vcpu API
>>   Add the NetBSD Virtual Machine Monitor accelerator.
>>   Introduce the NVMM impl
>>   Add the NVMM acceleration enlightenments
>>
>>  accel/stubs/Makefile.objs |    1 +
>>  accel/stubs/nvmm-stub.c   |   43 ++
>>  configure                 |   36 ++
>>  cpus.c                    |   58 ++
>>  include/sysemu/hw_accel.h |   14 +
>>  include/sysemu/nvmm.h     |   35 ++
>>  qemu-options.hx           |    4 +-
>>  target/i386/Makefile.objs |    1 +
>>  target/i386/helper.c      |    2 +-
>>  target/i386/nvmm-all.c    | 1222 ++++++++++++++++++++++++++++++++++++=
+
>>  10 files changed, 1413 insertions(+), 3 deletions(-)
>>  create mode 100644 accel/stubs/nvmm-stub.c
>>  create mode 100644 include/sysemu/nvmm.h
>>  create mode 100644 target/i386/nvmm-all.c
>>
>> --
>> 2.24.0
>>
>=20
>=20



--in89QeMdSgpvpVTFC6acuvXBaNlx44mUk--

--e1JpJWfvnKK38AgOlqUWqo0qjW08EPlu3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAl4vCWwACgkQS7MI6bAu
dmyF2Q/5AdKPDQIBQGg37euT9r3aR0WPtdspGtLKltrEkQRuV4z5qBEl1N3DPpVx
u6OSRXdGBIGuG/bflvQ9Zz8bv9+SvXT8M6GlnlkpwGSU9qeno4mhfyZD7MyujZ3P
rluUz8om8yFYlNv1SD3XMUJ8WN3pRwWFYmLW+HwJfTWdZ979w78c8631BNIueV7o
I+V+2LX1rD6624dVbi/wLF092m874Jfwx5wkKRkpNDGHbKEpU3xydYzlTlapuDbP
43Ur0oCgfgwvPa7Ccm7RVAxUyIk392MjbNOQKTKtX6o/dH77G2cHIYIhJILBCThX
VRLJfD9KBLEJ341yzkhX6UNXlfV1RmuFajDGWjBG7MSod779SAVZJROZBDhJ1HET
Jm8iJ4ZDiUm2KbVfYbCJcsIqfUCn5rn8cT0CodYuu3KQNJGMKpO2vZCHWY/BIJA9
j99BmWBR3EDC5fIthuCVFNGCSiD8ObbBG7f88Gjs7PtpXtQlGQhX/jMvud6bkT9/
OwoBMvRXH21/pexoktEQD1rFBHmPBpolgUdJq917162UvTZvSEj6SDIwIyIOtX4O
gNQCi0kbIUZ+bdeZsgeVrSM6z/KIT6EvACXiAlBUmzsrgnOq6GTObr5XNGlZPhMY
jrdqM8RyGBoZLWSTwHiGxNjTyxIg5IEO7SqFH/oX8KeO6vnzInk=
=3tRh
-----END PGP SIGNATURE-----

--e1JpJWfvnKK38AgOlqUWqo0qjW08EPlu3--

