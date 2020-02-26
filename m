Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FDFC4BA10
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 13:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DDB72467B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 13:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDB72467B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6wu5-0002TR-8p
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 08:39:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j6wtF-0001Zn-3d
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:38:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j6wtD-00012a-Tq
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:38:17 -0500
Received: from 12.mo6.mail-out.ovh.net ([178.32.125.228]:46679)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j6wtC-0000ri-5r
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:38:15 -0500
Received: from player699.ha.ovh.net (unknown [10.110.103.225])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id BE3401FCDE2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 14:38:11 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player699.ha.ovh.net (Postfix) with ESMTPSA id 65397FC5092F;
 Wed, 26 Feb 2020 13:37:52 +0000 (UTC)
Date: Wed, 26 Feb 2020 14:37:51 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v6 17/18] spapr: Clean up RMA size calculation
Message-ID: <20200226143751.17b4bfa4@bahia.home>
In-Reply-To: <20200224233724.46415-18-david@gibson.dropbear.id.au>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-18-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 8413568531551656422
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrleeggdehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.125.228
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, farosas@linux.ibm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 10:37:23 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> Move the calculation of the Real Mode Area (RMA) size into a helper
> function.  While we're there clean it up and correct it in a few ways:
>   * Add comments making it clearer where the various constraints come from
>   * Remove a pointless check that the RMA fits within Node 0 (we've just
>     clamped it so that it does)
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c | 59 ++++++++++++++++++++++++++++++--------------------
>  1 file changed, 35 insertions(+), 24 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 6e9f15f64d..f0354b699d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2648,6 +2648,40 @@ static PCIHostState *spapr_create_default_phb(void)
>      return PCI_HOST_BRIDGE(dev);
>  }
> =20
> +static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
> +{
> +    MachineState *machine =3D MACHINE(spapr);
> +    hwaddr rma_size =3D machine->ram_size;
> +    hwaddr node0_size =3D spapr_node0_size(machine);
> +
> +    /* RMA has to fit in the first NUMA node */
> +    rma_size =3D MIN(rma_size, node0_size);
> +
> +    /*
> +     * VRMA access is via a special 1TiB SLB mapping, so the RMA can
> +     * never exceed that
> +     */
> +    rma_size =3D MIN(rma_size, TiB);
> +
> +    /*
> +     * Clamp the RMA size based on machine type.  This is for
> +     * migration compatibility with older qemu versions, which limited
> +     * the RMA size for complicated and mostly bad reasons.
> +     */
> +    if (smc->rma_limit) {

/home/greg/Work/qemu/qemu-ppc/hw/ppc/spapr.c: In function =E2=80=98spapr_rm=
a_size=E2=80=99:
/home/greg/Work/qemu/qemu-ppc/hw/ppc/spapr.c:2671:9: error: =E2=80=98smc=E2=
=80=99 undeclared (first use in this function)
     if (smc->rma_limit) {

> +        spapr->rma_size =3D MIN(spapr->rma_size, smc->rma_limit);
> +    }
> +
> +    if (rma_size < (MIN_RMA_SLOF * MiB)) {
> +        error_setg(errp,
> +"pSeries SLOF firmware requires >=3D %ldMiB guest RMA (Real Mode Area)",
> +                   MIN_RMA_SLOF);
> +        return -1;
> +    }
> +
> +    return rma_size;
> +}
> +
>  /* pSeries LPAR / sPAPR hardware init */
>  static void spapr_machine_init(MachineState *machine)
>  {
> @@ -2660,7 +2694,6 @@ static void spapr_machine_init(MachineState *machin=
e)
>      int i;
>      MemoryRegion *sysmem =3D get_system_memory();
>      MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> -    hwaddr node0_size =3D spapr_node0_size(machine);
>      long load_limit, fw_size;
>      char *filename;
>      Error *resize_hpt_err =3D NULL;
> @@ -2700,22 +2733,7 @@ static void spapr_machine_init(MachineState *machi=
ne)
>          exit(1);
>      }
> =20
> -    spapr->rma_size =3D node0_size;
> -
> -    /*
> -     * Clamp the RMA size based on machine type.  This is for
> -     * migration compatibility with older qemu versions, which limited
> -     * the RMA size for complicated and mostly bad reasons.
> -     */
> -    if (smc->rma_limit) {
> -        spapr->rma_size =3D MIN(spapr->rma_size, smc->rma_limit);
> -    }
> -
> -    if (spapr->rma_size > node0_size) {
> -        error_report("Numa node 0 has to span the RMA (%#08"HWADDR_PRIx"=
)",
> -                     spapr->rma_size);
> -        exit(1);
> -    }
> +    spapr->rma_size =3D spapr_rma_size(spapr, &error_fatal);
> =20
>      /* Setup a load limit for the ramdisk leaving room for SLOF and FDT =
*/
>      load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
> @@ -2954,13 +2972,6 @@ static void spapr_machine_init(MachineState *machi=
ne)
>          }
>      }
> =20
> -    if (spapr->rma_size < MIN_RMA_SLOF) {
> -        error_report(
> -            "pSeries SLOF firmware requires >=3D %ldMiB guest RMA (Real =
Mode Area memory)",
> -            MIN_RMA_SLOF / MiB);
> -        exit(1);
> -    }
> -
>      if (kernel_filename) {
>          uint64_t lowaddr =3D 0;
> =20


