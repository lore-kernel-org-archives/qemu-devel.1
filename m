Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9654DC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F73E222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F73E222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Fr5-0003IL-K4
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 04:53:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j7Fq4-0002jo-Bi
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j7Fq2-0002ky-BY
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:52:16 -0500
Received: from 19.mo4.mail-out.ovh.net ([87.98.179.66]:34657)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j7Fq0-0002jL-Um
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:52:14 -0500
Received: from player755.ha.ovh.net (unknown [10.110.115.182])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id A3B7E223771
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 10:52:10 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player755.ha.ovh.net (Postfix) with ESMTPSA id 298DEFE5ED50;
 Thu, 27 Feb 2020 09:52:03 +0000 (UTC)
Date: Thu, 27 Feb 2020 10:52:02 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] ppc: Officially deprecate the CPU "compat" property
Message-ID: <20200227105202.64b48944@bahia.home>
In-Reply-To: <20200226224641.GJ41629@umbus.fritz.box>
References: <158274357799.140275.12263135811731647490.stgit@bahia.lan>
 <20200226224641.GJ41629@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Nfba0B1uDd0yRFlyyhhh=4t";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 10469180286384249318
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrleeigddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpehprghttghhvgifrdhorhhgnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejheehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.179.66
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/Nfba0B1uDd0yRFlyyhhh=4t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Feb 2020 09:46:41 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Feb 26, 2020 at 07:59:38PM +0100, Greg Kurz wrote:
> > Server class POWER CPUs have a "compat" property, which was obsoleted
> > by commit 7843c0d60d and replaced by a "max-cpu-compat" property on the
> > pseries machine type. A hack was introduced so that passing "compat" to
> > -cpu would still produce the desired effect, for the sake of backward
> > compatibility : it strips the "compat" option from the CPU properties
> > and applies internally it to the pseries machine. The accessors of the
> > "compat" property were updated to do nothing but warn the user about the
> > deprecated status when doing something like:
> >=20
> > $ qemu-system-ppc64 -global POWER9-family-powerpc64-cpu.compat=3Dpower9
> > qemu-system-ppc64: warning: CPU 'compat' property is deprecated and has=
 no
> >  effect; use max-cpu-compat machine property instead
> >=20
> > This was merged during the QEMU 2.10 timeframe, a few weeks before we
> > formalized our deprecation process. As a consequence, the "compat"
> > property fell through the cracks and was never listed in the officialy
> > deprecated features.
> >=20
> > We are now eight QEMU versions later, it is largely time to mention it
> > in qemu-deprecated.texi. Also, since -global XXX-powerpc64-cpu.compat=3D
> > has been emitting warnings since QEMU 2.10 and the usual way of setting
> > CPU properties is with -cpu, completely remove the "compat" property.
> > Keep the hack so that -cpu XXX,compat=3D stays functional some more tim=
e,
> > as required by our deprecation process.
> >=20
> > The now empty powerpc_servercpu_properties[] list which was introduced
> > for "compat" and never had any other use is removed on the way. We can
> > re-add it in the future if the need for a server class POWER CPU specif=
ic
> > property arises again.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> Applied to ppc-for-5.0, thanks.
>=20
> > ---
> >  qemu-deprecated.texi            |    6 +++++

I've just discovered that Paolo posted a series to convert documentation
to rST. Especially this patch that introduces docs/system/deprecated.rst :

https://patchew.org/QEMU/20200226113034.6741-1-pbonzini@redhat.com/20200226=
113034.6741-18-pbonzini@redhat.com/

Paolo and David,

Please advise on the better way to ensure the changes from _my_ patch
make it to the rST version.

Thanks!

