Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B40C4CECD
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 00:15:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7386121848
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 00:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FUOUd5uV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7386121848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iANcb-0003Fi-KF
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 20:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iANbt-0002nF-Q7
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 20:14:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iANbs-0000hl-7F
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 20:14:17 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:41083 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1iANbr-0000gw-Hw
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 20:14:16 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46Y0p96MNlz9sPD; Wed, 18 Sep 2019 10:14:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568765649;
 bh=HfeW0Hs5zO4JnXE9pmFCoU6KyxK+OKfnV8bXXdNqPPY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FUOUd5uV2UxQy0MOL3TH2k/GKRH+9UkkuUEI4QDzWF957b/0CizOHOJpU9sqgLe2H
 yr6P1hjdNii9I5+UoM5dpnvThTB9U874FUj1n3i4W2M6lR0lKhpLIpe/KgW+BuhrNM
 6JA7/tigTkyVVrsYo32sdA2eidvVk7m16KRnFmSQ=
Date: Wed, 18 Sep 2019 10:12:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190918001200.GB2440@umbus.fritz.box>
References: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
 <156871565600.196432.9246692833113774428.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
In-Reply-To: <156871565600.196432.9246692833113774428.stgit@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 04/17] ppc: Pass local error object pointer
 to error_append_hint()
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yuval Shaia <yuval.shaia@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2019 at 12:20:56PM +0200, Greg Kurz wrote:
> Ensure that hints are added even if errp is &error_fatal or &error_abort.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/mac_newworld.c |    7 +++++--
>  hw/ppc/spapr.c        |    7 +++++--
>  hw/ppc/spapr_pci.c    |    9 +++++----
>  target/ppc/kvm.c      |   13 +++++++++----
>  4 files changed, 24 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index c5bbcc743352..aca8c40bf395 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -618,8 +618,11 @@ static void core99_set_via_config(Object *obj, const=
 char *value, Error **errp)
