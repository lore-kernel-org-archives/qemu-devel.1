Received: from eggs.gnu.org ([2001:4830:134:3::10]:48685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ce35n-00044A-Tz
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:10:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ce35m-0005jx-VX
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:10:11 -0500
Date: Wed, 15 Feb 2017 18:10:03 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170215171003.GJ4935@noname.redhat.com>
References: <20170212014724.10618-1-mreitz@redhat.com>
	<w51lgtazdqs.fsf@maestria.local.igalia.com>
	<8d536684-8a07-7c34-16ca-be234685ab2a@redhat.com>
	<w51k28tumiv.fsf@maestria.local.igalia.com>
	<7fcba84d-4cd8-b34d-ef3e-4fbfa46d59a9@redhat.com>
	<20170215164451.GH4935@noname.redhat.com>
	<4756605d-5cd3-20be-d7fc-2909bae8a268@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
In-Reply-To: <4756605d-5cd3-20be-d7fc-2909bae8a268@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Swap request limit
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 15.02.2017 um 17:48 hat Max Reitz geschrieben:
> On 15.02.2017 17:44, Kevin Wolf wrote:
> > Am 15.02.2017 um 14:42 hat Max Reitz geschrieben:
> >> On 14.02.2017 10:52, Alberto Garcia wrote:
> >>> On Mon 13 Feb 2017 06:13:38 PM CET, Max Reitz wrote:
> >>>
> >>>>>> -#define BDRV_REQUEST_MAX_SECTORS MIN(SIZE_MAX >> BDRV_SECTOR_BITS=
, \
> >>>>>> -                                     INT_MAX >> BDRV_SECTOR_BITS)
> >>>>>> -#define BDRV_REQUEST_MAX_BYTES (BDRV_REQUEST_MAX_SECTORS << BDRV_=
SECTOR_BITS)
> >>>>>> +#define BDRV_REQUEST_MAX_BYTES      MIN(SIZE_MAX, INT_MAX)
> >>>>>> +#define BDRV_REQUEST_MAX_SECTORS    (BDRV_REQUEST_MAX_BYTES >> BD=
RV_SECTOR_BITS)
> >>>>>
> >>>>> I'm just pointing it out because I don't know if this can cause
> >>>>> problems, but this patch would make BDRV_REQUEST_MAX_BYTES not a
> >>>>> multiple of the sector size (INT_MAX is actually a prime number).
> >>>>
> >>>> Very good point. I don't think this could be an issue, though. For o=
ne
> >>>> thing, the use of BDRV_REQUEST_MAX_BYTES is very limited.
> >>>
> >>> Ok, but then I wonder what's the benefit of increasing
> >>> BDRV_REQUEST_MAX_BYTES.
> >>
> >> The benefit is that the definition looks cleaner.
> >=20
> > Whatever way we want to write it, I think MAX_BYTES =3D MAX_SECTORS * 5=
12
> > should be a given. Everything else is bound to confuse people and
> > introduce bugs sooner or later.
>=20
> Probably only sooner and not later, considering we are switching to byte
> granularity overall anyway. And if something confuses people, I'd argue
> it's the fact that we still have sector granularity all over the place
> and not that your requests can be a bit bigger if you submit them in
> bytes than if you submit them in sectors.
>=20
> Anyway, if MAX_BYTES should be a multiple of the sector size, then I
> can't think of a much better way to write this than what we currently
> have and this patch is unneeded.

Maybe we can just get rid of BDRV_REQUEST_MAX_SECTORS? Or do we need to
do a few more conversion before that?

Kevin

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYpItrAAoJEH8JsnLIjy/WlSYP/37Wsyc0TXSRUVAA4iNZyRIp
Z1ySkNmsUyKz6URNTH853ifHcLN4MePW0kLPtGtdSDl1nMQiypBhohr9WTOPxira
At4VXVWGbPonBEIvFgPb6jICX6XxrrNH77nZFmjQK6i8fKP3+Tc1DY2IVcsvHysH
8u/+uJSIFb9oljI9deM9fIr1IaCN8Z4I8UgdXDPJi1UuiNXsuAlnFr2gkvSUHvrf
ZtyBGE8qxH+S1IgC34KBHG/KBJ1JqkRWGqcysF6zaBcd9MPaXN2txNgz3SrE7Vj1
gyzttZEjNgCUWhRVZIRAlD3Uu/DPMe9tS0tcGxCdjtAIpS2xydt1/9J+oo9ZbKO2
xtKaqXrl4GqbkSfKwurMa0wO4KRWgAhf+sBeWg23iSrsfwnLGul1iIfOVqNiInOZ
RwqrSpGAe2EEOKkwYADNY0OZeztFOQgdXxUjuYP0cD9vSt7URlbZY30ZlyEIg/B9
fmdsUsS2JUQJiRBP8nZaD8jDLffTCgqYgpcjwct8Ljw9WOtfyyKH0aI2w0yf891m
v7zpeudSbdph4JZwKuwQnibwxzKuEjPlLa5Iwh74xonVS10bEVyuf0vj3MMFJbop
DQnAHC46/qmg7nL5KOPW0NZYxf0KnkBhaSmJXlHwHPfZCC3mPTsTtrMwNVwpUU3o
G/bSsJS2vrAqyXKUvyma
=a4TA
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
