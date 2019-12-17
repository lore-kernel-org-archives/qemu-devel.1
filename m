Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E70C2D0C3
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 00:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B228206CB
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 00:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Fko2HA34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B228206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih18T-0008Ps-NO
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 19:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih17m-0007qI-ML
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 19:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih17k-0006Wo-KE
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 19:54:06 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:54033 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih17i-0006SO-Jx; Mon, 16 Dec 2019 19:54:04 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cKQY5cD6z9sSF; Tue, 17 Dec 2019 11:53:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576544037;
 bh=eUnzBawbUIXHs8Lo7RBGukPxptjlv+EQ604xvR9fs/A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Fko2HA34ZgkJMAB/5rEbSW7JofdX1RnpajxBsyHZ3klfyDYLfL2tIwdHrUrGP6t5k
 Ec35vJWNaU/UW8LzBnghxzNLWh25rDnkyKOHfLZQlWH8BlbWYxPosSvDOtyGMZMaDM
 duBomXDLypVOUw/6ntQ6jtpoMIioJM9AquI3BBg4=
Date: Tue, 17 Dec 2019 11:53:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v5 3/5] tpm_spapr: Support suspend and resume
Message-ID: <20191217005351.GK6242@umbus.fritz.box>
References: <20191212202430.1079725-1-stefanb@linux.vnet.ibm.com>
 <20191212202430.1079725-4-stefanb@linux.vnet.ibm.com>
 <20191213053933.GE207300@umbus.fritz.box>
 <3ee5443f-6156-62de-d70d-13b4b224c2f3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UlsYxwg8UDQn+EKZ"
