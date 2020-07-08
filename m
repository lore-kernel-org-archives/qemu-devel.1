Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A49C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 11:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8F720739
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 11:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="c6N5UZJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8F720739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jt80x-00021D-T6
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 07:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jt805-0001LK-0s; Wed, 08 Jul 2020 07:12:29 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:59877)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jt801-0002Nk-JE; Wed, 08 Jul 2020 07:12:28 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B1xTl1Sxpz9sRN; Wed,  8 Jul 2020 21:12:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594206731;
 bh=KzZ3l7/0bUaPXMlIZQ5x9zfQ8X2cyhuVGjUpRus/mDg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c6N5UZJ5MIP6eSQyN6yQGDqcAMLP48LBRHsy8pW+bA33fIdfdsD7yhLZ2pzBuxcoi
 JJxYW7BMtnzxypAIHoqN3+VNDr7iEbEa1sBSvW02bkpZtZgC9Ogwz149c1xQWSdVzL
 xO0nQujkxKlrnM4eRCrLABD/9bIMyOy+fXoMed7M=
Date: Wed, 8 Jul 2020 20:00:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] cpu: Add starts_halted() method
Message-ID: <20200708100038.GG18595@umbus.fritz.box>
References: <20200707204333.261506-1-bauerman@linux.ibm.com>
 <20200707214917.GX7276@habkost.net>
 <87y2nu3nxq.fsf@morokweng.localdomain>
 <c53b36b7-ee7b-bb66-8220-cce788fd631d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XaUbO9McV5wPQijU"
Content-Disposition: inline
In-Reply-To: <c53b36b7-ee7b-bb66-8220-cce788fd631d@redhat.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--XaUbO9McV5wPQijU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2020 at 10:38:29AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Hi Thiago,
>=20
> On 7/8/20 1:28 AM, Thiago Jung Bauermann wrote:
> >=20
> > Hello Eduardo,
> >=20
> > Eduardo Habkost <ehabkost@redhat.com> writes:
> >=20
> >> On Tue, Jul 07, 2020 at 05:43:33PM -0300, Thiago Jung Bauermann wrote:
> >>> PowerPC sPAPRs CPUs start in the halted state, but generic QEMU code
> >>> assumes that CPUs start in the non-halted state. spapr_reset_vcpu()
> >>> attempts to rectify this by setting CPUState::halted to 1. But that's=
 too
> >>> late for hotplugged CPUs in a machine configured with 2 or mor thread=
s per
> >>> core.
> >>>
> >>> By then, other parts of QEMU have already caused the vCPU to run in an
> >>> unitialized state a couple of times. For example, ppc_cpu_reset() cal=
ls
> >>> ppc_tlb_invalidate_all(), which ends up calling async_run_on_cpu(). T=
his
> >>> kicks the new vCPU while it has CPUState::halted =3D 0, causing QEMU =
to issue
> >>> a KVM_RUN ioctl on the new vCPU before the guest is able to make the
> >>> start-cpu RTAS call to initialize its register state.
> >>>
> >>> This doesn't seem to cause visible issues for regular guests, but on a
> >>> secure guest running under the Ultravisor it does. The Ultravisor rel=
ies on
> >>> being able to snoop on the start-cpu RTAS call to map vCPUs to guests=
, and
> >>> this issue causes it to see a stray vCPU that doesn't belong to any g=
uest.
> >>>
> >>> Fix by adding a starts_halted() method to the CPUState class, and mak=
ing it
> >>> return 1 if the machine is an sPAPR guest.
> >>>
> >>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> >> [...]
> >>> +static uint32_t ppc_cpu_starts_halted(void)
> >>> +{
> >>> +    SpaprMachineState *spapr =3D
> >>> +        (SpaprMachineState *) object_dynamic_cast(qdev_get_machine(),
> >>> +                                                  TYPE_SPAPR_MACHINE=
);
> >>
> >> Wouldn't it be simpler to just implement this as a MachineClass
> >> boolean field?  e.g.:
>=20
> Class boolean field certainly sounds better, but I am not sure this
> is a property of the machine. Rather the arch? So move the field
> to CPUClass? Maybe not, let's discuss :)

It is absolutely a property of the machine.  e.g. I don't think we
want this for powernv.  pseries is a bit of a special case since it is
explicitly a paravirt platform.  But even for emulated hardware, the
board can absolutely strap things so that cpus do or don't start
immediately.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XaUbO9McV5wPQijU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8FmUMACgkQbDjKyiDZ
s5J5ThAAmnqiq7JbTXzWm67r+1FBN3CmpPCZH3BLbi/sZCIXol06kRUzCDIENBoX
IzRw+hP16z84YKSXtQgZ3eFjtjzJkOEOAe1Iplf3RHDZcqtFMyw8luk2U1gvglG/
8An/bLstvajt5vBgg28uTIFqvxorCzabmLXntwLAyfA8K7s/Pag3VJmOPa7JtO91
7sNVlmctRX9yPx+Y+USj/vXx7hbh64TSUqmN7sRYSj8k3Vhb8zbreNcLIeN23TJX
gOO4vtducAghgMtyz2bTrLpwh1HIfbnERt9xcWyPsImLsGM44BRx+oiUvgTx6lHA
IowCYU5lhRgoh8dRD9SLHgrsyEpwgstaAjmr02hnDwKuxKrn2fX6joK9PZswm2AC
rr1g7U7ykFhRYxw2XjF2HEUXzyGDgDdl1OegBkQG3gyRUeS4diHRYydX5nhCXLs5
PfnpgNj32xwfnA4RajFuNxFC9j9hbpNipIpLmOgtKI7o+FMmR2jYi9YffI5S/1vs
YG+401t+eC7qXKR07/mMpplHH7EkqrsaB0Xb8EPvEK2VPK1R+m3fx2NgNPL6ybUl
qCp0l4eFJN9GY0xjNnZWCsl2E8A7UsrOX5ocu4AjI6MW1q5xB+sM2tVpnWGMgHCB
jB+NfiWiciu4P3HBkCU346pU+AU8Hp8L/RV11OmvgOmWk/5vlfk=
=ZWY6
-----END PGP SIGNATURE-----

--XaUbO9McV5wPQijU--

