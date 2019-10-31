Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42256CA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 10:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8832086D
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 10:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iWgX7WpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8832086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ7bg-0005Ar-C9
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 06:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iQ7YF-0007LL-2I
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iQ7YD-0001Di-Dc
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:19:34 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:43009 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iQ7YC-00011K-2O; Thu, 31 Oct 2019 06:19:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 473hBl0kYwz9sP6; Thu, 31 Oct 2019 21:19:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1572517167;
 bh=1xot8t1rZciAt3W5U3AHPoL0RX7ITsue76PaTtlt9bk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iWgX7WpFl/cCtT1eK5q9nqqdS/168LdeUiSdK4y96SlHiLBH8xwRbJklKfZp0iShE
 bFOmHm5DY4QcBQdcmU+v2rj/hIiwyMiXvzpJzQhDzzt0BDpTSwLhnLQTdc9KzEQ9fT
 L55xSuzFgpAUiuXRtLp3S1RF26661IYwKI5011Ws=
Date: Thu, 31 Oct 2019 11:06:25 +0100
From: David Gibson <david@gibson.dropbear.id.au>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] spapr/kvm: Set default cpu model for all machine classes
Message-ID: <20191031100625.GV3552@umbus.metropole.lan>
References: <20191030163243.10644-1-david@gibson.dropbear.id.au>
 <7899d767-8a17-0d50-1893-bc8437978437@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="87MiR7gHvrw39A9h"
Content-Disposition: inline
In-Reply-To: <7899d767-8a17-0d50-1893-bc8437978437@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 Igor Mammedov <imammedo@redhat.com>, jdenemar@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--87MiR7gHvrw39A9h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2019 at 06:32:28PM +0100, David Hildenbrand wrote:
> On 30.10.19 17:32, David Gibson wrote:
> > We have to set the default model of all machine classes, not just for t=
he
> > active one. Otherwise, "query-machines" will indicate the wrong CPU mod=
el
> > ("qemu-s390x-cpu" instead of "host-s390x-cpu") as "default-cpu-type".
>=20
> Maybe use ppc CPU models here instead of s390x ones :)

Oops, thanks.


