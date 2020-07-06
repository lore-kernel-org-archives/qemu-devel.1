Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4237C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 14:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 754112070C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 14:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754112070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsSLw-0005F5-Je
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 10:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jsSLI-0004jn-2e
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 10:43:36 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:42702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jsSLF-0004wJ-EX
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 10:43:35 -0400
Received: from player759.ha.ovh.net (unknown [10.110.115.29])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 5F9889824B
 for <qemu-devel@nongnu.org>; Mon,  6 Jul 2020 16:43:30 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player759.ha.ovh.net (Postfix) with ESMTPSA id 51215141EE48E;
 Mon,  6 Jul 2020 14:43:22 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R0069c9ae004-2bbc-44ed-b5ec-228a6e6c65cf,C4ABCEF356A601883B7DEB1AA4190402CFF29AFD)
 smtp.auth=groug@kaod.org
Date: Mon, 6 Jul 2020 16:43:21 +0200
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 03/44] qdev: Use returned bool to check for
 qdev_realize() etc. failure
Message-ID: <20200706164321.30de6339@bahia.lan>
In-Reply-To: <87k0zganbc.fsf@dusky.pond.sub.org>
References: <20200706080950.403087-1-armbru@redhat.com>
 <20200706080950.403087-4-armbru@redhat.com>
 <20200706120718.70c37bc0@bahia.lan>
 <87k0zganbc.fsf@dusky.pond.sub.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4076039139545815438
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudefgdekvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehkefhtdehgeehheejledufeekhfdvleefvdeihefhkefhudffhfeuuedvffdthfenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeehledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.73.241; envelope-from=groug@kaod.org;
 helo=10.mo69.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 10:43:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 06 Jul 2020 13:35:19 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Greg Kurz <groug@kaod.org> writes:
> 
> > On Mon,  6 Jul 2020 10:09:09 +0200
> > Markus Armbruster <armbru@redhat.com> wrote:
> >
> >> Convert
> >> 
> >>     foo(..., &err);
> >>     if (err) {
> >>         ...
> >>     }
> >> 
> >> to
> >> 
> >>     if (!foo(..., &err)) {
> >>         ...
> >>     }
> >> 
> >> for qdev_realize(), qdev_realize_and_unref(), qbus_realize() and their
> >> wrappers isa_realize_and_unref(), pci_realize_and_unref(),
> >> sysbus_realize(), sysbus_realize_and_unref(), usb_realize_and_unref().
> >> Coccinelle script:
> >> 
> >>     @@
> >>     identifier fun = {
> >>         isa_realize_and_unref, pci_realize_and_unref, qbus_realize,
> >>         qdev_realize, qdev_realize_and_unref, sysbus_realize,
> >>         sysbus_realize_and_unref, usb_realize_and_unref
> >>     };
> >>     expression list args, args2;
> >>     typedef Error;
> >>     Error *err;
> >>     @@
> >>     -    fun(args, &err, args2);
> >>     -    if (err)
> >>     +    if (!fun(args, &err, args2))
> >>          {
> >>              ...
> >>          }
> >> 
> >> Chokes on hw/arm/musicpal.c's lcd_refresh() with the unhelpful error
> >> message "no position information".  Nothing to convert there; skipped.
> >> 
> >> Fails to convert hw/arm/armsse.c, because Coccinelle gets confused by
> >> ARMSSE being used both as typedef and function-like macro there.
> >> Converted manually.
> >> 
> >> A few line breaks tidied up manually.
> >> 
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> Reviewed-by: Eric Blake <eblake@redhat.com>
> >> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> ---
> >
> > FWIW I had posted an R-b for this patch in v1 (20200629124037.2b9a269e@bahia.lan).
> 
> When I sliced and diced my patches for v2, I dropped R-bys for patches
> substantially altered.  This one was borderline: the patch does strictly
> less, and the work it no longer does us done by later patches.
> 
> Example: v1's first hunk
> 
>     diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
>     index 52e0d83760..3e45aa4141 100644
>     --- a/hw/arm/allwinner-a10.c
>     +++ b/hw/arm/allwinner-a10.c
>     @@ -72,17 +72,12 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
>      {
>          AwA10State *s = AW_A10(dev);
>          SysBusDevice *sysbusdev;
>     -    Error *err = NULL;
> 
>     -    qdev_realize(DEVICE(&s->cpu), NULL, &err);
>     -    if (err != NULL) {
>     -        error_propagate(errp, err);
>     +    if (!qdev_realize(DEVICE(&s->cpu), NULL, errp)) {
>              return;
>          }
> 
>     -    sysbus_realize(SYS_BUS_DEVICE(&s->intc), &err);
>     -    if (err != NULL) {
>     -        error_propagate(errp, err);
>     +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->intc), errp)) {
>              return;
>          }
>          sysbusdev = SYS_BUS_DEVICE(&s->intc);
> 
> became
> 
>     diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
>     index 52e0d83760..e1acffe5f6 100644
>     --- a/hw/arm/allwinner-a10.c
>     +++ b/hw/arm/allwinner-a10.c
>     @@ -74,14 +74,12 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
>          SysBusDevice *sysbusdev;
>          Error *err = NULL;
> 
>     -    qdev_realize(DEVICE(&s->cpu), NULL, &err);
>     -    if (err != NULL) {
>     +    if (!qdev_realize(DEVICE(&s->cpu), NULL, &err)) {
>              error_propagate(errp, err);
>              return;
>          }
> 
>     -    sysbus_realize(SYS_BUS_DEVICE(&s->intc), &err);
>     -    if (err != NULL) {
>     +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->intc), &err)) {
>              error_propagate(errp, err);
>              return;
>          }
> 
> 
> in v2 and v3.  The two error_propagate() and the local variable now go
> away only in PATCH v3 33.
> 
> Would you like me to record your R-by for the patch's current version?
> 

I've reviewed it again, so, yes, please do.

