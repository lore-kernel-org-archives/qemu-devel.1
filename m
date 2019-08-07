Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C44C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 760112199C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s8KNTiLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760112199C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvNHR-0001p3-NZ
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44516)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hvNEw-0006iX-Mf
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hvNEv-0006Xp-4N
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:48:34 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45120)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hvNEu-0006U7-Rd
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:48:33 -0400
Received: by mail-ot1-x344.google.com with SMTP id x21so12017572otq.12
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xcs8eszuqoo75MPHipKVwOdBKi8vP3Ou/V7cEZfAmDM=;
 b=s8KNTiLFjmIPG8oLZ/GxijanephAJui6nVR+rHZ7VPnbcvCyimWuBAoa8Qnqx8L63P
 pCtDFz4392cPrAKnXAL9JJWEkUKqNkdqtQwz2IEdskBfCGwvvXkkVbTz5HBn4I5b7F/G
 AFISfvOYY7fg7OrsbZNMG4cwKQOohplmr+yJQyaZvySAxPL9a47sAPxZKEd/P3VT/zp2
 RrZrqlxg1Rdn7Kf3vy1i/DV0/R8X9wpkGGfht9pGalTp7VF+5OMTpGykhjSbERN3uB+c
 NJhmxLQK9nEYsPVlC+E+R1lAU/whSR1Q+TjKlUMy2hMtKbIUP1ISNDvBb/mM3NqmQE8Q
 kf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xcs8eszuqoo75MPHipKVwOdBKi8vP3Ou/V7cEZfAmDM=;
 b=VT72uDiAndgO9J8Xs2hZvUSEOjH0qrhrXVsAEFwsMR0Br/FHtC/vAYGMpyJITrAshe
 9UyonvbBpNv96PhlBZzZIModr3+B5v1/+NqVw/vi/CrbnUBShhfW9VMgtMBviE/qsJwf
 RAGqfWkKJGqD4GxF/AzgMhigyTZ4nlOtSeT0A4pnJL7BQ84H6OzBee5ATRG25lfR9+xF
 By159cZUxj1UmD+GRoGVn+cBs4sbNLch8Y2igCCvr7ByROQHixrVz+wON11mEvquiyRK
 ao5GsoWwCSFT6CaS8WZkXi/CLJQZbYf9uJVdTm3l3Z8mD14mLlFFhiBOyGhcMJ/QGYpe
 bHLA==
X-Gm-Message-State: APjAAAUvInEF8KzuNX+7zLy4mQQdxmGRQMQpfptCmOafBk0drFEdaHBm
 y8ykSJHjDDbuf6W2/ThbWLjt75K+BHXwfkZzIhpD+A==
X-Google-Smtp-Source: APXvYqz5d+EKLWKcvLMUz9rjZAkkB1Osu9CC/3cwO6fMJxQSa0GjSxmlmsJUIwKnaZspasmzrZ8doG0tUQ3mk9RXzWc=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr235392oie.48.1565189308794;
 Wed, 07 Aug 2019 07:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-6-damien.hedde@greensocs.com>
