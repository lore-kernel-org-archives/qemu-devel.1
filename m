Received: from eggs.gnu.org ([2001:4830:134:3::10]:45700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdg0U-0000yy-Ua
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:31:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdg0S-0008MR-2Y
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:31:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cdg0R-0008Kn-QJ
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:31:07 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BDAA4A794
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 16:31:07 +0000 (UTC)
References: <20170213135235.12274-1-pbonzini@redhat.com>
	<20170213135235.12274-2-pbonzini@redhat.com>
	<20170214074831.GE6428@lemon.lan> <20170214122607.GD467@redhat.com>
	<20170214145156.GM23310@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e4530bb2-4d17-7f64-607c-bc3039e5f139@redhat.com>
Date: Tue, 14 Feb 2017 17:31:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170214145156.GM23310@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="r6MUQcIuNh8cxT3WPE2vbfQst0rUqFaBv"
Subject: Re: [Qemu-devel] [PATCH 01/18] block: move AioContext, QEMUTimer,
 main-loop to libqemuutil
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r6MUQcIuNh8cxT3WPE2vbfQst0rUqFaBv
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Message-ID: <e4530bb2-4d17-7f64-607c-bc3039e5f139@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/18] block: move AioContext, QEMUTimer,
 main-loop to libqemuutil
References: <20170213135235.12274-1-pbonzini@redhat.com>
 <20170213135235.12274-2-pbonzini@redhat.com>
 <20170214074831.GE6428@lemon.lan> <20170214122607.GD467@redhat.com>
 <20170214145156.GM23310@stefanha-x1.localdomain>
In-Reply-To: <20170214145156.GM23310@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 14/02/2017 15:51, Stefan Hajnoczi wrote:
> On Tue, Feb 14, 2017 at 12:26:07PM +0000, Daniel P. Berrange wrote:
>> On Tue, Feb 14, 2017 at 03:48:31PM +0800, Fam Zheng wrote:
>>> On Mon, 02/13 14:52, Paolo Bonzini wrote:
>>>> --- /dev/null
>>>> +++ b/util/aiocb.c
>>>> @@ -0,0 +1,55 @@
>>>> +/*
>>>> + * BlockAIOCB allocation
>>>> + *
>>>> + * Copyright (c) 2003-2017 Fabrice Bellard and the QEMU team
>>>
>>> Hmm, I'm not lawyer, just wondering if the QEMU team is a legal entit=
y that can
>>> hold copyright? :)
>>
>> Reword it to say
>>
>>   "Copyright (c) 2003-2017 Fabrice Bellard and other QEMU contributors=
"
>>
>> so it is referring to individual contributors as distinct copyright
>> holders, as opposed to a single entity called "QEMU team"
>=20
> Paolo: Please confirm and I'll merge your series with this tweak.

Either way is fine.  There's also util/async.c:

util/async.c: * Copyright (c) 2009-2017 the QEMU team

which probably should use the same 2003-2017 notice as aiocb.c (async.c
was split by Kevin out of vl.c in 2009, but bottom halves date back to a
commit from Fabrice in 2006).

Also, we might as well patch LICENSE.

Paolo


--r6MUQcIuNh8cxT3WPE2vbfQst0rUqFaBv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYozDIAAoJEL/70l94x66Dv9kIAKwGKviRa0RIZdVPeielwaK+
Yq7viBGghGw08QhEIRxay6c9buDMwZPPITy1NB1W7WdePOIdDDBPLSZEIY6r+BKd
62yxy722lJw6vWeCoDfRCW9Q2ocEDi+UbXYShqgUFvWPYIsu2zA+6q1Kuy9REcKu
gDzsRFEktHt80T167xz8yvySwyM17weeoMQ+xZaLwYSBTsUGibo0z+j9W1ryNu49
o8Lbq+sF0NL6AijXpt639lM2rkbusY+nrR3agVW4gjlBbqAkNOeSm2uN9Irnm/Sr
lLNPvs0M8pA84p78klT1IqQ1kTvo+PH60SWeAoctivE3sEtO5jt0hhZNNEoylg8=
=0iRE
-----END PGP SIGNATURE-----

--r6MUQcIuNh8cxT3WPE2vbfQst0rUqFaBv--
