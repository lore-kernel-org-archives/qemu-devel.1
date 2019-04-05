Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DDAC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 11:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 344572186A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 11:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344572186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40391 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCNGs-00058R-9D
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 07:44:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCNCq-00013v-3c
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCMxw-0007Va-J3
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:25:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCMxv-0007R3-JG
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:25:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so7561522wrp.2
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 04:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to;
	bh=py5snUs2KKEs5+mfgJd840urtmh8YiBl/TLFir1GskM=;
	b=Jg38tweYMIWaFo03rr4MrURU11a21s7qAvWw4LxiTYrl6/LG3ddm0wpl4tw2ctNO2u
	Sj5vuhCUPnukHD2SP6QCjNCAHThFV0kgc/QF1yRdmEPidIZBmVsjag7mAvwglBtwi3G/
	HlpAFpjTuRpVyPB+wW96+ctj51z2f1z9/Z8Z0WvFMq1wqlV3/Be+0czC5wMsbKlWUDUl
	98qW6TQknnOxhRH7lceyrj3gjusZG8HjIQs5SrDISnkxrmIKWc4UAJ3qaLMqXFfaWPlc
	yL3FEj5yVxwjtfVg6jE6STL2h/NVB/jsoWwIX7KUaaAXNFrb6KOo1YX0VpwzdGJobZVP
	HNiw==
X-Gm-Message-State: APjAAAVOt0B1s9eR2pEU96sLXDOxqi6gdNPxVGzMj/Y7+0SqEt1/UIb8
	67GFAB6en7phhpsZ77+8kVpjSA==
X-Google-Smtp-Source: APXvYqxqxpTRolGr9jHk59RvCE36j5XBLuHBqVUjOkFORJXtdIhCUuH3fjYnZ0G6PJn6+4teHiQImQ==
X-Received: by 2002:adf:c18d:: with SMTP id x13mr3376783wre.246.1554463497841; 
	Fri, 05 Apr 2019 04:24:57 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	b3sm24790987wrx.57.2019.04.05.04.24.56
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 05 Apr 2019 04:24:56 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
References: <20190405123928.70da87e2.olaf@aepfle.de>
	<1cec1873-9962-f258-a052-167efec620e9@redhat.com>
	<20190405125918.462c6ae4.olaf@aepfle.de>
	<7fded1f3-7539-45b5-17c7-39fe7193dbc9@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <aba99e13-f034-3946-3da2-9cecd615cde6@redhat.com>
Date: Fri, 5 Apr 2019 13:24:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7fded1f3-7539-45b5-17c7-39fe7193dbc9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="P9cFa7yM8YcSGvDtuigNJwgnqsmyIDVNo"
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
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405112455.zig06-SzRiBC_l8miyOKRg8Ygb3hEjZzusXhxZBphNw@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P9cFa7yM8YcSGvDtuigNJwgnqsmyIDVNo
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <aba99e13-f034-3946-3da2-9cecd615cde6@redhat.com>
Subject: Re: [Qemu-devel] edk2 fails to compile in v4.0.0-rc2
References: <20190405123928.70da87e2.olaf@aepfle.de>
 <1cec1873-9962-f258-a052-167efec620e9@redhat.com>
 <20190405125918.462c6ae4.olaf@aepfle.de>
 <7fded1f3-7539-45b5-17c7-39fe7193dbc9@redhat.com>
In-Reply-To: <7fded1f3-7539-45b5-17c7-39fe7193dbc9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/5/19 1:14 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/5/19 12:59 PM, Olaf Hering wrote:
>> Am Fri, 5 Apr 2019 12:49:15 +0200
>> schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:
>>
>>> The EDK2 submodule was added for UEFI testing, you don't need to comp=
ile
>>> it to build/use QEMU.
>>>
>>> How did you end up compiling it?
>>
>> The qemu.spec file has this since a very long time:
>> make -C roms efirom ${unrelated_settings}
>=20
> I don't have any qemu.spec, is it a SUSE file?

I checked and apparently.

