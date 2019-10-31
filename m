Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35CECA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 10:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368BB20656
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 10:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="naTVCUBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368BB20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ7oq-0001d5-O7
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 06:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iQ7YF-0007LT-1v
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iQ7YD-0001Dc-DH
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:19:34 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:33943 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iQ7YC-00011j-2O; Thu, 31 Oct 2019 06:19:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 473hBl2cvMz9sPK; Thu, 31 Oct 2019 21:19:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1572517167;
 bh=xEctnMe3PfsuXaZ9oXkr+9u9KD8dPJ4J2MRQj8wiTxk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=naTVCUBGRDiysggJASoZLFSu/pLWZKc0j62OMRwpRMBZKvibVfv79wreda/F280tG
 xkXZMN8HP4d1xc4U8Kd+vJDpECAedfyZ1+kGBCYsP+G/YKJ6f3tUBe3F/hvJ+9IU1V
 x/UkqhTqRYbqMEZlddDBEgKB92U5wGgXRNdtl42g=
Date: Thu, 31 Oct 2019 11:07:53 +0100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr/kvm: Set default cpu model for all machine classes
Message-ID: <20191031100753.GW3552@umbus.metropole.lan>
References: <20191030163243.10644-1-david@gibson.dropbear.id.au>
 <20191031091556.1c25fbe1@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NYEXl3WhqsXurSTm"
Content-Disposition: inline
In-Reply-To: <20191031091556.1c25fbe1@bahia.lan>
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
Cc: david@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org,
 Igor Mammedov <imammedo@redhat.com>, jdenemar@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NYEXl3WhqsXurSTm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2019 at 09:15:56AM +0100, Greg Kurz wrote:
> On Wed, 30 Oct 2019 17:32:43 +0100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > We have to set the default model of all machine classes, not just for t=
he
> > active one. Otherwise, "query-machines" will indicate the wrong CPU mod=
el
> > ("qemu-s390x-cpu" instead of "host-s390x-cpu") as "default-cpu-type".
> >=20
>=20
> A PPC cpu model might be better.

Indeed.

>=20
> > s390x already fixed this in de60a92e "s390x/kvm: Set default cpu model =
for
> > all machine classes".  This patch applies a similar fix for the pseries=
-*
> > machine types on ppc64.
> >=20
> > Doing a
> >     {"execute":"query-machines"}
> > under KVM now results in
> >     {
> >       "hotpluggable-cpus": true,
> >       "name": "pseries-4.2",
> >       "numa-mem-supported": true,
> >       "default-cpu-type": "host-powerpc64-cpu",
> >       "is-default": true,
> >       "cpu-max": 1024,
> >       "deprecated": false,
> >       "alias": "pseries"
> >     },
> >     {
> >       "hotpluggable-cpus": true,
> >       "name": "pseries-4.1",
> >       "numa-mem-supported": true,
> >       "default-cpu-type": "host-powerpc64-cpu",
> >       "cpu-max": 1024,
> >       "deprecated": false
> >     },
> >     ...
> >=20
> > Libvirt probes all machines via "-machine none,accel=3Dkvm:tcg" and will
> > currently see the wrong CPU model under KVM.
> >=20
> > Reported-by: Ji=C5=99i Denemark <jdenemar@redhat.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Igor Mammedov <imammedo@redhat.com>
>=20
> Missing S-o-b.

Oops, fixed.

