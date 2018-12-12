Received: from eggs.gnu.org ([2001:4830:134:3::10]:47950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX3Ek-0002Ox-Lk
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 07:03:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX3Ej-0000xb-Hk
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 07:03:34 -0500
Date: Wed, 12 Dec 2018 13:03:22 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181212120322.GA5415@linux.fritz.box>
References: <154115285434.11300.8459925605672823399.stgit@dhcp-3-135.uk.xensource.com>
	<20181102110412.GD7521@dhcp-200-186.str.redhat.com>
	<20181212085951.GA7604@aepfle.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20181212085951.GA7604@aepfle.de>
Subject: Re: [Qemu-devel] [Xen-devel] xen_disk qdevification (was: [PATCH
 0/3] Performance improvements for xen_disk v2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>
Cc: Tim Smith <tim.smith@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Paul Durrant <Paul.Durrant@citrix.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 12.12.2018 um 09:59 hat Olaf Hering geschrieben:
> On Fri, Nov 02, Kevin Wolf wrote:
>=20
> > A while ago, a downstream patch review found out that there are some QMP
> > commands that would immediately crash if a xen_disk device were present
> > because of the lacking qdevification. This is not the code quality
> > standard I envision for QEMU. It's time for non-qdev devices to go.
>=20
> Do you have that backwards by any chance? IMO the presence of assert()
> contributes to bad code quality, not the drivers that trigger those
> asserts.

You like shooting the messenger, it seems? Bugs aren't bad, only
catching them is?

But anyway, in this case, I seem to remember it was a plain old
segfault, not a failed assertion.

Kevin

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcEPkKAAoJEH8JsnLIjy/WfOkP/ilV8ovJG80SyTXbBf5iGlTf
92OkHNDm8N+VfVuMFTCXiaIkkwCFbtvDKfI3LYUngh7PgIevZCYJWgjOQRJl7pZi
ki4Fptcei2B7kLgtKBCECQEpPUaycTHpqVlSsPBBJ7q8EMH7by7DEs8oH7AvxJNx
tfdbhESKNQKrj4igZuq6VwpwyqOOyrl//CKkGon8Wsz5NiHmww9e4jxcH3gIjx+U
BFwaB7NP8XjsbDncHzp9Z+p4G3wasbymy9Hq8GM9ujyg/XJwgBGfAEcm6VzGCaO2
ufUumuxkHlu8HCqtaG3Yw2RHzGtzMJ92GUJj2k4apuXQf5sZnE1OYxq0djN7JGrm
Y/ie86jw+jONwFNn1CVC/h9UCFOrkaPNvxstes2UxBb3jESpRnUtEdIEsWRyNPfH
Cw9DC35Qww3o52R6sjoy6HlN3xeu6jEnc+cP8WDVONYwmpePXZQ7Lg0BWArAgkrS
FyWUWnGZKUVeTcI4/SthtN5Jw3UTsF3KFklDPvVm7TQ/3YxVHjtsSdOaVPzCT5pH
xc9TBuso6i827+WRre6hGSgQw5E15wjORT4/xaD8tEy8vz4HwUQ5bKyQDTGXouOt
fKJGQjPwszI1RQddoZdNpJdBLLxTs54vxtGEZXbX6o02HfwqAoQBEhOJlBhNKSuY
BmN8CKru3jSU5bvKKyVX
=795z
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
