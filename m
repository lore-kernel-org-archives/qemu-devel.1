Received: from eggs.gnu.org ([2001:4830:134:3::10]:55865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ckhi0-00022D-Uo
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 20:45:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ckhhx-0008PY-PB
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 20:45:08 -0500
Date: Mon, 6 Mar 2017 10:23:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170305232328.GB12030@umbus.fritz.box>
References: <1488548254-456-1-git-send-email-clg@kaod.org>
	<39ad7cac-b29e-b01e-723c-8cbdb1cf3ca9@redhat.com>
	<f55bb0be-778c-6ded-1564-9b77c4521f52@kaod.org>
	<b4b5780b-4604-9577-f42a-8821c4cb18d4@redhat.com>
	<c8ea232a-3511-f42a-6643-18a66a3d8e9c@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <c8ea232a-3511-f42a-6643-18a66a3d8e9c@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] ppc/spapr: QOM'ify sPAPRRTCState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2017 at 06:23:15PM +0100, C=E9dric Le Goater wrote:
> On 03/03/2017 05:54 PM, Thomas Huth wrote:
> > On 03.03.2017 15:49, C=E9dric Le Goater wrote:
> >> On 03/03/2017 03:13 PM, Thomas Huth wrote:
> >>> On 03.03.2017 14:37, C=E9dric Le Goater wrote:
> >>>> Also use an 'Object *' under the sPAPR machine to hold the RTC
> >>>> object.
> >>>
> >>> The change from TYPE_SYS_BUS_DEVICE to TYPE_DEVICE is certainly a good
> >>> idea! But what's the advantage of using Object* instead of DeviceStat=
e*
> >>> in sPAPRMachineState ?
> >>
> >> it makes spapr_rtc_create() a little simpler. =20
> >>
> >> We could go even further and use a sPAPRRTCState under sPAPRMachineSta=
te=20
> >> that we  would initialize with object_initialize().=20
> >=20
> > I think a sPAPRRTCState* would make more sense here - if you just see an
> > Object* and are not familiar with the code, you wonder what this pointer
> > is all about (and you then have to cast it to something different if you
> > want to do anything with it) ... so IMHO either a DeviceState* or
> > sPAPRRTCState* is the better choice here.
>=20
> I think having a non-pointer is a better for the object lifecycle=20
> but I don't have a strong opinion on that. We will see what Dave=20
> prefers.

You seem to be talking at cross purposes.  AFAICT Thomas is not
talking about the difference between a pointer and a non-pointer, he's
talking about the difference between a generic Object (pointer or
otherwise) and a concrete type.

I agree with Thomas that a specific type is preferable.  I'm not
particularly bothered by the difference between pointer and
non-pointer.

In any case, this has missed the cutoff for qemu-2.9, I'm afraid.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYvJ3tAAoJEGw4ysog2bOS8v4QANRe/hwLoZtf8XpV1TLGttIh
mVpgVL8bNOpoyXxtmXwTNzosk8Iq0QhDWsLHlZPiczbOY2vCXunz+SfcvhLf9zCV
35oo16ynvgs2H/BrHMRTVcFvXjjcPlJTfXwknxExQOaVShED1iqwNcKriT47mVgb
ssyn2W1FAY3TO84mHYtC4tw2/pCVKWInWo8DQ8VaXs889FwTFlJD/EnAWkErbS0K
+Qeo9gMqei8BkHPBXVK1zirVmFzOqvdk35rrBSyQIUr/NsWW6sg2nH3/2ByAarVg
OH3g/MiFHAqkEsqZYdIkLTiw16+7PXVphzdEHhbS4eTVJc0AlkVjdDDsbvAMbnpv
RDo7c1ZU49JcSlfEZL97iAmqrp4+0D+PPcolGwWwEzJhsYQAnZs1tOjO8xJAwMrh
pY0XL1w2wmfESHqqook8pNLQu3elPXJgmqjoRkDODlxCtA1TndirZmEEujrz/Ffu
JY7+ztsh13oepYq+j9qehcn7Wzq+BQjvoVNbvIo0kuZx4WN3KKO2KERS3ahe3ZY1
rQEuANZtu3gMMufirolW/fHnUirKNwrznrAVg38dDjdFUw0HDHf9Z8DJVgPlfKD6
0Q/xEvD7Vj5Puqpx+mklEQ2myw5aaRUKfwIVn5Z2KC275LAlsNsD1bnfOaVdJ6S3
M9pCMojLonbNIf9Az9iv
=kSqX
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
