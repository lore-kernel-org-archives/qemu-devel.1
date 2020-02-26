Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E15C4BA16
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 13:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D56DE24685
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 13:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56DE24685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6woo-0007el-WA
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 08:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j6wnn-0006cY-Jg
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:32:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j6wnl-0002iK-NG
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:32:39 -0500
Received: from 3.mo1.mail-out.ovh.net ([46.105.60.232]:60103)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j6wng-0002du-In
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:32:37 -0500
Received: from player729.ha.ovh.net (unknown [10.110.115.195])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 266DF1B2AF0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 14:32:29 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player729.ha.ovh.net (Postfix) with ESMTPSA id D2E59FEF2A3E;
 Wed, 26 Feb 2020 13:32:11 +0000 (UTC)
Date: Wed, 26 Feb 2020 14:32:09 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v6 13/18] spapr: Don't use weird units for MIN_RMA_SLOF
Message-ID: <20200226143209.1f23e719@bahia.home>
In-Reply-To: <20200224233724.46415-14-david@gibson.dropbear.id.au>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-14-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8317304090605492710
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrleeggdehhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedvledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.60.232
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

On Tue, 25 Feb 2020 10:37:19 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> MIN_RMA_SLOF records the minimum about of RMA that the SLOF firmware
> requires.  It lets us give a meaningful error if the RMA ends up too small,
> rather than just letting SLOF crash.
> 
> It's currently stored as a number of megabytes, which is strange for global
> constants.  Move that megabyte scaling into the definition of the constant
> like most other things use.
> 
> Change from M to MiB in the associated message while we're at it.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 828e2cc135..272a270b7a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -103,7 +103,7 @@
>  #define FW_OVERHEAD             0x2800000
>  #define KERNEL_LOAD_ADDR        FW_MAX_SIZE
>  
> -#define MIN_RMA_SLOF            128UL
> +#define MIN_RMA_SLOF            (128 * MiB)
>  
>  #define PHANDLE_INTC            0x00001111
>  
> @@ -2959,10 +2959,10 @@ static void spapr_machine_init(MachineState *machine)
>          }
>      }
>  
> -    if (spapr->rma_size < (MIN_RMA_SLOF * MiB)) {
> +    if (spapr->rma_size < MIN_RMA_SLOF) {
>          error_report(
> -            "pSeries SLOF firmware requires >= %ldM guest RMA (Real Mode Area memory)",
> -            MIN_RMA_SLOF);
> +            "pSeries SLOF firmware requires >= %ldMiB guest RMA (Real Mode Area memory)",
> +            MIN_RMA_SLOF / MiB);
>          exit(1);
>      }
>  


