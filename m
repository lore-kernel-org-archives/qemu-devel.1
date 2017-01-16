Received: from eggs.gnu.org ([2001:4830:134:3::10]:53794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cT87l-0001wU-T7
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 09:19:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cT87h-0007pu-6Y
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 09:19:05 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cT87g-0007pm-W6
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 09:19:01 -0500
Received: by mail-wm0-x243.google.com with SMTP id c85so30962043wmi.1
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 06:19:00 -0800 (PST)
Date: Mon, 16 Jan 2017 14:18:55 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170116141855.GH14681@stefanha-x1.localdomain>
References: <8a51513f-59d7-a361-a4ef-99679aa460fb@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgApRN/oydYDdnYz"
Content-Disposition: inline
In-Reply-To: <8a51513f-59d7-a361-a4ef-99679aa460fb@siemens.com>
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


--OgApRN/oydYDdnYz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 16, 2017 at 09:36:51AM +0100, Jan Kiszka wrote:
> some of you may know that we are using a shared memory device similar to
> ivshmem in the partitioning hypervisor Jailhouse [1].
>=20
> We started as being compatible to the original ivshmem that QEMU
> implements, but we quickly deviated in some details, and in the recent
> months even more. Some of the deviations are related to making the
> implementation simpler. The new ivshmem takes <500 LoC - Jailhouse is
> aiming at safety critical systems and, therefore, a small code base.
> Other changes address deficits in the original design, like missing
> life-cycle management.

My first thought is "what about virtio?".  Can you share some background
on why ivshmem fits the use case better than virtio?

The reason I ask is because the ivshmem devices you define would have
parallels to existing virtio devices and this could lead to duplication.

Stefan

--OgApRN/oydYDdnYz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYfNZPAAoJEJykq7OBq3PISEwIAKRpyCiJzIVibz5fCRyAlGGB
cjqv7b/jB+EcE+t4zB8HOAA8AkGNKEAZZ5k2SncrySLBrC0QJ6KasOLyVEF2/qQ2
Kr2J0P0WTYohJXunGY7vooet9XwZIfEIgFfQWRdIsGDHe+gsm3pLq8YOOB2bu3b7
RzITJdy3Q3+iOPgD4fRGI83pVqHTyAE0Ue/AkmWX80yEkujlDi26wTk8HouOg+Ag
ZKI6HM8hWrkLWIVD/5jeg05y8ivxU6iqomiSUaR4HaftIhLvv+wSaOUNE2gmn74o
r/5yuqOeI3nDo7PyRSuJvGqo0ND/AtRxL8f+yNL+l2+7xA6E5y2ECwXYQh/Cakc=
=UAW4
-----END PGP SIGNATURE-----

--OgApRN/oydYDdnYz--
