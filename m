Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC870C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 10:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DE42171F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 10:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DE42171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39802 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCMQI-0003HU-Mp
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 06:50:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCMPR-0002wa-FX
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCMPQ-0006mh-7b
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:49:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCMPP-0006iX-6c
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:49:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so7446327wrq.1
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 03:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:cc:message-id
	:date:user-agent:mime-version:in-reply-to;
	bh=hjmSgqvTbccAElTNi1wSrEbUU7hIkG9dVzNVcvJ7Am0=;
	b=Aa3fzsCLgXPwzXVAq0pgaBpT5bya/exyevSbdul9z4B607QOsG/Pl7xv20RZrA4iCz
	45iGl7KcLWiUOpIR9VOR+qNb85MmLOukICwAGQLadSZgKXYMx6Cx+wcZNJwgTy2EQxuE
	5u4Wh/mhXQB1tKBpJX5UeeS1+dMDUjCllY8/IHLIDymx96J7iqm5pVSLqiKKbnhBUb31
	6ygijPT7ndooIH55CVWr0x9mQ2rZYpubEKF7A9oA115o5W6i6LG3Dvp8eLYWed//Y75H
	A5IQVARCjpfjvDwZwjTcy9OXIwXq0QDbMepm/zbsH2aqiSdsbGrOQ5HJx7vxLBKjPZ9N
	hVwQ==
X-Gm-Message-State: APjAAAXzx8FNfoFh6ix5aW4VuC6Kl0LpopcGT0IDmemcs3zi+hM+oogX
	61jYt4GlPG51aVrV69RqKj1q1A==
X-Google-Smtp-Source: APXvYqx8Z0WSGezdvDl6pdmWK0eEjF0biAMwL1qIsd79+XixI95S5sOqNToe9LS1akyBQf0/CrEFng==
X-Received: by 2002:a5d:6101:: with SMTP id v1mr7992339wrt.222.1554461357774; 
	Fri, 05 Apr 2019 03:49:17 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	y125sm3818673wmc.39.2019.04.05.03.49.16
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 05 Apr 2019 03:49:16 -0700 (PDT)
To: Olaf Hering <olaf@aepfle.de>, qemu-devel@nongnu.org
References: <20190405123928.70da87e2.olaf@aepfle.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1cec1873-9962-f258-a052-167efec620e9@redhat.com>
Date: Fri, 5 Apr 2019 12:49:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405123928.70da87e2.olaf@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1BypOdhQZ3eiZQFYGYsBy3QuyMXjAT4Fq"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] edk2 fails to compile in v4.0.0-rc2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405104915.Jks6a-U-o2fD22RNT0hw_CW1CJE3o4QvkpO9oMJh0Ds@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1BypOdhQZ3eiZQFYGYsBy3QuyMXjAT4Fq
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Olaf Hering <olaf@aepfle.de>, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1cec1873-9962-f258-a052-167efec620e9@redhat.com>
Subject: Re: [Qemu-devel] edk2 fails to compile in v4.0.0-rc2
References: <20190405123928.70da87e2.olaf@aepfle.de>
In-Reply-To: <20190405123928.70da87e2.olaf@aepfle.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Olaf,

On 4/5/19 12:39 PM, Olaf Hering wrote:
> It seems in qemu.git#master the edk2.git submodule is now mandatory.

The EDK2 submodule was added for UEFI testing, you don't need to compile
it to build/use QEMU.

How did you end up compiling it?

