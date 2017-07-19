Received: from eggs.gnu.org ([2001:4830:134:3::10]:39457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXqjT-0004Z2-Qi
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXqjQ-0004Fn-LT
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:17:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXqjQ-0004Fd-CH
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:17:44 -0400
References: <201707191247531805742@zte.com.cn>
	<20170719061651.GE2757@localhost.localdomain>
	<20170719121628.GI2103@work-vm>
	<20170719124147.GH2757@localhost.localdomain>
	<f870ca6c-a8fb-a88c-f171-a66f4158671d@redhat.com>
	<20170719150758.GK30084@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4558ee82-0214-cd91-1de9-8081b98ddb0b@redhat.com>
Date: Wed, 19 Jul 2017 10:17:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170719150758.GK30084@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hWPbimIlmQDNNbUg2JJfWtaUkJiKoqqqL"
Subject: Re: [Qemu-devel] [PATCH v2] hmp: allow cpu index for "info lapic"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, wang.yi59@zte.com.cn, liu.yunh@zte.com.cn, qemu-devel@nongnu.org, "libvir-list@redhat.com" <libvir-list@redhat.com>, pbonzini@redhat.com, Liu.Jianjun3@zte.com.cn, rth@twiddle.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hWPbimIlmQDNNbUg2JJfWtaUkJiKoqqqL
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, wang.yi59@zte.com.cn,
 liu.yunh@zte.com.cn, qemu-devel@nongnu.org,
 "libvir-list@redhat.com" <libvir-list@redhat.com>, pbonzini@redhat.com,
 Liu.Jianjun3@zte.com.cn, rth@twiddle.net
Message-ID: <4558ee82-0214-cd91-1de9-8081b98ddb0b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] hmp: allow cpu index for "info lapic"
References: <201707191247531805742@zte.com.cn>
 <20170719061651.GE2757@localhost.localdomain> <20170719121628.GI2103@work-vm>
 <20170719124147.GH2757@localhost.localdomain>
 <f870ca6c-a8fb-a88c-f171-a66f4158671d@redhat.com>
 <20170719150758.GK30084@redhat.com>
In-Reply-To: <20170719150758.GK30084@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/19/2017 10:07 AM, Daniel P. Berrange wrote:
>> It doesn't.  Perhaps we should add that as a future libvirt-qemu.so AP=
I
>> addition, although it's probably easier to just use QMP than HMP when
>> using 'virsh qemu-monitor-command' if HMP doesn't do what you want.
>=20
> Or special case the "cpu 1" command - ie notice that it is being
> requested and don't execute 'human-montor-command'. Instead just
> record the CPU index, and use that for future "human-monitor-command"
> invokations, so we get full compat with the (dubious) stateful HMP
> semantics that traditionally existed.

Is 'cpu' (and the followup commands affected by it) the only stateful
HMP command pairing?  Is there a way to specify multiple HMP commands in
a single human-monitor-command QMP call?

Indeed, tweaking qemu's human-monitor-command call to track the state
might be cleaner than having libvirt have to tweak API to work around
this wart of HMP.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hWPbimIlmQDNNbUg2JJfWtaUkJiKoqqqL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllveBAACgkQp6FrSiUn
Q2ozQQf+I4z+tbkkeXXaihWfBrwwYgMmti2kNgeFJthFbaj0vUJfR8vwGWLeEeCK
6ZbR0TZsQx4EF+bFF6/YiouCUCO3j1lYxtaD4IM1v+Ju2Ae3kYVrOEzFPUawLT5P
zY5i2Kmvk6G6mFfn54Q9//iR3K0DHJh2nHQI1GzX0xqbTKH5OlBv2J9oij8ZwWPg
GBhZVSOvYLjmbdgt8cLWm+8rlj6Wb1hcsmwC7YUDLp0h0mi0AyOnt6i+YRN05O41
rWuB3TCUf8m+6ZPATu9a6H5iMu7Tnz/j0sZdnYZndAy9Ap7JhmAK/A1e4CMTKoSG
e0bMOMI/f/BD4GfoBGELteJA8PuLWw==
=pgMo
-----END PGP SIGNATURE-----

--hWPbimIlmQDNNbUg2JJfWtaUkJiKoqqqL--
