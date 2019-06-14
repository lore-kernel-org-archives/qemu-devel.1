Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF6BC31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87AC320851
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AC320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50060 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbjZh-0004o7-RI
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 06:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52987)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbjOC-0005ec-Q7
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbjAc-00024W-Pe
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:10:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39871)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbjAa-00023R-Sr
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:10:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so1709063wma.4
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 03:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to;
 bh=8OcuYFQn5PtIShuEjxfCb4tr3n4Ndlvfv/f5n+YCVjo=;
 b=JhEhqtbCcEiCDGfo01BhEyd37ZOzdwJS+85mwZOXdDynd/t0q2dRgbt8fnCu9et86T
 iTLO6p5+DSf3BiXgXiGeLIUArsOPmtdOaSY6ee2V5x6gay9xSGFbu3Pub3iLX4u5QjAp
 /05PXCmWZwC8E/e3wZkRWcqnTqW08GIneoR87vyWo4SoMR72dkE2Ttox7/Zgh2tGAVla
 zLh8fq3LYQISIqB7ZiLixf+oJTXCW3SgE75F+ocTKvsL/GBVe+GwrAFF9mFuvbG8jibG
 8iCQfoD/yZqIWjqTRDljbteqLW7AqoqmmVBqZxZKtMW/GsILunHnrUrIhx0xSYMHFIug
 3NMQ==
X-Gm-Message-State: APjAAAV9SbXoRuUuONWWgncCEUDDFNGtc71NjDx8eJPBzqeBHjFCla3Y
 y2HIV33wPJaMka2qaLFJUAtHHA==
X-Google-Smtp-Source: APXvYqxc6SjhN0pM1uvOOqTc/hrWDkBc+/Zw7TmXyYKAjyPutHRXqGXsUVRObzpBpDElUNcthADLpg==
X-Received: by 2002:a05:600c:230c:: with SMTP id
 12mr7207272wmo.166.1560507050575; 
 Fri, 14 Jun 2019 03:10:50 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id p13sm2022853wrt.67.2019.06.14.03.10.49
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 03:10:49 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20190613050937.124903-1-aik@ozlabs.ru>
 <35361394-42ba-dcf0-6fe2-5a0a538d1440@redhat.com>
 <d20e26db-7157-d9bd-c707-d7f4443396c0@ozlabs.ru>
 <20190614093306.GG10957@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3f3a9055-429e-5930-ef20-468d27373e8c@redhat.com>
Date: Fri, 14 Jun 2019 12:10:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190614093306.GG10957@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nA5lo8IEY6bGXkKuhz36nAVF4IJaswywP"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH qemu] loader: Trace loaded images
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
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nA5lo8IEY6bGXkKuhz36nAVF4IJaswywP
Content-Type: multipart/mixed; boundary="X0S6auHYMkoUwPJWFRO9PEtdlqceL1jz4";
 protected-headers="v1"
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Message-ID: <3f3a9055-429e-5930-ef20-468d27373e8c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH qemu] loader: Trace loaded images
References: <20190613050937.124903-1-aik@ozlabs.ru>
 <35361394-42ba-dcf0-6fe2-5a0a538d1440@redhat.com>
 <d20e26db-7157-d9bd-c707-d7f4443396c0@ozlabs.ru>
 <20190614093306.GG10957@stefanha-x1.localdomain>
In-Reply-To: <20190614093306.GG10957@stefanha-x1.localdomain>

--X0S6auHYMkoUwPJWFRO9PEtdlqceL1jz4
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/14/19 11:33 AM, Stefan Hajnoczi wrote:
> On Fri, Jun 14, 2019 at 10:13:04AM +1000, Alexey Kardashevskiy wrote:
>>
>>
>> On 13/06/2019 23:08, Philippe Mathieu-Daud=E9 wrote:
>>> Hi Alexey,
>>>
>>> On 6/13/19 7:09 AM, Alexey Kardashevskiy wrote:
>>>> This adds a trace point which prints every loaded image. This includ=
es
>>>> bios/firmware/kernel/initradmdisk/pcirom.
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> ---
>>>>
>>>> The example for a pseries guest:
>>>>
>>>> loader_write_rom slof.bin: @0x0 size=3D0xe22e0 ROM=3D0
>>>> loader_write_rom phdr #0: /home/aik/t/vml4120le: @0x400000 size=3D0x=
13df000 ROM=3D0
>>>> loader_write_rom /home/aik/t/le.cpio: @0x1ad0000 size=3D0x9463a00 RO=
M=3D0
>>>
>>> I find the "ROM=3D0" part confuse, maybe you can change to "ROM:false=
".
>>
>> How? I mean I can do that in the code as rom->isrom?"true":"false" and=

>> make trace point accept "%s" but it is quite ugly and others seem to
>> just use %d for bool.
>=20
> Yes, %d is the convention for bool.  Perhaps you can name it "is_rom"
> instead of "ROM".  That way the name communicates that this is a boolea=
n
> value.

I agree a boolean is easier to parse for trace analyzer tools than a
"true/false" string.

Stefan, is it possible to add a boolean format string to the backends?
For example the 'log' backend would log it as "true"/"false".

Just a thought ;)

Regards,

Phil.


--X0S6auHYMkoUwPJWFRO9PEtdlqceL1jz4--

--nA5lo8IEY6bGXkKuhz36nAVF4IJaswywP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAl0DcqgACgkQoqP9bt6t
wN6y7RAAgxtcnFSDOoKftVBpDmypgwwe2mG0Ov6ZV7qB2FtUmHtPvHs4irUaaP0Z
lyCDUr2u9Q731NaWUyXM2BNCblx9KAsch/toryTLNX5zr8vaqou5jKYQJ7jeOln0
/DyZJpPCe1zLYe0gypG8Qwgj99MumzGd0Nwe2+px+smYf/YcDfdDu0AaFyXwscPY
8ovhZH2aRjbWLJn71WzOCFCC9i8JRHP8qaYDppRTASPtuzAu9QSTQPUrYTaC9g1q
rxFl5uXWp+sM1jH95oxvLxXrt0f3/V4ItlI0Qjpo68wqyyExOcPKAs7zUcTlZrKd
dBHxq5N27ENgfNbBHWVkCuGCik+54aVZBkvFQvnK2GLWXybtRG6VzrslfShMbN4Q
Ss+73nCRqzNEZB2Uj2P89fsir3RkyqGXRvZxBy8WfggXUpK35DYScuf/nGnujbCo
E1qeXEETNUPEP1Fb9f2NAFros3VNyn3aVupSAS8bWzaq6J9H/dRxNy2rC4cz50pf
h2Ju2eHEQVhioQZbPkTHWKql1lS9DXR6pj1VT83jyO+pWA+8LcvCQf4tkb69QOlo
fy4/uzeGB7zSkiOKTUsH3ida4ds+UCiB/8Q/JiLPyNCVnjtT7acBEIRG058Tj1Fm
x36wo3i5cAEJrsDvCto10G6uyyTBYZMPE3FdtCYQNDIkeFTIaRE=
=BgS6
-----END PGP SIGNATURE-----

--nA5lo8IEY6bGXkKuhz36nAVF4IJaswywP--

