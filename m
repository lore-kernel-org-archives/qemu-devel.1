Received: from eggs.gnu.org ([209.51.188.92]:38211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMJV6-0008Dm-5E
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMJV3-0005KO-JD
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:44:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hMJUx-0005AM-SR
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:44:14 -0400
References: <20190430181343.1362-1-driver1998@foxmail.com>
	<141080f9-8374-1d16-7b40-a4848a455086@redhat.com>
	<tencent_DAABF38404447BB09E9711B789C215AAD109@qq.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <153ed8ff-73b1-b120-9f83-a143c6bdac64@redhat.com>
Date: Thu, 2 May 2019 16:44:05 -0500
MIME-Version: 1.0
In-Reply-To: <tencent_DAABF38404447BB09E9711B789C215AAD109@qq.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oFhh7Xu7cvW0S1qfReAuLeHb6vmaxh9vU"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] include/qemu/osdep.h: Move
 the__USE_MINGW_ANSI_STDIO define up to avoid confliction.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: driver1998 <driver1998@foxmail.com>, qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oFhh7Xu7cvW0S1qfReAuLeHb6vmaxh9vU
From: Eric Blake <eblake@redhat.com>
To: driver1998 <driver1998@foxmail.com>, qemu-devel <qemu-devel@nongnu.org>
Message-ID: <153ed8ff-73b1-b120-9f83-a143c6bdac64@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] include/qemu/osdep.h: Move
 the__USE_MINGW_ANSI_STDIO define up to avoid confliction.
References: <20190430181343.1362-1-driver1998@foxmail.com>
 <141080f9-8374-1d16-7b40-a4848a455086@redhat.com>
 <tencent_DAABF38404447BB09E9711B789C215AAD109@qq.com>
In-Reply-To: <tencent_DAABF38404447BB09E9711B789C215AAD109@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/2/19 4:05 PM, driver1998 wrote:
> On 5/1/19 2:30 AM, Eric Blake wrote:
>> Your entire series is missing 'In-Reply-To:' and 'References:' headers=
,
>> making each message show up as individual new threads rather than
>> properly threaded to a 0/4 cover letter. You'll want to fix your sendi=
ng
>> habits to avoid that problem in future submissions.
>=20
> I am terribly sorry about that, this is the first time I summit patches=
, and I am still getting used to the tooling.

That's okay, we were all first-timers once; and most human maintainers
try to be more forgiving than automated tools when it comes to working
around first-timer learning curves. There may be other useful hints you
can use at https://wiki.qemu.org/Contribute/SubmitAPatch

> Thank you for pointing out the issue though.
>=20
>> It's unusual to use a trailing '.' in the subject line. Also, your
>> subject is very long; commit message summaries should typically be
>> around 60-70 characters because 'git log' shows them with further
>> indentation, where an 80-column terminal window makes it hard to see t=
he
>> tail at a glance.  Better might be a short subject line explaining the=

>> "what", and then a non-empty commit message explaining the "why"
>=20
> Thank you for pointing out, I'll update that in the upcoming v3 set.
>=20
>> Question - does it hurt to make the define of __USE_MINGW_ANSI_STDIO
>> unconditional?  In other words, we're unlikely to break any non-mingw
>> platform if we drop the #ifdef __MINGW32__ line.
>=20
> I personally have no idea, so I'll keep it as is.

Fair enough for your patch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--oFhh7Xu7cvW0S1qfReAuLeHb6vmaxh9vU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzLZKUACgkQp6FrSiUn
Q2pdvQgAql9L8zApXNRLq5WkHnALApNsOTysaJjf/Raow/VeU2yZihhIdafKDpLJ
MmfhrDlWbIp3kTaqiaOCRpoBvuEt7ipoDTdjjNdDFZybOJuf6AKr6rSJv29O5MUc
Uz5ddl4urw/IR8lBQWL69tDnOUZC88BUVWlgRBorI6EqKCvcx4Q1JU4oaS9lRA2h
mQkx5NF1697DEic03w3pIbBuiPemDD6eS+8Ofz8N8oFuRXQ9C9BdaQIU0Y+gjtl0
1K4MkVePwJZIokAa9L3ZqByxwt5QoCqRQOIlQRCYZXZEsjOx1pskDnICU8vw7URU
Hdts6bO5xCMsypncfvr0V+IG0F1Ryg==
=Oo0Z
-----END PGP SIGNATURE-----

--oFhh7Xu7cvW0S1qfReAuLeHb6vmaxh9vU--