Content-Disposition: inline
In-Reply-To: <3ee5443f-6156-62de-d70d-13b4b224c2f3@linux.ibm.com>
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
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--UlsYxwg8UDQn+EKZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2019 at 07:46:44AM -0500, Stefan Berger wrote:
> On 12/13/19 12:39 AM, David Gibson wrote:
> > On Thu, Dec 12, 2019 at 03:24:28PM -0500, Stefan Berger wrote:
> > > Extend the tpm_spapr frontend with VM suspend and resume support.
> > >=20
> > > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > >=20
> > > diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
> > > index c4a67e2403..8f5a142bd4 100644
> > > --- a/hw/tpm/tpm_spapr.c
> > > +++ b/hw/tpm/tpm_spapr.c
> > > @@ -87,6 +87,8 @@ typedef struct {
> > >       TPMVersion be_tpm_version;
> > >       size_t be_buffer_size;
> > > +
> > > +    bool deliver_response; /* whether to deliver response after VM r=
esume */
> > >   } SPAPRvTPMState;
> > >   static void tpm_spapr_show_buffer(const unsigned char *buffer,
> > > @@ -256,6 +258,12 @@ static void tpm_spapr_request_completed(TPMIf *t=
i, int ret)
> > >       uint32_t len;
> > >       int rc;
> > > +    if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
> > I'm trying to figure out the circumstances in which
> > request_completed() would get called before post_load on the
> > destination.
>=20
> This is on the source side where we must not deliver the response in case
> the devices are now suspending but defer the delivery to after the
> resume.

Ah, I see.  But in that case, AFAICT this means we've received the
completion when we're in the last stages of migration, which means
it's entirely possible we've already transferred the vtpm device's
state.  So there's no guarantee that either the deliver_response
change here, or the response buffer will actually make it to the other
side.

> > > +        /* defer delivery of response until .post_load */
> > > +        s->deliver_response |=3D true;
> > |=3D is a bitwise OR which is not what you want, although it will
> > *probably* work in practice.  Better to just use
> > 	s->deliver_response =3D true;
> >=20
> > > +        return;
> > > +    }
> > > +
> > >       s->state =3D SPAPR_VTPM_STATE_COMPLETION;
> > >       /* a max. of be_buffer_size bytes can be transported */
> > > @@ -316,6 +324,7 @@ static void tpm_spapr_reset(SpaprVioDevice *dev)
> > >       SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(dev);
> > >       s->state =3D SPAPR_VTPM_STATE_NONE;
> > > +    s->deliver_response =3D false;
> > >       s->be_tpm_version =3D tpm_backend_get_tpm_version(s->be_driver);
> > >       tpm_spapr_update_deviceclass(dev);
> > > @@ -339,9 +348,53 @@ static enum TPMVersion tpm_spapr_get_version(TPM=
If *ti)
> > >       return tpm_backend_get_tpm_version(s->be_driver);
> > >   }
> > > +/* persistent state handling */
> > > +
> > > +static int tpm_spapr_pre_save(void *opaque)
> > > +{
> > > +    SPAPRvTPMState *s =3D opaque;
> > > +
> > > +    s->deliver_response |=3D tpm_backend_finish_sync(s->be_driver);
> > Same problem here.
> >=20
> > > +    trace_tpm_spapr_pre_save(s->deliver_response);
> > > +    /*
> > > +     * we cannot deliver the results to the VM since DMA would touch=
 VM memory
> > > +     */
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +static int tpm_spapr_post_load(void *opaque, int version_id)
> > > +{
> > > +    SPAPRvTPMState *s =3D opaque;
> > > +
> > > +    if (s->deliver_response) {
> > > +        trace_tpm_spapr_post_load();
> > > +        /* deliver the results to the VM via DMA */
> > > +        tpm_spapr_request_completed(TPM_IF(s), 0);
> > > +        s->deliver_response =3D false;
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > >   static const VMStateDescription vmstate_spapr_vtpm =3D {
> > >       .name =3D "tpm-spapr",
> > > -    .unmigratable =3D 1,
> > > +    .version_id =3D 1,
> > > +    .minimum_version_id =3D 0,
> > > +    .minimum_version_id_old =3D 0,
> > > +    .pre_save =3D tpm_spapr_pre_save,
> > > +    .post_load =3D tpm_spapr_post_load,
> > > +    .fields =3D (VMStateField[]) {
> > > +        VMSTATE_SPAPR_VIO(vdev, SPAPRvTPMState),
> > > +
> > > +        VMSTATE_UINT8(state, SPAPRvTPMState),
> > > +        VMSTATE_BUFFER(buffer, SPAPRvTPMState),
> > Transferring the whole 4kiB buffer unconditionally when it mostly
> > won't have anything useful in it doesn't seem like a great idea.
>=20
>=20
> It's really only needed in case of a 'delayed response'. So, yeah, we cou=
ld
> transfer data in only that case then.
>=20
>=20
> >=20
> > > +        /* remember DMA address */
> > > +        VMSTATE_UINT32(crq.s.data, SPAPRvTPMState),
> > > +        VMSTATE_BOOL(deliver_response, SPAPRvTPMState),
> > > +        VMSTATE_END_OF_LIST(),
> > > +    }
> > >   };
> > >   static Property tpm_spapr_properties[] =3D {
> > > diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> > > index 6278a39618..d109661b96 100644
> > > --- a/hw/tpm/trace-events
> > > +++ b/hw/tpm/trace-events
> > > @@ -67,3 +67,5 @@ tpm_spapr_do_crq_get_version(uint32_t version) "res=
ponse: version %u"
> > >   tpm_spapr_do_crq_prepare_to_suspend(void) "response: preparing to s=
uspend"
> > >   tpm_spapr_do_crq_unknown_msg_type(uint8_t type) "Unknown message ty=
pe 0x%02x"
> > >   tpm_spapr_do_crq_unknown_crq(uint8_t raw1, uint8_t raw2) "unknown C=
RQ 0x%02x 0x%02x ..."
> > > +tpm_spapr_pre_save(bool v) "TPM response to deliver after resume: %d"
> > > +tpm_spapr_post_load(void) "Delivering TPM response after resume"
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UlsYxwg8UDQn+EKZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl34Jx4ACgkQbDjKyiDZ
s5JmyQ/6Ay2ySpR24DNbu/lElLUAWGZv1IUn1LiyHQdhtDE+fGfifUfytzne0IF0
3eQtBYmX27RSckQNXHObG1EDfy144HC0BWpzAhX2lGRvbnf5g+MSfS+Hwb50P9/Y
N2QgSmImVjhbHddo+Edo8t3pdacbW+IzBs1IR4eMswWifSK9o+4S93R+6jOpzy5X
uoaTkJiU46aRQfdM0xau0ze1qJ0m+IJ2kT14GHylFFJtdrXSy/8VjGBxhShiag7q
Z+D5/faMc5xn9RX2ijgxasflOWJ+uKXI5k++qwP5o00O5iaOD+K0mwxSlSoyGiqF
WrdrkCDrHXCpuP7bUpH8AUx9GX5s23k4mzd2+GazwJGhqDTl7S3Y+/8vkff6WARG
tVqprX922xUMXMvCbjGUgGRx2NwSYbJH2p0G4ux3SOVLnVGrza+kgY8zUl3WtUVq
IQK56EWgQMhR+3DaKzT49XxLATCAiZSNlMLyZgjlY9A073aLBcH6BNMKznMlVBrG
eTzJZIpnhv7nirkXfZzJtUACzGoo153T02T2syVi5Y7MV4p6hG6mTFGHw5PBVZC2
PpvQ3qC532WcIl1qfnPeLjGkTDBVAt1DL942xCkohNPD/SwNu6xuU/vnotkTNaIQ
JJ2rznLgTO3znl9PHAKzhfiRkzvd+zYtrNmNX413a/mTDU3V7ns=
=wJr5
-----END PGP SIGNATURE-----

--UlsYxwg8UDQn+EKZ--

