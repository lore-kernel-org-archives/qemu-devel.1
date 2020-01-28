Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B14C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:17:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0694F24681
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FOgZOsCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0694F24681
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwPno-0002ht-3E
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 07:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1iwPkj-00025U-TZ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:13:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1iwPki-0001Eh-8J
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:13:57 -0500
Received: from mout.gmx.net ([212.227.17.22]:39497)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1iwPkg-0001BG-Jw
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1580213628;
 bh=dmnQST713N9Z0nSAgOvXb77WQSKK0yPNBNLyyBD5n6o=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=FOgZOsCj7k1WasQ1o1ZP/o/m2nVN1vlHj4/JuJCPt3y7wQsPYZg8AM0Wo3WpeDAbC
 j/e5E9vxE5P/ZGI67hi2ikXrdMtMsNusUPOb4UgLgW3jEs+pLwsxOvtWxLxDUaTTMe
 yq6q/GyqtP4ZrSA2hP0C4A0pAPFFZrmwl4pjSn0g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mq2jC-1jJ5NB3SYU-00nCC5; Tue, 28
 Jan 2020 13:13:48 +0100
Subject: Re: [PATCH 0/4] Implements the NetBSD Virtual Machine Monitor
 accelerator
To: Sergio Lopez <slp@redhat.com>
References: <20200107125401.18126-1-n54@gmx.com>
 <20200128091007.lh5re4neqhhqmr7x@dritchie>
 <d6078248-b6ca-1c9b-16a4-1e9eaccafa53@gmx.com>
 <20200128120852.zufs4us27fnea7ch@dritchie>
From: Kamil Rytarowski <n54@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Message-ID: <323c01fe-810a-e1d2-8b2d-77348846a446@gmx.com>
Date: Tue, 28 Jan 2020 13:12:56 +0100
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128120852.zufs4us27fnea7ch@dritchie>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="thVDvaFdQIKzCIc1nWTbwJX8lpfkoXMQ6"
X-Provags-ID: V03:K1:CU36PbTopjjVaxIHMI90rzKkt3EbpulStsukrqC6nr3V3U7RSTT
 sKF5kXRt2v9WBibFw2Fb6XDQWhC+hi9z8LBJ6xs3gaK3sdm5G4oGxNjYy0e9hSrRl14sdHu
 78w2Jwcj6LHfFdLIbaPWfrpChijTM2/ek669EaVc5ZQc9Ux6R7DUMfNxmyNVGF6mGZwj28S
 5TeFiITno51UpAfjcKXmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zFtfcB2J4F4=:MXzV1XO9b5evGj+8/FCiYD
 OaiiRpU/zlvK6hnqK/bSErYqXBKm3Zjts8OnIRhpe9Cac8dR5PEcvpF11qSKYPUq/xM5lI/1E
 OzLH/UQ1RseAXuvAbYpCTRuqlhmFf+M5D12FV62VocRFfizkTiX5zHNaGgcGFMxOTeWP7hSeB
 Za6NhemNQWfQvFAuB4IaaaLfVZiwBj8/8hq+ERxzvR7JUXPjQ4topNK885HPeYzWtV6f69dNj
 CLfubcaeHxNJ7a7SOdETjV8F72C0TAbSqRKCIwWoEteA6/GMo4gDUj9rlimvRXTZ1h7jzP08C
 2QULPJ7Fi7flJzu5TBl6cc0L7R1CSjp8zzcAFEwHChuREbFoUbAn/Itzxu0ZrE9VUGg8SRyg/
 jxMC53aLtuV5myTWYoX3u4nsqfRRRhN/4gxaNunW2Tp+R3BIaxn4S4JSeXua8MflKmqMOijuE
 9caB5wfQ2R5Lh6kXTkLX0vMLtN5TZqFduVx2ymivn4fZVqsbjJ4CdbwB04ZLgyTwOR9OXDVsd
 m8WAsXmy9wr0KLIwpq3A1XPirAXyWhaD8p65loI7at+Ee9N1XbaSXyVmu+SKpSvfWoKM0IEDy
 vnfcMIOxePBbaC7Oad03ihE7BJH46Rwd5fzSj9vJfekml6324Ov8sXfSc7AWZi7M1wOULFklT
 HpNsx3Q6ZFZRoMJTXddaKbL5Bg9QhE/rMLJ2lHaQEoqdSYkukJRGRcRA7J7FIg4KcwLXOZfT2
 JxJATqvJklTuXGe8/abj8Q56gFDeqrZ7n7CgHRE/0A2exI4aVkgnTeXdPBuzFq/AqT5FJGU2R
 w9hUq69GyV54n1vGBQuOAeG/+Ck4qvxnakvBP1VgkGtOkCHBXL2g+5hZBjEx8Myn1ec/p188/
 ccCz9IFaM+/ktwk2CCU8o5ZT0zwQEFQL3A9DEW3fNlxuXZ726Tauw1rOm9FnMCsD+FRg8zRDZ
 4rWFUlgrfAKaGPtSgBYoOWAo22twS2JUPmLWEOv2lgbRaoOj5Jt61RdjzW+qePGK98JWMeLb4
 lh8jBrwkq4F5nyWFZNkWF6+fj0w58Ne02g8UaPDiJGuceqHSvL4bfW41dA8qt2KyIOb031RyS
 Q2dwbYHRRl8ORZY8H/fYCgDSPKaBqxLgNk+mHo7jOE/HwK5wZCGkBijdBaFxADuAGpgCJKjHl
 xMpo/AhW08lx3NZo1jPaJyC35nVABkgYyJcLaOWdLqFAkwwHJupBoFQ6Sis1nk26YIsvw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.22
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
 qemu-devel@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--thVDvaFdQIKzCIc1nWTbwJX8lpfkoXMQ6
