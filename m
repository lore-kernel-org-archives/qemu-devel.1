Received: from eggs.gnu.org ([2001:4830:134:3::10]:46178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1f5LIr-00073u-QY
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 21:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1f5LIn-0000lP-Gl
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 21:09:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54912 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@redhat.com>) id 1f5LIn-0000kp-BD
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 21:08:57 -0400
Date: Mon, 9 Apr 2018 11:08:44 +1000
From: David Gibson <dgibson@redhat.com>
Message-ID: <20180409110844.0a5188af@umbus.fritz.box>
In-Reply-To: <b00ba0ab-538f-a6f1-3b99-1a0d9adb6eab@redhat.com>
References: <20180327164141.19075-1-famz@redhat.com>
	<b00ba0ab-538f-a6f1-3b99-1a0d9adb6eab@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/Tgr==jJcsU3tA1C2xyYSsfP";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2] scsi-disk: Don't enlarge min_io_size to
 max_io_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, danielhb@linux.vnet.ibm.com, eblake@redhat.com

--Sig_/Tgr==jJcsU3tA1C2xyYSsfP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Apr 2018 17:54:00 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 27/03/2018 18:41, Fam Zheng wrote:
> > Some backends report big max_io_sectors. Making min_io_size the same
> > value in this case will make it impossible for guest to align memory,
> > therefore the disk may not be usable at all.
> >=20
> > Do not enlarge them when they are zero.
> >=20
> > Reported-by: David Gibson <dgibson@redhat.com>
> > Signed-off-by: Fam Zheng <famz@redhat.com>
[snip]
> Queued, thanks.
>=20
> Paolo

Any ETA on going from queued to actually merged?  This is holding up a
handful of Power bugfixes for 2.12, because I can't complete my usual
testing cycle.

--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/Tgr==jJcsU3tA1C2xyYSsfP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrKvRwACgkQbDjKyiDZ
s5I+BA//UxcLAu7V/M+0R6ag2LoE8EyL5nywTpY374ZveIzWYzib3Ay813PtkE+s
FmQnTMkZGA3sHV1+pkJMmRT1QJPX3Q96PN60s5sD4XtbP/JJua/kCiRCmwohoy3j
PxJykW0Iu5xqsS3yqScXMcDMF0Khc1s5QsKPyMf0LwauOg0Xjp9vZzosA463dLFQ
kNkMAjNFAm77Sj3wTpX4Vb2PfcMFQ0Pamp1Gc3P9dtfCEOmsqyOZsn4PO+hVjGO6
banQlGzroyNo7beT7tVtj6Wkq+r4McJ9o1rMZbacmfwJzh8Z1VixgR7jo3R7TZ+x
JkaPFSyeHBOlW37LlrtmJT0WnrSubqAtJqdELOV+o4IcJMNAdMYaG4DzlR5vINWC
Sm9hicI9JL06GLy9UoHqDruNvrviRyTiHq4JHmG2TNeK6/3PdoiXjZG5ywhKXOfE
bVq2SCnwqN4gBiX/zFhV2PgaiUBZOWD6UchoKibD5xuEMWAnKke6GzSzR/+7jWO5
3lnYm8sM1qOlYk2sYQi8HTKQgiKlI8OUsclP4x/XGRqJ+OAqBV1C8qM0sLxAof/9
b/xxWUSBL8NGKOWW2ttJX847NgIVO2P4rpjRZD42IRCaaXOijGZz0f5SUhx2nWl1
xdqqDIx6+z4MYvOf/EhBJGmUmWCHiUe4I3XgqdUCHk7P17h5wBQ=
=ZivO
-----END PGP SIGNATURE-----

--Sig_/Tgr==jJcsU3tA1C2xyYSsfP--
