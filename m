Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4BCC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C21206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C21206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw56H-0003vM-Uc
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jw55e-0003Pd-T9
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:42:26 -0400
Received: from 1.mo6.mail-out.ovh.net ([46.105.56.136]:43809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jw55b-0008H9-6W
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:42:26 -0400
Received: from player798.ha.ovh.net (unknown [10.110.171.173])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 7D1EA21FA6C
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 16:42:12 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player798.ha.ovh.net (Postfix) with ESMTPSA id B83481481743B;
 Thu, 16 Jul 2020 14:42:01 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002bf28cd65-9b19-4f5a-91ad-9c4e97feb9ee,82226C5D462F885DC4F8BFF1B5769E1A03475668)
 smtp.auth=groug@kaod.org
Date: Thu, 16 Jul 2020 16:42:00 +0200
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] spapr_pci: Robustify support of PCI bridges
Message-ID: <20200716164200.2bea2977@bahia.lan>
In-Reply-To: <87eepbmudt.fsf@dusky.pond.sub.org>
References: <159431476748.407044.16711294833569014964.stgit@bahia.lan>
 <20200716044540.GL93134@umbus.fritz.box>
 <87eepbmudt.fsf@dusky.pond.sub.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7441072487532697998
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrfeeggdektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehkefhtdehgeehheejledufeekhfdvleefvdeihefhkefhudffhfeuuedvffdthfenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.56.136; envelope-from=groug@kaod.org;
 helo=1.mo6.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 10:42:13
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jul 2020 16:01:18 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> David Gibson <david@gibson.dropbear.id.au> writes:
> 
> > On Thu, Jul 09, 2020 at 07:12:47PM +0200, Greg Kurz wrote:
> >> Some recent error handling cleanups unveiled issues with our support of
> >> PCI bridges:
> >> 
> >> 1) QEMU aborts when using non-standard PCI bridge types,
> >>    unveiled by commit 7ef1553dac "spapr_pci: Drop some dead error handling"
> >> 
> >> $ qemu-system-ppc64 -M pseries -device pcie-pci-bridge
> >> Unexpected error in object_property_find() at qom/object.c:1240:
> >> qemu-system-ppc64: -device pcie-pci-bridge: Property '.chassis_nr' not found
> >> Aborted (core dumped)
> >
> > Oops, I thought we had a check that we actually had a "pci-bridge"
> > device before continuing with the hotplug, but I guess not.
> >
> >> This happens because we assume all PCI bridge types to have a "chassis_nr"
> >> property. This property only exists with the standard PCI bridge type
> >> "pci-bridge" actually. We could possibly revert 7ef1553dac but it seems
> >> much simpler to check the presence of "chassis_nr" earlier.
> >
> > Hrm, right, 7ef1553dac was not really correct since add_drcs() really
> > can fail.
> 
> Right.  I failed to see that we can run into a bridge without a
> "chassis_nr" here.
> 
> >> 2) QEMU abort if same "chassis_nr" value is used several times,
> >>    unveiled by commit d2623129a7de "qom: Drop parameter @errp of
> >>    object_property_add() & friends"
> >> 
> >> $ qemu-system-ppc64 -M pseries -device pci-bridge,chassis_nr=1 \
> >>                         -device pci-bridge,chassis_nr=1
> >> Unexpected error in object_property_try_add() at qom/object.c:1167:
> >> qemu-system-ppc64: -device pci-bridge,chassis_nr=1: attempt to add duplicate property '40000100' to object (type 'container')
> >> Aborted (core dumped)
> 
> Before d2623129a7de, the error got *ignored* in
> spapr_dr_connector_new():
> 
>     SpaprDrc *spapr_dr_connector_new(Object *owner, const char *type,
>                                              uint32_t id)
>     {
>         SpaprDrc *drc = SPAPR_DR_CONNECTOR(object_new(type));
>         char *prop_name;
> 
>         drc->id = id;
>         drc->owner = owner;
>         prop_name = g_strdup_printf("dr-connector[%"PRIu32"]",
>                                     spapr_drc_index(drc));
>         object_property_add_child(owner, prop_name, OBJECT(drc), &error_abort);
>         object_unref(OBJECT(drc));
> --->    object_property_set_bool(OBJECT(drc), true, "realized", NULL);
>         g_free(prop_name);
> 
>         return drc;
>     }
> 
> I doubt that's healthy.
> 

This isn't. The object_property_set_bool() was later converted to
qdev_realize() (thanks again for the cleanups!) but the problem
remains. Realize can fail and I see now reason we don't do proper
error handling when it comes to the DRCs.

I'll look into fixing that.

> >> This happens because we assume that "chassis_nr" values are unique, but
> >> nobody enforces that and we end up generating duplicate DRC ids. The PCI
> >> code doesn't really care for duplicate "chassis_nr" properties since it
> >> is only used to initialize the "Chassis Number Register" of the bridge,
> >> with no functional impact on QEMU. So, even if passing the same value
> >> several times might look weird, it never broke anything before, so
> >> I guess we don't necessarily want to enforce strict checking in the PCI
> >> code now.
> >
> > Yeah, I guess.  I'm pretty sure that the chassis number of bridges is
> > supposed to be system-unique (well, unique within the PCI domain at
> > least, I guess) as part of the hardware spec.  So specifying multiple
> > chassis ids the same is a user error, but we need a better failure
> > mode.
> >
> >> Workaround both issues in the PAPR code: check that the bridge has a
> >> unique and non null "chassis_nr" when plugging it into its parent bus.
> >>
> >> Fixes: 05929a6c5dfe ("spapr: Don't use bus number for building DRC ids")
> >
> > Arguably, it's really fixing 7ef1553dac.
> 
> I agree 7ef1553dac broke the "use a bridge that doesn't have property
> 'chassis_nr' case.
> 
> I suspect the "duplicate chassis_nr" case has always been broken, and
> d2623129a7de merely uncovered it.
> 

Yes.

> If we can trigger the abort with hot-plug, then d2623129a7de made things
> materially worse (new way to accidentally kill your guest and maybe lose
> data), and I'd add a Fixes: blaming it.
> 

Yes it does.

David,

Maybe consider folding a third Fixes: tag into this patch ?

> >> Reported-by: Thomas Huth <thuth@redhat.com>
> >> Signed-off-by: Greg Kurz <groug@kaod.org>
> >
> > I had a few misgivings about the details of this, but I think I've
> > convinced myself they're fine.  There's a couple of things I'd like to
> > polish, but I'll do that as a follow up.
> 


