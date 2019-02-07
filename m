Received: from eggs.gnu.org ([209.51.188.92]:48012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1groyy-0005Rd-HM
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1groyx-0002Fm-OC
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:05:08 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:54112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1groyx-0002Dh-Gh
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:05:07 -0500
Date: Thu, 7 Feb 2019 21:04:58 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190207190458.ui6gopjkizgbthqj@function>
References: <20190207140316.16103-1-samuel.thibault@ens-lyon.org>
	<20190207140316.16103-28-samuel.thibault@ens-lyon.org>
	<df0735c3-cab0-085f-f8ea-db820055b221@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df0735c3-cab0-085f-f8ea-db820055b221@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULLv4 27/32] slirp: improve send_packet()
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, stefanha@redhat.com, jan.kiszka@siemens.com

Philippe Mathieu-Daud=C3=A9, le jeu. 07 f=C3=A9vr. 2019 19:31:49 +0100, a=
 ecrit:
> > +    if (ret < 0) {
> > +        g_critical("Failed to send packet, ret: %ld", (long) ret);
>=20
> From the v3 discussion [*] I thought send_packet() would return a
> gssize, then we'd use G_GSSIZE_FORMAT here (and similarly use gssize
> instead ssize_t in this series).
> Anyway your fix is simpler.

That was the idea of my fix, yes :)

Samuel
