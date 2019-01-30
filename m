Received: from eggs.gnu.org ([209.51.188.92]:55821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gouy2-0000CO-Fg
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 13:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gouy0-0000k4-F7
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 13:52:10 -0500
Received: from 9.mo5.mail-out.ovh.net ([178.32.96.204]:47813)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gouxy-0000X4-Na
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 13:52:08 -0500
Received: from player774.ha.ovh.net (unknown [10.109.143.246])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 9309F213338
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 19:52:02 +0100 (CET)
References: <1548863140-31975-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c814b36e-a813-f0da-6fe6-e80a52bc21e6@kaod.org>
Date: Wed, 30 Jan 2019 19:51:56 +0100
MIME-Version: 1.0
In-Reply-To: <1548863140-31975-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: XIVE is an interrupt
 controller, not a machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org

On 1/30/19 4:45 PM, Thomas Huth wrote:
> The "XIVE" section is currently listed in the "PowerPC Machines"
> section, which is weird, since this is an interrupt controller
> device.=20

( I wonder how XIVE should be classified, the logic is as big as=20
  a core on the POWER9 processor. )

> Move it to the "Devices" section instead.
> Signed-off-by: Thomas Huth <thuth@redhat.com>

yes, looks good me.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  MAINTAINERS | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b334b53..eac36b6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1038,14 +1038,6 @@ F: tests/libqos/*spapr*
>  F: tests/rtas*
>  F: tests/libqos/rtas*
> =20
> -XIVE
> -M: David Gibson <david@gibson.dropbear.id.au>
> -M: C=C3=A9dric Le Goater <clg@kaod.org>
> -L: qemu-ppc@nongnu.org
> -S: Supported
> -F: hw/*/*xive*
> -F: include/hw/*/*xive*
> -
>  virtex_ml507
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  L: qemu-ppc@nongnu.org
> @@ -1645,6 +1637,14 @@ F: tests/libqos/fw_cfg.c
>  F: tests/fw_cfg-test.c
>  T: git https://github.com/philmd/qemu.git fw_cfg-next
> =20
> +XIVE
> +M: David Gibson <david@gibson.dropbear.id.au>
> +M: C=C3=A9dric Le Goater <clg@kaod.org>
> +L: qemu-ppc@nongnu.org
> +S: Supported
> +F: hw/*/*xive*
> +F: include/hw/*/*xive*
> +
>  Subsystems
>  ----------
>  Audio
>=20
