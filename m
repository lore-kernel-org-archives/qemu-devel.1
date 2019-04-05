Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A02BC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 13:16:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 183DE21850
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 13:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183DE21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41948 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCOhs-0003gS-Cx
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 09:16:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCOgu-0003M6-O5
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCOgr-0001Hd-Vm
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:15:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCOgq-0000lz-AZ
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:15:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so7901137wrw.13
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 06:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to;
	bh=TTYJOuuHlnURHic1gAsJukOeYAE5y+r1LNA8pfP/eFc=;
	b=QGYNaRfOdNZYzf4h07u2ehBjS59XpX96vwhfVJxITMiDPxiaZ6/wiYWdUh02mJHUcq
	/6BELKspAqRAuZDgYWce92PL+mfPuavhy3vXOTllHhKb58bwkOh1m1FfPIuiYrmCEQRq
	WhvfsjORnp4+o4kV9NVFKaKfkz0nMZ4SB9KnUI8ZbNEkxVXVUSiCq9smEjakRNA7LV3k
	es2b3j04PItlpIpG3WxFyANlI0ESi0UP51tv81QI+VPNv5MVLMzKu3D1UbiTb9cxBs1f
	v1QPThpkRTQhOUg4WZJjTmwqTe+yDuTamFbxaqkaNg9DH7cQev7MmnV9rG/KiNx5utXE
	6Ypg==
X-Gm-Message-State: APjAAAW+7OsXts09Hgw7ANAaht2mQrODHIlRD52LhQH/qeBwUctrQBPX
	odV9IE/t2jSftXmo7Vgbz0IO9A==
X-Google-Smtp-Source: APXvYqzlLLY/sSP0WDQobrpJElkqUOwFY3nRTYZGR4UyJ84XCxzRRJmQq0WzFJA3CGjCTSUl1wrSug==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr8347688wru.150.1554470077577; 
	Fri, 05 Apr 2019 06:14:37 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	u17sm3742596wmu.36.2019.04.05.06.14.36
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 05 Apr 2019 06:14:36 -0700 (PDT)
To: Olaf Hering <olaf@aepfle.de>
References: <20190405115529.11590-1-philmd@redhat.com>
	<20190405140917.3af9b91d.olaf@aepfle.de>
	<6bdd3c91-1e65-db2d-8ff2-fa667a819a1f@redhat.com>
	<20190405150438.48c1cc84.olaf@aepfle.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3c212c03-80a3-a8bb-fbe0-0071ebfb6936@redhat.com>
Date: Fri, 5 Apr 2019 15:14:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405150438.48c1cc84.olaf@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sF1bhJDHdeIomA5oUHaUGn3VHF9hhQ10B"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH for-4.0] roms: Allow the EFIROM variable to
 be overridden
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
Cc: ipxe-devel@lists.ipxe.org, "Michael S . Tsirkin" <mst@redhat.com>,
	qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405131430.uHLodCqNrH00oF5gmtxp9JJQLwRWhDlohOyU4WIgrQs@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sF1bhJDHdeIomA5oUHaUGn3VHF9hhQ10B
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, ipxe-devel@lists.ipxe.org
Message-ID: <3c212c03-80a3-a8bb-fbe0-0071ebfb6936@redhat.com>
Subject: Re: [PATCH for-4.0] roms: Allow the EFIROM variable to be overridden
References: <20190405115529.11590-1-philmd@redhat.com>
 <20190405140917.3af9b91d.olaf@aepfle.de>
 <6bdd3c91-1e65-db2d-8ff2-fa667a819a1f@redhat.com>
 <20190405150438.48c1cc84.olaf@aepfle.de>
