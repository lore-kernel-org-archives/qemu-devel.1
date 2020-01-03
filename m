Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9213AC3276C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 00:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C9982085B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 00:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mpZZKQlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9982085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inAjC-0001ih-Hw
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 19:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1inAhS-0000A9-7e
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 19:20:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1inAhQ-0003aK-K4
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 19:20:22 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:34193 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1inAhP-0003K5-Fv; Thu, 02 Jan 2020 19:20:20 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47plsn6BXpz9sRW; Fri,  3 Jan 2020 11:20:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578010813;
 bh=3pX7F5giFylzhxl5ZE/j2spBbPk7L+DltqI80W6E31c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mpZZKQlJwFemmvBCN/Y+fjDb5k+QodVy7sLbEewLajCMY7dtC9ulsZuXagBgLJLkJ
 8/Uw55X1MwpByRNvuGgaJ7ihsaJdTAkyDTnKnmVX3R3semItfDL8m5+ti7rqgza/T3
 VgS1m2L1+ttEvCfnkfmHndK6Rd9E3MXKQ3CUCbHE=
Date: Fri, 3 Jan 2020 11:19:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 4/6] tpm_spapr: Support suspend and resume
Message-ID: <20200103001900.GM2098@umbus>
References: <20191219140605.3243321-1-stefanb@linux.vnet.ibm.com>
 <20191219140605.3243321-5-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GoZzJvFfKjxI3RhA"
Content-Disposition: inline
In-Reply-To: <20191219140605.3243321-5-stefanb@linux.vnet.ibm.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--GoZzJvFfKjxI3RhA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 09:06:03AM -0500, Stefan Berger wrote:
> Extend the tpm_spapr frontend with VM suspend and resume support.
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  hw/tpm/tpm_spapr.c  | 67 ++++++++++++++++++++++++++++++++++++++++++++-
>  hw/tpm/trace-events |  2 ++
>  2 files changed, 68 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
> index ab184fbb82..cf5c7851e7 100644
> --- a/hw/tpm/tpm_spapr.c
> +++ b/hw/tpm/tpm_spapr.c
> @@ -76,6 +76,9 @@ typedef struct {
> =20
>      unsigned char buffer[TPM_SPAPR_BUFFER_MAX];
> =20
> +    uint32_t numbytes; /* number of bytes in suspend_buffer */
> +    unsigned char *suspend_buffer;
> +
>      TPMBackendCmd cmd;
> =20
>      TPMBackend *be_driver;
> @@ -240,6 +243,13 @@ static void tpm_spapr_request_completed(TPMIf *ti, i=
nt ret)
> =20
>      /* a max. of be_buffer_size bytes can be transported */
>      len =3D MIN(tpm_cmd_get_size(s->buffer), s->be_buffer_size);
> +
> +    if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
> +        /* defer delivery of response until .post_load */
> +        s->numbytes =3D len;
> +        return;
> +    }

I'm not understanding the basics of what's going on here.  IIUC, the
backend TPM can complete a request after we've entered migration
downtime.  But if that's the case, I can't see any guarantee that we
won't have already transmitted the TPM device state, so updating it
here might never reach the destination.  In that case we'd still lose
the request, so I'm not sure what we're accomplishing here.

