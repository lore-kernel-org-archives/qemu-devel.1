Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C08CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112872074B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112872074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw1Ee-0003dF-CJ
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 06:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jw1Dv-0002os-Qs
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:34:43 -0400
Received: from 3.mo179.mail-out.ovh.net ([178.33.251.175]:57865)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jw1Dt-0001lK-8S
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:34:43 -0400
Received: from player756.ha.ovh.net (unknown [10.110.208.220])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id D7B8B172E9C
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 12:34:38 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player756.ha.ovh.net (Postfix) with ESMTPSA id 09999138F9FD0;
 Thu, 16 Jul 2020 10:34:33 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006c0787347-977c-43f8-bb79-59c6d966bdb4,82226C5D462F885DC4F8BFF1B5769E1A03475668)
 smtp.auth=groug@kaod.org
Date: Thu, 16 Jul 2020 12:34:30 +0200
From: Greg Kurz <groug@kaod.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] spapr_pci: Robustify support of PCI bridges
Message-ID: <20200716123430.12918da6@bahia.lan>
In-Reply-To: <20200716025009-mutt-send-email-mst@kernel.org>
References: <159431476748.407044.16711294833569014964.stgit@bahia.lan>
 <20200716025009-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3260043182197152217
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrfeeggddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehkefhtdehgeehheejledufeekhfdvleefvdeihefhkefhudffhfeuuedvffdthfenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeehiedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=178.33.251.175; envelope-from=groug@kaod.org;
 helo=3.mo179.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 06:34:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jul 2020 02:53:07 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Jul 09, 2020 at 07:12:47PM +0200, Greg Kurz wrote:
> > Some recent error handling cleanups unveiled issues with our support of
> > PCI bridges:
> > 
> > 1) QEMU aborts when using non-standard PCI bridge types,
> >    unveiled by commit 7ef1553dac "spapr_pci: Drop some dead error handling"
> > 
> > $ qemu-system-ppc64 -M pseries -device pcie-pci-bridge
> > Unexpected error in object_property_find() at qom/object.c:1240:
> > qemu-system-ppc64: -device pcie-pci-bridge: Property '.chassis_nr' not found
> > Aborted (core dumped)
> > 
> > This happens because we assume all PCI bridge types to have a "chassis_nr"
> > property. This property only exists with the standard PCI bridge type
> > "pci-bridge" actually. We could possibly revert 7ef1553dac but it seems
> > much simpler to check the presence of "chassis_nr" earlier.
> > 
> > 2) QEMU abort if same "chassis_nr" value is used several times,
> >    unveiled by commit d2623129a7de "qom: Drop parameter @errp of
> >    object_property_add() & friends"
> > 
> > $ qemu-system-ppc64 -M pseries -device pci-bridge,chassis_nr=1 \
> >                         -device pci-bridge,chassis_nr=1
> > Unexpected error in object_property_try_add() at qom/object.c:1167:
> > qemu-system-ppc64: -device pci-bridge,chassis_nr=1: attempt to add duplicate property '40000100' to object (type 'container')
> > Aborted (core dumped)
> > 
> > This happens because we assume that "chassis_nr" values are unique, but
> > nobody enforces that and we end up generating duplicate DRC ids. The PCI
> > code doesn't really care for duplicate "chassis_nr" properties since it
> > is only used to initialize the "Chassis Number Register" of the bridge,
> > with no functional impact on QEMU. So, even if passing the same value
> > several times might look weird, it never broke anything before, so
> > I guess we don't necessarily want to enforce strict checking in the PCI
> > code now.
> > 
> > Workaround both issues in the PAPR code: check that the bridge has a
> > unique and non null "chassis_nr" when plugging it into its parent bus.
> > 
> > Fixes: 05929a6c5dfe ("spapr: Don't use bus number for building DRC ids")
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> 
> 
> 
> > ---
> >  hw/ppc/spapr_pci.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> > 
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 329002ac040e..09d52ef7954d 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1480,6 +1480,57 @@ static void spapr_pci_bridge_plug(SpaprPhbState *phb,
> >      add_drcs(phb, bus);
> >  }
> >  
> > +/* Returns non-zero if the value of "chassis_nr" is already in use */
> > +static int check_chassis_nr(Object *obj, void *opaque)
> > +{
> > +    int new_chassis_nr =
> > +        object_property_get_uint(opaque, "chassis_nr", &error_abort);
> > +    int chassis_nr =
> > +        object_property_get_uint(obj, "chassis_nr", NULL);
> > +
> > +    if (!object_dynamic_cast(obj, TYPE_PCI_BRIDGE)) {
> > +        return 0;
> > +    }
> > +
> > +    /* Skip unsupported bridge types */
> > +    if (!chassis_nr) {
> > +        return 0;
> > +    }
> > +
> > +    /* Skip self */
> > +    if (obj == opaque) {
> > +        return 0;
> > +    }
> > +
> > +    return chassis_nr == new_chassis_nr;
> > +}
> > +
> > +static bool bridge_has_valid_chassis_nr(Object *bridge, Error **errp)
> 
> I would rename this "bridge_has_unique_chassis_nr".
> 

Right.

> > +{
> > +    int chassis_nr =
> > +        object_property_get_uint(bridge, "chassis_nr", NULL);
> > +
> > +    /*
> > +     * slotid_cap_init() already ensures that "chassis_nr" isn't null for
> > +     * standard PCI bridges, so this really tells if "chassis_nr" is present
> > +     * or not.
> > +     */
> > +    if (!chassis_nr) {
> > +        error_setg(errp, "PCI Bridge lacks a \"chassis_nr\" property");
> > +        error_append_hint(errp, "Try -device pci-bridge instead.\n");
> > +        return false;
> > +    }
> > +
> > +    /* We want unique values for "chassis_nr" */
> > +    if (object_child_foreach_recursive(object_get_root(), check_chassis_nr,
> > +                                       bridge)) {
> > +        error_setg(errp, "Bridge chassis %d already in use", chassis_nr);
> > +        return false;
> > +    }
> > +
> > +    return true;
> > +}
> > +
> >  static void spapr_pci_plug(HotplugHandler *plug_handler,
> >                             DeviceState *plugged_dev, Error **errp)
> >  {
> > @@ -1491,6 +1542,12 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
> >      PCIBus *bus = PCI_BUS(qdev_get_parent_bus(DEVICE(pdev)));
> >      uint32_t slotnr = PCI_SLOT(pdev->devfn);
> >  
> > +    if (pc->is_bridge) {
> > +        if (!bridge_has_valid_chassis_nr(OBJECT(plugged_dev), errp)) {
> > +            return;
> > +        }
> > +    }
> > +
> 
> 
> Add a comment here explaning DRC ids are generated from chassis_nr and
> these need to be unique?
> 

Makes sense.

> 
> >      /* if DR is disabled we don't need to do anything in the case of
> >       * hotplug or coldplug callbacks
> >       */
> >
> 
> With above fixed:
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>  
> Feel free to merge.
> 

Thanks !

