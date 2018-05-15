Received: from eggs.gnu.org ([2001:4830:134:3::10]:59857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fIWoh-0002mU-20
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fIWob-0000ch-Vv
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:04:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57630 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fIWob-0000aP-Rt
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:04:17 -0400
Date: Tue, 15 May 2018 11:04:11 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180515100411.GI14755@stefanha-x1.localdomain>
References: <1526348758-6643-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<1526348758-6643-2-git-send-email-suhang16@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zqjkMoGlbUJ91oFe"
Content-Disposition: inline
In-Reply-To: <1526348758-6643-2-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH v8 1/2] Implement .hex file loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>
Cc: jim@groklearning.com, joel@jms.id.au, qemu-devel@nongnu.org


--zqjkMoGlbUJ91oFe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 15, 2018 at 09:45:57AM +0800, Su Hang wrote:
> This patch adds Intel Hexadecimal Object File format support to
> the loader.  The file format specification is available here:
> http://www.piclist.com/techref/fileext/hex/intel.htm
>=20
> The file format is mainly intended for embedded systems
> and microcontrollers, such as Micro:bit Arduino, ARM, STM32, etc.
>=20
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
> ---
>  hw/arm/boot.c       |   7 +-
>  hw/core/loader.c    | 246 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/loader.h |  12 +++
>  3 files changed, 264 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--zqjkMoGlbUJ91oFe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+rCbAAoJEJykq7OBq3PIhB0IAMCmdmwgEJjEyiZMErNn2Ekt
M1weLj32VNEOqiLwhSSEe+SuOuubwL36oisfxc+MqP/MaovvAeF5nmB8wPaZtXy6
LXBh0UPWKxEME1LH6Vgf8iylgXo4l72aLyEDXIvWwiJHgGtHhrNnWE18dx2g+rqZ
7Nleoa8yCkPvR7SH5J2ScuighpYoaDlojLYRAJChmSxoJZXbndN7fgRE3noMmPvI
qSNkbaXYS2SzsrNShzBK2DZtgFusKe1ZJuhagjSRPO9q9/YeTn1IM6Y07iqnQWJQ
MDkCIv3yTGzpssp9EUuQwcLCZ71d+F/xxBf2M3xfW2PgkpdA+9otboHHrzP1Ees=
=Eh0T
-----END PGP SIGNATURE-----

--zqjkMoGlbUJ91oFe--
