Received: from eggs.gnu.org ([209.51.188.92]:54924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjTyk-0000jF-IV
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:02:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjTyi-0001Ym-MW
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:02:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gjTya-0001QO-JJ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:02:18 -0500
References: <20190115184229.73688-1-emaste@freefall.freebsd.org>
	<CAPyFy2Dw2F3ks_5f8cvWjrsOTS0_Ybr5kELUpyHQmOQWUaeuFg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <15cf568b-b914-b48a-79db-4cc9a761654c@redhat.com>
Date: Tue, 15 Jan 2019 13:02:09 -0600
MIME-Version: 1.0
In-Reply-To: <CAPyFy2Dw2F3ks_5f8cvWjrsOTS0_Ybr5kELUpyHQmOQWUaeuFg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iuq18YgHO1GGu8tTwPIsGERvRcsV4fT2J"
Subject: Re: [Qemu-devel] [PATCH] .cirrus.yml: basic compile and test for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Maste <emaste@freebsd.org>, qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iuq18YgHO1GGu8tTwPIsGERvRcsV4fT2J
From: Eric Blake <eblake@redhat.com>
To: Ed Maste <emaste@freebsd.org>, qemu-devel <qemu-devel@nongnu.org>
Message-ID: <15cf568b-b914-b48a-79db-4cc9a761654c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] .cirrus.yml: basic compile and test for
 FreeBSD
References: <20190115184229.73688-1-emaste@freefall.freebsd.org>
 <CAPyFy2Dw2F3ks_5f8cvWjrsOTS0_Ybr5kELUpyHQmOQWUaeuFg@mail.gmail.com>
In-Reply-To: <CAPyFy2Dw2F3ks_5f8cvWjrsOTS0_Ybr5kELUpyHQmOQWUaeuFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/15/19 12:51 PM, Ed Maste wrote:
> On Tue, 15 Jan 2019 at 13:42, Ed Maste <emaste@freebsd.org> wrote:
>>
>> From: Ed Maste <emaste@freebsd.org>
>=20
> I'm not sure what part of the path between `git send-email` and the
> list moved this From: into the message body, but it's not intentional.

It doesn't hurt. 'git am' prefers the From: in the message body over the
From: from the message headers, if the two differ, because that is the
only way some people have to get git to record their commits correctly
due to the list having to rewrite their headers to avoid the mail being
rejected from over-strict SPF settings.  In your case, the two lines
look identical (the list didn't rewrite your header From: to work around
SPF); but it may be due to your 'git config format.from' settings.

> If someone's going to pick up this patch please edit the commit
> message.

'git am' already does it automatically.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--iuq18YgHO1GGu8tTwPIsGERvRcsV4fT2J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw+LjEACgkQp6FrSiUn
Q2o1GQgAnBm+awVwm4h60y0G8fDGdENhORAOrsB6ae+RTgbVI6ga0Vl4+mUu8NFX
BHAE1lNx1C0zuuYR0NvYS/sHe1Mi+loFq8I6Wc2bG+a4WO2JV5kdkrjV6vT2RWyh
gd2K9UysLUOr/fk4Mxr8sIsdrunrq4p/tpsbO59XXOcUrmOE0i77rjxyB4pDZYab
1NNpav6cqgsme4O6zIRDY3zxRdE0ZbjLXzba8qGM7aqYRZqMhligcP8yEZuJEift
PplaIk4oXM3kZFAr1aX3cHEy8J5pupJhOdTyZSYVV/H0oALi/13MJr5RIFQlXbkF
aLJaJf+cEibOGpxrjxyfb4racZqyNA==
=UUdf
-----END PGP SIGNATURE-----

--iuq18YgHO1GGu8tTwPIsGERvRcsV4fT2J--
