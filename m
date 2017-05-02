Received: from eggs.gnu.org ([2001:4830:134:3::10]:51171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d5TMg-0006Pe-14
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d5TMf-0007XU-4E
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:40:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d5TMe-0007Wu-V6
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:40:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DAA76EB37E
	for <qemu-devel@nongnu.org>; Tue,  2 May 2017 08:40:55 +0000 (UTC)
References: <1493712420-22480-1-git-send-email-thuth@redhat.com>
	<614ac73b-37f3-0e5e-535c-ac4d9cb8f81e@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d6ea63a9-e277-1976-7758-b9d8c8241088@redhat.com>
Date: Tue, 2 May 2017 10:40:49 +0200
MIME-Version: 1.0
In-Reply-To: <614ac73b-37f3-0e5e-535c-ac4d9cb8f81e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] Print a warning message if the user
 specified a legacy USB option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On 02.05.2017 10:18, Paolo Bonzini wrote:
> 
> 
> On 02/05/2017 10:07, Thomas Huth wrote:
>> '-usb' and '-usbdevice' are considered as deprecated nowadays and
>> we might want to remove these options in a future version of QEMU.
>> So mark this options as deprecated in the documenation and print out
>> a warning if they are used to tell the user what to use instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v2: Also update the documentation accordingly
>>
>>  qemu-options.hx | 8 +++++---
>>  vl.c            | 4 ++++
>>  2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index f68829f..57bacc5 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -946,12 +946,13 @@ STEXI
>>  ETEXI
>>  
>>  DEF("usb", 0, QEMU_OPTION_usb,
>> -    "-usb            enable the USB driver (will be the default soon)\n",
>> +    "-usb            enable the USB driver (if it is not used by default yet)\n",
>>      QEMU_ARCH_ALL)
>>  STEXI
>>  @item -usb
>>  @findex -usb
>> -Enable the USB driver (will be the default soon)
>> +Enable the USB driver (if it is not used by default yet). Note that this
>> +option is deprecated, please use @code{-M usb=on} instead.
> 
> This is pointless, "-usb" is just syntactic sugar and doesn't add any
> complex logic.

Ok.

>>  ETEXI
>>  
>>  DEF("usbdevice", HAS_ARG, QEMU_OPTION_usbdevice,
>> @@ -961,7 +962,8 @@ STEXI
>>  
>>  @item -usbdevice @var{devname}
>>  @findex -usbdevice
>> -Add the USB device @var{devname}. @xref{usb_devices}.
>> +Add the USB device @var{devname}. Note that this option is deperecated,
>> +please use @code{-device usb-...} instead. See also @xref{usb_devices}.
>>  
>>  @table @option
> 
> This makes sense, but the usb_devices section of the manual still
> documents -usbdevice instead of "-device usb-...".

I noticed that, too, after sending my patch ... actually, that section
is really out of date, e.g. it also says that QEMU only "emulates a PCI
UHCI USB controller" which is just not true nowadays anymore... Looks
like we need to spend some effort here to update it properly...

 Thomas
