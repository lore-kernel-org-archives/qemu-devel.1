Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EF8C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D19C21D56
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D19C21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m00nbsd.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8qc5-0004ml-Dl
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 14:20:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <max@m00nbsd.net>) id 1j8qWC-0000x1-MG
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:14:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <max@m00nbsd.net>) id 1j8qWB-0007cW-A8
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:14:20 -0500
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:48477)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <max@m00nbsd.net>) id 1j8qWB-0007SY-0r
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:14:19 -0500
Received: from mxplan6.mail.ovh.net (unknown [10.109.138.227])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 8E3B92A5622E;
 Mon,  2 Mar 2020 20:14:09 +0100 (CET)
Received: from m00nbsd.net (37.59.142.99) by DAG3EX2.mxp6.local (172.16.2.22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 2 Mar 2020
 20:14:08 +0100
Subject: Re: [PATCH v2 2/4] Add the NetBSD Virtual Machine Monitor accelerator.
To: Kamil Rytarowski <n54@gmx.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 <rth@twiddle.net>, <ehabkost@redhat.com>, <slp@redhat.com>,
 <peter.maydell@linaro.org>
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com> <20200128140945.929-3-n54@gmx.com>
 <e3279b9d-e6f9-43f3-3ebb-b31ba8ff5f7e@redhat.com>
 <4e29b732-ce95-02f1-ec9c-31f1ce33cda0@gmx.com>
 <4ece50db-33c7-4630-6b0f-52197b2ae845@redhat.com>
 <5b289981-1e54-2301-af36-86361415bf6b@gmx.com>
From: Maxime Villard <max@m00nbsd.net>
Autocrypt: addr=max@m00nbsd.net; keydata=
 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
Message-ID: <bd4bb6d3-be33-2f97-8ee5-695b41b5eff1@m00nbsd.net>
Date: Mon, 2 Mar 2020 20:14:05 +0100
MIME-Version: 1.0
In-Reply-To: <5b289981-1e54-2301-af36-86361415bf6b@gmx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG4EX2.mxp6.local (172.16.2.32) To DAG3EX2.mxp6.local
 (172.16.2.22)
X-Ovh-Tracer-GUID: 4c8f012f-e978-46a5-b540-3c6a0f3c7665
X-Ovh-Tracer-Id: 6557522535184469868
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddtgedguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffggjggtgfhisehtkeertddttdejnecuhfhrohhmpeforgigihhmvgcugghilhhlrghrugcuoehmrgigsehmtddtnhgsshgurdhnvghtqeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghniedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehmrgigsehmtddtnhgsshgurdhnvghtpdhrtghpthhtohepnhehgeesghhmgidrtghomh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 79.137.123.220
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 02/03/2020 =C3=A0 19:05, Kamil Rytarowski a =C3=A9crit=C2=A0:
> On 02.03.2020 18:12, Paolo Bonzini wrote:
>> On 03/02/20 12:56, Kamil Rytarowski wrote:
>>> On 03.02.2020 12:41, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> @@ -1768,6 +1785,7 @@ disabled with --disable-FEATURE, default is
>>>>> enabled if available:
>>>>> =C2=A0=C2=A0=C2=A0 hax=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 HAX acceleration support
>>>>> =C2=A0=C2=A0=C2=A0 hvf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Hypervisor.framework acceleration support
>>>>> =C2=A0=C2=A0=C2=A0 whpx=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Windows Hypervisor Platform acceleration support
>>>>> +=C2=A0 nvmm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 NetBSD Virtual Machine Monitor acceleration support
>>>>> =C2=A0=C2=A0=C2=A0 rdma=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Enable RDMA-based migration
>>>>> =C2=A0=C2=A0=C2=A0 pvrdma=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Enable PVRDMA support
>>>>> =C2=A0=C2=A0=C2=A0 vde=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 support for vde network
>>>>> @@ -2757,6 +2775,20 @@ if test "$whpx" !=3D "no" ; then
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>>> =C2=A0 fi
>>>>>
>>>>
>>>> Maybe you can add something like:
>>>>
>>>> if test "$targetos" =3D "NetBSD"; then
>>>> =C2=A0=C2=A0=C2=A0 nvmm=3D"check"
>>>> fi
>>>>
>>>> to build by default with NVMM if available.
>>>
>>> I will add nvmm=3Dyes to the NetBSD) targetos check section.
>>
>> No, nvmm=3Dyes instead should fail the build if nvmm.h is not availabl=
e.
>> That is not a good default.
>>
>> Paolo
>>
>>
>=20
> Most users will get nvmm.h in place now and this is still a tunable.
>=20
> I have got no opinion what to put there, nvmm=3Dcheck still works.

I would keep "yes", for consistency with the other entries. Changing all
entries to "check" should be done in a separate commit, unrelated to
NVMM.

> diff --git a/configure b/configure
> index d4a837cf9d..b3560d88bb 100755
> --- a/configure
> +++ b/configure
> @@ -836,7 +836,7 @@ DragonFly)
>  NetBSD)
>    bsd=3D"yes"
>    hax=3D"yes"
> -  nvmm=3D"yes"
> +  nvmm=3D"check"
>    make=3D"${MAKE-gmake}"
>    audio_drv_list=3D"oss try-sdl"
>    audio_possible_drivers=3D"oss sdl"
>=20

