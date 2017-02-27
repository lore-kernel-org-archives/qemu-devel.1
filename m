Received: from eggs.gnu.org ([2001:4830:134:3::10]:39004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciJ3L-0005qV-3r
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:01:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciJ3I-0003t7-34
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:01:15 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:32836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ciJ3H-0003sF-Sj
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:01:12 -0500
Received: by mail-wm0-x244.google.com with SMTP id v77so12831551wmv.0
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 03:01:11 -0800 (PST)
Date: Mon, 27 Feb 2017 11:01:06 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170227110106.GE28403@stefanha-x1.localdomain>
References: <CAFrogKUMUSYF4a7gfO3ruO5hSm6qG6oVjp0vxAO-UNRMLxB54A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dFWYt1i2NyOo1oI9"
Content-Disposition: inline
In-Reply-To: <CAFrogKUMUSYF4a7gfO3ruO5hSm6qG6oVjp0vxAO-UNRMLxB54A@mail.gmail.com>
Subject: Re: [Qemu-devel] Question regarding Snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tim Cusack <thagrasshoppa@gmail.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, kchamart@redhat.com, eblake@redhat.com


--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2017 at 03:06:41PM -0600, Tim Cusack wrote:
> I have a scenario that perhaps not many have attempted, but I still hope
> that it is possible.
>=20
> Scenario:
>=20
> I would like to have a Base Windows 7 VM in KVM/QEMU.
>=20
> I would follow the following process (confirmed it works)
>=20
> 1. Shutdown running domain
> - virsh shutdown <Domain>
> 2. Remove existing disk from Domain XML:
> - virt-xml BASE --remove-device --disk target=3Dhda
> 3. Add Correct Disk image for Snapshot to Domain XML:
> - virt-xml BASE --add-device --disk
> /var/lib/libvirt/images/BASE.qcow2,format=3Dqcow2,target=3Dhda,bus=3Dide
> 4. Create the snapshot with description
> - virsh snapshot-create-as BASE <Model>.qcow2 "OEM, Model" --disk-only
> --atomic
> 5. Start Snapshot
> - virsh start FA2BASE

This process uses libvirt instead of QEMU commands.  Adding libvirt
mailing list.

>=20
> All that works, but my question and issue is this:
>=20
> Can you make a snapshot, then go back to the base and ignore that snapshot
> like a closed branch, make another snapshot, and then go back and forth
> from each to each?
>=20
> My reasons for needing this are that I have tools and software that doesnt
> play nice together, and would like to keep them separated on different
> snapshots, but never really need to have more than one up at a time.
>=20
> This would allow me to have only 1 windows license per computer, and the
> ability to just change from tool to tool with simple front end to virsh to
> remove the disk from the .xml and add the other one.
>=20
> So like this:
> Tool A is on snapshot A
> Tool B is on snapshot B
> go through steps 1-5 above to go back and forth.
>=20
> I know that I can not merge things back into the base, but I really don't
> need to do that, in fact, I can throw away the tool snapshots when new
> tools come out, by making new snapshots from the base when new tools come
> out.
>=20
> We have done this already, but we had an issue where the ability to write
> to the snapshots seemed to stop.
>=20
> Reason unknown, everything worked one day and next could not write to any
> snapshot, but could still load the base and work on it fine.
>=20
> This might be the wrong mailing list to post to, if so, could anyone point
> out a more appropriate one?
>=20
> Tim

--dFWYt1i2NyOo1oI9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtAbyAAoJEJykq7OBq3PIE+EIAJhMspM2HhdfOizMlAXecJPo
AjHHUQ9MggWpUTFZNai57enzf37pN6/Rmqyya6ktO3gB7a9nFNSTFDA3fD2sz4Xp
6OvRtS6ghSnikjAGs63jx8MwZyAvRcL0VJkXrSQL6z+tQNW9deupsyo4/NhmYSGY
nQ78vMXfdNfkGjWt22+8M0XIfNHm6mGFklT8HdE2LtfnKZ0ZNnegp438F68phbGW
ShdeXe7fPNYciDTckOcVNFTUzNwBzyCbBK49Q6P9XStIxFDhYWvHMWfzKg0NQEih
1QtLt5Mw1Lc3fQDV+aRwqyoxpR8IXpfzjyLzQJSVwczpR5bTNr7Pv2oxBVGf6Ck=
=SXaz
-----END PGP SIGNATURE-----

--dFWYt1i2NyOo1oI9--