>      } else if (!strcmp(value, "pmu-adb")) {
>          cms->via_config =3D CORE99_VIA_CONFIG_PMU_ADB;
>      } else {
> -        error_setg(errp, "Invalid via value");
> -        error_append_hint(errp, "Valid values are cuda, pmu, pmu-adb.\n"=
);
> +        Error *local_err =3D NULL;
> +
> +        error_setg(&local_err, "Invalid via value");
> +        error_append_hint(&local_err, "Valid values are cuda, pmu, pmu-a=
db.\n");
> +        error_propagate(errp, local_err);
>      }
>  }
> =20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 08a2a5a77092..39d6f57d014e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4337,10 +4337,13 @@ void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_i=
ndex, Error **errp)
>      vcpu_id =3D spapr_vcpu_id(spapr, cpu_index);
> =20
>      if (kvm_enabled() && !kvm_vcpu_id_is_valid(vcpu_id)) {
> -        error_setg(errp, "Can't create CPU with id %d in KVM", vcpu_id);
> -        error_append_hint(errp, "Adjust the number of cpus to %d "
> +        Error *local_err =3D NULL;
> +
> +        error_setg(&local_err, "Can't create CPU with id %d in KVM", vcp=
u_id);
> +        error_append_hint(&local_err, "Adjust the number of cpus to %d "
>                            "or try to raise the number of threads per cor=
e\n",
>                            vcpu_id * ms->smp.threads / spapr->vsmt);
> +        error_propagate(errp, local_err);
>          return;
>      }
> =20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 7b71ad7c74f1..4b7e9a1c8666 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1870,12 +1870,13 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
>      if (spapr_pci_find_phb(spapr, sphb->buid)) {
>          SpaprPhbState *s;
> =20
> -        error_setg(errp, "PCI host bridges must have unique indexes");
> -        error_append_hint(errp, "The following indexes are already in us=
e:");
> +        error_setg(&local_err, "PCI host bridges must have unique indexe=
s");
> +        error_append_hint(&local_err, "The following indexes are already=
 in use:");
>          QLIST_FOREACH(s, &spapr->phbs, list) {
> -            error_append_hint(errp, " %d", s->index);
> +            error_append_hint(&local_err, " %d", s->index);
>          }
> -        error_append_hint(errp, "\nTry another value for the index prope=
rty\n");
> +        error_append_hint(&local_err, "\nTry another value for the index=
 property\n");
> +        error_propagate(errp, local_err);
>          return;
>      }
> =20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8c5b1f25cc95..c6876b08c726 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -242,8 +242,11 @@ static void kvm_get_smmu_info(struct kvm_ppc_smmu_in=
fo *info, Error **errp)
>      assert(kvm_state !=3D NULL);
> =20
>      if (!kvm_check_extension(kvm_state, KVM_CAP_PPC_GET_SMMU_INFO)) {
> -        error_setg(errp, "KVM doesn't expose the MMU features it support=
s");
> -        error_append_hint(errp, "Consider switching to a newer KVM\n");
> +        Error *local_err =3D NULL;
> +
> +        error_setg(&local_err, "KVM doesn't expose the MMU features it s=
upports");
> +        error_append_hint(&local_err, "Consider switching to a newer KVM=
\n");
> +        error_propagate(errp, local_err);
>          return;
>      }
> =20
> @@ -2076,6 +2079,7 @@ void kvmppc_hint_smt_possible(Error **errp)
>      int i;
>      GString *g;
>      char *s;
> +    Error *local_err =3D NULL;
> =20
>      assert(kvm_enabled());
>      if (cap_ppc_smt_possible) {
> @@ -2086,12 +2090,13 @@ void kvmppc_hint_smt_possible(Error **errp)
>              }
>          }
>          s =3D g_string_free(g, false);
> -        error_append_hint(errp, "%s.\n", s);
> +        error_append_hint(&local_err, "%s.\n", s);
>          g_free(s);
>      } else {
> -        error_append_hint(errp,
> +        error_append_hint(&local_err,
>                            "This KVM seems to be too old to support VSMT.=
\n");
>      }
> +    error_propagate(errp, local_err);
>  }
> =20
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2BdlAACgkQbDjKyiDZ
s5IH7w/+IgnuloA+e1iBLmG/jfS/+D79or9aYJIC8QL3PWJGxqrS/aJTwIX5qYnS
AZGuZEzrByAI3MZC6TYOu6Y3Hax4ttZJppwTjRsbm01jVpcNxZ6QEvTaMCyZeMhN
P1fU4sejNt3RMFyjqgd8fE+oSNajmxLCJPIsHac2GImsg3Dm2bLmZ95Rx80RZi0u
zivYt3YkrdJl3VZeVDq0Ihmb5BXUGcCQGe0UopuN/pflKiaMD5xW5pqRwFEqwZFT
S9kZue50CBKfDaUh0n+Cd+a39HNaFf2gdYlENuOcv7awIHMnqwqsUbNmfA+mtBGW
V+ghaFnfdYqirlaXmEFauZ7AMPNb6yN4uxAR0FXx3oFFskzyIMIAeUQ+w+kzQRgA
94TRQtagg+xzbCDfFcZOzc2p0DyrWqwjlces7MLq0T1QQtUiDnSBMTtzVRszGuw5
Er+QBHl3JBlVAei3aOZf2O97YqtaP7/sUWsomkEyMvT87m1KLmyXNghTjoL2Mlvh
++fajUXhHKivVhtLmA6dWkorp5vXwnJLmmdS5qG4r6C7HzifgnSs2ZEngtWN3rxQ
rECmfDsER8RudkW7+I07asH8pD3m7M6eSyiIvEFzQ0RwEIsgwlkDvMe9mDeaFEVe
zw1pwDyxfOm+1bnJ+J2bdbdhOXckLdeFTyGvSECtzw13pRLYlM0=
=sFDR
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--

