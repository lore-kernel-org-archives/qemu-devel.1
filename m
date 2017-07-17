Received: from eggs.gnu.org ([2001:4830:134:3::10]:57924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dX5J3-0005GD-Vj
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dX5J3-0007po-45
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:39:22 -0400
Date: Mon, 17 Jul 2017 14:39:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170717123901.GH5301@noname.redhat.com>
References: <CAPuOgO2q9nNtoPOYuXSWDxBVVsXcWEMbMboLT4OdpXA_Dq5O=Q@mail.gmail.com>
	<7a891962-9c57-7668-e2fd-69e5e13b9078@redhat.com>
	<CAMr-obtga00C5cKS63T_5RW99hK2W1nKMDba4cnTGH8dVYrXaA@mail.gmail.com>
	<07dfafaa-884c-9b86-cf37-dbdc454d2b91@redhat.com>
	<20170717121910.GG5301@noname.redhat.com>
	<cd8a80fe-4ac9-5f34-ce1f-d512eee7f703@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <cd8a80fe-4ac9-5f34-ce1f-d512eee7f703@redhat.com>
Subject: Re: [Qemu-devel] Supporting unsafe create when backing file is not
 accessible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>, Ala Hino <ahino@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-discuss@nongnu.org, Nir Soffer <nsoffer@redhat.com>, John Snow Huston <jsnow@redhat.com>


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.07.2017 um 14:25 hat Eric Blake geschrieben:
> On 07/17/2017 07:19 AM, Kevin Wolf wrote:
>=20
> > While I think adding -u today is reasonably realistic, I'm doubtful that
> > we can get an introspection mechanism in place today. Perhaps we can
> > declare it a bug fix, but I'd rather not rush something like that.
> >=20
> > How does libvirt detect qemu-img features today? Just try and then check
> > the error message?
>=20
> Yeah, when it comes to non-advertised feature detection, the best you
> can do is try using the feature, and fall back to the older approach if
> the feature was not present (this approach only works for features that
> gracefully fail without side effects when attempted on older versions,
> but fortunately that's the case for most true feature additions).

Yes, for adding a new option like -u this should work.

> And note that creating an image without a backing file, then using
> 'qemu-img rebase -u' to give it a backing image without probing the
> backing image, IS currently documented and supported (so we DO have a
> safe fallback, regardless of when 'qemu-img create -u ... size' actually
> lands).

I thought so, too, but in fact this is not documented behaviour (yet):

   Unsafe mode

   qemu-img uses the unsafe mode if "-u" is specified. In this mode,
   only the backing file name and format of filename is changed without
   any checks on the file contents. The user must take care of
   specifying the correct new backing file, or the guest-visible content
   of the image will be corrupted.

   This mode is useful for renaming or moving the backing file to
   somewhere else.  It can be used without an accessible old backing
   file, i.e. you can use it to fix an image whose backing file has
   already been moved/renamed.

So we explicitly allow the old backing file to be missing, and we
guarantee that rebase -u doesn't check the image content, but we don't
say anything yet about whether the new backing file must exist.

As this is already unsafe mode, I think for rebase we can indeed just
clarify the documentation.

Kevin

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZbK/lAAoJEH8JsnLIjy/WGpYP/Ru2jbGjY/Lb8gnuT6H/niGh
NdzULuG2J13M8mbAJ2O/wPV6BoK3Yxa6Lp4A79pwneh8k75/lTkDUkRYIJLauG4l
1vLGomsBdcFv3ecfJXWRhSGMRI3cEkSxW8xwbWHpioECI+B+GuZ7n6RgGKYwPsR2
v+2gnIyxSgirTFCkJvsi6kTF2H9+NerrHDNJp4ksCOBRRPecCDcS38J8Qn3ACnni
mFfA1KlhgJwjPmBSledKTZ4a2ELFeBF70gPzNmoheNPXAD8xtNlfgv88YftURqXk
Bn3/frm0pJmwCzLA4u5ooCM2X6vwbUpVsAX3bWi6766WvQUgCnupCaSMFVyO4PdN
NIk8RkjzID10A5jwzfCnkzGDMoxojAMJZRPZwJ8seen6yoGiWYmL88zYgeIP7uWl
wV2J6hrCgHkZi4el5RXz2lieecGWlvi7p7pqdzSagO2jeKNFv/zxwKUSAo3CLx/n
JhnVoUGRS2d0oGA+O4GxNmdlK8qER0sNtnZX53McwaCAoCz2mxDrmbS9sG9pYvaf
QCvCVyGhqGcot/rNKrSaBjy1qiKXcV/hqosvSvchAx0BfY7cA8NXwyXiJbwCsk/A
vaD1kAYSVjeVKaFLcPaYUrXXh76F9qkx26LmsWWJ3Dp6vjKbpnmOtfC/5AZYNYBD
uliJ/Fk5DuVRJ07qT63q
=E8S5
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
