Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB17C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 17:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF483216C4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 17:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF483216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51291 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRgDq-0002cv-EV
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 13:00:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hRgCE-0001VA-CH
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hRg8b-0004CG-IR
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:55:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hRg8a-00045a-Ug
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:55:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9675581DE6;
	Fri, 17 May 2019 16:55:08 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F9596085B;
	Fri, 17 May 2019 16:54:59 +0000 (UTC)
Date: Fri, 17 May 2019 17:54:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190517165457.GC7070@work-vm>
References: <20190130073426.11525-1-kraxel@redhat.com>
	<20190130073426.11525-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130073426.11525-2-kraxel@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 17 May 2019 16:55:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 1/8] usb: assign unique serial numbers to
 hid devices
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Gerd Hoffmann (kraxel@redhat.com) wrote:
> Windows guests have trouble dealing with usb devices having identical
> serial numbers.  So, assign unique serial numbers to usb hid devices.
> All other usb devices have this already.
> 
> In the past the fixed serial number has been used to indicate working
> remote setup to linux guests.  Here is a bit of history:
> 
>  * First there was nothing.
>  * Then I added a rule to udev checking for serial == 42.
>    (this is in rhel-6).
>  * Then systemd + udev merged.
>  * Then I changed the rule to check for serial != 1 instead, so we can
>    use any serial but "1" which is the one the old broken devices had
>    (this is in rhel-7).  March 2014 in upstream systemd.
>  * Then all usb power management rules where dropped from systemd (June
>    2015).  Which I figured today (Sept 2018), after wondering that the
>    rules are gone in fedora 28.
> 
> So, three years ago the serial number check was dropped upstream, yet I
> hav't seen a single report about autosuspend issues (or cpu usage for
> usb emulation going up, which is the typical symtom).
> 
> So I figured I can stop worring that changing the serial number will
> break things and just do it.
> 
> And even if it turns out autosuspend is still an issue:  I think
> meanwhile we can really stop worrying about guests running in old qemu
> versions with broken usb suspend (fixed in 0.13 !).  If needed we can
> enable autosuspend unconditionally in guests.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Message-id: 20190110125108.22834-1-kraxel@redhat.com
> ---
>  hw/core/machine.c |  3 +++
>  hw/usb/dev-hid.c  | 26 +++++++++++++++-----------
>  2 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 2629515363..077fbd182a 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -30,6 +30,9 @@ GlobalProperty hw_compat_3_1[] = {
>      { "memory-backend-memfd", "x-use-canonical-path-for-ramblock-id", "true" },
>      { "tpm-crb", "ppi", "false" },
>      { "tpm-tis", "ppi", "false" },
> +    { "usb-kbd", "serial", "42" },
> +    { "usb-mouse", "serial", "42" },
> +    { "usb-kbd", "serial", "42" },

Hi Gerd,
  There's a copy-pasteism there that happened when you squashed
it down to the new format; you've got the usb-kbd twice
as opposed to having the usb-tablet in there.

Hmm, now how do we fix that? That means if we fix that
now then the usb 3-1 machine type in 4.1 would be the same as
3.1 but different from 4.0; which I suspect is the right fix
at this time.

Dave

>  };
>  const size_t hw_compat_3_1_len = G_N_ELEMENTS(hw_compat_3_1);
>  
> diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
> index 90cd745f06..f9ea3033a1 100644
> --- a/hw/usb/dev-hid.c
> +++ b/hw/usb/dev-hid.c
> @@ -61,10 +61,13 @@ enum {
>      STR_PRODUCT_MOUSE,
>      STR_PRODUCT_TABLET,
>      STR_PRODUCT_KEYBOARD,
> -    STR_SERIALNUMBER,
> +    STR_SERIAL_COMPAT,
>      STR_CONFIG_MOUSE,
>      STR_CONFIG_TABLET,
>      STR_CONFIG_KEYBOARD,
> +    STR_SERIAL_MOUSE,
> +    STR_SERIAL_TABLET,
> +    STR_SERIAL_KEYBOARD,
>  };
>  
>  static const USBDescStrings desc_strings = {
> @@ -72,10 +75,13 @@ static const USBDescStrings desc_strings = {
>      [STR_PRODUCT_MOUSE]    = "QEMU USB Mouse",
>      [STR_PRODUCT_TABLET]   = "QEMU USB Tablet",
>      [STR_PRODUCT_KEYBOARD] = "QEMU USB Keyboard",
> -    [STR_SERIALNUMBER]     = "42", /* == remote wakeup works */
> +    [STR_SERIAL_COMPAT]    = "42",
>      [STR_CONFIG_MOUSE]     = "HID Mouse",
>      [STR_CONFIG_TABLET]    = "HID Tablet",
>      [STR_CONFIG_KEYBOARD]  = "HID Keyboard",
> +    [STR_SERIAL_MOUSE]     = "89126",
> +    [STR_SERIAL_TABLET]    = "28754",
> +    [STR_SERIAL_KEYBOARD]  = "68284",
>  };
>  
>  static const USBDescIface desc_iface_mouse = {
> @@ -375,7 +381,7 @@ static const USBDesc desc_mouse = {
>          .bcdDevice         = 0,
>          .iManufacturer     = STR_MANUFACTURER,
>          .iProduct          = STR_PRODUCT_MOUSE,
> -        .iSerialNumber     = STR_SERIALNUMBER,
> +        .iSerialNumber     = STR_SERIAL_MOUSE,
>      },
>      .full = &desc_device_mouse,
>      .str  = desc_strings,
> @@ -389,7 +395,7 @@ static const USBDesc desc_mouse2 = {
>          .bcdDevice         = 0,
>          .iManufacturer     = STR_MANUFACTURER,
>          .iProduct          = STR_PRODUCT_MOUSE,
> -        .iSerialNumber     = STR_SERIALNUMBER,
> +        .iSerialNumber     = STR_SERIAL_MOUSE,
>      },
>      .full = &desc_device_mouse,
>      .high = &desc_device_mouse2,
> @@ -404,7 +410,7 @@ static const USBDesc desc_tablet = {
>          .bcdDevice         = 0,
>          .iManufacturer     = STR_MANUFACTURER,
>          .iProduct          = STR_PRODUCT_TABLET,
> -        .iSerialNumber     = STR_SERIALNUMBER,
> +        .iSerialNumber     = STR_SERIAL_TABLET,
>      },
>      .full = &desc_device_tablet,
>      .str  = desc_strings,
> @@ -418,7 +424,7 @@ static const USBDesc desc_tablet2 = {
>          .bcdDevice         = 0,
>          .iManufacturer     = STR_MANUFACTURER,
>          .iProduct          = STR_PRODUCT_TABLET,
> -        .iSerialNumber     = STR_SERIALNUMBER,
> +        .iSerialNumber     = STR_SERIAL_TABLET,
>      },
>      .full = &desc_device_tablet,
>      .high = &desc_device_tablet2,
> @@ -433,7 +439,7 @@ static const USBDesc desc_keyboard = {
>          .bcdDevice         = 0,
>          .iManufacturer     = STR_MANUFACTURER,
>          .iProduct          = STR_PRODUCT_KEYBOARD,
> -        .iSerialNumber     = STR_SERIALNUMBER,
> +        .iSerialNumber     = STR_SERIAL_KEYBOARD,
>      },
>      .full = &desc_device_keyboard,
>      .str  = desc_strings,
> @@ -447,7 +453,7 @@ static const USBDesc desc_keyboard2 = {
>          .bcdDevice         = 0,
>          .iManufacturer     = STR_MANUFACTURER,
>          .iProduct          = STR_PRODUCT_KEYBOARD,
> -        .iSerialNumber     = STR_SERIALNUMBER,
> +        .iSerialNumber     = STR_SERIAL_KEYBOARD,
>      },
>      .full = &desc_device_keyboard,
>      .high = &desc_device_keyboard2,
> @@ -718,9 +724,7 @@ static void usb_hid_initfn(USBDevice *dev, int kind,
>          return;
>      }
>  
> -    if (dev->serial) {
> -        usb_desc_set_string(dev, STR_SERIALNUMBER, dev->serial);
> -    }
> +    usb_desc_create_serial(dev);
>      usb_desc_init(dev);
>      us->intr = usb_ep_get(dev, USB_TOKEN_IN, 1);
>      hid_init(&us->hid, kind, usb_hid_changed);
> -- 
> 2.9.3
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