> >  target/ppc/translate_init.inc.c |   44 ++-----------------------------=
--------
> >  2 files changed, 8 insertions(+), 42 deletions(-)
> >=20
> > diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> > index 66eca3a1dede..56a69400c14a 100644
> > --- a/qemu-deprecated.texi
> > +++ b/qemu-deprecated.texi
> > @@ -242,6 +242,12 @@ The RISC-V no MMU cpus have been depcreated. The t=
wo CPUs: ``rv32imacu-nommu`` a
> >  ``rv64imacu-nommu`` should no longer be used. Instead the MMU status c=
an be specified
> >  via the CPU ``mmu`` option when using the ``rv32`` or ``rv64`` CPUs.
> > =20
> > +@subsection ``compat`` property of server class POWER CPUs (since 5.0)
> > +
> > +The ``compat`` property used to set backwards compatibility modes for
> > +the processor has been deprecated. The ``max-cpu-compat`` property of
> > +the ``pseries`` machine type should be used instead.
> > +
> >  @section System emulator devices
> > =20
> >  @subsection ide-drive (since 4.2)
> > diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_ini=
t.inc.c
> > index 53995f62eab2..2f7125c51f35 100644
> > --- a/target/ppc/translate_init.inc.c
> > +++ b/target/ppc/translate_init.inc.c
> > @@ -8492,44 +8492,6 @@ POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void *d=
ata)
> >      pcc->l1_icache_size =3D 0x10000;
> >  }
> > =20
> > -/*
> > - * The CPU used to have a "compat" property which set the
> > - * compatibility mode PVR.  However, this was conceptually broken - it
> > - * only makes sense on the pseries machine type (otherwise the guest
> > - * owns the PCR and can control the compatibility mode itself).  It's
> > - * been replaced with the 'max-cpu-compat' property on the pseries
> > - * machine type.  For backwards compatibility, pseries specially
> > - * parses the -cpu parameter and converts old compat=3D parameters into
> > - * the appropriate machine parameters.  This stub implementation of
> > - * the parameter catches any uses on explicitly created CPUs.
> > - */
> > -static void getset_compat_deprecated(Object *obj, Visitor *v, const ch=
ar *name,
> > -                                     void *opaque, Error **errp)
> > -{
> > -    QNull *null =3D NULL;
> > -
> > -    if (!qtest_enabled()) {
> > -        warn_report("CPU 'compat' property is deprecated and has no ef=
fect; "
> > -                    "use max-cpu-compat machine property instead");
> > -    }
> > -    visit_type_null(v, name, &null, NULL);
> > -    qobject_unref(null);
> > -}
> > -
> > -static const PropertyInfo ppc_compat_deprecated_propinfo =3D {
> > -    .name =3D "str",
> > -    .description =3D "compatibility mode (deprecated)",
> > -    .get =3D getset_compat_deprecated,
> > -    .set =3D getset_compat_deprecated,
> > -};
> > -static Property powerpc_servercpu_properties[] =3D {
> > -    {
> > -        .name =3D "compat",
> > -        .info =3D &ppc_compat_deprecated_propinfo,
> > -    },
> > -    DEFINE_PROP_END_OF_LIST(),
> > -};
> > -
> >  static void init_proc_POWER7(CPUPPCState *env)
> >  {
> >      /* Common Registers */
> > @@ -8611,7 +8573,6 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *dat=
a)
> > =20
> >      dc->fw_name =3D "PowerPC,POWER7";
> >      dc->desc =3D "POWER7";
> > -    device_class_set_props(dc, powerpc_servercpu_properties);
> >      pcc->pvr_match =3D ppc_pvr_match_power7;
> >      pcc->pcr_mask =3D PCR_VEC_DIS | PCR_VSX_DIS | PCR_COMPAT_2_05;
> >      pcc->pcr_supported =3D PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
> > @@ -8776,7 +8737,6 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *dat=
a)
> > =20
> >      dc->fw_name =3D "PowerPC,POWER8";
> >      dc->desc =3D "POWER8";
> > -    device_class_set_props(dc, powerpc_servercpu_properties);
> >      pcc->pvr_match =3D ppc_pvr_match_power8;
> >      pcc->pcr_mask =3D PCR_TM_DIS | PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
> >      pcc->pcr_supported =3D PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COM=
PAT_2_05;
> > @@ -8988,7 +8948,6 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *dat=
a)
> > =20
> >      dc->fw_name =3D "PowerPC,POWER9";
> >      dc->desc =3D "POWER9";
> > -    device_class_set_props(dc, powerpc_servercpu_properties);
> >      pcc->pvr_match =3D ppc_pvr_match_power9;
> >      pcc->pcr_mask =3D PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2=
_07;
> >      pcc->pcr_supported =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COM=
PAT_2_06 |
> > @@ -9198,7 +9157,6 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *da=
ta)
> > =20
> >      dc->fw_name =3D "PowerPC,POWER10";
> >      dc->desc =3D "POWER10";
> > -    device_class_set_props(dc, powerpc_servercpu_properties);
> >      pcc->pvr_match =3D ppc_pvr_match_power10;
> >      pcc->pcr_mask =3D PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2=
_07 |
> >                      PCR_COMPAT_3_00;
> > @@ -10486,6 +10444,8 @@ static void ppc_cpu_parse_featurestr(const char=
 *type, char *features,
> >          *s =3D '\0';
> >          for (i =3D 0; inpieces[i]; i++) {
> >              if (g_str_has_prefix(inpieces[i], "compat=3D")) {
> > +                warn_report_once("CPU 'compat' property is deprecated;=
 "
> > +                    "use max-cpu-compat machine property instead");
> >                  compat_str =3D inpieces[i];
> >                  continue;
> >              }
> >=20
>=20


--Sig_/Nfba0B1uDd0yRFlyyhhh=4t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl5XkUIACgkQcdTV5YIv
c9anKhAAiJjr7elVDL5JHu22aEbpg1XFKazwFr18KlUOJ6xKltrLCPjpeFEbVKH2
3r2OqEdfBpdmw9CiYT0D2YEkYD8bhRoLG4hwldowAis8BWELyWcJ8qAitNWWKtu6
y2PZtyo8vv/Nx8FR7Cvx+g9BGNC/DEaYAWJrNAX5hTLYg+XkTYHsCD4d7dEmeybJ
iaoIwYkyJg0+HhmPk6cnGkGYkyQSF1cEsJEkDNdeffj2ejMlTovbWfxKk3Zs+i5U
cIHKVgyDHqpSBQDASEsE3AK+qT9WAvofq1c5EKNdXQmQxVKhladlT+JTuZcGZkK4
PZfup43pZPdReTjj3tDPl1iBBgeIgN3EyBROzevwJCkV85KLbxwusltYQV/2hqVf
9wzo2AZ+cWhemgYum/sLChVlX4QNNQD/uZ4maZAgzsBIhd4V4zOBtIMm29cFJs38
tAx7fzxKRAZ2vU3nFfWGH1LdjXT5XA0/EGSbLkAZJrQzeQu7NryRGyucJYbFmUjB
XT1giOQxo6IM9JvoF/ScuI5tdFsYspJRs1LalJqj1kkaYcoi5iRdYvRTP+w8PZxb
+63IkhpzVCYiiZZP6qiyxGt5UYyajETE3qUm44YlAHenrJzpHU+dhrpUXaR3MsNA
QEM0qkNOrCQmbRCr6tg/k2xnPDZcywAtI2j0nhQGW1sq8VmCCA8=
=x0ti
-----END PGP SIGNATURE-----

--Sig_/Nfba0B1uDd0yRFlyyhhh=4t--