>>
>> This used to work still in January with c9d18c1c150c84e7a976df989ad04d=
df01083f46.
>=20
> Before f590a812c210 the EfiRom tool was not available, now we compile i=
t
> inconditionally.
>=20
> So I assume your distribution already provides the EfiRom tool. Can you=

> point me at the package which provides it? I wonder if your distributio=
n
> use a non-upstreamed patch that change the EDK2 BaseTools PIE/PIC flags=
=2E

I see EfiRom was previously provided by ovmf-tools-2017.src.rpm, and the
latest ovmf-2019.src.rpm has this file:

$ cat ovmf-pie.patch
Index:
ovmf-2018+git1534736099.43fe4c405292/BaseTools/Source/C/Makefiles/header.=
makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---
ovmf-2018+git1534736099.43fe4c405292.orig/BaseTools/Source/C/Makefiles/he=
ader.makefile
+++
ovmf-2018+git1534736099.43fe4c405292/BaseTools/Source/C/Makefiles/header.=
makefile
@@ -77,7 +77,7 @@ ifeq ($(DARWIN),Darwin)
 # assume clang or clang compatible flags on OS X
 BUILD_CFLAGS =3D -MD -fshort-wchar -fno-strict-aliasing -Wall -Werror
-Wno-deprecated-declarations -Wno-self-assign -Wno-unused-result
-nostdlib -g
 else
-BUILD_CFLAGS =3D -MD -fshort-wchar -fno-strict-aliasing -Wall -Werror
-Wno-deprecated-declarations -Wno-stringop-truncation -Wno-restrict
-Wno-unused-result -nostdlib -g
+BUILD_CFLAGS =3D -MD -fshort-wchar -fno-strict-aliasing -Wall -Werror
-Wno-deprecated-declarations -Wno-stringop-truncation -Wno-restrict
-Wno-unused-result -nostdlib -g -fPIE
 endif
 BUILD_LFLAGS =3D
 BUILD_CXXFLAGS =3D -Wno-unused-result




--P9cFa7yM8YcSGvDtuigNJwgnqsmyIDVNo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlynOwcACgkQoqP9bt6t
wN4kSQ/9EhLOD/85yxc8bLIoxsKOb1uNa3J9tyiM02WiesVt8u4H13MkVNH5bw5c
LqAab0+kFifkWqYqhgsVPfwB1yxPPCZu1KaUdMEwwu+GECaTOPjDcfkzVtgIrxSr
zL/AXwMyWA0SNaVhqzEQtECZ+/hNjwZvCIcWeAq2MykFiEWqhgd8UqBtRnyRAMUj
lMgtNYP4A6loxlE6zyVW+AuQySiCij8U98DXOQhZrLwQadj2SvGsDEyVxm1SiIvN
cg3u6qcIRDvteSMRPpzjPOnzZRIMe++tv3FwJZpFp0cUojt0MrBmrRKZDBt4gYxP
wdsVNrOZsIrpaxMS0cqyefaIT/p7xTI1PqHF2Gm2c4/PQdy/rgQ6Zpo2nbrTUPbi
7p8lNBgoF31u4wNp8hn/sBvb+z5TljTY6OBjRjLl5LaXV2wLHwh/8UCD+yL6sC6Y
/veYqZg2Mymv7w6G0ZX/q7PwlVx+E5cYdW91BHeWFYMy5q98rnByZw/SVCNxi2cp
30lpAbiZWcmvsHuNFSXaozveHiDDMP2SdLJQ9tBrWlrB6WfOXZQQId+CaN+DWGM4
8gM95PFaDXUwhWDKviNNF+tbZEcG3fi2Eo+/B3EXzdkRONNGYbNbEVIAHHk2SsFr
H/QCOJWDPa8K6syf6sMrBohG86an8QWFv4OhqdPS5/ll8oG617Q=
=OrYD
-----END PGP SIGNATURE-----

--P9cFa7yM8YcSGvDtuigNJwgnqsmyIDVNo--

