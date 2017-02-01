Received: from eggs.gnu.org ([2001:4830:134:3::10]:32771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <martin@c-home.cz>) id 1cZ1gN-00026m-2T
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:39:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <martin@c-home.cz>) id 1cZ1gJ-0000Ku-4Z
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:39:11 -0500
Received: from gw.c-home.cz ([89.24.150.100]:46197 helo=dmz.c-home.cz)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <martin@c-home.cz>) id 1cZ1gI-0000Ei-1U
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:39:07 -0500
Date: Wed, 1 Feb 2017 21:16:39 +0100 (CET)
From: Martin Cerveny <martin@c-home.cz>
Reply-To: Martin Cerveny <M.Cerveny@computer.org>
Message-ID: <alpine.GSO.2.00.1702012023540.5038@dmz.c-home.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Subject: [Qemu-devel] usb3 - xhci - Assertion `intr->er_full' failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Hello.

I have the xhci problem after I attach any (usbredir) device to qemu 
qemu-system-x86_64: hw/usb/hcd-xhci.c:903: xhci_events_update: Assertion `intr->er_full' failed.

The problem is repeatly reported (from 2014):

- https://bugs.launchpad.net/qemu/+bug/1373228
- http://lists.nongnu.org/archive/html/qemu-devel/2014-09/msg04809.html
- http://lists.nongnu.org/archive/html/qemu-discuss/2016-05/msg00017.html

My config:

- xen-4.8.0
- qemu-xen-4.8.0 (~qemu 2.7.0) also tried add +11 patches from qemu upstream to hw/usb/hcd-xhci.c
- xl "usbversion=3" -> qemu "-device nec-usb-xhci,id=usb"
- kernel dom0 4.7.9-200.fc24.x86_64
- usb with usbredir 0.7.1
- guest windows 7 - renesas driver 2.1.36 or 2.1.39

Questions:

Is there any chance to resolve this bug ?

Where is the verfied windows driver that is compatible/tested with xhci code ?