>=20
> >=20
> > s390x already fixed this in de60a92e "s390x/kvm: Set default cpu model =
for
> > all machine classes".  This patch applies a similar fix for the pseries=
-*
> > machine types on ppc64.
> >=20
> > Doing a
> >      {"execute":"query-machines"}
> > under KVM now results in
> >      {
> >        "hotpluggable-cpus": true,
> >        "name": "pseries-4.2",
> >        "numa-mem-supported": true,
> >        "default-cpu-type": "host-powerpc64-cpu",
> >        "is-default": true,
> >        "cpu-max": 1024,
> >        "deprecated": false,
> >        "alias": "pseries"
> >      },
> >      {
> >        "hotpluggable-cpus": true,
> >        "name": "pseries-4.1",
> >        "numa-mem-supported": true,
> >        "default-cpu-type": "host-powerpc64-cpu",
> >        "cpu-max": 1024,
> >        "deprecated": false
> >      },
> >      ...
> >=20
> > Libvirt probes all machines via "-machine none,accel=3Dkvm:tcg" and will
> > currently see the wrong CPU model under KVM.
> >=20
> > Reported-by: Ji=C5=99i Denemark <jdenemar@redhat.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Igor Mammedov <imammedo@redhat.com>
> > ---
> >   target/ppc/kvm.c | 21 +++++++++++++--------
> >   1 file changed, 13 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 7d2e8969ac..c77f9848ec 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -100,7 +100,7 @@ static bool kvmppc_is_pr(KVMState *ks)
> >       return kvm_vm_check_extension(ks, KVM_CAP_PPC_GET_PVINFO) !=3D 0;
> >   }
> > -static int kvm_ppc_register_host_cpu_type(MachineState *ms);
> > +static int kvm_ppc_register_host_cpu_type(void);
> >   static void kvmppc_get_cpu_characteristics(KVMState *s);
> >   static int kvmppc_get_dec_bits(void);
> > @@ -147,7 +147,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >           exit(1);
> >       }
> > -    kvm_ppc_register_host_cpu_type(ms);
> > +    kvm_ppc_register_host_cpu_type();
> >       return 0;
> >   }
> > @@ -2534,13 +2534,19 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(voi=
d)
> >       return pvr_pcc;
> >   }
> > -static int kvm_ppc_register_host_cpu_type(MachineState *ms)
> > +static void pseries_machine_class_fixup(ObjectClass *oc, void *opaque)
> > +{
> > +    MachineClass *mc =3D MACHINE_CLASS(oc);
> > +
> > +    mc->default_cpu_type =3D TYPE_HOST_POWERPC_CPU;
> > +}
> > +
> > +static int kvm_ppc_register_host_cpu_type(void)
> >   {
> >       TypeInfo type_info =3D {
> >           .name =3D TYPE_HOST_POWERPC_CPU,
> >           .class_init =3D kvmppc_host_cpu_class_init,
> >       };
> > -    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> >       PowerPCCPUClass *pvr_pcc;
> >       ObjectClass *oc;
> >       DeviceClass *dc;
> > @@ -2552,10 +2558,9 @@ static int kvm_ppc_register_host_cpu_type(Machin=
eState *ms)
> >       }
> >       type_info.parent =3D object_class_get_name(OBJECT_CLASS(pvr_pcc));
> >       type_register(&type_info);
> > -    if (object_dynamic_cast(OBJECT(ms), TYPE_SPAPR_MACHINE)) {
> > -        /* override TCG default cpu type with 'host' cpu model */
> > -        mc->default_cpu_type =3D TYPE_HOST_POWERPC_CPU;
> > -    }
> > +    /* override TCG default cpu type with 'host' cpu model */
> > +    object_class_foreach(pseries_machine_class_fixup, TYPE_SPAPR_MACHI=
NE,
> > +                         false, NULL);
> >       oc =3D object_class_by_name(type_info.name);
> >       g_assert(oc);
> >=20
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--87MiR7gHvrw39A9h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl26sh4ACgkQbDjKyiDZ
s5LwhhAAzZuoxlBdgRzTt6qo4F7bxAeYyDYVceEsiV1Qg03iTXIya3FhU70+x9F9
w1A77cCEZ9CwRTyfHRzDSgeXXw03xN0bhMTh4KW5p1XovBojj7Lwjc5MLaeO0lBc
3d6aVbqVxWD7GFMmRrUHN4OzMXxEErrivMHF2C/FvdANaKu2MO6LAJznHOZbrbhP
Cb333ZCpryOVJBKmz07ZbLnamW2LjhOmlVHFEup1L6BR6CNdoW5lOgoYY3h7/2m3
tgFck93wwJHf6UECBhZFN8CLS4HxYsgGelK9zR/U6AQ457qsjtis7TnmqQn5FVYq
GC3IEGP3WUYRT3mO8X4jX/+TIbwoIpdLugM5T98IWht4vAYD1d9k6h3TWyZzmgXD
rLhsRVOEhVothsRq1FhwuNAKiZdPCA0NXNIsh7bjabQMRSEaePlQCUk6FjjO5nWE
hO9JXIioRJo5yAXGyS0ltWlhKTe2oTHLQ/wZx2OwPEtGwZLR5L4o0uU0fZs6sGr2
wGq6KeRCjCQFWZTLoECMiRaZbiL1hRhdC0qCYYgAFDbl8tg+ZkUV6tTtnLTmJhl/
G4nmeTxCD8VuLJddZBOoiMEulOwYCFtaQgXQvfBC5yVTVQUsawprlBw1rDQ6GEMT
nVOkwYWaJG6S9KnXrKEVWjGpGZr144lnvMaFManCl4pasGqWDbs=
=a41a
-----END PGP SIGNATURE-----

--87MiR7gHvrw39A9h--

