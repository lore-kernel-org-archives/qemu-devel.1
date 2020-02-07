Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34360C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DEC920838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEC920838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j00gD-0006rL-7t
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 05:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j00ey-0005mq-L5
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:14:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j00ex-0002Q3-Hu
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:14:52 -0500
Received: from 6.mo69.mail-out.ovh.net ([46.105.50.107]:56524)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j00ex-0001vz-CE
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:14:51 -0500
Received: from player716.ha.ovh.net (unknown [10.108.57.16])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id D022583202
 for <qemu-devel@nongnu.org>; Fri,  7 Feb 2020 11:14:41 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player716.ha.ovh.net (Postfix) with ESMTPSA id 6AAB1F0A4DE3;
 Fri,  7 Feb 2020 10:14:37 +0000 (UTC)
Date: Fri, 7 Feb 2020 11:14:34 +0100
From: Greg Kurz <groug@kaod.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] ppc: function to setup latest class options
Message-ID: <20200207111434.75c97bbe@bahia.lan>
In-Reply-To: <20200207064628.1196095-1-mst@redhat.com>
References: <20200207064628.1196095-1-mst@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4076039140646951385
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrheehgddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeduiedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.50.107
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

On Fri, 7 Feb 2020 01:48:02 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> We are going to add more init for the latest machine, so move the setup
> to a function so we don't have to change the DEFINE_SPAPR_MACHINE macro
> each time.
> 

Not sure about the meaning of "change the DEFINE_SPAPR_MACHINE macro" but
yes, if we don't put the additional init there, we would be forced to
move it around each time to the new default machine init.

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 02cf53fc5b..4cf2a992a5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4428,6 +4428,12 @@ static const TypeInfo spapr_machine_info = {
>      },
>  };
>  
> +static void spapr_machine_latest_class_options(MachineClass *mc)
> +{
> +    mc->alias = "pseries";
> +    mc->is_default = 1;
> +}
> +
>  #define DEFINE_SPAPR_MACHINE(suffix, verstr, latest)                 \
>      static void spapr_machine_##suffix##_class_init(ObjectClass *oc, \
>                                                      void *data)      \
> @@ -4435,8 +4441,7 @@ static const TypeInfo spapr_machine_info = {
>          MachineClass *mc = MACHINE_CLASS(oc);                        \
>          spapr_machine_##suffix##_class_options(mc);                  \
>          if (latest) {                                                \
> -            mc->alias = "pseries";                                   \
> -            mc->is_default = 1;                                      \
> +            spapr_machine_latest_class_options(mc);                  \
>          }                                                            \
>      }                                                                \
>      static const TypeInfo spapr_machine_##suffix##_info = {          \