> For me it fails to compile. This is not a new error. It needs to be com=
piled with -fPIC since essentially forever.
>=20
> But I wonder, why does it fail to compile only for me?!
> Example of failure:
>=20
>  $ grep -h CommonLib.o /dev/shm/*/.build.log=20
> [   85s] gcc  -c  -I .. -I ../Include/Common -I ../Include/ -I ../Inclu=
de/IndustryStandard -I ../Common/ -I .. -I . -I ../Include/X64/  -MD -fsh=
ort-wchar -fno-strict-aliasing -Wall -Werror -Wno-deprecated-declarations=
 -Wno-stringop-truncation -Wno-restrict -Wno-unused-result -nostdlib -g -=
O2  CommonLib.c -o CommonLib.o
> [   89s] ar crs ../libs/libCommon.a BasePeCoff.o BinderFuncs.o CommonLi=
b.o Crc32.o Decompress.o EfiCompress.o EfiUtilityMsgs.o FirmwareVolumeBuf=
fer.o FvLib.o MemoryFile.o MyAlloc.o OsPath.o ParseGuidedSectionTools.o P=
arseInf.o PeCoffLoaderEx.o SimpleFileParsing.o StringFuncs.o TianoCompres=
s.o PcdValueCommon.o
> [  106s] /usr/lib64/gcc/x86_64-suse-linux/7/../../../../x86_64-suse-lin=
ux/bin/ld: ../libs/libCommon.a(CommonLib.o): relocation R_X86_64_32 again=
st `.rodata.str1.1' can not be used when making a PIE object; recompile w=
ith -fPIC
> [  106s] /usr/lib64/gcc/x86_64-suse-linux/7/../../../../x86_64-suse-lin=
ux/bin/ld: ../libs/libCommon.a(CommonLib.o): relocation R_X86_64_32 again=
st `.rodata.str1.1' can not be used when making a PIE object; recompile w=
ith -fPIC
> [  120s] /usr/lib64/gcc/x86_64-suse-linux/7/../../../../x86_64-suse-lin=
ux/bin/ld: ../libs/libCommon.a(CommonLib.o): relocation R_X86_64_32 again=
st `.rodata.str1.1' can not be used when making a PIE object; recompile w=
ith -fPIC
>=20
> What do I need to change in my setup so that -fPIC is not required?

Apparently your Linux distribution has transitioned to enabling PIE by
default in GCC 7, see:
https://lists.opensuse.org/opensuse-factory/2017-06/msg00403.html

"This is achieved by a gcc defaults override in the "gcc-PIE" package."

Regards,

Phil.


--1BypOdhQZ3eiZQFYGYsBy3QuyMXjAT4Fq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlynMqsACgkQoqP9bt6t
wN6rPBAAm4MM5iUy8Koceu92ju9lKju1alwJvGelswGjpYJmVofGROSSvqCCVn8L
JNSjM7JfWpfroJ2jL+RZutkbL10mBTOhh3nUU3WaSZJGsBOHyPneygrtIoTWI4nE
uEtUEKngmxPS78luW2XZfcKTVqccSrs05LehYg2b7o3eOVjcYHviz6bNSgnr4lcH
kvsFCj/YKP9Uqmo8o4yS10vcWkL4QYrjNqnQS+FbMf9QNhdKc72mg/i2BVpeGggi
VoZv5LWBd4Sic7Ga0icHSlIC9btyXofoDfp5li/sFSDiwAfrax78+E5fN/mN7yJi
qyoHFGgOsdM3vCIZL2xC9S1ZejV7BTxz0aEkOoejLYZlKAWmPm/iCNhSwoJLouSG
NNBEJ6TGaX1jn19iHhPetdw5S2hZ2nrtrbUd4yXbuPJBhhHH0pqWD5PG3A69TQE8
CpICc9+EKO2MY9JpQhWLT98ixbrtXQbKlS6jB2ckpTLTAOIgrgZ3dWJqZ73buyI+
GfhvRbLxd/JPWRFfsuk8io8wZQuPX8bdsQMH93j6M5oeoCLQV9qlAVZeYoMFV3no
XbRHXDxn1+hjVjUWGYuaqxsGg4qj+g6qjEdxounDg4w48XAfjvsqNn8hKxJ0A6C8
TTXb688+DQqGATMVCXbx8qSCyiCo80dzFrXAc4zdr55xxtIM/XQ=
=qgic
-----END PGP SIGNATURE-----

--1BypOdhQZ3eiZQFYGYsBy3QuyMXjAT4Fq--

