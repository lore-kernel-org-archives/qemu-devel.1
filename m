Received: from eggs.gnu.org ([2001:4830:134:3::10]:42546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gRFmn-0002bX-16
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:14:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gRFmj-0005fK-UH
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:14:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gRFmj-0005eg-OX
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:14:41 -0500
Date: Mon, 26 Nov 2018 13:14:38 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181126131438.6a54e565@redhat.com>
In-Reply-To: <154309181512.10041.15816389425746279853.launchpad@chaenomeles.canonical.com>
References: <154309137717.32238.5287661827417174062.malonedeb@wampee.canonical.com>
	<154309181512.10041.15816389425746279853.launchpad@chaenomeles.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1804961] Re: qemu-system-aarch64: Windows 10
 ARM64 BSoD on boot while using virt-3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: GH Cao <1804961@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org

On Sat, 24 Nov 2018 20:36:54 -0000
GH Cao <1804961@bugs.launchpad.net> wrote:

> ** Description changed:
> 
>   When I emulate a virt-3.0 machine, Windows 10 BSoD on boot, with the
>   error code being ACPI_BIOS_ERROR(0x000000A5), virt-2.12 boots fine.
>   
>   Windows Build: 10.0.17134.1
>   QEMU version: 3.0.0
>   Commandline: qemu-system-aarch64 -M virt -accel tcg,thread=multi -cpu cortex-a57 -smp 2 -m 2048 -bios QEMU_EFI.fd -device ramfb -device nec-usb-xhci -device usb-kbd -device usb-tablet -hda disk.vhd -vnc :0
>   
>   By the way, the patch to add DBG2 table discussed here
> - https://lists.gnu.org/archive/html/qemu-devel/2015-09/msg02550.html
> + https://lists.gnu.org/archive/html/qemu-devel/2015-09/msg01719.html
>   works (although minor change is required to adapt to the qemu 3.0.0
>   code), the table is accepted by Windows (Windows require both DBG2 and
>   SPCR to be valid for serial kernel debugging to work), so it may help
>   further diagnosing this issue.
> 

if you are able to attach a debugger early before guest BSODs,
you can try to use AMIL Debugger
https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/the-amli-debugger
to find out what windows doesn't like in ACPI tables.