Content-Type: multipart/mixed; boundary="HqrbfoM23zn9olz5b14e79nxOBb74W4Zz";
 protected-headers="v1"
From: Kamil Rytarowski <n54@gmx.com>
To: Sergio Lopez <slp@redhat.com>
Cc: pbonzini@redhat.com, Maxime Villard <maxv@netbsd.org>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
Message-ID: <323c01fe-810a-e1d2-8b2d-77348846a446@gmx.com>
Subject: Re: [PATCH 0/4] Implements the NetBSD Virtual Machine Monitor
 accelerator
References: <20200107125401.18126-1-n54@gmx.com>
 <20200128091007.lh5re4neqhhqmr7x@dritchie>
 <d6078248-b6ca-1c9b-16a4-1e9eaccafa53@gmx.com>
 <20200128120852.zufs4us27fnea7ch@dritchie>
In-Reply-To: <20200128120852.zufs4us27fnea7ch@dritchie>

--HqrbfoM23zn9olz5b14e79nxOBb74W4Zz
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.01.2020 13:08, Sergio Lopez wrote:
> On Tue, Jan 28, 2020 at 12:11:51PM +0100, Kamil Rytarowski wrote:
>> On 28.01.2020 10:10, Sergio Lopez wrote:
>>> On Tue, Jan 07, 2020 at 01:53:57PM +0100, Kamil Rytarowski wrote:
>>>> Hello QEMU Community!
>>>>
>>>> Over the past year the NetBSD team has been working hard on a new us=
er-mode API
>>>> for our hypervisor that will be released as part of the upcoming Net=
BSD 9.0.
>>>> This new API adds user-mode capabilities to create and manage virtua=
l machines,
>>>> configure memory mappings for guest machines, and create and control=
 execution
>>>> of virtual processors.
>>>>
>>>> With this new API we are now able to bring our hypervisor to the QEM=
U
>>>> community! The following patches implement the NetBSD Virtual Machin=
e Monitor
>>>> accelerator (NVMM) for QEMU on NetBSD 9.0 and newer hosts.
>>>>
>>>> When compiling QEMU for x86_64 passing the --enable-nvmm flag will c=
ompile the
>>>> accelerator for use. At runtime using the '-accel nvmm' should see a=

