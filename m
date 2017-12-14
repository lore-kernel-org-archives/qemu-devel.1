Received: from eggs.gnu.org ([2001:4830:134:3::10]:48086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePIKw-00022C-9q
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 20:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePIKu-00070N-FU
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 20:29:22 -0500
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 22:29:18 -0300
Message-ID: <CAAdtpL5n_VyDgn4=_ikuwTfznJ7ZUTmp5irAtD-FxEmDVf7Vpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/26] SDCard housekeeping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, Clement Deschamps <clement.deschamps@antfield.fr>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Isaac Lozano <109lozanoi@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

attaching a more complete boot log.

> Once this series applied, booting some Linux on a vexpress-a9 with few
> sd*command traces enabled result in this outputs (which result useful to
> understand/fix the different SD implementations):

$ cat /tmp/events
sd*command*
sdcard_set_mode
sdcard_read_block

$ qemu-system-arm \
  -M vexpress-a9 \
  -kernel vmlinuz-3.2.0-4-vexpress -initrd initrd.img-3.2.0-4-vexpress \
  -drive if=sd,cache=unsafe,file=a10-debian-server-2gb.2014-02-17.img \
  -append "root=/dev/mmcblk0p2 console=ttyAMA0 console=tty" -nographic \
  -trace events=/tmp/events
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.2.0-4-vexpress
(debian-kernel@lists.debian.org) (gcc version 4.6.3 (Debian 4.6.3-12)
) #1 SMP Debian 3.2.35-2
[    0.000000] CPU: ARMv7 Processor [410fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] Machine: ARM-Versatile Express
[    0.000000] Kernel command line: root=/dev/mmcblk0p2
console=ttyAMA0 console=tty
[    0.000000] Memory: 128MB = 128MB total
[    0.000000] Console: colour dummy device 80x30
[    0.000000] console [tty0] enabled
[    0.319496] Brought up 1 CPUs
[    0.319905] SMP: Total of 1 processors activated (617.67 BogoMIPS).
[    0.444966] Serial: AMBA PL011 UART driver
[    0.450544] mb:uart0: ttyAMA0 at MMIO 0x10009000 (irq = 37) is a PL011 rev1
[    0.481078] console [ttyAMA0] enabled
[    3.081225] mmci-pl18x mb:mmci: mmc0: PL181 manf 41 rev0 at
0x10005000 irq 41,42 (pio)
86.660802:sdcard_set_mode inactive -> card_identification (state: idle)
86.660815:sdcard_normal_command         IO_RW_DIRECT/ CMD52 arg
0x00000c00 (state idle)
86.660829:sdcard_command_response (no response) (state idle)
86.689998:sdcard_normal_command         IO_RW_DIRECT/ CMD52 arg
0x80000c08 (state idle)
86.690014:sdcard_command_response (no response) (state idle)
86.692380:sdcard_normal_command        GO_IDLE_STATE/ CMD00 arg
0x00000000 (state idle)
86.692392:sdcard_command_response (no response) (state idle)
86.695229:sdcard_normal_command         SEND_IF_COND/ CMD08 arg
0x000001aa (state idle)
86.695247:sdcard_command_response 00 00 01 aa  (state idle)
86.695887:sdcard_normal_command      IO_SEND_OP_COND/ CMD05 arg
0x00000000 (state idle)
86.695898:sdcard_command_response (no response) (state idle)
86.696065:sdcard_normal_command      IO_SEND_OP_COND/ CMD05 arg
0x00000000 (state idle)
86.696072:sdcard_command_response (no response) (state idle)
86.696198:sdcard_normal_command      IO_SEND_OP_COND/ CMD05 arg
0x00000000 (state idle)
86.696207:sdcard_command_response (no response) (state idle)
86.696311:sdcard_normal_command      IO_SEND_OP_COND/ CMD05 arg
0x00000000 (state idle)
86.696320:sdcard_command_response (no response) (state idle)
[    3.298428] mmc0: host does not support reading read-only switch.
assuming write-enable.
86.697384:sdcard_command_response 00 40 01 20  (state idle)
86.697639:sdcard_app_command         SD_SEND_OP_COND/ACMD41 arg
0x00000000 (state idle)
86.697656:sdcard_command_response 40 ff ff 00  (state idle)
86.699975:sdcard_normal_command        GO_IDLE_STATE/ CMD00 arg
0x00000000 (state idle)
86.700000:sdcard_command_response (no response) (state idle)
86.732420:sdcard_normal_command         SEND_IF_COND/ CMD08 arg
0x000001aa (state idle)
86.732460:sdcard_command_response 00 00 01 aa  (state idle)
86.732700:sdcard_command_response 00 00 01 20  (state idle)
86.732812:sdcard_app_command         SD_SEND_OP_COND/ACMD41 arg
0x40300000 (state idle)
86.732825:sdcard_command_response c0 ff ff 00  (state ready)
86.733272:sdcard_normal_command         ALL_SEND_CID/ CMD02 arg
0x00000000 (state ready)
86.733307:sdcard_command_response aa 58 59 51 45 4d 55 21 01 de ad be
ef 00 62 19  (state identification)
86.734086:sdcard_normal_command   SEND_RELATIVE_ADDR/ CMD03 arg
0x00000000 (state identification)
86.734107:sdcard_command_response 45 67 05 00  (state standby)
86.734573:sdcard_set_mode card_identification -> data_transfer (state: standby)
86.734580:sdcard_normal_command             SEND_CSD/ CMD09 arg
0x45670000 (state standby)
86.734593:sdcard_command_response 40 0e 00 32 5b 59 00 00 0d 47 7f 80
0a 40 00 00  (state standby)
86.735447:sdcard_normal_command SELECT/DESELECT_CARD/ CMD07 arg
0x45670000 (state standby)
86.735462:sdcard_command_response 00 00 07 00  (state transfer)
86.735917:sdcard_command_response 00 00 09 20  (state transfer)
86.737808:sdcard_app_command                SEND_SCR/ACMD51 arg
0x00000000 (state transfer)
86.737818:sdcard_command_response 00 00 09 20  (state sendingdata)
86.739778:sdcard_command_response 00 00 09 20  (state transfer)
86.740004:sdcard_app_command               SD_STATUS/ACMD13 arg
0x00000000 (state transfer)
86.740011:sdcard_command_response 00 00 09 20  (state sendingdata)
[    3.319526] mmc0: new SDHC card at address 4567
[    3.401452] mmcblk0: mmc0:4567 QEMU! 1.66 GiB
86.939168:sdcard_normal_command  READ_MULTIPLE_BLOCK/ CMD18 arg
0x00000000 (state transfer)
86.939198:sdcard_command_response 00 00 09 00  (state sendingdata)
86.939201:sdcard_read_block addr 0x00000000 size 0x200
86.939768:sdcard_read_block addr 0x00000200 size 0x200
86.940137:sdcard_read_block addr 0x00000400 size 0x200
86.940549:sdcard_read_block addr 0x00000600 size 0x200
86.940918:sdcard_read_block addr 0x00000800 size 0x200
86.941506:sdcard_read_block addr 0x00000a00 size 0x200
86.941796:sdcard_read_block addr 0x00000c00 size 0x200
86.942080:sdcard_read_block addr 0x00000e00 size 0x200
86.942451:sdcard_normal_command    STOP_TRANSMISSION/ CMD12 arg
0x00000000 (state sendingdata)
86.942463:sdcard_command_response 00 00 0b 00  (state transfer)
[    3.522382]  mmcblk0: p1 p2
88.022437:sdcard_normal_command          SEND_STATUS/ CMD13 arg
0x45670000 (state transfer)
88.022459:sdcard_command_response 00 00 09 00  (state transfer)
89.025296:sdcard_normal_command          SEND_STATUS/ CMD13 arg
0x45670000 (state transfer)
89.025315:sdcard_command_response 00 00 09 00  (state transfer)
[    5.777261] udevd[45]: starting version 175
90.032049:sdcard_normal_command          SEND_STATUS/ CMD13 arg
0x45670000 (state transfer)
90.032069:sdcard_command_response 00 00 09 00  (state transfer)
91.032126:sdcard_normal_command          SEND_STATUS/ CMD13 arg
0x45670000 (state transfer)
91.032148:sdcard_command_response 00 00 09 00  (state transfer)
91.854517:sdcard_normal_command  READ_MULTIPLE_BLOCK/ CMD18 arg
0x00351f80 (state transfer)
91.854547:sdcard_command_response 00 00 09 00  (state sendingdata)
91.854550:sdcard_read_block addr 0x6a3f0000 size 0x200
91.856100:sdcard_read_block addr 0x6a3f0200 size 0x200
91.856393:sdcard_read_block addr 0x6a3f0400 size 0x200
91.856692:sdcard_read_block addr 0x6a3f0600 size 0x200
91.857342:sdcard_read_block addr 0x6a3f0800 size 0x200
91.857652:sdcard_read_block addr 0x6a3f0a00 size 0x200
91.857955:sdcard_read_block addr 0x6a3f0c00 size 0x200
91.858256:sdcard_read_block addr 0x6a3f0e00 size 0x200
91.858979:sdcard_normal_command    STOP_TRANSMISSION/ CMD12 arg
0x00000000 (state sendingdata)
91.858990:sdcard_command_response 00 00 0b 00  (state transfer)
92.003670:sdcard_normal_command  READ_MULTIPLE_BLOCK/ CMD18 arg
0x00351ff0 (state transfer)
92.003692:sdcard_command_response 00 00 09 00  (state sendingdata)
92.003696:sdcard_read_block addr 0x6a3fe000 size 0x200
92.004126:sdcard_read_block addr 0x6a3fe200 size 0x200
92.004418:sdcard_read_block addr 0x6a3fe400 size 0x200
92.004704:sdcard_read_block addr 0x6a3fe600 size 0x200
92.005011:sdcard_read_block addr 0x6a3fe800 size 0x200
92.005313:sdcard_read_block addr 0x6a3fea00 size 0x200
92.005665:sdcard_read_block addr 0x6a3fec00 size 0x200
92.006023:sdcard_read_block addr 0x6a3fee00 size 0x200
92.006466:sdcard_normal_command    STOP_TRANSMISSION/ CMD12 arg
0x00000000 (state sendingdata)
92.006481:sdcard_command_response 00 00 0b 00  (state transfer)
92.022454:sdcard_normal_command  READ_MULTIPLE_BLOCK/ CMD18 arg
0x00000000 (state transfer)
92.022488:sdcard_command_response 00 00 09 00  (state sendingdata)
92.022497:sdcard_read_block addr 0x00000000 size 0x200
92.023021:sdcard_read_block addr 0x00000200 size 0x200
92.023436:sdcard_read_block addr 0x00000400 size 0x200
92.023841:sdcard_read_block addr 0x00000600 size 0x200
92.024179:sdcard_read_block addr 0x00000800 size 0x200
92.024555:sdcard_read_block addr 0x00000a00 size 0x200
92.024849:sdcard_read_block addr 0x00000c00 size 0x200
92.025151:sdcard_read_block addr 0x00000e00 size 0x200
92.025507:sdcard_normal_command    STOP_TRANSMISSION/ CMD12 arg
0x00000000 (state sendingdata)
92.025518:sdcard_command_response 00 00 0b 00  (state transfer)
92.043359:sdcard_normal_command          SEND_STATUS/ CMD13 arg
0x45670000 (state transfer)
92.043403:sdcard_command_response 00 00 09 00  (state transfer)
92.071967:sdcard_normal_command  READ_MULTIPLE_BLOCK/ CMD18 arg
0x00000008 (state transfer)
92.072003:sdcard_command_response 00 00 09 00  (state sendingdata)
92.072008:sdcard_read_block addr 0x00001000 size 0x200
92.072429:sdcard_read_block addr 0x00001200 size 0x200
92.072763:sdcard_read_block addr 0x00001400 size 0x200
92.073064:sdcard_read_block addr 0x00001600 size 0x200
92.073383:sdcard_read_block addr 0x00001800 size 0x200
92.073670:sdcard_read_block addr 0x00001a00 size 0x200
92.073949:sdcard_read_block addr 0x00001c00 size 0x200
92.074224:sdcard_read_block addr 0x00001e00 size 0x200
92.074552:sdcard_normal_command    STOP_TRANSMISSION/ CMD12 arg
0x00000000 (state sendingdata)
92.074562:sdcard_command_response 00 00 0b 00  (state transfer)
92.093569:sdcard_normal_command  READ_MULTIPLE_BLOCK/ CMD18 arg
0x00351ff8 (state transfer)
92.093590:sdcard_command_response 00 00 09 00  (state sendingdata)
92.093596:sdcard_read_block addr 0x6a3ff000 size 0x200
92.093994:sdcard_read_block addr 0x6a3ff200 size 0x200
92.094281:sdcard_read_block addr 0x6a3ff400 size 0x200
92.094568:sdcard_read_block addr 0x6a3ff600 size 0x200
92.094843:sdcard_read_block addr 0x6a3ff800 size 0x200
92.095118:sdcard_read_block addr 0x6a3ffa00 size 0x200
92.095389:sdcard_read_block addr 0x6a3ffc00 size 0x200
92.095654:sdcard_read_block addr 0x6a3ffe00 size 0x200
qemu-system-arm: terminating on signal 15 from pid 12630 (killall)
