Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AE1C32756
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 04:50:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F46F2171F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 04:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oLjYPscj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F46F2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvwrQ-0008QW-LV
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 00:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58463)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hvwqP-00079L-7s
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 00:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hvwqN-0008R4-Ms
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 00:49:37 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:51313)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hvwqM-0008PE-HB
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 00:49:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 464XpM0Z62z9sP9; Fri,  9 Aug 2019 14:49:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565326171;
 bh=YjnMqCNZQI31UbOplJ+jm8OYXGzLnXIBwIqFcWLCuLk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oLjYPscjGv8g8Kzf+tdPhBl32m99bYcFiU6ewab7X3LtvhLB0ZMquwCLJKS2WZ67i
 ySp7Xgq/7K7jOA11k+Qdt9njJQKyyHXI/8rVX5R7c0LCI9HiI2e4w+ZE8cT+0AyOfH
 R0ix62tc1cbFw9vdNdX8/CLT/XEJ/NDeLEQ9DTI4=
Date: Fri, 9 Aug 2019 14:46:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Balamuruhan S <bala24@linux.ibm.com>
Message-ID: <20190809044639.GN5465@umbus.fritz.box>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-7-bala24@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nb8zVy0QMK3AA1xu"
Content-Disposition: inline
In-Reply-To: <20190807071445.4109-7-bala24@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [RFC PATCH 6/6] hw/ppc/pnv_homer: add python
 interface support for homer/occ common area
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, qemu-devel@nongnu.org,
 hari@linux.vnet.ibm.com, clg@kaod.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--nb8zVy0QMK3AA1xu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2019 at 12:44:45PM +0530, Balamuruhan S wrote:
> use python interface APIs in homer/occ common area emulation to
> interact with scripts if provided else fallback to normal flow,
> it shows how simple to use the interface to call python methods
> with any number of arguments in any script placed in common
> -module-path provided in qemu commandline.

What's the use case for this?

