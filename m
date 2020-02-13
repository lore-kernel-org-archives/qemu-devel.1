Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B95C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B33D20873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B33D20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Fas-0000Jd-GX
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j2FZo-0007xQ-UI
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:34:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j2FZn-0000dQ-BW
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:34:48 -0500
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:58516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j2FZn-0000Xv-5A
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:34:47 -0500
Received: from player788.ha.ovh.net (unknown [10.110.115.139])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 7E55590611
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 15:34:43 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player788.ha.ovh.net (Postfix) with ESMTPSA id 1661BF5FAA70;
 Thu, 13 Feb 2020 14:34:27 +0000 (UTC)
Date: Thu, 13 Feb 2020 15:34:25 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 1/2] spapr: Disable legacy virtio devices for
 pseries-5.0 and later
Message-ID: <20200213153425.53b5c53c@bahia.lan>
In-Reply-To: <20200213005837.131791-2-david@gibson.dropbear.id.au>
References: <20200213005837.131791-1-david@gibson.dropbear.id.au>
 <20200213005837.131791-2-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 6810287063028570598
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrieekgdeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeekkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.75.45
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
Cc: pair@us.ibm.com, mst@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, clg@kaod.org, mdroth@us.ibm.com, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Feb 2020 11:58:36 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> PAPR specifies a kind of odd, paravirtualized PCI bus, which looks to
> the guess mostly like classic PCI, even if some of the individual
> devices on the bus are PCI Express.  One consequence of that is that
> virtio-pci devices still default to being in transitional mode, though
> legacy mode is now disabled by default on current q35 x86 machine
> types.
> 
> Legacy mode virtio devices aren't really necessary any more, and are
> causing some problems for future changes.  Therefore, for the
> pseries-5.0 machine type (and onwards), switch to modern-only
> virtio-pci devices by default.
> 
> This does mean we no longer support guest kernels prior to 4.0, unless
> they have modern virtio support backported (which some distro kernels
> like that in RHEL7 do).
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index cb220fde45..6e1e467cc6 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -65,6 +65,7 @@
>  
>  #include "hw/pci/pci.h"
>  #include "hw/scsi/scsi.h"
> +#include "hw/virtio/virtio-pci.h"
>  #include "hw/virtio/virtio-scsi.h"
>  #include "hw/virtio/vhost-scsi-common.h"
>  
> @@ -4567,7 +4568,14 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
>   */
>  static void spapr_machine_5_0_class_options(MachineClass *mc)
>  {
> -    /* Defaults for the latest behaviour inherited from the base class */

Hmm... and so it seems we still have to carry this around when we
add a new machine version. At least, that's what I had to do when
adding a dummy 5.1 machine. This is because it is the old machine
type that calls the class_options() function of the new one, not
the other way around.

I was thinking about adapting Michael's patch. Instead of having
a class_options() function that we only call for the latest
machine type, we need a function that sets the default behaviour
and call it for all machine types (which can still change the
behaviour in their own class_options() function).

Something like the following:

-----------------------------------------------------------------------------
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 828e2cc1359a..27e6f79ddc40 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4559,10 +4559,9 @@ static const TypeInfo spapr_machine_info = {
     },
 };
 
-static void spapr_machine_latest_class_options(MachineClass *mc)
+static void spapr_machine_default_class_options(MachineClass *mc)
 {
-    mc->alias = "pseries";
-    mc->is_default = 1;
+    /* Override non ppc specific default behaviour here. */
 }
 
 #define DEFINE_SPAPR_MACHINE(suffix, verstr, latest)                 \
@@ -4570,9 +4569,11 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
                                                     void *data)      \
     {                                                                \
         MachineClass *mc = MACHINE_CLASS(oc);                        \
+        spapr_machine_default_class_options(mc);                     \
         spapr_machine_##suffix##_class_options(mc);                  \
         if (latest) {                                                \
-            spapr_machine_latest_class_options(mc);                  \
+            mc->alias = "pseries";                                   \
+            mc->is_default = 1;                                      \
         }                                                            \
     }                                                                \
     static const TypeInfo spapr_machine_##suffix##_info = {          \
@@ -4591,7 +4592,11 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
  */
 static void spapr_machine_5_0_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    /*
+     * Most defaults for the latest behaviour are inherited from the
+     * base class. If a non ppc specific default behaviour needs to
+     * be overriden, do it in spapr_machine_latest_class_options().
+     */
 }
 
 DEFINE_SPAPR_MACHINE(5_0, "5.0", true);
-----------------------------------------------------------------------------

With the above applied...

> +    /* Most defaults for the latest behaviour are inherited from the
> +     * base class, but we need to override the (non ppc specific)
> +     * default behaviour for virtio */
> +    static GlobalProperty compat[] = {
> +        { TYPE_VIRTIO_PCI, "disable-legacy", "on", },
> +    };
> +
> +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));

... this change would just need to move to spapr_machine_default_class_options()
and any need machine type would have it automatically.

Makes sense ?

>  }
>  
>  DEFINE_SPAPR_MACHINE(5_0, "5.0", true);
> @@ -4578,12 +4586,16 @@ DEFINE_SPAPR_MACHINE(5_0, "5.0", true);
>  static void spapr_machine_4_2_class_options(MachineClass *mc)
>  {
>      SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> +    static GlobalProperty compat[] = {
> +        { TYPE_VIRTIO_PCI, "disable-legacy", "auto" },
> +    };
>  
>      spapr_machine_5_0_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
>      mc->nvdimm_supported = false;
> +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>  }
>  
>  DEFINE_SPAPR_MACHINE(4_2, "4.2", false);


