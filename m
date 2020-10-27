Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638D2C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 02:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF80C20790
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 02:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lqWUexAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF80C20790
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXEPr-0002En-1Y
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 22:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXEKw-0005sz-Kz; Mon, 26 Oct 2020 22:03:46 -0400
Received: from ozlabs.org ([203.11.71.1]:41829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXEKr-0001Vx-7H; Mon, 26 Oct 2020 22:03:46 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CKw3V6kBHz9sTf; Tue, 27 Oct 2020 13:03:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603764214;
 bh=U7Gt0HrrAcXBqZ9XQos1p0Yb2bBYxElVC2ehl+gNtfs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lqWUexAHneATPT+4hrIqn+bVTmTeZxz0k/dTG0+C0A03ROZDgzRW6oKqY/jvZhow1
 ocO1lwPcA6SeF1ixIokMa80H/ibW1SJsrplB9jGTerLNq7/eSQZGe0U4nPwEHi1gPK
 81eNIfkMWvyOpNb3Mgnj4TFbNhvvsZEkQvecSu6U=
Date: Tue, 27 Oct 2020 13:03:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 4/4] spapr: Improve spapr_reallocate_hpt() error reporting
Message-ID: <20201027020320.GE4671@yekko.fritz.box>
References: <160371602625.305923.7832478283946753271.stgit@bahia.lan>
 <160371605460.305923.5890143959901241157.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VUDLurXRWRKrGuMn"
Content-Disposition: inline
In-Reply-To: <160371605460.305923.5890143959901241157.stgit@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 22:03:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--VUDLurXRWRKrGuMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 01:40:54PM +0100, Greg Kurz wrote:
> spapr_reallocate_hpt() has three users, two of which pass &error_fatal
> and the third one, htab_load(), passes &local_err, uses it to detect
> failures and simply propagates -EINVAL up to vmstate_load(), which will
> cause QEMU to exit. It is thus confusing that spapr_reallocate_hpt()
> doesn't return right away when an error is detected in some cases. Also,
> the comment suggesting that the caller is welcome to try to carry on
> seems like a remnant in this respect.
>=20
> This can be improved:
> - change spapr_reallocate_hpt() to always report a negative errno on
>   failure, either as reported by KVM or -ENOSPC if the HPT is smaller
>   than what was asked,
> - use that to detect failures in htab_load() which is preferred over
>   checking &local_err,
> - propagate this negative errno to vmstate_load() because it is more
>   accurate than propagating -EINVAL for all possible errors.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.2, thanks.

