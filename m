Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79861C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 15:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40A89217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 15:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="FfuBcIFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A89217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56631 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCYi-0001sH-2U
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 11:56:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hUCXr-0001MO-I3
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hUCXq-0003iH-Ei
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:55:47 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:56846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
	id 1hUCXp-0003fX-US
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:55:46 -0400
Received: from [172.18.11.102] (antfield.tima.u-ga.fr [147.171.129.253])
	by beetle.greensocs.com (Postfix) with ESMTPSA id BCC3596F50;
	Fri, 24 May 2019 15:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
	s=mail; t=1558713340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=BLNPLWaOX6pDSRWfujRG/zNgmkAwKMMVkxpwJ8oIgoo=;
	b=FfuBcIFE04Nex3QjaonMvYlyLD7WGtmolkQD8cP1aI5IyDAYyuYDHeYQ/gTCS7uns49uhO
	4LH5uloI7b/NyQmu6JZzQ/KdejR841wd0TJKgCTw2+ok72MXLN3ebgY02l/rgyjmZD/Ec3
	Lv4Z534sEPxmaJC/V1CWi+U2+KPaHxo=
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190523150543.22676-1-peter.maydell@linaro.org>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <cb02187c-c7a1-4d7c-6a1f-061950c4eb14@greensocs.com>
Date: Fri, 24 May 2019 17:55:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523150543.22676-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
	s=mail; t=1558713340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=BLNPLWaOX6pDSRWfujRG/zNgmkAwKMMVkxpwJ8oIgoo=;
	b=kVWhmkxrGwkXqWt5eAO5KCI01lrV1f2USZgUBtkCVcwJMmHcgfdq9Xa12hQdzeZLQ6LAX3
	ny1Xv5tIJJo1qJUdFdr2pct5oTTloVyHb2aqyHa6KEIj8rFQHcJteUKvQfHmbM/3wpd3vP
	r2FSLOGasbGA/KbTDmNfn6L9uAmRC8Q=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1558713340; a=rsa-sha256; cv=none;
	b=rUJi5PXUB7iXKScVNeqaFk6iTjCeYn35ttu3JSku9PpRtaXE+4EoKTuyn9nXmdNr8tanzo
	nMtc00FjKmSIgBYNZD+uo56mLcu/WdMDCqU9v8Xf13SHJwOsRzpFNDdMH0LqaX0OYhtjnb
	kHw+5T4zYq2ReprXFv+1r7qU32vNuqo=
ARC-Authentication-Results: i=1; ORIGINATING;
	auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH v2] hw/core/bus.c: Only the main system bus
 can have no parent
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/23/19 5:05 PM, Peter Maydell wrote:
> In commit 80376c3fc2c38fdd453 in 2010 we added a workaround for
> some qbus buses not being connected to qdev devices -- if the
> bus has no parent object then we register a reset function which
> resets the bus on system reset (and unregister it when the
> bus is unparented).
> 
> Nearly a decade later, we have now no buses in the tree which
> are created with non-NULL parents, so we can remove the
> workaround and instead just assert that if the bus has a NULL
> parent then it is the main system bus.
> 
> (The absence of other parentless buses was confirmed by
> code inspection of all the callsites of qbus_create() and
> qbus_create_inplace() and cross-checked by 'make check'.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
> v1->v2: clean up also the bus_unparent() code
> ---
>  hw/core/bus.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/core/bus.c b/hw/core/bus.c
> index e09843f6abe..b8839c7268d 100644
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
>  
> @@ -108,18 +107,16 @@ static void bus_unparent(Object *obj)
>      BusState *bus = BUS(obj);
>      BusChild *kid;
>  
> +    /* Only the main system bus has no parent, and that bus is never freed */
> +    assert(bus->parent);
> +
>      while ((kid = QTAILQ_FIRST(&bus->children)) != NULL) {
>          DeviceState *dev = kid->child;
>          object_unparent(OBJECT(dev));
>      }
> -    if (bus->parent) {
> -        QLIST_REMOVE(bus, sibling);
> -        bus->parent->num_child_bus--;
> -        bus->parent = NULL;
> -    } else {
> -        assert(bus != sysbus_get_default()); /* main_system_bus is never freed */
> -        qemu_unregister_reset(qbus_reset_all_fn, bus);
> -    }
> +    QLIST_REMOVE(bus, sibling);
> +    bus->parent->num_child_bus--;
> +    bus->parent = NULL;
>  }
>  
>  void qbus_create_inplace(void *bus, size_t size, const char *typename,
> 

Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>

