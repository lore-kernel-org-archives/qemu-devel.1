Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ED6C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 20:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3AB02073B
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 20:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3AB02073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jePMi-0001FV-QY
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 16:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jePLw-0000nR-Un
 for qemu-devel@nongnu.org; Thu, 28 May 2020 16:42:12 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:51098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jePLt-0001ff-Kt
 for qemu-devel@nongnu.org; Thu, 28 May 2020 16:42:10 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 7949A7482D3;
 Thu, 28 May 2020 22:41:55 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 576207482CE; Thu, 28 May 2020 22:41:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 563627482CD;
 Thu, 28 May 2020 22:41:55 +0200 (CEST)
Date: Thu, 28 May 2020 22:41:55 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: USB pass-through problems
In-Reply-To: <20200528132850.gtxzkvor2u5kykqi@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.22.395.2005282236580.91944@zero.eik.bme.hu>
References: <alpine.BSF.2.22.395.2005272129480.93454@zero.eik.bme.hu>
 <20200528064039.yw5in3whgjvlni4z@sirius.home.kraxel.org>
 <alpine.BSF.2.22.395.2005281128460.96126@zero.eik.bme.hu>
 <20200528132850.gtxzkvor2u5kykqi@sirius.home.kraxel.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 May 2020, Gerd Hoffmann wrote:
>>>> #2  0x00007f23e8bfbb13 in libusb_handle_events_timeout_completed () at /lib64/libusb-1.0.so.0
>>>> #3  0x000055e09854b7da in usb_host_abort_xfers (s=0x55e09b036dd0) at hw/usb/host-libusb.c:963
>
>>> Hmm, does reverting 76d0a9362c6a6a7d88aa18c84c4186c9107ecaef change
>>> behavior?
>>
>> Yes it does. Reverting that patch fixes the problem, no hang and device
>> reconnects without problem.
>
> Hmm.  Looks like an libusb bug to me, it seems to not call the
> completion callback for the canceled transfers (which it should do
> according to the docs), so qemu waits for this to happen forever.
>
> We can certainly add a limit here (see below), question is how to
> handle the canceled but not completed transfers then.  I suspect
> we have to leak them to make sure we don't get use-after-free
> access from libusb ...

Also works,

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>

Got only one "usb_host_abort_xfers: leaking usb request" message.

Regards,
BALATON Zoltan

> cheers,
>  Gerd
>
> diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> index e28441379d99..4c3b5b140d9d 100644
> --- a/hw/usb/host-libusb.c
> +++ b/hw/usb/host-libusb.c
> @@ -944,30 +944,45 @@ fail:
>         libusb_close(s->dh);
>         s->dh = NULL;
>         s->dev = NULL;
>     }
>     return -1;
> }
>
> static void usb_host_abort_xfers(USBHostDevice *s)
> {
>     USBHostRequest *r, *rtmp;
> +    int limit = 100;
>
>     QTAILQ_FOREACH_SAFE(r, &s->requests, next, rtmp) {
>         usb_host_req_abort(r);
>     }
>
>     while (QTAILQ_FIRST(&s->requests) != NULL) {
>         struct timeval tv;
>         memset(&tv, 0, sizeof(tv));
>         tv.tv_usec = 2500;
>         libusb_handle_events_timeout(ctx, &tv);
> +        if (--limit == 0) {
> +            /*
> +             * Don't wait forever for libusb calling the complete
> +             * callback (which will unlink and free the request).
> +             *
> +             * Leaking memory here, to make sure libusb will not
> +             * access memory which we have released already.
> +             */
> +            QTAILQ_FOREACH_SAFE(r, &s->requests, next, rtmp) {
> +                fprintf(stderr, "%s: leaking usb request %p\n", __func__, r);
> +                QTAILQ_REMOVE(&s->requests, r, next);
> +            }
> +            return;
> +        }
>     }
> }
>
> static int usb_host_close(USBHostDevice *s)
> {
>     USBDevice *udev = USB_DEVICE(s);
>
>     if (s->dh == NULL) {
>         return -1;
>     }
>
>

