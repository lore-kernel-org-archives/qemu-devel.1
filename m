Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002ECC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 07:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C81C520702
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 07:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81C520702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jutH0-0007c2-4Q
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 03:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jutG7-0006eb-1H
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 03:52:19 -0400
Received: from 9.mo69.mail-out.ovh.net ([46.105.56.78]:43798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jutG4-000298-DE
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 03:52:18 -0400
Received: from player696.ha.ovh.net (unknown [10.108.35.122])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 6B2AF98B42
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 09:52:06 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player696.ha.ovh.net (Postfix) with ESMTPSA id 47F4014571F83;
 Mon, 13 Jul 2020 07:51:54 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0026e4cf995-3468-48a4-921b-b5e1cb283914,29C60B8BFD44B6CD822E82BF6A6060F4508BB267)
 smtp.auth=clg@kaod.org
Subject: Re: hw/misc/aspeed_scu: 5d971f9e breaks Supermicro AST2400
To: Erik Smit <erik.lucas.smit@gmail.com>, Joel Stanley <joel@jms.id.au>
References: <CA+MHfoubt1g2FzcjTw3a0vNr7X2T8Jb+nYoc4_x=Z2TP51afKg@mail.gmail.com>
 <a7acba46-5a9a-5dd2-71c6-7e4586485823@amsat.org>
 <CA+MHfot6FdS2yT0mEsCW36bCfwy-WY-1KPQ-KDfYBKzTy=Gd7w@mail.gmail.com>
 <CACPK8Xdqr+EufMgooCY=D+Vt98qu11YTHE5Fzi5+xqX=wKReeQ@mail.gmail.com>
 <CA+MHfouin6Zmz+GrjWRCc_WzPF=ff-z_5V7BLv0HkL+SW9bRoQ@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8879bfee-752b-c4e2-7646-c42dec84a440@kaod.org>
Date: Mon, 13 Jul 2020 09:51:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CA+MHfouin6Zmz+GrjWRCc_WzPF=ff-z_5V7BLv0HkL+SW9bRoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1343480067347286801
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrvdejgdduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefueeufeevleevleelleejuedtieevtefgteelgfeiieffgfettefhudeigfdtieenucffohhmrghinhepshhuphgvrhhmihgtrhhordgtohhmnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieeliedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.56.78; envelope-from=clg@kaod.org;
 helo=9.mo69.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:52:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/20 7:17 AM, Erik Smit wrote:
> Hi Joel,
> 
> On Wed, 1 Jul 2020 at 02:54, Joel Stanley <joel@jms.id.au> wrote:
>>
>> On Tue, 30 Jun 2020 at 15:32, Erik Smit <erik.lucas.smit@gmail.com> wrote:
>>>
>>> Hi Philippe,
>>>
>>> On Tue, 30 Jun 2020 at 17:29, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>
>>>> Hi Erik,
>>>>
>>>> On 6/30/20 5:11 PM, Erik Smit wrote:
>>>>> Hello,
>>>>>
>>>>> 5d971f9e memory: Revert "memory: accept mismatching sizes in
>>>>> memory_region_access_valid" breaks Supermicro AST2400 u-boot.
>>>>> Supermicro AST2500 u-boot is fine.
>>>>>
>>>>> The u-boot tries to make a 2-byte read from address 0x84, but
>>>>> aspeed_ast2400_scu_ops has min_access = 4. When I change min_access to
>>>>> 2 or revert above commit, u-boot boots again.
>>>>>
>>>>> Is changing min_access to 2 the right way to fix this?
>>
>> Ryan, do all addresses on the AST2400's APB respond to single byte accesses?
>>
>>>>
>>>> If you have access to the datasheet and can verify, then yes.
>>>> Else I suppose Cédric, Andrew or Joel can check for you.
>>>
>>> I do not have a datasheet. Aspeed seems quite picky about sharing this
>>> and I'm just a random researcher.
>>
>> Erik, can you point us to the image you're using?
> 
> SMT_X11_158.bin
> 
> You can get it on
> https://www.supermicro.com/en/products/motherboard/X11SSL-F by
> clicking on "BMC/IPMI Firmware" on the right.
> 
>> What is the command line are you testing with?
> 
> qemu-system-arm -machine palmetto-bmc -m 512 -drive
> file=SMT_X11_158.bin,format=raw,if=mtd -nodefaults -nographic -serial
> stdio
> 
> Best regards,
> 
> Erik Smit
> 

Here is a quick fix. But I think we should change valid.min_access_size
for all Aspeed models since the reads can be done with 1/2/4 bytes.
 
    aspeed/scu: Fix valid access size on AST2400
    
    The read access size of the SCU registers can be 1/2/4 bytes. Write is
    only 4 bytes.
    
    Signed-off-by: Cédric Le Goater <clg@kaod.org>

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 0ccbab7afb60..ca37f935f607 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -327,7 +327,7 @@ static const MemoryRegionOps aspeed_ast2400_scu_ops = {
     .read = aspeed_scu_read,
     .write = aspeed_ast2400_scu_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
-    .valid.min_access_size = 4,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .valid.unaligned = false,
 };