I see some movement on xhci sources (https://www.kraxel.org/cgit/qemu/log/?h=work/qemu-xhci) - 
Is there some special driver for "PCI_DEVICE_ID_REDHAT_XHCI" "1b36:000c PCI xhci usb host adapter" for Windows Guests
that is compatible with xhci qemu code ?

Thanks for response,
Martin Cerveny

---------------------------------- USB keyboard + qemu-xen-4.8.0 + 2.1.39 driver + DEBUG_XHCI + DEBUG_DATA ---------------------------

qemu-system-x86_64: usbredirparser: Peer version: USBMR 1.0, using 64-bits ids
qemu-system-x86_64: usb-redir: attaching low speed device 0e6a:6001 version 0.7 class 00

xhci_process_commands()
xhci: ERDP out of bounds: 19ed61000
xhci: ER[7] at 0 len 0
xhci: asserted controller error
xhci: event ring[7]:19ed61000 [256]
xhci_process_commands()
xhci: input context at 19ed60000
xhci: output context at 19ed5f000
xhci: input slot context: 08200000 00050000 00000000 00000000
xhci: input ep0 context: 00000000 00080026 9ed63001 00000001 00001000
xhci: endpoint 0.1 type is 4, max transaction (burst) size is 8
xhci: output slot context: 08200000 00050000 00000000 08000000
xhci: output ep0 context: 00000001 00080026 9ed63001 00000001 00001000
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed63001
xhci: setup packet pid 0x69 addr 0 ep 0
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed63031
xhci_process_commands()
xhci: input context at 19ed60000
xhci: output context at 19ed5f000
xhci: input slot context: 08200000 00050000 00000000 00000000
xhci: input ep0 context: 00000000 00080026 9ed63031 00000001 00001000
xhci_ep_nuke_xfers(1, 1)
xhci: set epctx: 19ed5f020 state=0 dequeue=000000019ed63031
xhci: endpoint 0.1 type is 4, max transaction (burst) size is 8
xhci: output slot context: 08200000 00050000 00000000 10000001
xhci: output ep0 context: 00000001 00080026 9ed63031 00000001 00001000
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed63031
xhci: setup packet pid 0x69 addr 1 ep 0
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed63061
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed63061
xhci: setup packet pid 0x69 addr 1 ep 0
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed63091
xhci_process_commands()
xhci: input context at 19ed60000
xhci: output context at 19ed5f000
xhci: input slot context: 00000000 00000000 00000000 00000000
xhci: output slot context: 08200000 00050000 00000000 10000001
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed63091
xhci: setup packet pid 0x69 addr 1 ep 0
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed630c1
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed630c1
xhci: setup packet pid 0x69 addr 1 ep 0
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed630f1
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed630f1
xhci: setup packet pid 0x69 addr 1 ep 0
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed63121
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed63121
xhci: setup packet pid 0x69 addr 1 ep 0
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed63151
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed63151
xhci: setup packet pid 0x69 addr 1 ep 0
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed63181
xhci: ERDP out of bounds: 19ed6c000
xhci: ER[6] at 0 len 0
xhci: asserted controller error
xhci: event ring[6]:19ed6c000 [256]
xhci_process_commands()
xhci: input context at 19ed60000
xhci: output context at 19ed5f000
xhci: input ep1.1 context: 00060000 0008003e 9ed6d001 00000001 00081000
xhci: slot 1 ep 3 already disabled
xhci: endpoint 1.1 type is 7, max transaction (burst) size is 8
xhci: output ep1.1 context: 00060001 0008003e 9ed6d001 00000001 00081000
xhci: input ep2.1 context: 00060000 0003003e 9ed6e001 00000001 00031000
xhci: slot 1 ep 5 already disabled
xhci: endpoint 2.1 type is 7, max transaction (burst) size is 3
xhci: output ep2.1 context: 00060001 0003003e 9ed6e001 00000001 00031000
xhci: output slot context: 28200000 00050000 00000000 18000001
xhci_process_commands()
xhci_get_port_bandwidth()
xhci: bandwidth context at 19cbc2000
xhci_process_commands()
xhci_get_port_bandwidth()
xhci: bandwidth context at 19cbc2000
xhci_process_commands()
xhci_get_port_bandwidth()
xhci: bandwidth context at 19cbc2000
xhci_process_commands()
xhci_get_port_bandwidth()
xhci: bandwidth context at 19cbc2000
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed63181
xhci: setup packet pid 0xe1 addr 1 ep 0
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed631a1
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed631a1
xhci: setup packet pid 0x69 addr 1 ep 0
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed631d1
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed631d1
xhci: setup packet pid 0x69 addr 1 ep 0
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed63010
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed63010
xhci: setup packet pid 0x69 addr 1 ep 0
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed63040
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed63040
xhci: setup packet pid 0xe1 addr 1 ep 0
xhci_event(): ER full, queueing
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed63060
xhci_events_update(): event ring still more than half full (hack)
xhci_process_commands()
xhci_ep_nuke_xfers(1, 1)
xhci: set epctx: 19ed5f020 state=3 dequeue=000000019ed63060
xhci_process_commands()
xhci: set epctx: 19ed5f020 state=3 dequeue=000000019ed63060
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed63060
xhci: setup packet pid 0x69 addr 1 ep 0
xhci_event(): ER full, queueing
xhci_event(): ER full, queueing
xhci: set epctx: 19ed5f020 state=1 dequeue=000000019ed63090
xhci_process_commands()
xhci_ep_nuke_xfers(1, 1)
xhci: set epctx: 19ed5f020 state=3 dequeue=000000019ed63090
xhci_process_commands()
xhci: set epctx: 19ed5f020 state=3 dequeue=000000019ed63090
xhci: ERDP out of bounds: 0
xhci: ER[6] at 0 len 0
xhci: asserted controller error
xhci: ERDP out of bounds: 0
xhci: ER[7] at 0 len 0
xhci: asserted controller error
xhci_process_commands()
xhci_ep_nuke_xfers(1, 1)
xhci: set epctx: 19ed5f020 state=0 dequeue=000000019ed63090
xhci_ep_nuke_xfers(1, 3)
xhci: set epctx: 19ed5f060 state=0 dequeue=000000019ed6d001
xhci_ep_nuke_xfers(1, 5)
xhci: set epctx: 19ed5f0a0 state=0 dequeue=000000019ed6e001
xhci_process_commands()
xhci_get_port_bandwidth()
xhci: bandwidth context at 19cbc2000
xhci_process_commands()
xhci_get_port_bandwidth()
xhci: bandwidth context at 19cbc2000
xhci_process_commands()
xhci_get_port_bandwidth()
xhci: bandwidth context at 19cbc2000
xhci_process_commands()
xhci_get_port_bandwidth()
xhci: bandwidth context at 19cbc2000
xhci_process_commands()
xhci: ERDP out of bounds: 19ec4b000
xhci: ER[7] at 0 len 0
xhci: asserted controller error
xhci: event ring[7]:19ec4b000 [256]
xhci_process_commands()
xhci: input context at 19ec49000
xhci: output context at 19ec40000
xhci: input slot context: 08200000 00050000 00000000 00000000
xhci: input ep0 context: 00000000 00080026 9ec4e001 00000001 00001000
xhci: endpoint 0.1 type is 4, max transaction (burst) size is 8
xhci: output slot context: 08200000 00050000 00000000 10000001
xhci: output ep0 context: 00000001 00080026 9ec4e001 00000001 00001000
xhci: set epctx: 19ec40020 state=1 dequeue=000000019ec4e001
xhci: setup packet pid 0x69 addr 1 ep 0
xhci: set epctx: 19ec40020 state=1 dequeue=000000019ec4e031
qemu-system-x86_64: hw/usb/hcd-xhci.c:903: xhci_events_update: Assertion `intr->er_full' failed.