>=20
> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> ---
>  hw/ppc/pnv_homer.c      | 20 ++++++++++++++++++++
>  hw/ppc/pnv_xscom.c      |  9 +++++----
>  include/sysemu/sysemu.h |  4 ++++
>  vl.c                    | 24 ++++++++++++++++++++++++
>  4 files changed, 53 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
> index 73a94856d0..6ae5e74f19 100644
> --- a/hw/ppc/pnv_homer.c
> +++ b/hw/ppc/pnv_homer.c
> @@ -16,7 +16,9 @@
>   * You should have received a copy of the GNU Lesser General Public
>   * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
>   */
> +#include "sysemu/python_api.h"
>  #include "qemu/osdep.h"
> +#include "sysemu/sysemu.h"
>  #include "sysemu/hw_accel.h"
>  #include "sysemu/cpus.h"
>  #include "hw/ppc/pnv.h"
> @@ -37,6 +39,15 @@ static bool core_max_array(hwaddr addr)
> =20
>  static uint64_t homer_read(void *opaque, hwaddr addr, unsigned width)
>  {
> +    if (homer_module && homer) {
> +        uint64_t homer_ret;
> +        char **address =3D g_malloc(sizeof(uint64_t));
> +        python_args_init_cast_long(address, addr, 0);
> +        homer_ret =3D python_callback_int(module_path, homer_module, hom=
er, address, 1);
> +        python_args_clean(address, 1);
> +        g_free(address);
> +        return homer_ret;
> +    }
>      switch (addr) {
>          case 0xe2006:  /* max pstate ultra turbo */
>          case 0xe2018:  /* pstate id for 0 */
> @@ -106,6 +117,15 @@ const MemoryRegionOps pnv_homer_ops =3D {
> =20
>  static uint64_t occ_common_area_read(void *opaque, hwaddr addr, unsigned=
 width)
>  {
> +    if (occ_module && occ) {
> +        uint64_t occ_ret;
> +        char **address =3D g_malloc(sizeof(uint64_t));
> +        python_args_init_cast_long(address, addr, 0);
> +        occ_ret =3D python_callback_int(module_path, occ_module, occ, ad=
dress, 1);
> +        python_args_clean(address, 1);
> +        g_free(address);
> +        return occ_ret;
> +    }
>      switch (addr) {
>          /*
>           * occ-sensor sanity check that asserts the sensor
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index 18a780bcdf..5e41b7c953 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -179,13 +179,14 @@ static uint64_t xscom_read(void *opaque, hwaddr add=
r, unsigned width)
>      MemTxResult result;
> =20
>      if (xscom_module && xscom_readp) {
> -        char **args =3D g_malloc(2 * sizeof(uint64_t));
> +        char **args =3D g_malloc(3 * sizeof(uint64_t));
>          PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
>          python_args_init_cast_long(args, pcba, 0);
> -        python_args_init_cast_int(args, pcc->chip_type, 1);
> +        python_args_init_cast_int(args, chip->chip_num, 1);
> +        python_args_init_cast_int(args, pcc->chip_type, 2);
>          val =3D python_callback_int(module_path, xscom_module, xscom_rea=
dp,
> -                                  args, 2);
> -        python_args_clean(args, 2);
> +                                  args, 3);
> +        python_args_clean(args, 3);
>          g_free(args);
>      }
>      else {
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 9b8dc346d6..3c8119e040 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -121,6 +121,10 @@ extern const char *module_path;
>  extern const char *xscom_module;
>  extern const char *xscom_readp;
>  extern const char *xscom_writep;
> +extern const char *homer_module;
> +extern const char *homer;
> +extern const char *occ_module;
> +extern const char *occ;
>  extern int mem_prealloc;
> =20
>  #define MAX_NODES 128
> diff --git a/vl.c b/vl.c
> index 28f0dc1c1b..c96d35d907 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -144,6 +144,10 @@ const char *module_path =3D NULL;
>  const char *xscom_module =3D NULL;
>  const char *xscom_readp =3D NULL;
>  const char *xscom_writep =3D NULL;
> +const char *homer_module =3D NULL;
> +const char *homer =3D NULL;
> +const char *occ_module =3D NULL;
> +const char *occ =3D NULL;
>  int mem_prealloc =3D 0; /* force preallocation of physical target memory=
 */
>  bool enable_mlock =3D false;
>  bool enable_cpu_pm =3D false;
> @@ -495,6 +499,22 @@ static QemuOptsList qemu_module_opts =3D {
>              .name =3D "xscom_write",
>              .type =3D QEMU_OPT_STRING,
>          },
> +        {
> +            .name =3D "homer_module",
> +            .type =3D QEMU_OPT_STRING,
> +        },
> +        {
> +            .name =3D "homer",
> +            .type =3D QEMU_OPT_STRING,
> +        },
> +        {
> +            .name =3D "occ_module",
> +            .type =3D QEMU_OPT_STRING,
> +        },
> +        {
> +            .name =3D "occ",
> +            .type =3D QEMU_OPT_STRING,
> +        },
>          { /* end of list */ }
>      },
>  };
> @@ -3231,6 +3251,10 @@ int main(int argc, char **argv, char **envp)
>                  xscom_module =3D qemu_opt_get(opts, "xscom_module");
>                  xscom_readp =3D qemu_opt_get(opts, "xscom_read");
>                  xscom_writep =3D qemu_opt_get(opts, "xscom_write");
> +                homer_module =3D qemu_opt_get(opts, "homer_module");
> +                homer =3D qemu_opt_get(opts, "homer");
> +                occ_module =3D qemu_opt_get(opts, "occ_module");
> +                occ =3D qemu_opt_get(opts, "occ");
>                  break;
>              case QEMU_OPTION_mem_prealloc:
>                  mem_prealloc =3D 1;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nb8zVy0QMK3AA1xu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1M+q8ACgkQbDjKyiDZ
s5J9Yw/+PRNe0EMaUvaeBvqRqro2dSk3uFZCVJFxzcm+XGS5M7HwU7auVZbNi6oL
y4HPcBbCpDs08OhvM7fIkOWanPcXpDYZ9TU7dIWR6abLy9NAFl8CyMvwFZspy9wV
4cir1PA/mZTX40I8e98wKOwKf6MUN58i8mlGa0ahYTkMo6kiFrHlzqarRwnD9mpR
/Ieh3c1yQ22C4dg7sBdfe/q5btgiMp8QSSYxOZU8syoiexYluP7dkrLHFq3cdzGP
3wTm88obDtfn53rYFb7MfBm2xyW8dycE7DQkRGFHBIzLjmZuQPxrct1vB9QjZJJu
YgASr4xfxESyL18bNk1NffxJkjsZ5vZgpKl9xs5t5ZfDLe4q0aNbNbkNI4dzAX8v
M1twA9rPBmS3y7mfhziy2SZTuXNZHQpqNlwVeh/sR+4nMBplwQxzcQBGpUjrDkA8
5glnWa58188PXfXIv84kD+NLgaMQMw45eoi5DFS7TvyjqBQhU3bwsT54DR35jCh5
CFBXgUAYnf/bG7JDjNIehVBCQD9zzFPvu8vUHV8Zdo0EIjyPXyO8cuhrFSf2p90B
QTcGzRUIbNJ8FYSKrjUjcZAZ19cHZX7ytNEG40Y2J9ViSeewXswpqqI6EPVx4mZw
oDcCLpesVOedWu2EJnbL2VkKdJLcBRVLRgieRyHLjvTjy7JS0CA=
=pexm
-----END PGP SIGNATURE-----

--nb8zVy0QMK3AA1xu--

