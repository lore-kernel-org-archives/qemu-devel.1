Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EED8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 08:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D35120BED
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 08:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dow2FcyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D35120BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvGkw-00018e-Pq
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 04:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvGk7-0000Hz-Eo
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 04:56:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27062
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvGk5-0004u5-H8
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 04:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594717008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LSdHcmvYmsAtymoblKX0gh0LcxDypuqG+SLuvDvfd08=;
 b=Dow2FcyFt8NwU/r/p4+33fhdLjLN45RXILKSY4preLiIrDB8MliuM4V97+uTCShdbVN4KV
 bdYU0Ze2Tn+nSaY2UgRmj0AhtVkvFe2J+xkI9dfoGfSYMBffSqK+Ph7OUYORFjyrxo4MXr
 XNVbkFjeC7rHJ/nRpJyxCyDbsW5H8Pw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-v61fjEOvPG6HZVnTYlT4Vg-1; Tue, 14 Jul 2020 04:56:47 -0400
X-MC-Unique: v61fjEOvPG6HZVnTYlT4Vg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B6D6800685;
 Tue, 14 Jul 2020 08:56:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A20DC724D4;
 Tue, 14 Jul 2020 08:56:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3048E1267F16; Tue, 14 Jul 2020 10:56:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] docs/qdev-device-use: Clean up the sentences related to
 -usbdevice
References: <20200710065520.24784-1-thuth@redhat.com>
Date: Tue, 14 Jul 2020 10:56:41 +0200
In-Reply-To: <20200710065520.24784-1-thuth@redhat.com> (Thomas Huth's message
 of "Fri, 10 Jul 2020 08:55:20 +0200")
Message-ID: <87r1te79va.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thomas Huth <thuth@redhat.com> writes:

> Most of the -usbdevice paramaters have been removed already. Update
> the doc accordingly.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/qdev-device-use.txt | 28 +++-------------------------
>  1 file changed, 3 insertions(+), 25 deletions(-)
>
> diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt
> index 4bbbcf561f..f8d0d2fe29 100644
> --- a/docs/qdev-device-use.txt
> +++ b/docs/qdev-device-use.txt
> @@ -125,12 +125,7 @@ The -device argument differs in detail for each
> type of drive:

Additional context:

   The various old ways to define drives all boil down to the common form

       -drive if=TYPE,bus=BUS,unit=UNIT,OPTS...

   TYPE, BUS and UNIT identify the controller device, which of its buses
   to use, and the drive's address on that bus.  Details depend on TYPE.
[...]
>  
>  * if=pflash, if=mtd, if=sd, if=xen are not yet available with -device
>  
> -For USB devices, the old way is actually different:
> -
> -    -usbdevice disk:format=FMT:FILENAME
> -
> -Provides much less control than -drive's OPTS...  The new way fixes
> -that:
> +For USB storage devices, you can use something like:
>  
>      -device usb-storage,drive=DRIVE-ID,removable=RMB
>  

Losing "the old way is actually different" makes "The various old ways
to define drives all boil down to the common form" apply to USB.
Misleading.

We could choose to keep information on the old way, like this:

   For USB devices, the old way was actually different:

       -usbdevice disk:format=FMT:FILENAME

   "Was" because "disk:" is gone since v2.12.0.

   The old way provided much less control than -drive's OPTS...  The new
   way fixes that:

       -device usb-storage,drive=DRIVE-ID,removable=RMB

If we prefer not to, then perhaps:

   For USB devices, the old way was actually different, and is long
   gone.  The new way looks like

       -device usb-storage,drive=DRIVE-ID,removable=RMB

> @@ -177,8 +172,6 @@ The appropriate DEVNAME depends on the machine type.  For type "pc":
>  
>    This lets you control I/O ports and IRQs.
>  
> -* -usbdevice serial::chardev becomes -device usb-serial,chardev=dev.
> -

If we choose to keep information on old ways, we could

   * -usbdevice serial::chardev is gone since v2.12.0.  It became
     -device usb-serial,chardev=dev.

Else:

   * Use -device usb-serial,chardev=dev for USB serial devices.  The old
     way is long gone.

>  * -usbdevice braille doesn't support LEGACY-CHARDEV syntax.  It always
>    uses "braille".  With -device, this useful default is gone, so you
>    have to use something like
> @@ -238,10 +231,6 @@ The old way to define the guest part looks like this:

Additional context:

   === Network Devices ===

   Host and guest part of network devices have always been separate.

   The old way to define the guest part looks like this:
>  
>      -net nic,netdev=NET-ID,macaddr=MACADDR,model=MODEL,name=ID,addr=STR,vectors=V
>  
> -Except for USB it looks like this:
> -
> -    -usbdevice net:netdev=NET-ID,macaddr=MACADDR,name=ID
> -
>  The new way is -device:
>  
>      -device DEVNAME,netdev=NET-ID,mac=MACADDR,DEV-OPTS...

As for block devices, this now reads as if USB was the same as all the
others, which is misleading.

If keep, then perhaps:

   Except for USB it looked like this:

       -usbdevice net:netdev=NET-ID,macaddr=MACADDR,name=ID

   "Looked" because "net:" is gone since v2.12.0.

If not:

   For USB devices, the old way was actually different, and is long
   gone.

> @@ -336,12 +325,7 @@ The new way is -device DEVNAME,DEV-OPTS...  Details depend on DRIVER:
>  * mouse           -device usb-mouse
>  * tablet          -device usb-tablet
>  * wacom-tablet    -device usb-wacom-tablet
> -* host:...        See "Host Device Assignment"
> -* disk:...        See "Block Devices"
> -* serial:...      See "Character Devices"
>  * braille         See "Character Devices"
> -* net:...         See "Network Devices"
> -* bt:...          not yet available with -device
>  
>  === Watchdog Devices ===
>  
> @@ -358,17 +342,11 @@ and host USB devices.  PCI devices can only be assigned with -device:

More context:

   === Host Device Assignment ===

   QEMU supports assigning host PCI devices (qemu-kvm only at this time)
   and host USB devices.  PCI devices can only be assigned with -device:
>  
>      -device vfio-pci,host=ADDR,id=ID
>  
> -The old way to assign a host USB device is
> -
> -    -usbdevice host:auto:BUS.ADDR:VID:PRID
> -
> -where any of BUS, ADDR, VID, PRID can be the wildcard *.
> -
> -The new way is
> +To assign a host USB device use:
>  
>      -device usb-host,hostbus=BUS,hostaddr=ADDR,vendorid=VID,productid=PRID
>  
> -Omitted options match anything, just like the old way's wildcard.
> +Omitted options match anything.

   QEMU supports assigning host PCI devices (qemu-kvm only at this time)
   and host USB devices.  They can only be assigned with -device.

   PCI:

       -device vfio-pci,host=ADDR,id=ID

   USB:

       -device usb-host,hostbus=BUS,hostaddr=ADDR,vendorid=VID,productid=PRID

   Omitted options match anything.

If keep, add something like

   The old way to assign a USB host device

       -usbdevice host:auto:BUS.ADDR:VID:PRID

   was removed in v2.12.0.  Any of BUS, ADDR, VID, PRID could be the
   wildcard *.

>  
>  === Default Devices ===

Since v2.12.0 was more than two years ago, keeping information on the
old way may be no longer useful.


