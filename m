Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A55C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 17:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9426520678
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 17:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9426520678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipbrh-0000kL-JA
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 12:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ipbqu-0008Tt-2r
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 12:44:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ipbqs-0007qM-Rn
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 12:44:11 -0500
Received: from 7.mo69.mail-out.ovh.net ([46.105.50.32]:46358)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ipbqs-0007es-Hw
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 12:44:10 -0500
Received: from player690.ha.ovh.net (unknown [10.109.146.240])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 28B1B7B66D
 for <qemu-devel@nongnu.org>; Thu,  9 Jan 2020 18:44:07 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player690.ha.ovh.net (Postfix) with ESMTPSA id 23679DEC9C13;
 Thu,  9 Jan 2020 17:43:50 +0000 (UTC)
Date: Thu, 9 Jan 2020 18:43:49 +0100
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 04/15] hw/ppc/spapr_rtas: Restrict variables scope to
 single switch case
Message-ID: <20200109184349.1aefa074@bahia.lan>
In-Reply-To: <20200109152133.23649-5-philmd@redhat.com>
References: <20200109152133.23649-1-philmd@redhat.com>
 <20200109152133.23649-5-philmd@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 7378866518583449891
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiuddgieelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieeltddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.50.32
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Juan Quintela <quintela@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  9 Jan 2020 16:21:22 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> We only access these variables in RTAS_SYSPARM_SPLPAR_CHARACTERISTICS
> case, restrict their scope to avoid unnecessary initialization.
>=20

I guess a decent compiler can be smart enough detect that the initialization
isn't needed outside of the RTAS_SYSPARM_SPLPAR_CHARACTERISTICS branch...
Anyway, reducing scope isn't bad. The only hitch I could see is that some
people do prefer to have all variables declared upfront, but there's a nest=
ed
param_val variable already so I guess it's okay.

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/ppc/spapr_rtas.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 6f06e9d7fe..7237e5ebf2 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -267,8 +267,6 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU =
*cpu,
>                                            uint32_t nret, target_ulong re=
ts)
>  {
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> -    MachineState *ms =3D MACHINE(spapr);
> -    unsigned int max_cpus =3D ms->smp.max_cpus;
>      target_ulong parameter =3D rtas_ld(args, 0);
>      target_ulong buffer =3D rtas_ld(args, 1);
>      target_ulong length =3D rtas_ld(args, 2);
> @@ -276,6 +274,8 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU =
*cpu,
> =20
>      switch (parameter) {
>      case RTAS_SYSPARM_SPLPAR_CHARACTERISTICS: {
> +        MachineState *ms =3D MACHINE(spapr);
> +        unsigned int max_cpus =3D ms->smp.max_cpus;

The max_cpus variable used to be a global. Now that it got moved
below ms->smp, I'm not sure it's worth keeping it IMHO. What about
dropping it completely and do:

        char *param_val =3D g_strdup_printf("MaxEntCap=3D%d,"
                                          "DesMem=3D%" PRIu64 ","
                                          "DesProcs=3D%d,"
                                          "MaxPlatProcs=3D%d",
                                          ms->smp.max_cpus,
                                          current_machine->ram_size / MiB,
                                          ms->smp.cpus,
                                          ms->smp.max_cpus);

And maybe insert an empty line between the declaration of param_val
and the code for a better readability ?

>          char *param_val =3D g_strdup_printf("MaxEntCap=3D%d,"
>                                            "DesMem=3D%" PRIu64 ","
>                                            "DesProcs=3D%d,"


