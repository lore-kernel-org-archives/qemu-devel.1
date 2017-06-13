Received: from eggs.gnu.org ([2001:4830:134:3::10]:40775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKj8u-0006Rv-7a
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKj8r-0001EY-3S
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:33:48 -0400
Date: Tue, 13 Jun 2017 11:33:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170613103340.GD29273@stefanha-x1.localdomain>
References: <CAOE=1Z1H-7DQtcUsKt7P2fhYQ2fBVp7R9KJwPki5wH9KvhbxBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline
In-Reply-To: <CAOE=1Z1H-7DQtcUsKt7P2fhYQ2fBVp7R9KJwPki5wH9KvhbxBg@mail.gmail.com>
Subject: Re: [Qemu-devel] Is there more trace-events in vhost module?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam <batmanustc@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-discuss@nongnu.org


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2017 at 08:21:07PM +0800, Sam wrote:
> I'm debuging ovs-2.6.0, dpdk-2.2.0 and qemu-2.6.0. And I run such command:
>=20
> QEMU_CMD -D qemu-log.log -trace events=3Dqemu-events ...
>=20
> I want to trace vhost-user protocol process between QEMU and ovs-dpdk.
> Ovs-dpdk's log shows lots of infomations of vhost-user protocol, but QEMU=
's
> log shows only a little.
>=20
> As in qemu-events, there is only 'vhost_user_event' event I could use. Is
> there more events or some other method to debug vhost related module in
> QEMU?

vhost_user_event is the only QEMU trace event that currently exists for
vhost-user.

Guidelines for submitting patches are here if you decide to add more:
http://wiki.qemu.org/Contribute/SubmitAPatch

Stefan

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZP7+EAAoJEJykq7OBq3PIURcH/3D2vjuzW5xe0L9eQE4v5Z9Y
rK+2vJ9aKLZ+jQWYWZPDgiufkbwqwfgyyAl8FeXzdlFgviv37bOEwn3oxUi/z1K6
2G8C0OG4hWKiBL8XzltPj7LK6oVXORuWDbWx5zzFGmQTKq5+SSZQaUnY5nPg6lJq
nx+oZqoI8K1sEJQq9gtoAq6Jb6Bt3TuqWl4C+17DJvYT1oUIV+Q3zD9LHtGNNzHH
e3fXA4R3FrlWUlTjaYhQvsT6/u82SdUoNgG2N04XTa7porawqxFh0KxjYCLUCiKl
bdHZ1xUAavX7L2X7HeS7CgCmnnTqLjxRp/wpDeO1a8nffJpnOSblNQ/WCpaBiUI=
=mFx5
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
