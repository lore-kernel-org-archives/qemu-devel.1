Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C983AC282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 08:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F11218D0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 08:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F11218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49436 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDPsP-0005S6-PZ
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 04:43:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDPm6-0000Dl-Vh
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDPm5-00046z-TR
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:37:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDPm5-00046B-EX
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:37:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id c1so13254990wml.4
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 01:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to;
	bh=sN2Dvxf+Cmu4nilr5jMlcbg8EoGXCwx8g+W/mvBYpq4=;
	b=lTMHLPUFHCVldRQIkGIcxoCnm48myqg16EZbC7hDQIefBdUCuWKQFWKa4Gqui7kpZP
	gRe4+wtBWh2+6KY7UG7zVjrDfywXqhKNU/ODsfjksKc+Y3rSlzsqBz76mfd0yDg1ElYa
	M/qeVCmqdRVP7uBdaCKKo0W9LvUGGsNTrp+OAzjDYxM4nkfjohXHVfNFxww1JsNsByH8
	nyVJTvJv64FitU9K9iIKdjn+axhy7fOuJAWJBlDWT8EWOjKjiA8owGJF62jyYKPNxhc2
	cN2omDipR3j8QMmqGP3JqXlriJ2Bzm3kzH1DTA4fBjPcWqqIQzBhOkLuZiuATPJKRNMu
	xvGw==
X-Gm-Message-State: APjAAAUfaZwBSCUCOaPqE+EPBglLBVagUNlPnhOoDBfW1j1cbNg0uduQ
	iEIgq09QHkcr3OthniUYCz7fxA==
X-Google-Smtp-Source: APXvYqxSOr8cYXboS7ULRNANS3D5HUDx1mVNmFu794i5PcDSm53IGtL4vl8EKu7zCTOjrdLJFtiJNw==
X-Received: by 2002:a7b:cc91:: with SMTP id p17mr16613404wma.38.1554712623754; 
	Mon, 08 Apr 2019 01:37:03 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	l20sm8892001wme.20.2019.04.08.01.37.02
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 01:37:02 -0700 (PDT)
To: Olaf Hering <olaf@aepfle.de>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20190405115529.11590-1-philmd@redhat.com>
	<20190405140917.3af9b91d.olaf@aepfle.de>
	<6bdd3c91-1e65-db2d-8ff2-fa667a819a1f@redhat.com>
	<20190405150438.48c1cc84.olaf@aepfle.de>
	<3c212c03-80a3-a8bb-fbe0-0071ebfb6936@redhat.com>
	<20190405191703-mutt-send-email-mst@kernel.org>
	<20190408082129.5103140f.olaf@aepfle.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b0e145bd-8072-21d2-9cd5-f955ee10e993@redhat.com>
Date: Mon, 8 Apr 2019 10:37:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408082129.5103140f.olaf@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="txZgAG1XFPETmNWbrE5vQb7RRDDYixdlL"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
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
Cc: Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	qemu-devel@nongnu.org, ipxe-devel@lists.ipxe.org,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408083701.HHx31Q5upUg0MngySvTaW2LPnu-X5PzvFnkxd99UmJM@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--txZgAG1XFPETmNWbrE5vQb7RRDDYixdlL
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Olaf Hering <olaf@aepfle.de>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 ipxe-devel@lists.ipxe.org
Message-ID: <b0e145bd-8072-21d2-9cd5-f955ee10e993@redhat.com>
Subject: Re: [PATCH for-4.0] roms: Allow the EFIROM variable to be overridden
References: <20190405115529.11590-1-philmd@redhat.com>
 <20190405140917.3af9b91d.olaf@aepfle.de>
 <6bdd3c91-1e65-db2d-8ff2-fa667a819a1f@redhat.com>
 <20190405150438.48c1cc84.olaf@aepfle.de>
 <3c212c03-80a3-a8bb-fbe0-0071ebfb6936@redhat.com>
 <20190405191703-mutt-send-email-mst@kernel.org>
 <20190408082129.5103140f.olaf@aepfle.de>
In-Reply-To: <20190408082129.5103140f.olaf@aepfle.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 4/8/19 8:21 AM, Olaf Hering wrote:
> Am Fri, 5 Apr 2019 19:17:35 -0400
> schrieb "Michael S. Tsirkin" <mst@redhat.com>:
>=20
>> Let's keep it simple: set a config variable, then check it here.
>=20
> Better revert f590a812c21074e82228de3e1dfb57b75fc02b62 and 23858f4092fc=
9ebf9e7a5e5110e44abef6fc6643 for the time being. It looks like a no-op ri=
ght now. How did people get away without the system-wide EfiRom until now=
? It is certainly only a very small inconvenience to build a private EfiR=
om for those who can not possibly receive it from the vendor.

But f590a812c210 and 23858f4092fc are used for ACPI UEFI testing, what
about the v2 which looks "simple" to me:
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01033.html

> Also roms/ seems to be unable to receive configure options.
>=20
> Olaf
>=20


--txZgAG1XFPETmNWbrE5vQb7RRDDYixdlL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlyrCC0ACgkQoqP9bt6t
wN4gwBAAxp0AsAlU3AZV6ZZT1GWgdpzhMnazPiuiuDYUtlxga7wq5FA+j26aWZiz
aOgwM2ACTrtRLQNnK0kz5r64N0tYrRLUqR2eX90WaknOhDyXAwci7GpQh4ofKjdV
s3lIH6dTcJ4Hyuk+24NLrID07bArLhnvQW4ZWKivFhjQKrA1ToGZwWGNa3UbEk2u
Hf2AkXkgXqva9Acf0VHv4Tf5oxMRurE7/AIxSorwAqPG/EcBnINpCwB385HgAe44
mQnjj6//7R8NmTNlNb6r/E6EjYDy3fa3O4m5kYZ30bLzHh0ewTOf8TDXRNmL/GeK
zUaRlCXHB228/UexxYxjrJdt9gvtGaZzhKqbG3dNpXAkOAp3sRvvwkO0MVXaDqQK
UzZwViNR8DopkXd6mSnlGxjnPR1eQE7X6uk5NBgVNfakcN1gDSxGn0zUjA56GFwJ
dlUf7k3xTDtgOSvOp0+5Dr2b/hmsrV1iWtjKn2ozUl1wdPqRS1InGPxA8/u5VR9d
QYc/+VGapG6TmEzgWS1BhdDFEzZ+vdNkbkyJT72Q9g81lV4hxX//nE88TSOsHzC/
x6HzfQYe5zSdEfawJSRJD2FmV5eO+tKPNC+whTXtdpzCWQP7VZ48f8qY4HVxRmqA
S74O07N3IMMpMQQChni626kQ+5mqidtsjyn56ysnFnLd7fJ7ZvM=
=6Wlb
-----END PGP SIGNATURE-----

--txZgAG1XFPETmNWbrE5vQb7RRDDYixdlL--

