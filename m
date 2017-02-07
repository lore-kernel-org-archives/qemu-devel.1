Received: from eggs.gnu.org ([2001:4830:134:3::10]:33021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cb7Vn-0001tf-LI
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:16:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cb7Vk-0007n7-KV
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:16:55 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <87wpd211e0.fsf@dusky.pond.sub.org>
References: <20170127094154.19778-1-berto@igalia.com>
	<87wpd211e0.fsf@dusky.pond.sub.org>
Date: Tue, 07 Feb 2017 16:16:13 +0100
Message-ID: <w51zihyjaki.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Clarify that -vga std is now the
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Tue 07 Feb 2017 04:11:51 PM CET, Markus Armbruster wrote:
>>  Cirrus Logic GD5446 Video card. All Windows versions starting from
>>  Windows 95 should recognize and use this graphic card. For optimal
>>  performances, use 16 bit color depth in the guest and the host OS.
>> -(This one is the default)
>> +(This card was the default before QEMU 2.2)
>>  @item std
>>  Standard VGA card with Bochs VBE extensions.  If your guest OS
>>  supports the VESA 2.0 VBE extensions (e.g. Windows XP) and if you want
>>  to use high resolution modes (>= 1280x1024x16) then you should use
>> -this option.
>> +this option. (This card is the default since QEMU 2.2)
>>  @item vmware
>>  VMWare SVGA-II compatible adapter. Use it if you have sufficiently
>>  recent XFree86/XOrg server or Windows guest with a driver for this
>
> Do we want to cover history in the user manual?  Or should we simply
> move the "(This one is the default)" phrase?

> Hmm, the default seems to depend on the machine type:
>
>     if (default_vga) {
>         if (machine_class->default_display) {
>             vga_model = machine_class->default_display;
>         } else if (vga_interface_available(VGA_CIRRUS)) {
>             vga_model = "cirrus";
>         } else if (vga_interface_available(VGA_STD)) {
>             vga_model = "std";
>         }
>     }
>
> The pc-*-2.2 and newer set ->default_display = "std".

Right, if you set e.g. pc-i440fx-1.7 you'll get a cirrus card, that's
why I thought it was worth mentioning that older versions had a
different default.

But I'm fine either way to be honest.

Berto
