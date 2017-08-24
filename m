Received: from eggs.gnu.org ([2001:4830:134:3::10]:53907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkuyj-0007BO-4E
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkuyg-0005Jq-0Z
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:27:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dkuyf-0005JC-Ml
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:27:29 -0400
References: <20170823072656.3352-1-zyimin@linux.vnet.ibm.com>
	<871ef0e3-ea8b-df59-0eeb-8019b350f1d2@linux.vnet.ibm.com>
	<20170824091332.01ff3698.cohuck@redhat.com>
	<26519e3e-3ef4-7b18-6d80-27941ee36df9@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <20d23300-2f98-7b38-afab-4c8971afb356@redhat.com>
Date: Thu, 24 Aug 2017 11:27:26 -0500
MIME-Version: 1.0
In-Reply-To: <26519e3e-3ef4-7b18-6d80-27941ee36df9@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="whAPRqN4R05I3t2SrK7Pru2a3wJrRKS1n"
Subject: Re: [Qemu-devel] [PATCH 0/4] four zpci patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--whAPRqN4R05I3t2SrK7Pru2a3wJrRKS1n
From: Eric Blake <eblake@redhat.com>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, agraf@suse.de,
 borntraeger@de.ibm.com
Message-ID: <20d23300-2f98-7b38-afab-4c8971afb356@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] four zpci patches
References: <20170823072656.3352-1-zyimin@linux.vnet.ibm.com>
 <871ef0e3-ea8b-df59-0eeb-8019b350f1d2@linux.vnet.ibm.com>
 <20170824091332.01ff3698.cohuck@redhat.com>
 <26519e3e-3ef4-7b18-6d80-27941ee36df9@linux.vnet.ibm.com>
In-Reply-To: <26519e3e-3ef4-7b18-6d80-27941ee36df9@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 03:48 AM, Yi Min Zhao wrote:
>=20
>=20
> =E5=9C=A8 2017/8/24 =E4=B8=8B=E5=8D=883:13, Cornelia Huck =E5=86=99=E9=81=
=93:
>> On Thu, 24 Aug 2017 13:20:12 +0800
>> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>>
>>> Why can't I receive [Qemu-devel] prefixed patches?

>>
> I sent patches to qemu-devel@nongnu.org and cc you also myself.
> But what I received looks like CC ones, no [Qemu-devel] prefix.

You can tell mailman whether you want to receive copies of mails through
the list even when you are listed in cc (defaults to on, but some people
like myself set it off to reduce mail); if you switch that option in
your subscription settings, then you will not see the [Qemu-devel]
prefix on any mail where you were cc'd.  [side note: turning off copies
of mail where you are cc'd triggers what I consider to be a mailman bug:
it actively rewrites the to/cc of the email to omit your address in the
copy it sends to the list, which means people who follow up to the list
no longer cc you, and do not know that you were cc'd in the first place]

Furthermore, there may be other places along the way that do data
de-duplication.  For example, anyone subscribing via a gmail.com address
gets at most one copy of a message based on the message-id; if they are
subscribed to the mailing list and also get a cc of a given message,
only one of those copies will show up (because google suppressed the
second copy with the same message-id, even though the subject lines are
different); the one copy is often (but not always) the one without the
[Qemu-devel] prefix because cc'd mail goes through less processing and
thus tends to arrive sooner than the copy sent through mailman.  [side
note: google calls de-duplication a feature, but you can't turn it off,
and it's one of the reasons that I don't use google for my personal email=
]

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--whAPRqN4R05I3t2SrK7Pru2a3wJrRKS1n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlme/m4ACgkQp6FrSiUn
Q2rABAf/ei1xZQEaGFh75S78iGNS8pucHfsCna7zr7U9LdwpUun4xcA9IWvO2BBx
PG13t5EWtIOCIksdD/t6nlq+sLKFgPz/1mF+uPhnDCs18/ucEQlj6qVhMZQmmV40
/MHlU+fxvacf3SX+iQQY3+OpH1cJU4h04xdETXi05L/u2UhB9FQ4b0Eg1kacMJ39
VD8koXPrBMrzyDtPNxFgavQ1c3A6RfdD8Kgu0UxlDcTjzKqO1gwHCQQzZOe2eApQ
WsKdjZYpGIxc+tpGO9lmje1JLDiA64PH4iOXZHcZfVgJhyxt+zlGfMVf9zGmfm+u
fTd/PyktL9DAPPcuLklxsVbRHY3JxQ==
=FPIo
-----END PGP SIGNATURE-----

--whAPRqN4R05I3t2SrK7Pru2a3wJrRKS1n--
