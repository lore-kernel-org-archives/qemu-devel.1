Received: from eggs.gnu.org ([2001:4830:134:3::10]:36064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cGEWO-0002pM-DA
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 19:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cGEWK-0004EC-H1
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 19:31:12 -0500
Received: from ozlabs.org ([103.22.144.67]:53259)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cGEWJ-0004DH-L6
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 19:31:08 -0500
Date: Mon, 12 Dec 2016 10:26:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161211232609.GA12127@umbus.fritz.box>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
	<1481285870-3396-2-git-send-email-thuth@redhat.com>
	<ca0a18a3-c007-9b72-3709-fcddb0d3b3d5@vivier.eu>
	<d73b3f30-8445-4734-4d78-2efdf193791e@redhat.com>
	<f52e8502-56b9-e7aa-c95a-b3a5c33b0801@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <f52e8502-56b9-e7aa-c95a-b3a5c33b0801@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH 01/20] Makefile: Allow CPU targets to
 reside in target/ folder, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, James Hogan <james.hogan@imgtec.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 10, 2016 at 11:59:09AM +0100, Laurent Vivier wrote:
> Le 09/12/2016 =E0 17:51, Thomas Huth a =E9crit :
> > On 09.12.2016 13:24, Laurent Vivier wrote:
> >> Le 09/12/2016 =E0 13:17, Thomas Huth a =E9crit :
> >>> To be able to compile the CPU targets from within a subfolder
> >>> of the target/ folder, we've got to adapt the Makefile.target
> >>> a little bit first. After this change, target CPUs can either
> >>> reside in a target/xxx folder or continue to use the target-xxx
> >>> scheme. The latter will be disabled once all targets have been
> >>> moved.
> >>>
> >>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >>> ---
> >>>  Makefile.target | 10 ++++++++--
> >>>  1 file changed, 8 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/Makefile.target b/Makefile.target
> >>> index 7a5080e..90b25ae 100644
> >>> --- a/Makefile.target
> >>> +++ b/Makefile.target
> >>> @@ -7,11 +7,17 @@ include config-target.mak
> >>>  include config-devices.mak
> >>>  include $(SRC_PATH)/rules.mak
> >>> =20
> >>> +ifneq ($(wildcard $(SRC_PATH)/target/$(TARGET_BASE_ARCH)),)
> >>> +TARGET_FOLDER=3Dtarget/$(TARGET_BASE_ARCH)
> >>> +else
> >>> +TARGET_FOLDER=3Dtarget-$(TARGET_BASE_ARCH)
> >>> +endif
> >>
> >> Perhaps you should consider to use ':=3D' instead of '=3D'.
> >=20
> > Most of the other variables in that file seem to be set with '=3D' inst=
ead
> > of ':=3D', so using '=3D' sounds more consistent to me ... is there a r=
eal
> > benefit of using ':=3D' here?
>=20
> With ':=3D' your variable is expanded once, with '=3D' it is expanded
> whenever it is used. I think this is not needed in your case.
>=20
> https://www.gnu.org/software/make/manual/html_node/Flavors.html#Flavors

I tend to thing '=3D' is the safer default option unless you're really
hitting performance problems that ':=3D' can alleviate.  Not
re-expanding can lead to confusing bugs later if the definition is
changed so that re-expansion matters in future.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYTeCPAAoJEGw4ysog2bOSe2IP/0wofT5eKEOnfjqGbHA/5kml
HIE4u37MH8wR73lbqeYMUUBFK6E+smAxD1T2PLntqNlQ9C2/EIksnanjgaarovMx
BawewzJzXtAQl7d/sNhBGim8uKAATUIgj9D++xbJYTGD9o2ssju8zaOd4b8qPc5M
lTO/Tjet/9EGd4h2YvmRSY073kU6uRENRMLvqsrqLi+MfA1zE1/L897M6VUHel8Q
G78ARNWJBf8GBfw7mcwq7aQ/IA/6+6EHZKktErhmFcZBjvr4I5shWOMVzsHSl1kU
rVdiCEoEEwjlABqM94rPlSsT525BuAyOry2TJ49gW7r4pSDWNIY2VjXS/mAy17KR
1aE9Xuw2c8EZhNLiMGDxj7bq0O1FDNz/XoFnFGRIKDcIts3r7HCQaHW9RqNd1yl9
VcR4Ha93S11A+iT0Bb/AD/vwlY+A23Ei26JFgxMQoZ+5KwvTxtC+a68MUMnT2FIh
IzmzFo1F41G5t52lNFPi+fbFL4mYCznPtKTM/xwhroCobavJB1skrayp6bN3f7I2
gHSx+esM/hyCZshrYQtGjPOocBgqgZNIcxP6OjlH2exwgISpPgfsNZxb+/lqcWmC
TVgJfhNo5uNH+krdAlmFS8zJ18YtWo5M/fe1OYN8kEd43WQu1/jKwEE2TZil7lSY
BfTmrtsdDvZCqYkJhvQW
=HIyo
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