With this patch, the supermicro firmware boots further but there is still 
an issue. It might be the flash definition I used. The machine is detected
as an AST2300 SoC which is weird.

Cheers,

C.



U-Boot 2009.01 ( 4月 02 2019 - 15:29:02) ASPEED (v.0.21) 

I2C:   ready
DRAM:  128 MB
Flash: 32 MB
*** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial
H/W:   AST2400 series chip
COM:   port1 and port2
PWM:   port[ABCDH]
Hit any key to stop autoboot:  0 
## Booting kernel from Legacy Image at 21400000 ...
   Image Name:   21400000
   Image Type:   ARM Linux Kernel Image (gzip compressed)
   Data Size:    1536645 Bytes =  1.5 MB
   Load Address: 40008000
   Entry Point:  40008000
   Verifying Checksum ... cramfs size 15032320
cramfs size 7315456
OK
   Uncompressing Kernel Image ... OK

Starting kernel ...

Linux version 2.6.28.9 (root@localhost) (gcc version 4.9.1 (crosstool-NG 1.20.0) ) #1 Wed Nov 20 18:20:38 CST 2019
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00093177
CPU: VIVT data cache, VIVT instruction cache
Machine: ASPEED-AST2300
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 20066
Kernel command line: console=ttyS1,115200 root=/dev/mtdblock2 rootfstype=cramfs noinitrd rw mem=79M
PID hash table entries: 512 (order: 9, 2048 bytes)
Console: colour dummy device 80x30
console [ttyS1] enabled
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 79MB = 79MB total
Memory: 76736KB available (2848K code, 358K data, 112K init)
SLUB: Genslabs=12, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Calibrating delay loop... 835.58 BogoMIPS (lpj=4177920)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
net_namespace: 636 bytes
NET: Registered protocol family 16
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
NET: Registered protocol family 1
NetWinder Floating Point Emulator V0.97 (extended precision)
NTFS driver 2.1.29 [Flags: R/W].
JFFS2 version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
fuse init (API version 7.10)
msgmni has been set to 149
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Non-volatile memory driver v1.2
ttyS0 at MMIO 0x1e783000 (irq = 9) is a ASPEED UART
ttyS1 at MMIO 0x1e784000 (irq = 10) is a ASPEED UART
brd: module loaded
loop: module loaded
nbd: registered device at major 43
Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
BMC flash ID:0x19ba20
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.28.9 #1)
pc : [<c017916c>]    lr : [<c01c6ec4>]    psr: 60000013
sp : c481de28  ip : c481de38  fp : c481de34
r10: 00000000  r9 : c481c028  r8 : c030b434
r7 : c030b5c0  r6 : 0019ba20  r5 : c0304240  r4 : c0304240
r3 : 0000008c  r2 : c02cc4e8  r1 : 00000000  r0 : c02cc4e9
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00093177  Table: 40004000  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc481c268)
Stack: (0xc481de28 to 0xc481e000)
de20:                   c481de64 c481de38 c01c6ec4 c0179168 c001f490 c001f51c 
de40: c001f494 c001f51c 00000000 c030b5c0 c01c6dcc c481c028 c481dfdc c481de68 
de60: c00242c4 c01c6dd8 00000000 00000044 c0065200 000212d0 00000000 00000000 
de80: 00000000 00003433 00000000 00000000 00000000 ffffffff 00000000 00000000 
dea0: 00000000 ffffffff 00000000 00000000 00000000 c0330210 00000000 c481df4c 
dec0: 000003e0 c4803480 c481df2c c481ded8 c01756b8 c007e608 00000000 00000000 
dee0: 000080d0 c4816130 00000000 c033b29c 000080d0 00000000 c481df24 c481df08 
df00: c0175874 c482eb80 c482f5a0 c032f694 00000000 00000000 00000000 00000000 
df20: c481df3c c481df30 c01756e8 c0175528 c481df6c c481df40 c00b9294 c01756dc 
df40: c482f5a0 c02a166b c032f694 00000062 c482eb80 0000002b c032f694 00000000 
df60: c481df8c c481df70 c00b99f4 c00b9268 c481df8c c482f5a0 c00b9978 c02f3564 
df80: c481dfbc c481df90 c005e890 c00b998c c481dfac 00003334 00000000 c0010000 
dfa0: c481dfbc 0000007f c02f2b4c c02f2b50 c481dfdc c001f494 c001f51c 00000000 
dfc0: 00000000 00000000 00000000 00000000 c481dff4 c481dfe0 c0008a08 c002427c 
dfe0: 00000000 00000000 00000000 c481dff8 c003f8b8 c000899c 00000000 00000000 
Backtrace: 
Function entered at [<c017915c>] from [<c01c6ec4>]
Function entered at [<c01c6dcc>] from [<c00242c4>]
 r9:c481c028 r8:c01c6dcc r7:c030b5c0 r6:00000000 r5:c001f51c
r4:c001f494
Function entered at [<c0024270>] from [<c0008a08>]
Function entered at [<c0008990>] from [<c003f8b8>]
 r5:00000000 r4:00000000
Code: e1a0c00d e92dd800 e24cb004 e2402001 (e4d13001) 
---[ end trace 8e932b3f82a003bb ]---
Kernel panic - not syncing: Attempted to kill init!




