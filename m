Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345FEC04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 05:49:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A3D20848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 05:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A3D20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49005 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR9GR-00022g-VG
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 01:49:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hR9Fh-0001Up-CI
	for qemu-devel@nongnu.org; Thu, 16 May 2019 01:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hR95D-00051P-Le
	for qemu-devel@nongnu.org; Thu, 16 May 2019 01:37:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hR95D-00050X-E9
	for qemu-devel@nongnu.org; Thu, 16 May 2019 01:37:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 861E630001EB;
	Thu, 16 May 2019 05:37:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 031C660FAF;
	Thu, 16 May 2019 05:37:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 53B7011385E4; Thu, 16 May 2019 07:37:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190514171545.24961-1-peter.maydell@linaro.org>
Date: Thu, 16 May 2019 07:37:30 +0200
In-Reply-To: <20190514171545.24961-1-peter.maydell@linaro.org> (Peter
	Maydell's message of "Tue, 14 May 2019 18:15:45 +0100")
Message-ID: <878sv7yn6t.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 16 May 2019 05:37:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] hw/core/bus.c: Only the main system bus can
 have no parent
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> In commit 80376c3fc2c38fdd453 in 2010 we added a workaround for
> some qbus buses not being connected to qdev devices -- if the
> bus has no parent object then we register a reset function which
> resets the bus on system reset.
>
> Nearly a decade later, we have now no buses in the tree which
> are created with non-NULL parents, so we can remove the
> workaround and instead just assert that if the bus has a NULL
> parent then it is the main system bus.
>
> (The absence of other parentless buses was confirmed by
> code inspection of all the callsites of qbus_create() and
> qbus_create_inplace() and cross-checked by 'make check'.)

Could we assert(parent || bus == main_system_bus) in qbus_realize()?

Aside: I hate sysbus_get_default().  It creates main_system_bus on first
call, wherever that call may be hiding.  I feel we should create it
explicitly.  I'd then make main_system_bus public, and delete
sysbus_get_default().

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> While I was reviewing Damian's reset patchset I noticed this
> code which meant that we theoretically had multiple 'roots' to
> the set of things being reset, so I wondered what was actually
> using it. It turns out nothing was :-)
>
> Commit 80376c3fc2c38fdd453 also added a TODO in vl.c suggesting
> that there is the wrong place to register the reset function
> which effectively resets the whole system starting at the
> root which is the main system bus:
>    qemu_register_reset(qbus_reset_all_fn, sysbus_get_default());
> I don't understand why vl.c is a bad place to put that, and I'd
> rather not move it to qdev.c (where in qdev.c?) because that
> would reshuffle reset ordering which seems liable to cause
> regressions. So maybe we should just delete that TODO comment?

Hmm.

The one in vl.c arranges to run qbus_reset_all(main_system_bus), which
walks the tree rooted at main_system_bus, resetting its buses and
devices in post-order.

A registry of callbacks to run on certain events is a fine technique.
Relying on registration order, however, is in bad taste.  We should
model dependencies between reset functions explicitly.

That said, we can't ignore dependencies just because we've coded them
badly.

I count more than 100 qemu_register_reset(), and most of them look like
they reset hardware.  Why do devices use qemu_register_reset() instead
of DeviceClass method reset?

Registered handlers run in (implicitly defined) registration order,
reset methods in (explicit) qdev tree post order.  Much better as long
as that's the order we want.

Say we managed to clean up this mess somehow, so reset handler
registration order doesn't matter anymore.  Then moving the
qemu_register_reset() for main_system_bus from main() to wherever we
create main_system_bus would make sense, wouldn't it?

If it does make sense, we should keep the TODO in main(), because it
asks for exactly that.  Perhaps delete "by qdev.c".

> ---
>  hw/core/bus.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/hw/core/bus.c b/hw/core/bus.c
> index e09843f6abe..e50287c2b35 100644
> --- a/hw/core/bus.c
> +++ b/hw/core/bus.c
> @@ -96,10 +96,9 @@ static void qbus_realize(BusState *bus, DeviceState *parent, const char *name)
>          bus->parent->num_child_bus++;
>          object_property_add_child(OBJECT(bus->parent), bus->name, OBJECT(bus), NULL);
>          object_unref(OBJECT(bus));
> -    } else if (bus != sysbus_get_default()) {
> -        /* TODO: once all bus devices are qdevified,
> -           only reset handler for main_system_bus should be registered here. */
> -        qemu_register_reset(qbus_reset_all_fn, bus);
> +    } else {
> +        /* The only bus without a parent is the main system bus */
> +        assert(bus == sysbus_get_default());
>      }
>  }

You delete a qemu_register_reset() because it's unreachable.  The commit
that added it also added a qemu_unregister_reset().  It's now in
bus_unparent().  Why is it still needed?

