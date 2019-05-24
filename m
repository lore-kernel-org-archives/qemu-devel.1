Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0D2C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:45:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10F320879
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10F320879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58084 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUEG7-0008N7-Ug
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 13:45:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hUEFO-0007y6-Dc
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hUEFN-0008Tv-7N
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:44:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hUEFN-0008TI-1h
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:44:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id s17so10855014wru.3
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 10:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=+oPttmyQhfhhpHMfE0Nfwvs2f+u3sK9tDWbLls/gdpE=;
	b=ARA91Gt5hGRQoCpo23h7UPNCDnmP/hUh8gyKhIKATNJtJeggB+yr9CdTT7l32XkefL
	Z54LWaDrZzCqttmBRirrAh1LmjbSN0Wh5gFfEsi9CykNPHH8MXMkibS76BWfme7fn6m3
	6lrwMLoR9uDJq0yNOKj0nRqpnEP4X0oEwPLKnQ3Luy7XKAEkwEjher40AufW0HtCADv9
	DgN64aBrXzFUPknKJD+KxRTTlHZbPnOpssxnuXYx6ys5cxKMNtrmGFJsXA4P4C0qYK+K
	SlX/7o55eV3oZ85gnZlKpY7e33QLQz/yFZafxaOj0kZF6xnxSut0LMqxZUuCfze9y/8Q
	TMMQ==
X-Gm-Message-State: APjAAAUaGZEb+sK2GozoVTHCf7Uo0nMI+3RHNxX6tRyn2mhI2K904EUh
	vBsyI0omjrU7+COXAwxkI6gYpA==
X-Google-Smtp-Source: APXvYqy6wr2iQmow0OCaspEN/mh2Op+hHP1YWtB9aw/P+aTT6KB7yn/iQSEv6fsWledkfo5h6o/o8g==
X-Received: by 2002:adf:df08:: with SMTP id y8mr5402024wrl.258.1558719887786; 
	Fri, 24 May 2019 10:44:47 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id v5sm5686875wra.83.2019.05.24.10.44.47
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 10:44:47 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190523150543.22676-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1e3f682b-ea42-a653-1002-4202c9c5a40f@redhat.com>
Date: Fri, 24 May 2019 19:44:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523150543.22676-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
	Markus Armbruster <armbru@redhat.com>
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