In-Reply-To: <20190729145654.14644-6-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2019 15:48:18 +0100
Message-ID: <CAFEAcA9+ivkBKgZ83qVE8LKuyQvng6m_85oyj6G1kx0bu86NUQ@mail.gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v3 05/33] Switch to new api in qdev/bus
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
Cc: Fam Zheng <fam@euphon.net>, Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jul 2019 at 15:58, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Deprecate old reset apis and make them use the new one while they
> are still used somewhere.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  hw/core/qdev.c         | 22 +++-------------------
>  include/hw/qdev-core.h | 28 ++++++++++++++++++++++------
>  2 files changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 559ced070d..e9e5f2d5f9 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -312,25 +312,9 @@ static void device_foreach_reset_child(Object *obj, void (*func)(Object *))
>      }
>  }
>
> -static int qdev_reset_one(DeviceState *dev, void *opaque)
> -{
> -    device_legacy_reset(dev);
> -
> -    return 0;
> -}
> -
> -static int qbus_reset_one(BusState *bus, void *opaque)
> -{
> -    BusClass *bc = BUS_GET_CLASS(bus);
> -    if (bc->reset) {
> -        bc->reset(bus);
> -    }
> -    return 0;
> -}
> -
>  void qdev_reset_all(DeviceState *dev)
>  {
> -    qdev_walk_children(dev, NULL, NULL, qdev_reset_one, qbus_reset_one, NULL);
> +    device_reset(dev, false);
>  }
>
>  void qdev_reset_all_fn(void *opaque)
> @@ -340,7 +324,7 @@ void qdev_reset_all_fn(void *opaque)
>
>  void qbus_reset_all(BusState *bus)
>  {
> -    qbus_walk_children(bus, NULL, NULL, qdev_reset_one, qbus_reset_one, NULL);
> +    bus_reset(bus, false);
>  }
>
>  void qbus_reset_all_fn(void *opaque)
> @@ -922,7 +906,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>              }
>          }
>          if (dev->hotplugged) {
> -            device_legacy_reset(dev);
> +            device_reset(dev, true);
>          }
>          dev->pending_deleted_event = false;

The other changes here don't change the semantics, but this
one does -- previously we were only resetting this specific
device and now we're resetting both the device and its children.
I think it belongs as its own patch in with the other
"remove device_legacy_reset call" patches.

>
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index eeb75611c8..1670ae41bb 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -109,6 +109,11 @@ typedef struct DeviceClass {
>      bool hotpluggable;
>
>      /* callbacks */
> +    /*
> +     * Reset method here is deprecated and replaced by methods in the
> +     * resettable class interface to implement a multi-phase reset.
> +     * TODO: remove once every reset callback is unused
> +     */
>      DeviceReset reset;
>      DeviceRealize realize;
>      DeviceUnrealize unrealize;
> @@ -455,19 +460,22 @@ bool bus_is_resetting(BusState *bus);
>   */
>  bool bus_is_reset_cold(BusState *bus);
>
> -void qdev_reset_all(DeviceState *dev);
> -void qdev_reset_all_fn(void *opaque);
> -
>  /**
> - * @qbus_reset_all:
> - * @bus: Bus to be reset.
> + * qbus/qdev_reset_all:
> + * @bus/dev: Bus/Device to be reset.
>   *
> - * Reset @bus and perform a bus-level ("hard") reset of all devices connected
> + * Reset @bus/dev and perform a bus-level reset of all devices/buses connected
>   * to it, including recursive processing of all buses below @bus itself.  A
>   * hard reset means that qbus_reset_all will reset all state of the device.
>   * For PCI devices, for example, this will include the base address registers
>   * or configuration space.
> + *
> + * Theses functions are deprecated, please use device/bus_reset or

"these"

> + * resettable_reset_* instead
> + * TODO: remove them when all occurence are removed

"occurrences" (two 'r's, plural with 's'), here and below

>   */

The comment here says that qbus_reset_all() does a "hard" reset,
which presumably is equivalent to a 'cold' reset, but the
code in our new implementation passes cold = false.

> +void qdev_reset_all(DeviceState *dev);
> +void qdev_reset_all_fn(void *opaque);
>  void qbus_reset_all(BusState *bus);
>  void qbus_reset_all_fn(void *opaque);
>
> @@ -489,9 +497,17 @@ void qdev_machine_init(void);
>   * device_legacy_reset:
>   *
>   * Reset a single device (by calling the reset method).
> + *
> + * This function is deprecated, please use device_reset() instead.
> + * TODO: remove the function when all occurences are removed.
>   */
>  void device_legacy_reset(DeviceState *dev);
>
> +/**
> + * device_class_set_parent_reset:
> + * TODO: remove the function when DeviceClass's reset method
> + * is not used anymore.
> + */
>  void device_class_set_parent_reset(DeviceClass *dc,
>                                     DeviceReset dev_reset,
>                                     DeviceReset *parent_reset);
> --
> 2.22.0

thanks
-- PMM