>      rc =3D spapr_vio_dma_write(&s->vdev, be32_to_cpu(crq->data),
>                               s->buffer, len);
> =20
> @@ -288,11 +298,13 @@ static void tpm_spapr_reset(SpaprVioDevice *dev)
>      SpaprTpmState *s =3D VIO_SPAPR_VTPM(dev);
> =20
>      s->state =3D SPAPR_VTPM_STATE_NONE;
> +    s->numbytes =3D 0;
> =20
>      s->be_tpm_version =3D tpm_backend_get_tpm_version(s->be_driver);
> =20
>      s->be_buffer_size =3D MIN(tpm_backend_get_buffer_size(s->be_driver),
>                              TPM_SPAPR_BUFFER_MAX);
> +    s->suspend_buffer =3D g_realloc(s->suspend_buffer, s->be_buffer_size=
);
> =20
>      tpm_backend_reset(s->be_driver);
>      tpm_spapr_do_startup_tpm(s, s->be_buffer_size);
> @@ -309,9 +321,62 @@ static enum TPMVersion tpm_spapr_get_version(TPMIf *=
ti)
>      return tpm_backend_get_tpm_version(s->be_driver);
>  }
> =20
> +/* persistent state handling */
> +
> +static int tpm_spapr_pre_save(void *opaque)
> +{
> +    SpaprTpmState *s =3D opaque;
> +
> +    tpm_backend_finish_sync(s->be_driver);
> +
> +    if (s->numbytes) {
> +        memcpy(s->suspend_buffer, s->buffer, s->numbytes);
> +    }
> +
> +    trace_tpm_spapr_pre_save(s->numbytes);
> +    /*
> +     * we cannot deliver the results to the VM since DMA would touch VM =
memory
> +     */
> +
> +    return 0;
> +}
> +
> +static int tpm_spapr_post_load(void *opaque, int version_id)
> +{
> +    SpaprTpmState *s =3D opaque;
> +
> +    if (s->numbytes) {
> +        trace_tpm_spapr_post_load();
> +
> +        memcpy(s->buffer, s->suspend_buffer,
> +               MIN(s->numbytes, s->be_buffer_size));
> +        /* deliver the results to the VM via DMA */
> +        tpm_spapr_request_completed(TPM_IF(s), 0);
> +        s->numbytes =3D 0;
> +    }
> +
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_spapr_vtpm =3D {
>      .name =3D "tpm-spapr",
> -    .unmigratable =3D 1,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 0,
> +    .minimum_version_id_old =3D 0,
> +    .pre_save =3D tpm_spapr_pre_save,
> +    .post_load =3D tpm_spapr_post_load,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_SPAPR_VIO(vdev, SpaprTpmState),
> +
> +        VMSTATE_UINT8(state, SpaprTpmState),
> +        VMSTATE_UINT32(numbytes, SpaprTpmState),
> +        VMSTATE_VBUFFER_ALLOC_UINT32(suspend_buffer,
> +                                     SpaprTpmState, 0, NULL,
> +                                     numbytes),
> +        /* remember DMA address */
> +        VMSTATE_UINT32(crq.data, SpaprTpmState),
> +        VMSTATE_END_OF_LIST(),
> +    }
>  };
> =20
>  static Property tpm_spapr_properties[] =3D {
> diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> index 9143a8eaa3..5592cec7de 100644
> --- a/hw/tpm/trace-events
> +++ b/hw/tpm/trace-events
> @@ -67,3 +67,5 @@ tpm_spapr_do_crq_get_version(uint32_t version) "respons=
e: version %u"
>  tpm_spapr_do_crq_prepare_to_suspend(void) "response: preparing to suspen=
d"
>  tpm_spapr_do_crq_unknown_msg_type(uint8_t type) "Unknown message type 0x=
%02x"
>  tpm_spapr_do_crq_unknown_crq(uint8_t raw1, uint8_t raw2) "unknown CRQ 0x=
%02x 0x%02x ..."
> +tpm_spapr_pre_save(uint32_t v) "Number of TPM response bytes to deliver =
after resume: %u"
> +tpm_spapr_post_load(void) "Delivering TPM response after resume"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GoZzJvFfKjxI3RhA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4OiHEACgkQbDjKyiDZ
s5L9Eg//R1C2dNKhfH2GFn+leb4gK4DF/u/LMODgWb1kVLmO3GY3IZvr5xBx5/OJ
5XCAgxTdx6T7weySgjKzBIZM4k41eiFC6wYenv56A6HddwjZA2kNmKZRC2g4K0A3
Wpx45iVLWJa3BEibVYv5JDq5TA+IsQeSKTE0SFpZYjBndv3MRebCyRIaN14TRiIK
kYgxJSaKoZD+S+1ZPoS80tZOT/yTbLM7Gf81gEw0xf9G21N5YjOwBXqNn4O8uvS1
tyj1rWYilkH5WClIozA3FrOt3KYA22UJIvaVUJZ8AYuH+9xJuOW8cDicmTu9sSyB
e02sZRPrCiveskEqmzwN9v6Xy0kL/XRm/q0eSdf1QTobAegB3U8wV0Y1H25d+KDu
lGcO0mbani0a2QSzaAPme2b7nQM574l9y8nzurDyx/ARXHL6oWzJ+58ePru9mIs3
LiYssUddCuiO5W92ySJ54h5NbDU5Ur7P/wxs+gzTB50cbzdZF6QuLzRnA+Wr3Tyg
eX3OHSTmyjsz985HhOPix5bs/H2BGuhMIN0JcouGTR5LHza38KMUf8duwJ+BURwK
8ZsW0s6u7u0mE1SXocUjDihh3CWNMaGz3O/bWetePelhsfS61MYmiCdj5tH2PXba
YNVvDdbdhN0/CxcB2PJVlBDCOBd0sZ7QiHTiKxm70UkqhMDvzsI=
=MyAK
-----END PGP SIGNATURE-----

--GoZzJvFfKjxI3RhA--

