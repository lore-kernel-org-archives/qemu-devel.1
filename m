Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CCAC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 13:00:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D6021855
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 13:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D6021855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41668 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCOS8-0006D5-Oe
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 09:00:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCORG-0005u8-T1
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 08:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCORF-0001ya-NH
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 08:59:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCORE-0001wl-OA
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 08:59:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so7930043wrp.2
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 05:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to;
	bh=T5RLSaop/Bo/4wxDSaS7Kg7rZ4Avgo8WRsjQT+c5n1A=;
	b=Ydv6CxnfNHbC9b3DP1DvFYk3QP+g496kVBeDrvbRFQVHZvo9H9Z2kPacxQsmNVmlKI
	O2X/+wVXwzi1OYiCW5LbFniS4BZO6fRZLdwwUAnNu5v2DeynuojWRRPpRWRCysc2cu2+
	O4ZyWPBf2isdPnHkbb7UdfbG1FawWISVL3Zw/HuUr3KI+PFzQiKKuKI8gNuWhVL+xN2W
	CWemZxyeya1POwYkexPKqP94O6zRL6CgQ96h3HgHK85ZS/dycXLBM6QLJpTguZ+bpEkO
	fKYuIqB15pdbRKVj1bqMwM5AtU+1vi5YuYzK7WQR0/axMmdbdkEZ33jFA1ph5su0U44I
	vvgA==
X-Gm-Message-State: APjAAAVQ0xtoLo4qCP/RwWM+o/AVhXUsat9koGnwNxdjMjSJa/wiVMDu
	JZJYx8czhys8lmxM4cycgR85bA==
X-Google-Smtp-Source: APXvYqzkRwIOcvt3ewc9XRkAmsUjj8hMW4GVCD5hmk56PNVlMBB+3o1++XaerzQV/XNi3HDbXc3mPQ==
X-Received: by 2002:adf:ef91:: with SMTP id d17mr8122600wro.78.1554469159213; 
	Fri, 05 Apr 2019 05:59:19 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id o1sm2738972wmh.47.2019.04.05.05.59.17
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 05 Apr 2019 05:59:18 -0700 (PDT)
To: Olaf Hering <olaf@aepfle.de>
References: <20190405115529.11590-1-philmd@redhat.com>
	<20190405140917.3af9b91d.olaf@aepfle.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6bdd3c91-1e65-db2d-8ff2-fa667a819a1f@redhat.com>
Date: Fri, 5 Apr 2019 14:59:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405140917.3af9b91d.olaf@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6lMHMtjFEEUGQuACLponBOkqtM0VAkpMv"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405125916.7UF137fZ7ZBOWChknVocHk4d8cMQt3IwJrpe-mQlsyQ@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6lMHMtjFEEUGQuACLponBOkqtM0VAkpMv
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Message-ID: <6bdd3c91-1e65-db2d-8ff2-fa667a819a1f@redhat.com>
Subject: Re: [PATCH for-4.0] roms: Allow the EFIROM variable to be overridden
References: <20190405115529.11590-1-philmd@redhat.com>
 <20190405140917.3af9b91d.olaf@aepfle.de>
In-Reply-To: <20190405140917.3af9b91d.olaf@aepfle.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/5/19 2:09 PM, Olaf Hering wrote:
> Am Fri,  5 Apr 2019 13:55:29 +0200
> schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:
>=20
>> +EFIROM ?=3D edk2/BaseTools/Source/C/bin/EfiRom
>=20
> This name is too generic and will conflict with ipxe.git if any of "bio=
s seavgabios pxerom" is used for 'make -C roms'.

This is similar to commit c9d18c1c150c84e where you said "it used to
work", what is the difference?

IPXE override the EFIROM variable, so there is no change there.

How can I trigger a SUSE package build with this patch?

Thanks,

Phil.


--6lMHMtjFEEUGQuACLponBOkqtM0VAkpMv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlynUSQACgkQoqP9bt6t
wN7ATg//cXb2NbsUw7JvaJq9RxdQxTXw4dX+WWjO55UFv9GwQWF6jCvjYWBWvz39
ipIkq4dBHAQYodi+TUfO906b+F7gi2CZ0X3vqY7tyZQRAzjG1eD/pTCSqNBPuD0s
pfiphXSagFMR62GYFO4fI0ApoD7H6RtImWt/9Fj1xFFgQXlqY+lNpK9a/oLX1/pu
G+1+ynSxgDknD+MRDkH8iM6mkDKitdXq1akfAjaPvPsY76jPEzv0u6kc/8p3jmqH
amE0mXWjMhrswTE5eEOPl1on8AiaT6r2qk8d3TwTRqHdzBYG1qM8TM48zt3fyUeN
/vV6Y8yLxiuOzK9iAFmpKSViotrIjJ9oUAjJJNulC737XaARr+jkVpeMgxsdGsl0
7flCRZwg9hx06nae4zSVIAH22iULg6FV2/lnEcr0e2Pi5fxyx9HpV0tPeTpETyMM
DI5SNwl/TBEsnCY0BM1OzJa4jtsXKLimMYSwI7AjZyBdsjbK/7LVt3NCGJ9EkfIM
8+M0pAzrrN7UsZ59sD376Q43ll1zYDkybrAaac47julU4hu3BLHoNi1VatG0Jphi
8u2EEUgEPCVYyzR2w6pRvT2MHWlXHU+IExo/X5//CLOjcVOPn8pi2OoV/dbmQFqU
lQdQo2VwSR2tRo4OQATlbeC0fmRN6HCG7/McwOPWtUkSAnDYCj0=
=P5vv
-----END PGP SIGNATURE-----

--6lMHMtjFEEUGQuACLponBOkqtM0VAkpMv--