In-Reply-To: <20190405150438.48c1cc84.olaf@aepfle.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/5/19 3:04 PM, Olaf Hering wrote:
> Am Fri, 5 Apr 2019 14:59:16 +0200
> schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:
>> On 4/5/19 2:09 PM, Olaf Hering wrote:
>>> Am Fri,  5 Apr 2019 13:55:29 +0200
>>> schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:
>>>  =20
>>>> +EFIROM ?=3D edk2/BaseTools/Source/C/bin/EfiRom =20
>>>
>>> This name is too generic and will conflict with ipxe.git if any of "b=
ios seavgabios pxerom" is used for 'make -C roms'. =20
>>
>> This is similar to commit c9d18c1c150c84e where you said "it used to
>> work", what is the difference?
>=20
> Before there was no need to pass EFIROM=3D to make, so ipxe.git was hap=
py.
> Now it is required, and ipxe.git gets an unexpected value.
>=20
>> IPXE override the EFIROM variable, so there is no change there.
>=20
> For me ipxe tries to rm $(type -P EfiRom). Let me double check.

Eh you are right...

$ make -C roms EFIROM=3D/bin/true clean
[...]
make -C ipxe/src veryclean
make[1]: Entering directory '/home/phil/source/qemu/roms/ipxe/src'
rm -f bin{,-*}/*.* bin{,-*}/.certificate.* bin{,-*}/.certificates.*
bin{,-*}/.private_key.* bin{,-*}/errors bin{,-*}/NIC ./util/zbin
=2E/util/elf2efi32 ./util/elf2efi64 /bin/true ./util/efifatbin
=2E/util/iccfix ./util/einfo TAGS bin{,-*}/symtab
rm: cannot remove '/bin/true': Permission denied
make[1]: *** [Makefile.housekeeping:1564: clean] Error 1

This seems to be a pre-existent IPXE bug:

$ git checkout c9d18c1c150c84e7a976df989ad04ddf01083f46
$ make -C roms EFIROM=3D/bin/true clean
[...]
rm: cannot remove '/bin/true': Permission denied
make[1]: *** [Makefile.housekeeping:1564: clean] Error 1

>> How can I trigger a SUSE package build with this patch?
>=20
> Not so easy without a VM.

Oh, unfortunate :(

>=20
> Olaf
>=20


--sF1bhJDHdeIomA5oUHaUGn3VHF9hhQ10B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlynVLYACgkQoqP9bt6t
wN74Ew/+L3ECOpJLHIr/I1zCNC99eWBv+Gbusrwxwm8xnlY5gyCnBPVrHORSYAgf
fwdRALyoGn51aG4bUaEUEtMbxr27Hpg5EIJ5z+G0OE+flWGUWtXk7s6cNlcaHYef
AOzClsy0/4g6G4LgRAGsRbhXKnJ/F3o75P5CLtlNnNlOe1ckMQspUer+j3wHX4wE
Y7R52c3RZvQAzOv8T3TaqqKWgh8v7zNTJA0l1Jc0pdpyq1hrnxfC5f6aDVvao6n/
NzcZIdfRooogBf6F8I3gH1eE32Z4Vlg7SxlSWm2BAAAkfFSraDm9Ji23acdH+CB+
UnKqMzw4C9Ue0IadmZrSiCXqlE+LAafCuz6ICm1kj9HymoMDLF9JufYQFIujWFwx
qn7WNq0d/L+4qLdRDD5vMpyY2vEagRg1jMoja2Tfb0+P1GizL5jRZ7KAGy5kXfK3
W2qdtw7pEDmiyte0Wy4wovRYXtTihLyn4ACzCHuTMhz7matSaZogw+dZIMLIh823
EemxHKfdcWUUu3CaQifM0MMqMYwEmGB/j/sxXZvpHYm3WGP0fkewBk3JTSqdA+0f
EbNzV8uj1ky9E/LSfeUaRP3wzGHZVskgrPw8w22iHTVqEAmSJFY6yKKwSNrigYEm
n3tDkbAJNW/+Ju1cMMthVZQQ0C8GkeRVGTFBykHs/XIOc5rgU5c=
=R0Cx
-----END PGP SIGNATURE-----

--sF1bhJDHdeIomA5oUHaUGn3VHF9hhQ10B--

