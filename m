Received: from eggs.gnu.org ([2001:4830:134:3::10]:37363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyhh-0007I5-Hp
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEybR-0006g2-Ko
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:28:20 -0400
Date: Tue, 23 Oct 2018 16:08:13 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023150813.GD12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-6-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-6-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 05/45] trace-events: Fix copy/paste typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Michael Walle <michael@walle.cc>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:03:42PM -0300, Eduardo Habkost wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> Missed while reviewing 5dd85b4b486.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
> Message-Id: <20181002212522.23303-2-f4bug@amsat.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/timer/trace-events | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index fa4213df5b..ca9ad6321a 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -56,7 +56,7 @@ systick_timer_tick(void) "systick reload"
>  systick_read(uint64_t addr, uint32_t value, unsigned size) "systick read=
 addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
>  systick_write(uint64_t addr, uint32_t value, unsigned size) "systick wri=
te addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
> =20
> -# hw/char/cmsdk_apb_timer.c
> +# hw/timer/cmsdk_apb_timer.c
>  cmsdk_apb_timer_read(uint64_t offset, uint64_t data, unsigned size) "CMS=
DK APB timer read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>  cmsdk_apb_timer_write(uint64_t offset, uint64_t data, unsigned size) "CM=
SDK APB timer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>  cmsdk_apb_timer_reset(void) "CMSDK APB timer: reset"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPOV0ACgkQbDjKyiDZ
s5LzKQ/+JeGuzYfQU510G1hxIW1ZS17M5QYhQkpELWUAIXY98JHrlqbyOvH2to16
6QjvpsEkbJK5eJNMh7eTYRCiySlNUaVALarclyC/adkhn9j9HcP8gJZ59jpCheoe
C7nte8GH14gMDBCMLXS5yLHTOyAiVRp8fHH9L7Ljs+jDtIu4aIWQkNqVMn5gjxTS
Hs9vUfok6PtRbiyudKpPjDOg1gTyX3TqhmDRwtbYaxCZ8zEZ8JWTmXKGEOTXq1j5
uvRrXMujvBS+2g0DReg6FyeJokjadEnBMjheDPrNY3gWNYm4m3oCkLGMkbkq+ESU
HSp98b54dXH1lRnHk+4VOMCqhxPY67UWr4LX0t3mRxIu3OIN7sEEg9kMCKo5eVDt
5ZWlxz+KengLZUzoa4YbPzOOTV0VbkQOGYgfTF09g/JLjH9ImAo5SE0ijnTfTptv
iA2c3+Jst+qokJ0C8HkzbmbS5eCi5NpLk/tx/OZG766KgONHnafozCJq0AAPSKgz
IVAViNVfVKpayRJS1zCeUdVf0xNV3pip/vIayRXM67d2xOUQtWymJVhMB75PBXzr
qgbj3gkqzaKJ70fdxTe9M/Osdy18EKuNNfrJoPujuiqXGbl1IuHzrH+b2viIfM52
y+CPI9InOLujfhqqp4Dg+jCCZDCCQv4rp4MuYqyrw4wFAXZ88Sg=
=OmoP
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--
