Received: from eggs.gnu.org ([2001:4830:134:3::10]:60949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fdTx2-0003Pk-Cq
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 01:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fdTwy-0004U5-Et
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 01:15:36 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:42729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1fdTwy-0004TG-6b
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 01:15:32 -0400
Received: by mail-pf0-x22b.google.com with SMTP id l9-v6so8233577pff.9
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 22:15:31 -0700 (PDT)
Date: Thu, 12 Jul 2018 15:14:48 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20180712151448.13157365@aik.ozlabs.ibm.com>
In-Reply-To: <a230a615-1dcb-dde9-6dae-bee8ef7c08fb@redhat.com>
References: <20180702062644.48040-1-aik@ozlabs.ru>
	<20180710122244.7466489f@aik.ozlabs.ibm.com>
	<20180710064248.GM22363@umbus.fritz.box>
	<20180710171453.6e3eee34@aik.ozlabs.ibm.com>
	<20180711062619.GQ22363@umbus.fritz.box>
	<20180711205305.0f3a42f1@aik.ozlabs.ibm.com>
	<20180712010152.GR22363@umbus.fritz.box>
	<a230a615-1dcb-dde9-6dae-bee8ef7c08fb@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_//3.b0+ueYdfYsI4n0y8GXaK";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [GIT PULL for qemu-pseries] pseries:
 Update SLOF firmware image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_//3.b0+ueYdfYsI4n0y8GXaK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Jul 2018 07:01:34 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 12.07.2018 03:01, David Gibson wrote:
> > On Wed, Jul 11, 2018 at 08:53:05PM +1000, Alexey Kardashevskiy wrote: =
=20
> >> On Wed, 11 Jul 2018 16:26:19 +1000
> >> David Gibson <david@gibson.dropbear.id.au> wrote:
> >> =20
> >>> On Tue, Jul 10, 2018 at 05:14:53PM +1000, Alexey Kardashevskiy wrote:=
 =20
> >>>> On Tue, 10 Jul 2018 16:42:48 +1000
> >>>> David Gibson <david@gibson.dropbear.id.au> wrote:
> >>>>    =20
> >>>>> On Tue, Jul 10, 2018 at 12:22:44PM +1000, Alexey Kardashevskiy wrot=
e:   =20
> >>>>>> On Mon,  2 Jul 2018 16:26:44 +1000
> >>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>>>>      =20
> >>>>>>> The following changes since commit edb1fb337f65f82fe32b989c4f018e=
fe85c1dddb:
> >>>>>>>
> >>>>>>>   pseries: Update SLOF firmware image (2018-07-02 16:21:30 +1000)
> >>>>>>>
> >>>>>>> are available in the git repository at:
> >>>>>>>
> >>>>>>>   git@github.com:aik/qemu.git tags/qemu-slof-20180702
> >>>>>>>
> >>>>>>> for you to fetch changes up to edb1fb337f65f82fe32b989c4f018efe85=
c1dddb:
> >>>>>>>
> >>>>>>>   pseries: Update SLOF firmware image (2018-07-02 16:21:30 +1000)
> >>>>>>>
> >>>>>>> ----------------------------------------------------------------
> >>>>>>>
> >>>>>>> I just missed a couple of gcc 8.1 fixes and thought I can still s=
queeze
> >>>>>>> them before the 3.0  soft freeze.
> >>>>>>>
> >>>>>>>
> >>>>>>> *** Note: this is not for master, this is for pseries     =20
> >>>>>>
> >>>>>>
> >>>>>> Not good for 3.1 either?     =20
> >>>>>
> >>>>> Ugh.. somehow I missed this SLOF update request, and now we're in 3=
.0
> >>>>> hard freeze.
> >>>>>
> >>>>> How bad are the bugs this SLOF update fixes?   =20
> >>>>
> >>>> These only fix gcc 8.1 warnings and runtime errors =3D> not really
> >>>> bugfixes so it is not a big deal if they miss 3.0.   =20
> >>>
> >>> Ok, well, if you want to resend the update, I'll queue it for 3.1. =20
> >>
> >>
> >> It is still on github, why resend? =20
> >=20
> > Good point, done. =20
>=20
> Won't there be another update in the 3.1 time frame? If yes, this sounds
> like wasted space in the repository to me (the firmware blobs are rather
> big, and there are no new features in that binary, just fixes for
> compiling with GCC 8 ... and people who want to compile SLOF on their
> own can use the sources from aik's git tree, too).


I compiled the blob with gcc 8.1 and if something goes wrong I'd rather
know this earlier than later - this my motivation, not the fixes
themselves.



--
Alexey

--Sig_//3.b0+ueYdfYsI4n0y8GXaK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEECIb1sawlPgRl/px9ze7KtGKK020FAltG48gACgkQze7KtGKK
023uMA/8DaSC0QlaXnnY59xtI0Dn8IebEkbQFeKS6Lpb0VwPv+SL/1VqW0jblxaP
4OqM5Tfpzlb/7z2Cr9lBO6HzfIQwGPg8xkW+SLlR/qyKjqMuW5o86QnVJU0Gpjha
+pigtTm1ab0cYoNq9c/vYiaL+zEaf5Gq97RRYxEG083HWcAGMvB5ymuiB/q6pxXY
qqAniEAiLCLRooeb3kkuXqZUD4Y52lAMma4oZWtaQjQxMrjySK/TO+PgAFBWNK3f
2c54vfk1tWWeVcAd6CEmorDKRS1ImHuDbN23x5S2zWSNgDy4E9wjmUejl0m5gKke
TJF+eJV/4Nc41wb5HItDmIiWM1qgSM6WjYoAWDKgjvriST/JLQPh3c4mDWpYSrXy
JI4QLyjaU07DzGw1Gf6QtUJxWB7pVRP4k0th0MbEfqBywIUBFo3tjFeSlOzGZ/sK
H/GpK43f38rmK/K4QFDKQLF1ZVi1pEDs2dzht6TOsXQS4ZDAZqttAdRtQHS4xZr8
dKVBM/1dp7Wq2rglk/0kpVD40IOVxytu6URFUGrZ6gv1H/aWdsp1Z6hnfQ9CkzwZ
2ZY1DGmjx7uDAuT3io/x0VJPKReM4Da4I3TE7AThZKp4ScCri5eet7eei7yWNGUw
KGog6OPhyWi0mA4XhNRrob3JP7/ZfV6gdn3Hf4fkLIIuglJngbI=
=en+J
-----END PGP SIGNATURE-----

--Sig_//3.b0+ueYdfYsI4n0y8GXaK--
