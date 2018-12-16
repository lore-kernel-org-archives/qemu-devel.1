Received: from eggs.gnu.org ([2001:4830:134:3::10]:60833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fabian@lesniak-it.de>) id 1gYbSd-0002RV-IS
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 13:48:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fabian@lesniak-it.de>) id 1gYbSa-0006x1-DU
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 13:48:19 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:45683)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fabian@lesniak-it.de>)
	id 1gYbSa-0006sJ-3Z
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 13:48:16 -0500
References: <CA+X5Wn6-3RHWt7QAeud-53nio9gT+9mo4M_PN6-m561CyQFNmQ@mail.gmail.com>
From: Fabian Lesniak <fabian@lesniak-it.de>
Message-ID: <be820e03-c95b-2a30-bccc-73e21ed21bfe@lesniak-it.de>
Date: Sun, 16 Dec 2018 19:48:07 +0100
MIME-Version: 1.0
In-Reply-To: <CA+X5Wn6-3RHWt7QAeud-53nio9gT+9mo4M_PN6-m561CyQFNmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] hw/input/ps2.c : BTN_SIDE and BTN_EXTRA not
 forwarded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: james harvey <jamespharvey20@gmail.com>, qemu-devel@nongnu.org, kraxel@redhat.com, Eric Blake <eblake@redhat.com>

Probably the PS/2 mouse is not used at all because the HID Tablet takes
precedence. By entering "info mice" on the monitor console you can see
which mouse is currently used. If you disable or uninstall the HID
Tablet, the PS/2 mouse should take over.

"IMEX" is short for Intelli Mouse Explorer.

Am 16.12.18 um 06:40 schrieb james harvey:
> Running qemu 3.1.0.  virt-viewer 7.0.  spice, spice-gtk, and
> spice-protocol all git versions from the past week or so.
>
> I have a Logitech G600 mouse.  The scroll wheel can be pushed left or right.
>
> On Arch Linux host, "evtest" shows these as event codes 275 (BTN_SIDE)
> and 276 (BTN_EXTRA.)  In host, they work as expected, by default as
> back and forward in supporting programs such as web browsers.
>
> On Arch Linux guest, "evtest" shows these events as supported for the
> "ImExPS/2 Generic Explorer Mouse", but it doesn't show those events as
> happening when I push the scroll wheel left or right.  Other events
> work fine.
>
> On Windows 7 guest, there's no effect from pushing the scroll wheel
> left or right, either.
>
> I'm happy to help debug where the event forwarding is breaking down,
> but have no idea how to do that.
>
>
> Patch v1 for these buttons from Nov 24, 2016:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg415246.html
>
> Patch v2 from Nov 28, 2016:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg415690.html
>
> Patch v3 from Dec 6, 2016:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg417007.html
>
>
> The v1 notes say: 'Note that the guest has to switch the ps2 mouse
> into IMEX mode, otherwise events of the extra buttons are ignored. For
> example on a Windows guest one needs to manually select the "Microsoft
> PS/2 Mouse" driver.'
>
> I'll admit I'm not sure what IMEX mode is.  QEMU is providing the PS/2
> mouse emulation by default, and I don't see a way to give qemu options
> for it.
>
> Regardless, following this note's instructions for "IMEX mode", in
> Windows 7 guest, changing the driver from the default "Microsoft -
> PS/2 Compatible Mouse" to "Microsoft - Microsoft PS/2 Mouse" and
> rebooting guest has no effect.  The extra buttons still don't work.
>
> Windows 7 Device Manager does show 2 "Mice and other pointing
> devices".  First is "HID-compliant mouse"
> (HID\VID_0627&PID_0001&REV_0000) which shows it's USB, so I'm guessing
> that's the absolute movement EvTouch USB Graphics Tablet.  Second is
> the PS/2 - currently set to "Microsoft PS/2 Mouse" (ACPI\PNP0F13).
