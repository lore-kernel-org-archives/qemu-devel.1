Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AF9C33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3946720728
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3946720728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is7n9-0004Ls-75
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 11:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1is7mV-0003oT-MC
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:14:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1is7mS-0005iR-1I
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:14:03 -0500
Received: from 20.mo1.mail-out.ovh.net ([188.165.45.168]:43432)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1is7mR-0005fi-Rb
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:13:59 -0500
Received: from player756.ha.ovh.net (unknown [10.108.57.188])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 695D01A6762
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 17:13:57 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player756.ha.ovh.net (Postfix) with ESMTPSA id C9E9DD78D839;
 Thu, 16 Jan 2020 16:13:52 +0000 (UTC)
Date: Thu, 16 Jan 2020 17:13:51 +0100
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH] spapr: Fail CAS if option vector table cannot be parsed
Message-ID: <20200116171351.57fc442a@bahia.lan>
In-Reply-To: <ee5bcc16-2e86-a9b2-423d-bc82d327f581@redhat.com>
References: <157918715618.376249.7891210201270364781.stgit@bahia.lan>
 <ee5bcc16-2e86-a9b2-423d-bc82d327f581@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 10071174667312732451
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrtdehgdekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejheeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.45.168
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jan 2020 16:34:06 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Hi Greg,
>=20

Hi Phil,

> On 1/16/20 4:05 PM, Greg Kurz wrote:
> > Most of the option vector helpers have assertions to check their
> > arguments aren't null. The guest can provide an arbitrary address
> > for the CAS structure that would result in such null arguments.
> > Fail CAS with H_PARAMETER instead of aborting QEMU.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >   hw/ppc/spapr_hcall.c |    9 +++++++++
> >   1 file changed, 9 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 84e1612595bb..051869ae20ec 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -1701,9 +1701,18 @@ static target_ulong h_client_architecture_suppor=
t(PowerPCCPU *cpu,
> >  =20
> >       /* For the future use: here @ov_table points to the first option =
vector */
> >       ov_table =3D addr;
> > +    if (!ov_table) {
> > +        return H_PARAMETER;
> > +    }
>=20
> This doesn't look right to check ov_table, I'd check addr directly instea=
d:
>=20

I decided to check ov_table because this is what we pass to
spapr_ovec_parse_vector() and that shouldn't be NULL.

> -- >8 --
> @@ -1679,12 +1679,16 @@ static target_ulong=20
> h_client_architecture_support(PowerPCCPU *cpu,
>=20
>       cas_pvr =3D cas_check_pvr(spapr, cpu, &addr, &raw_mode_supported,=20
> &local_err);
>       if (local_err) {
>           error_report_err(local_err);
>           return H_HARDWARE;
>       }
> +    if (!addr) {
> +        // error_report*()
> +        return H_PARAMETER;
> +    }
>=20

I don't really care one way or another, but adding an error_report() is a
good idea since linux just print out the following in case of CAS failure:

WARNING: ibm,client-architecture-support call FAILED!

>       /* Update CPUs */
>       if (cpu->compat_pvr !=3D cas_pvr) {
> ---
>=20
> Still I'm not sure it makes sense, because the guest can also set other=20
> invalid addresses such addr=3D0x69.
>=20

The point of this patch is just to avoid hitting the assertions. 0x69
is probably bullshit but it passes the g_assert() at least.

> >  =20
> >       ov1_guest =3D spapr_ovec_parse_vector(ov_table, 1);
> > +    if (!ov1_guest) {
> > +        return H_PARAMETER;
> > +    }
>=20
> This one is OK (unlikely case where vector 1 isn't present).
>=20
> >       ov5_guest =3D spapr_ovec_parse_vector(ov_table, 5);
> > +    if (!ov5_guest) {
> > +        return H_PARAMETER;
> > +    }
>=20
> This one is OK too (unlikely case where vector 5 isn't present).
>=20
> >       if (spapr_ovec_test(ov5_guest, OV5_MMU_BOTH)) {
> >           error_report("guest requested hash and radix MMU, which is in=
valid.");
> >           exit(EXIT_FAILURE);
> >=20
> >=20
>=20


