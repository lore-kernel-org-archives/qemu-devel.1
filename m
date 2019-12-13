Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CC5C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 05:41:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C43FC2253D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 05:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="R4gOIp9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43FC2253D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifdhM-0000FC-MK
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 00:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ifdgC-0007d6-KU
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 00:39:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ifdg9-0004PC-VS
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 00:39:56 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:51953 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ifdg8-0004He-Pv; Fri, 13 Dec 2019 00:39:53 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47YzyD1Y1pz9sPT; Fri, 13 Dec 2019 16:39:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576215588;
 bh=K8I7BySlXe5w70jX25JhHMATjVMwd7LT9XDyP6NzhxY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R4gOIp9dC2iGmCiVVrn92yqN5+vXvWRJEB1hptLieKldWsMz8jCmf7fayxM3Sv3Op
 JYMPzag2Vm3L9nHpwun44jntpfif0ewVJfSmsh4WATeVZ+heXE/ozhP3LKyLM05D2G
 0jmkqPFWxBODljfDNs1ub2avWEP8LkvpThGVS03Q=
Date: Fri, 13 Dec 2019 16:39:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 3/5] tpm_spapr: Support suspend and resume
Message-ID: <20191213053933.GE207300@umbus.fritz.box>
References: <20191212202430.1079725-1-stefanb@linux.vnet.ibm.com>
 <20191212202430.1079725-4-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qicme7IxPpkH/pPU"
Content-Disposition: inline
In-Reply-To: <20191212202430.1079725-4-stefanb@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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


--qicme7IxPpkH/pPU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2019 at 03:24:28PM -0500, Stefan Berger wrote:
> Extend the tpm_spapr frontend with VM suspend and resume support.
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>=20
> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
> index c4a67e2403..8f5a142bd4 100644
> --- a/hw/tpm/tpm_spapr.c
> +++ b/hw/tpm/tpm_spapr.c
> @@ -87,6 +87,8 @@ typedef struct {
>      TPMVersion be_tpm_version;
> =20
>      size_t be_buffer_size;
> +
> +    bool deliver_response; /* whether to deliver response after VM resum=
e */
>  } SPAPRvTPMState;
> =20
>  static void tpm_spapr_show_buffer(const unsigned char *buffer,
> @@ -256,6 +258,12 @@ static void tpm_spapr_request_completed(TPMIf *ti, i=
nt ret)
>      uint32_t len;
>      int rc;
> =20
> +    if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {

I'm trying to figure out the circumstances in which
request_completed() would get called before post_load on the
destination.

> +        /* defer delivery of response until .post_load */
> +        s->deliver_response |=3D true;

|=3D is a bitwise OR which is not what you want, although it will
*probably* work in practice.  Better to just use
	s->deliver_response =3D true;

> +        return;
> +    }
> +
>      s->state =3D SPAPR_VTPM_STATE_COMPLETION;
> =20
>      /* a max. of be_buffer_size bytes can be transported */
> @@ -316,6 +324,7 @@ static void tpm_spapr_reset(SpaprVioDevice *dev)
>      SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(dev);
> =20
>      s->state =3D SPAPR_VTPM_STATE_NONE;
> +    s->deliver_response =3D false;
> =20
>      s->be_tpm_version =3D tpm_backend_get_tpm_version(s->be_driver);
>      tpm_spapr_update_deviceclass(dev);
> @@ -339,9 +348,53 @@ static enum TPMVersion tpm_spapr_get_version(TPMIf *=
ti)
>      return tpm_backend_get_tpm_version(s->be_driver);
>  }
> =20
> +/* persistent state handling */
> +
> +static int tpm_spapr_pre_save(void *opaque)
> +{
> +    SPAPRvTPMState *s =3D opaque;
> +
> +    s->deliver_response |=3D tpm_backend_finish_sync(s->be_driver);

Same problem here.

> +    trace_tpm_spapr_pre_save(s->deliver_response);
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
> +    SPAPRvTPMState *s =3D opaque;
> +
> +    if (s->deliver_response) {
> +        trace_tpm_spapr_post_load();
> +        /* deliver the results to the VM via DMA */
> +        tpm_spapr_request_completed(TPM_IF(s), 0);
> +        s->deliver_response =3D false;
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
> +        VMSTATE_SPAPR_VIO(vdev, SPAPRvTPMState),
> +
> +        VMSTATE_UINT8(state, SPAPRvTPMState),
> +        VMSTATE_BUFFER(buffer, SPAPRvTPMState),

Transferring the whole 4kiB buffer unconditionally when it mostly
won't have anything useful in it doesn't seem like a great idea.

> +        /* remember DMA address */
> +        VMSTATE_UINT32(crq.s.data, SPAPRvTPMState),
> +        VMSTATE_BOOL(deliver_response, SPAPRvTPMState),
> +        VMSTATE_END_OF_LIST(),
> +    }
>  };
> =20
>  static Property tpm_spapr_properties[] =3D {
> diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> index 6278a39618..d109661b96 100644
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
> +tpm_spapr_pre_save(bool v) "TPM response to deliver after resume: %d"
> +tpm_spapr_post_load(void) "Delivering TPM response after resume"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qicme7IxPpkH/pPU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3zJBUACgkQbDjKyiDZ
s5LIjw/+JBlIgi+CV3NicSHeunB98iIMN9C4LDuoF/oEaPVq0OqM3VpocDH13dKt
Cz3UZZpiIRlBF9EIO8KyxTgkxpGuu24ntkkof172meOY0INHJMADWuCMraO1oaOA
haOIg64RderRz1U9majVWAeR/uY7cDs2qlNJCGmhhtkklYOjOVIwS/TxO0EvU6/R
xQ0qV0JVwfsBNwwPogpIkjgxpCoMi/v93V5cYzDsrKnscLPpN2Y85mgCRUoXpAus
NBZex9DM85uja2WEvkuBhJBGyT8moH/PP1RpSwBdJr6SKYFPej2+YYP3qs66ehrq
vC0QUn6GC29BtPttQYLQlYX/AXV9TZBdVQu/Up+mJWsMXu2ZuOeO/0aMBhao/+iN
gCccbAtTDZ1rR/14zwS1mZWzW8DpHSat1JvPYGLuhmMmiK87nzngxY4gspU2ckJ2
9y2JaC4RcNrARqnao5y8NgJUp1qBjpKWQJA9FU3pJnoXsifLluP8H2Yy2bYtiO4L
FgHoGvA/Ezkg7G4YoWvylKjNz4Mu8aonHkGugVMDVo0H8Z2UlfRGpecReAD9zNt6
ykTVdFnX/5qSsWhDT4CAHViXTpE4noo1+RaXOIdq5Dpvx/8eL+cmqEmDYOwcrY3S
dtXe9x+WJbehRGsax5//hRVBfF366nIrMAJaXhr81pJENlV579M=
=OQsi
-----END PGP SIGNATURE-----

--qicme7IxPpkH/pPU--