> ---
>  hw/ppc/spapr.c         |   18 ++++++++++--------
>  include/hw/ppc/spapr.h |    3 +--
>  2 files changed, 11 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ff7de7da2875..12a012d9dd09 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1483,8 +1483,7 @@ void spapr_free_hpt(SpaprMachineState *spapr)
>      close_htab_fd(spapr);
>  }
> =20
> -void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
> -                          Error **errp)
> +int spapr_reallocate_hpt(SpaprMachineState *spapr, int shift, Error **er=
rp)
>  {
>      ERRP_GUARD();
>      long rc;
> @@ -1496,7 +1495,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr,=
 int shift,
> =20
>      if (rc =3D=3D -EOPNOTSUPP) {
>          error_setg(errp, "HPT not supported in nested guests");
> -        return;
> +        return -EOPNOTSUPP;
>      }
> =20
>      if (rc < 0) {
> @@ -1504,8 +1503,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr,=
 int shift,
>          error_setg_errno(errp, errno, "Failed to allocate KVM HPT of ord=
er %d",
>                           shift);
>          error_append_hint(errp, "Try smaller maxmem?\n");
> -        /* This is almost certainly fatal, but if the caller really
> -         * wants to carry on with shift =3D=3D 0, it's welcome to try */
> +        return -errno;
>      } else if (rc > 0) {
>          /* kernel-side HPT allocated */
>          if (rc !=3D shift) {
> @@ -1513,6 +1511,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr,=
 int shift,
>                         "Requested order %d HPT, but kernel allocated ord=
er %ld",
>                         shift, rc);
>              error_append_hint(errp, "Try smaller maxmem?\n");
> +            return -ENOSPC;
>          }
> =20
>          spapr->htab_shift =3D shift;
> @@ -1533,6 +1532,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr,=
 int shift,
>      /* We're setting up a hash table, so that means we're not radix */
>      spapr->patb_entry =3D 0;
>      spapr_set_all_lpcrs(0, LPCR_HR | LPCR_UPRT);
> +    return 0;
>  }
> =20
>  void spapr_setup_hpt(SpaprMachineState *spapr)
> @@ -2286,11 +2286,13 @@ static int htab_load(QEMUFile *f, void *opaque, i=
nt version_id)
>      }
> =20
>      if (section_hdr) {
> +        int ret;
> +
>          /* First section gives the htab size */
> -        spapr_reallocate_hpt(spapr, section_hdr, &local_err);
> -        if (local_err) {
> +        ret =3D spapr_reallocate_hpt(spapr, section_hdr, &local_err);
> +        if (ret < 0) {
>              error_report_err(local_err);
> -            return -EINVAL;
> +            return ret;
>          }
>          return 0;
>      }
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index bb47896f173b..2e89e36cfbdc 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -846,8 +846,7 @@ void spapr_hotplug_req_add_by_count_indexed(SpaprDrcT=
ype drc_type,
>  void spapr_hotplug_req_remove_by_count_indexed(SpaprDrcType drc_type,
>                                                 uint32_t count, uint32_t =
index);
>  int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
> -void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
> -                          Error **errp);
> +int spapr_reallocate_hpt(SpaprMachineState *spapr, int shift, Error **er=
rp);
>  void spapr_clear_pending_events(SpaprMachineState *spapr);
>  void spapr_clear_pending_hotplug_events(SpaprMachineState *spapr);
>  int spapr_max_server_number(SpaprMachineState *spapr);
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VUDLurXRWRKrGuMn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+Xf+gACgkQbDjKyiDZ
s5IhXA/9HnLgN6XPtZeV1H/gN4USAgEG5B3x+xAcsdB0jkAHk5QYO3MiU6qPsYrb
0yX0k/ZOLr3Etih6hzeDaQJpUhDdwLU2RG+SpkLbfJ01Tip+ed3UIaHB8cw1plUN
7cdPFEVwO3ZAsxoprkqcBqNbNUvPyJB9moFTohlwsHJqbjo/vJzuO/J95MuZBJXG
DZXD7NQXLMY28NkjSdDL11+IAnsgOAFNg2eVg0KLQ94x+VuNbdomPnlvwf/7FwQc
CLRGDxHvmn3A6b/2YC7nkC8Tk4cRl3M1g3WbPAf7+2m1rkjkVn2ontzBF7davIJq
FtXvfCftWLxhGJKp4DKeatZIhwV5GkHXLrxJYClr2ASYNYCLCAz6xb5HWJlKE2SN
dnxX2TRE0JSdoEzEgtvZczUGKlFMoAGtGvKgpmPNF/HGJmfEINkeQ5fXWqeshqM9
dLPEYj84S+NKzBQ3Qlmyz8Pq2s87f4ydPVuuGMC5qo1Tw1PEnr4K6ve0hSM1Cjm/
nItenK5FgoLwFcHyCAYUYSx/cbrUObSeILiatcsPsLR75oQIkTUMaUHvbFGBPicb
OBT27bJj/46udPZDLJlDJlKy/cegrXDnZrOopTPprRLnajif9O0j09fU1BWG09r/
3u21kydrt8O7ADQT2z5Qr4s+15zMJ5FbvEuma2NqeV7OvZcAYuY=
=bmV2
-----END PGP SIGNATURE-----

--VUDLurXRWRKrGuMn--