> With these fixed.
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> > ---
> >  target/ppc/kvm.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 7d2e8969ac..c77f9848ec 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -100,7 +100,7 @@ static bool kvmppc_is_pr(KVMState *ks)
> >      return kvm_vm_check_extension(ks, KVM_CAP_PPC_GET_PVINFO) !=3D 0;
> >  }
> > =20
> > -static int kvm_ppc_register_host_cpu_type(MachineState *ms);
> > +static int kvm_ppc_register_host_cpu_type(void);
> >  static void kvmppc_get_cpu_characteristics(KVMState *s);
> >  static int kvmppc_get_dec_bits(void);
> > =20
> > @@ -147,7 +147,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >          exit(1);
> >      }
> > =20
> > -    kvm_ppc_register_host_cpu_type(ms);
> > +    kvm_ppc_register_host_cpu_type();
> > =20
> >      return 0;
> >  }
> > @@ -2534,13 +2534,19 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(voi=
d)
> >      return pvr_pcc;
> >  }
> > =20
> > -static int kvm_ppc_register_host_cpu_type(MachineState *ms)
> > +static void pseries_machine_class_fixup(ObjectClass *oc, void *opaque)
> > +{
> > +    MachineClass *mc =3D MACHINE_CLASS(oc);
> > +
> > +    mc->default_cpu_type =3D TYPE_HOST_POWERPC_CPU;
> > +}
> > +
> > +static int kvm_ppc_register_host_cpu_type(void)
> >  {
> >      TypeInfo type_info =3D {
> >          .name =3D TYPE_HOST_POWERPC_CPU,
> >          .class_init =3D kvmppc_host_cpu_class_init,
> >      };
> > -    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> >      PowerPCCPUClass *pvr_pcc;
> >      ObjectClass *oc;
> >      DeviceClass *dc;
> > @@ -2552,10 +2558,9 @@ static int kvm_ppc_register_host_cpu_type(Machin=
eState *ms)
> >      }
> >      type_info.parent =3D object_class_get_name(OBJECT_CLASS(pvr_pcc));
> >      type_register(&type_info);
> > -    if (object_dynamic_cast(OBJECT(ms), TYPE_SPAPR_MACHINE)) {
> > -        /* override TCG default cpu type with 'host' cpu model */
> > -        mc->default_cpu_type =3D TYPE_HOST_POWERPC_CPU;
> > -    }
> > +    /* override TCG default cpu type with 'host' cpu model */
> > +    object_class_foreach(pseries_machine_class_fixup, TYPE_SPAPR_MACHI=
NE,
> > +                         false, NULL);
> > =20
> >      oc =3D object_class_by_name(type_info.name);
> >      g_assert(oc);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NYEXl3WhqsXurSTm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl26snkACgkQbDjKyiDZ
s5IdUxAAq6oKGzSH8Df+NKvcLQfYrff79Z23EZN4dLEHpw5YvyGTvZkCmNdEaVgK
BA8XrNYg8dxP/Rb2FGFqboedaFyUsQ4w4NkfRNqqfd6dVh6VASGz1f/vLcx46j74
2eJU9yw0hSQOu0q96tf3aeTBSuXrKaHkvS5HsTCZTrd1vMF0A6tfnN8gYKLBBNxG
k106RycoNKJVVkmjz4I91StabbP0S9t2PdRKhZCRFjBxLEL/ihw4o7lKIC5JjwNA
9f1lagKqeZe75qQCnNuaUMvDSn2f9stMuPylfDJi2ClzPSGNOCnOvmvsjQFAxez6
VzmiLntHdNNJ1wWqfqpdER4kzhqXXXQaoLUf1cR43MIQHdWP5eS+rDlUVd1EZaJa
9k6+hxErmoVTvMLNLT3s3yYOpdeuzC71zCbyBt0RDt01S5vK3NYwGkE6Huz0929z
NeAs75IZlJBWUfVFBF9qm4vTxdj/3HEn3k8KUhmxdfRIsHJJYcwyGhjxJwaLThoh
CTfPJK3Zr9k610V7GokK7NOLyGXuoIXOBAipPvwFDElLHSpcD6B3Bqf/14yzJfRy
11sofZB1cq269495O3Z3Oxj33SDYJlNSx0XCF63Iap2a71zXTFXbO/kGFCEe1xQ5
iTOFgmWmA79cGA9w1z/42DKo63qnJyiTDPbyBDJNY9zEutyQRck=
=xtzg
-----END PGP SIGNATURE-----

--NYEXl3WhqsXurSTm--