>>>> significant performance improvement over emulation, much like when u=
sing 'hax'
>>>> on NetBSD.
>>>>
>>>> The documentation for this new API is visible at https://man.netbsd.=
org under
>>>> the libnvmm(3) and nvmm(4) pages.
>>>>
>>>> NVMM was designed and implemented by Maxime Villard.
>>>>
>>>> Thank you for your feedback.
>>>
>>> Thank you for working on this, it's nice to see that QEMU will gain
>>> HW-assisted acceleration on NetBSD 9.0. A couple things:
>>>
>>
>> Thank you for the review!
>>
>>>  - Are you and/or Maxime willing to step up as maintainers for the
>>>    NVMM support in QEMU?
>>>
>>
>> NVMM (as of today) is part of the NetBSD support and I am the maintain=
er
>> for the NetBSD code (noted in MAINTAINERS).
>>
>> In case of non-trivial changes I will reach Maxime for his feedback.
>=20
> OK, sounds good to me.
>=20
>>>  - In the next version of the patch series, please use
>>>    "scripts/get_maintainer.pl" to get the list of people you need to
>>>    CC for the patch series.
>>>
>>
>> I've submitted a fixup patch '[PATCH v2 2/4] Add the NetBSD Virtual
>> Machine Monitor accelerator.' instead of the full series.
>>
>> I have rechecked the maintainers with the patch and I don't see anybod=
y
>> else as a candidate for review.
>=20
> $ ./scripts/get_maintainer.pl /tmp/0004.patch=20
> Paolo Bonzini <pbonzini@redhat.com> (maintainer:Main loop)
> Richard Henderson <rth@twiddle.net> (maintainer:Overall TCG CPUs)
> Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86 TCG CPUs)
> qemu-devel@nongnu.org (open list:All patches CC here)
>=20
> $ ./scripts/get_maintainer.pl /tmp/0002.patch=20
> get_maintainer.pl: No maintainers found, printing recent contributors.
> get_maintainer.pl: Do not blindly cc: them on patches!  Use common sens=
e.
>=20
> "Philippe Mathieu-Daud=E9" <philmd@redhat.com> (commit_signer:31/112=3D=
28%)
> Paolo Bonzini <pbonzini@redhat.com> (commit_signer:31/112=3D28%)
> Thomas Huth <thuth@redhat.com> (commit_signer:25/112=3D22%,commit_signe=
r:14/53=3D26%)
> "Daniel P. Berrang=E9" <berrange@redhat.com> (commit_signer:24/112=3D21=
%)
> Laurent Vivier <laurent@vivier.eu> (commit_signer:22/112=3D20%,commit_s=
igner:10/53=3D19%)
> Gerd Hoffmann <kraxel@redhat.com> (commit_signer:13/53=3D25%)
> "Michael S. Tsirkin" <mst@redhat.com> (commit_signer:9/53=3D17%)
> Markus Armbruster <armbru@redhat.com> (commit_signer:9/53=3D17%)
> qemu-devel@nongnu.org (open list:All patches CC here)
>=20
> I think you should resping the whole series as v2, adding Richard,
> Eduardo and Philippe to the CC list. That should help with the review
> process.
>=20

OK. I will do it.

Please have a look at v2 2/4, submit reviewed-by and I will submit the
whole series again.

> Thanks,
> Sergio.
>=20
>> I don't maintain a merge queue on my own. Please put the reviewed
>> patches on a merge queue yourself.
>>
>>
>> Thank you in advance,
>>
>>> Thanks,
>>> Sergio.
>>>
>>
>>
>=20
>=20
>=20



--HqrbfoM23zn9olz5b14e79nxOBb74W4Zz--

--thVDvaFdQIKzCIc1nWTbwJX8lpfkoXMQ6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAl4wJUgACgkQS7MI6bAu
dmyz/RAAg1KFavjkdoJP3As2QrlRtIjPKnGozhxA+4x4vUeFnAtl3gid5257axdZ
iZATzH8Sjzl07LBpJ/u6piu9+CabD22PtFjPZ6K2QXeofmnqK1sNp3nHsvWSwgLx
D6mgcYg/w7pbPLhks54SiWtnhwVl2GOAH6Ej/FYM59Rz1ptEUaVZ1Je7VSfp6AaM
92V0gWMz/rQoWevjsYPsk5cNLsf9jOb0xHkMg2ZvDcHyt+Rh4B3Jl3ksaifzoyfM
14+XMsvZWCtf+XcKB6K/3g6vETDGqWI2dlQn1H/dEjxmwPn1N38MgM3qEfLTdwAg
A3pvb26VZpvy0YFHU4dH0gJAiLQImlK0UWpGND2hinqr5JFDi5nSzt/2OEqLuHkq
rzcFC8QUPSOsqiiWEKxRAOWjFVXbv7zkyU9hS1klvY+qiHnUKsIrlV14CuNff3nu
YjrCWfP0kuFWqKr3ISM2F6UbxCuy4aUL58xB1YK7q4V+8soFcE7228JgeEpdCMUv
fA0iePnpo8HBFPyG+uLoZbEYF15Ci9/sj/8wxmtWFI6L5YWD1G1B+yLYPdC7emAm
QP+TQ+g+CqGf2gfGK2ZZwNJqF3YEOgQbcdifbi2fkAr0ITdZX4kVriiFpSrQZWrd
NUp9DEwA/hQDtSco/YAXpYt47zh8gnBJ/05mB2xsUdmztbAeFtI=
=1+ll
-----END PGP SIGNATURE-----

--thVDvaFdQIKzCIc1nWTbwJX8lpfkoXMQ6--

