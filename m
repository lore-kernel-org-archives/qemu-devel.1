Received: from eggs.gnu.org ([209.51.188.92]:48057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1h0tpZ-0007Dm-TH
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 15:04:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1h0tpX-0001dM-UT
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 15:04:57 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1h0tpX-0001bO-LS
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 15:04:55 -0500
Received: by mail-pg1-x542.google.com with SMTP id m2so3834368pgl.5
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 12:04:54 -0800 (PST)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Mon, 4 Mar 2019 23:01:20 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201903042301.21256.randrianasulu@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Misc MIPS fulong2e improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: balaton@eik.bme.hu, qemu-devel@nongnu.org

Unfortunately, even after unpacking pmon_1c.tar.gz , compiling and installing tools into /opt/pmon200o/tools  resetting resulted git inside 'pmon' directory to earlist commit possible (because modern pmon fails to comple 2e targets), unpacking and copying to /usr/local toolchain based on gcc 2.95.3, and adding build.sh script to specific directory pmon/zloader - I was only able to build gzrom elf:



/dev/shm/pmon/zloader.2emini# qemu-system-mips64el -M fulong2e -cpu Loongson-2E -m 256  -kernel gzrom -nographic

PMON2000 MIPS Initializing. Standby...
ERRORPC=00000000 CONFIG=00030932
 PRID=00006302
DIMM read
read memory type
read number of rows
read blocks per ddrram
read number of sides
read width
00000020
No DIMM in slot 1
DIMM SIZE=08000000
dma: command ae not supported
sdcfg=2d9043ae
msize=08000000
Init SDRAM Done!
Sizing caches...
Init caches...
godson2 caches found
Init caches done, cfg = 00030932

Copy PMON to execute location...
  start = 0x81000000
  s0 = 0x20000000
0000000d
copy text section done.
Copy PMON to execute location done.
sp=80ffc000Uncompressing Bios......................OK,Booting Bios
QEMU 3.0.50 monitor - type 'help' for more information
(qemu) quit

this is without you patch series .... and with quite oldish qemu (3.1 rc)
