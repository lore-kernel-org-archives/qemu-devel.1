Received: from eggs.gnu.org ([2001:4830:134:3::10]:33353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cTQYn-0000Zk-I9
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:00:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cTQYk-0006X2-JG
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:00:13 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cTQYk-0006Wm-DL
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:00:10 -0500
Received: by mail-wm0-x244.google.com with SMTP id d140so20794405wmd.2
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 02:00:10 -0800 (PST)
Date: Tue, 17 Jan 2017 10:00:05 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170117100005.GD4265@stefanha-x1.localdomain>
References: <8a51513f-59d7-a361-a4ef-99679aa460fb@siemens.com>
	<20170116141855.GH14681@stefanha-x1.localdomain>
	<f9501690-7d47-127d-b171-33ac5a199e39@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Content-Disposition: inline
In-Reply-To: <f9501690-7d47-127d-b171-33ac5a199e39@siemens.com>
Subject: Re: [Qemu-devel] Towards an ivshmem 2.0?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Jailhouse <jailhouse-dev@googlegroups.com>


--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 16, 2017 at 03:34:58PM +0100, Jan Kiszka wrote:
> On 2017-01-16 15:18, Stefan Hajnoczi wrote:
> > On Mon, Jan 16, 2017 at 09:36:51AM +0100, Jan Kiszka wrote:
> >> some of you may know that we are using a shared memory device similar =
to
> >> ivshmem in the partitioning hypervisor Jailhouse [1].
> >>
> >> We started as being compatible to the original ivshmem that QEMU
> >> implements, but we quickly deviated in some details, and in the recent
> >> months even more. Some of the deviations are related to making the
> >> implementation simpler. The new ivshmem takes <500 LoC - Jailhouse is
> >> aiming at safety critical systems and, therefore, a small code base.
> >> Other changes address deficits in the original design, like missing
> >> life-cycle management.
> >=20
> > My first thought is "what about virtio?".  Can you share some background
> > on why ivshmem fits the use case better than virtio?
> >=20
> > The reason I ask is because the ivshmem devices you define would have
> > parallels to existing virtio devices and this could lead to duplication.
>=20
> virtio was created as an interface between a host and a guest. It has no
> notion of direct (or even symmetric) connection between guests. With
> ivshmem, we want to establish only a minimal host-guest interface. We
> want to keep the host out of the business negotiating protocol details
> between two connected guests.
>=20
> So, the trade-off was between reusing existing virtio drivers - in the
> best case, some changes would have been required definitely - and
> requiring complex translation of virtio into a vm-to-vm model on the one
> side and establishing a new driver ecosystem on much simpler host
> services (500 LoC...). We went for the latter.

Thanks.  I was going in the same direction about vhost-pci as
Marc-Andr=E9.  Let's switch to his sub-thread.

Stefan

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYfeslAAoJEJykq7OBq3PI0C4H/ROVBoUcShBdFHO5IWjeqhg/
jghsq5qddF9FYS0Z0FakZOhh/WooXIksfU8OKL0t5yCDr6r23qAkv2P4+9U1bh+i
1LYdu9jgGdOiqTp+VTkABhcHJH8dUatBBxQcsMh+PCir+MJSBpCkVy90y9BU45Vf
62zAp6DwKUKCGOoaHqkKzIOrMtqrvwWCw7qtohRvqDZlAL+DiQ5C+Vk8cSVWc0Vb
5hQdbzXnJRxyWOymGNqpGyI2409rvQcuXPjCHAwXYBuoVyQ2rgFmDMmMraM90wMi
CuK1nXLOMV+WxzKJl/4pvH7pvb50FsIoFil6PFjaJa/ncvYn/6yHtZPr9CkvziM=
=OrHw
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--
