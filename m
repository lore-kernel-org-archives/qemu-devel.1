Received: from eggs.gnu.org ([2001:4830:134:3::10]:56023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTaHr-0005uv-UO
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 16:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTaHn-000213-6d
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 16:55:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dTaHm-00020K-TG
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 16:55:35 -0400
References: <cover.1498222907.git.tgolembi@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <346b5b87-4d9b-ab82-8966-71680ae06af0@redhat.com>
Date: Fri, 7 Jul 2017 15:55:31 -0500
MIME-Version: 1.0
In-Reply-To: <cover.1498222907.git.tgolembi@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rri3x1Q9WDiAxuhlMMg1i9kPsFWjBSCQu"
Subject: Re: [Qemu-devel] [RFC 0/3] qemu-ga: support for sending events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rri3x1Q9WDiAxuhlMMg1i9kPsFWjBSCQu
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org
Message-ID: <346b5b87-4d9b-ab82-8966-71680ae06af0@redhat.com>
Subject: Re: [Qemu-devel] [RFC 0/3] qemu-ga: support for sending events
References: <cover.1498222907.git.tgolembi@redhat.com>
In-Reply-To: <cover.1498222907.git.tgolembi@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/23/2017 08:02 AM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD wrote:
> This is just a draft, or a request for comments if you will.
>=20
> This patch sets drafts the support of sending events by QEMU Guest Agen=
t.
> Events can plan important role in monitoring of the guest OS behaviour.=
 The
> range of use cases ranges from events important for scheduling, e.g. me=
mory and
> CPU usage statistics, to things like changes to IP addresses on network=

> interfaces to for example changes in the list of active users.
>=20
> For now the patch set adds single periodic callback function to the GA =
main
> loop that can perform checks and trigger events that have occured since=

> previous run of the callback.

How do we guarantee that the guest cannot flood qemu with too many events=
?

Obviously, qga is already used where we (in general) trust the guest to
not be malicious, but we still have to assume that a guest can be
compromised, and will try to abuse qga to escape to an attack against qem=
u.

>=20
> We can of course take it one step further and add a general framwork fo=
r
> periodically running any of the already implemented commands. Add a fun=
ction
> that would maintain a list of registered checks. Client would use some =
command
> (register-monitor-command) passing it a command name and timeout in sec=
onds and
> the monitoring handler would then run the specified command and report =
the
> result... or report only if the return value changed since previous inv=
ocation.
> This feature would remove part of the communication overhead between cl=
ient and
> GA.
>=20
> So before I invest any more time in either of these approaches, tell me=
=2E Would
> somethign like this be wanted or is that too controversial? Any other t=
houghts
> and ideas?
>=20
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rri3x1Q9WDiAxuhlMMg1i9kPsFWjBSCQu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZX/VEAAoJEKeha0olJ0NqA50H/j0fIE3j3O8GZaIKYelGinQe
VtlShvjyUpZ9XpKy6Q/uMUCND/+xmTTk+twm07QLxhFfayfqb97HlesWgKvJeT+S
nXapD6HpyaX8CTaIO1MqF9IhGiQVWYWW9aWwHU+VtGtPqmOn6sVaNouJTbUVMVqU
ujRe1dt9g55wgZGNlm1Xn+d0Syr1xvtsOsfne45ufoYRH9K9fcHKLSNSJfBSXLsh
qN3XLRTIk3fUy9k2hq1gUbkBYLQqlF+NAmkFfujrWHQsWK5zXpfUnJu4eRpJT3AT
850dp/uu3szFH7uyruKKqHWk9ifSUibTylU+aQzGa5zimPvxWsNfWrxlebMfgac=
=togJ
-----END PGP SIGNATURE-----

--rri3x1Q9WDiAxuhlMMg1i9kPsFWjBSCQu--
