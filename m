Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84004C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 10:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 580FA2173E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 10:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580FA2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvfkJ-0004XX-LN
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 06:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34227)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvfjt-00047p-Vy
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 06:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvfjo-0005Am-B4
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 06:33:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54506)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvfjm-00059e-AF
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 06:33:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so1879923wme.4
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 03:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to;
 bh=FKarhDaqNwIX8qsfM2UDoOGQhIPKFfCqDxE/2gbLDgQ=;
 b=kU14WWM28ALN23oHJTp+Yzi+vmDAjawgSQ8b7RMVLrgdFEdZOnkoHN3MYCwqCMw3kG
 A3Qq+s59A+g7f3kmPEZZYPXR+UrpSRifEQI4v0YH9cfrSem0sbGZujs5J1rKSv927USt
 8nhx+59QHD4SvcqqIRGVI1QUs7+NjcZ7WY21jxBdg231sZRCT85jJXfKnTZn4wT9pAuK
 xOosGo3xX6/IndwU0EuVeEu2ORHjVmIALY9IwZDkgoJrOsw4/pQCJP2IW3x48HaNIcCV
 TYaATD2qK4EeyIANhGQmuXqyrQqkQLoS++Q7rsMnEbLtZmpGwxHHPb7d+4RRq0Cj+8oS
 aEJg==
X-Gm-Message-State: APjAAAV4+yxotZ81g6r23Cav/gR7s6Z2fnIX5U4kbiFz6OzIc7+zOuAt
 7lV66kM2TBao3Uwm9k2RMci1oQ==
X-Google-Smtp-Source: APXvYqyNRrOkUTM4beBpNlcAL+2q8YOXUgcjyDBBCiFEAVyuUO2ieiqEiFICIGN1yMQe06uKq6axMg==
X-Received: by 2002:a1c:f418:: with SMTP id z24mr3576083wma.80.1565260415630; 
 Thu, 08 Aug 2019 03:33:35 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id l3sm2933632wrb.41.2019.08.08.03.33.33
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Aug 2019 03:33:34 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-2-bala24@linux.ibm.com>
 <5839fa4e-b6f3-9547-e71d-50be75c4f9fc@redhat.com>
 <20190808101013.GD1999@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1f5d9c88-523a-3bc5-7ab1-f814e645b37d@redhat.com>
Date: Thu, 8 Aug 2019 12:33:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190808101013.GD1999@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9Gd0CuTlwgwBDfgJRkn3i6lPI2DggEM2c"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [RFC PATCH 1/6] utils/python_api: add scripting
 interface for Qemu with python lib
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
Cc: Peter Maydell <peter.maydell@linaro.org>, maddy@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, Balamuruhan S <bala24@linux.ibm.com>,
 anju@linux.vnet.ibm.com, clg@kaod.org, Stefan Hajnoczi <stefanha@redhat.com>,
 hari@linux.vnet.ibm.com, pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9Gd0CuTlwgwBDfgJRkn3i6lPI2DggEM2c
Content-Type: multipart/mixed; boundary="Ava5A9MRu01jSqKA3yiWc2B1ZTsDhTVHK";
 protected-headers="v1"
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Balamuruhan S <bala24@linux.ibm.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, hari@linux.vnet.ibm.com, clg@kaod.org,
 Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com,
 david@gibson.dropbear.id.au
Message-ID: <1f5d9c88-523a-3bc5-7ab1-f814e645b37d@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/6] utils/python_api: add scripting
 interface for Qemu with python lib
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-2-bala24@linux.ibm.com>
 <5839fa4e-b6f3-9547-e71d-50be75c4f9fc@redhat.com>
 <20190808101013.GD1999@stefanha-x1.localdomain>
In-Reply-To: <20190808101013.GD1999@stefanha-x1.localdomain>

--Ava5A9MRu01jSqKA3yiWc2B1ZTsDhTVHK
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/8/19 12:10 PM, Stefan Hajnoczi wrote:
> On Wed, Aug 07, 2019 at 12:20:47PM +0200, Philippe Mathieu-Daud=E9 wrot=
e:
>>> +void python_args_clean(char *args[], int nargs)
>>> +{
>>> +    for (int i =3D 0; i < nargs; i++) {
>>> +        g_free(args[i]);
>>> +    }
>>> +}
>>>
>>
>> Wondering about security, is this feature safe to enable in production=

>> environment? It seems to bypass all the hard effort to harden QEMU sec=
urity.
>=20
> This seems like a feature that distros would not enable.  Only users
> building QEMU from source could enable it.

Good. What about throwing big ./configure warning like the unsupported
cpu/os ones? Better safe than sorry :)


--Ava5A9MRu01jSqKA3yiWc2B1ZTsDhTVHK--

--9Gd0CuTlwgwBDfgJRkn3i6lPI2DggEM2c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAl1L+nwACgkQoqP9bt6t
wN6dqQ//bCoMIi2VTdipRLKpv1s8lWvDJ6Ila9Fet3Nsvjef+cR/YvenV4RuCR00
NJO4HDvo7s+Gr4wz4Ps7+UYywLwn8etxddtEeTeJ3cBwFrBneILxkubPirU6/+JV
fxXjkAI/8aXMdJvILk47eQ/sgSyzWXXEGfx0iUIvTF2e6WEhKlgZzqUUnuDFSLh2
Iu6lpRo908EizmcEyIPSFJDrn6KhDcvQjUyPwZeoDPrE+QDFkZXXe6A/OhNNobOv
jYf3u/9rFg88WkQZQxMuQFTOJU+XA06rmnHj5G6gA44ogALhDt5abx9A5lAmbI8T
ih8aqy2+Kr2/5bcvcvS6lCib8svceDPf5gjFt/GopahE3J4lYAMohHllQmJ5zV0f
qEA0UJ1KGMp49KslXMgHQshlKJQibJzPBHkFsW5Ito0AVV80hMFYztDSXBjudU8D
aCSUVv7JsWZBeZiPf45GUBK6LVwGPdbe/otV1t5ZsSz0QCGVll76RY9ZdlXO0Q1t
Jm/MRgpp2dE5LsYn6l7ocJgKBR8N4MiIPuYMLlTRz+QTER95DRhMJJTn6Qn+8Dmi
6q7JFDCZDS/HUtMkOQsATk+TNn5Z6iI2zBlhB0DkG1V5I0gbb5MC+YmHm877e88v
I+Gwj/W9qG2W3cSbbDXVoSQ5BpH8uvDWDCvM1Payc99GG3uaPcg=
=uZ/a
-----END PGP SIGNATURE-----

--9Gd0CuTlwgwBDfgJRkn3i6lPI2DggEM2c--

