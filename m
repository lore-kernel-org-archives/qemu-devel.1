Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC56C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9551E2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9551E2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juuaA-0003dg-Tz
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1juuZF-0002mc-Je
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:16:09 -0400
Received: from 16.mo1.mail-out.ovh.net ([178.33.104.224]:45690)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1juuZB-0004sr-91
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:16:09 -0400
Received: from player716.ha.ovh.net (unknown [10.110.171.136])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 6F1C81CD3A7
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 11:16:02 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player716.ha.ovh.net (Postfix) with ESMTPSA id DA447143AA1CC;
 Mon, 13 Jul 2020 09:15:59 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002f97c3a62-5fee-4c34-9e0c-cb9941785b04,29C60B8BFD44B6CD822E82BF6A6060F4508BB267)
 smtp.auth=clg@kaod.org
Subject: Re: hw/misc/aspeed_scu: 5d971f9e breaks Supermicro AST2400
To: Erik Smit <erik.lucas.smit@gmail.com>
References: <CA+MHfoubt1g2FzcjTw3a0vNr7X2T8Jb+nYoc4_x=Z2TP51afKg@mail.gmail.com>
 <a7acba46-5a9a-5dd2-71c6-7e4586485823@amsat.org>
 <CA+MHfot6FdS2yT0mEsCW36bCfwy-WY-1KPQ-KDfYBKzTy=Gd7w@mail.gmail.com>
 <CACPK8Xdqr+EufMgooCY=D+Vt98qu11YTHE5Fzi5+xqX=wKReeQ@mail.gmail.com>
 <CA+MHfouin6Zmz+GrjWRCc_WzPF=ff-z_5V7BLv0HkL+SW9bRoQ@mail.gmail.com>
 <8879bfee-752b-c4e2-7646-c42dec84a440@kaod.org>
 <CA+MHfou6ijtwjzWye6CKaqTa4sKxF1WmgH9juaSdO344uP2UZA@mail.gmail.com>
 <2c326d1c-3b91-96f4-20c0-2e2e1be9b2ad@kaod.org>
 <CA+MHfotwwdVVJmYrWVRrUU7zwJ1jV21bKCWGBFKnCJeoRjtUvA@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <fce104e2-94d8-a909-20c3-2429db636e95@kaod.org>
Date: Mon, 13 Jul 2020 11:15:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CA+MHfotwwdVVJmYrWVRrUU7zwJ1jV21bKCWGBFKnCJeoRjtUvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2761269524443728704
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrvdekgdduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepkefhtedufeffvedvleejgeeghedvgeeuieeufeejueeltddugeduhedvveelgfehnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejudeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.33.104.224; envelope-from=clg@kaod.org;
 helo=16.mo1.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 05:16:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 10:58 AM, Erik Smit wrote:
> On Mon, 13 Jul 2020 at 10:37, Cédric Le Goater <clg@kaod.org> wrote:
>> On 7/13/20 10:06 AM, Erik Smit wrote:
>>> On Mon, 13 Jul 2020 at 09:52, Cédric Le Goater <clg@kaod.org> wrote:
>>>>
>>>> With this patch, the supermicro firmware boots further but there is still
>>>> an issue. It might be the flash definition I used. The machine is detected
>>>> as an AST2300 SoC which is weird.
>>>
>>>> BMC flash ID:0x19ba20
>>>> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>>>
>>> The firmware is expecting the flash ID to repeat. The following makes it boot.
>>
>> That doesn't work for me.
> 
> You'll probably also need
> https://github.com/qemu/qemu/commit/2d6c7194c230d334da70b88b1bee5e616595cabd

Nice. You should send that one.

It looks much better. the machine reaches a shell but there are still
some issues and it reboots (ipmi_kcs). 

I don't know what are these faults :

  Unhandled fault: external abort on non-linefetch (0x008) at 0xc50f0000

Thanks,

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
Calibrating delay loop... 653.72 BogoMIPS (lpj=3268608)
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
BMC flash ID:0xc21920c2
 platform_flash: MX25L25635E (32768 Kbytes)
Creating 7 MTD partitions on "spi0.0":
0x00000000-0x00100000 : "bootloader"
0x00100000-0x00400000 : "nvram"
0x00400000-0x01400000 : "rootFS"
0x01400000-0x01700000 : "kernel"
0x01700000-0x01f40000 : "webpage"
0x00000000-0x01fc0000 : "all_part"
0x01fc0000-0x01fd0000 : "uboot_env"
mice: PS/2 mouse device common for all mice
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP cubic registered
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ip6_tables: (C) 2000-2006 Netfilter Core Team
IPv6 over IPv4 tunneling driver
sit0: Disabled Privacy Extensions
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
VFS: Mounted root (cramfs filesystem) readonly.
Freeing init memory: 112K
starting pid 335, tty '': '/etc/init.d/rcS'
udevd[360]: specified group 'tty' unknown

udevd[360]: specified group 'kmem' unknown

populate devices node .............
Block at 0x00000000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00000000 is not formatted. It will be erased
Block at 0x00010000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00010000 is not formatted. It will be erased
Block at 0x00020000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00020000 is not formatted. It will be erased
Block at 0x00030000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00030000 is not formatted. It will be erased
Block at 0x00040000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00040000 is not formatted. It will be erased
Block at 0x00050000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00050000 is not formatted. It will be erased
Block at 0x00060000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00060000 is not formatted. It will be erased
Block at 0x00070000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00070000 is not formatted. It will be erased
Block at 0x00080000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00080000 is not formatted. It will be erased
Block at 0x00090000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00090000 is not formatted. It will be erased
Block at 0x000a0000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x000a0000 is not formatted. It will be erased
Block at 0x000b0000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x000b0000 is not formatted. It will be erased
Block at 0x000c0000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x000c0000 is not formatted. It will be erased
Block at 0x000d0000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x000d0000 is not formatted. It will be erased
Block at 0x000e0000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x000e0000 is not formatted. It will be erased
Block at 0x000f0000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x000f0000 is not formatted. It will be erased
Block at 0x00100000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00100000 is not formatted. It will be erased
Block at 0x00110000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00110000 is not formatted. It will be erased
Block at 0x00120000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00120000 is not formatted. It will be erased
Block at 0x00130000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00130000 is not formatted. It will be erased
Block at 0x00140000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00140000 is not formatted. It will be erased
Block at 0x00150000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00150000 is not formatted. It will be erased
Block at 0x00160000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00160000 is not formatted. It will be erased
Block at 0x00170000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00170000 is not formatted. It will be erased
Block at 0x00180000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00180000 is not formatted. It will be erased
Block at 0x00190000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00190000 is not formatted. It will be erased
Block at 0x001a0000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x001a0000 is not formatted. It will be erased
Block at 0x001b0000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x001b0000 is not formatted. It will be erased
Block at 0x001c0000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x001c0000 is not formatted. It will be erased
Block at 0x001d0000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x001d0000 is not formatted. It will be erased
Block at 0x001e0000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x001e0000 is not formatted. It will be erased
Block at 0x001f0000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x001f0000 is not formatted. It will be erased
Block at 0x00200000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00200000 is not formatted. It will be erased
Block at 0x00210000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00210000 is not formatted. It will be erased
Block at 0x00220000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00220000 is not formatted. It will be erased
Block at 0x00230000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00230000 is not formatted. It will be erased
Block at 0x00240000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00240000 is not formatted. It will be erased
Block at 0x00250000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00250000 is not formatted. It will be erased
Block at 0x00260000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00260000 is not formatted. It will be erased
Block at 0x00270000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00270000 is not formatted. It will be erased
Block at 0x00280000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00280000 is not formatted. It will be erased
Block at 0x00290000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x00290000 is not formatted. It will be erased
Block at 0x002a0000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x002a0000 is not formatted. It will be erased
Block at 0x002b0000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x002b0000 is not formatted. It will be erased
Block at 0x002c0000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x002c0000 is not formatted. It will be erased
Block at 0x002d0000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x002d0000 is not formatted. It will be erased
Block at 0x002e0000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x002e0000 is not formatted. It will be erased
Block at 0x002f0000: free 0x00000000, dirty 0x00010000, unchecked 0x00000000, used 0x00000000, wasted 0x00000000
JFFS2: Erase block at 0x002f0000 is not formatted. It will be erased
Cowardly refusing to erase blocks on filesystem with no valid JFFS2 nodes
c->nr_free_blocks 0, empty_blocks 0, bad_blocks 0, c->nr_blocks 48
format partition......
Erasing 64 Kibyte @ 2f0000 -- 100 % complete 
Block at 0x00000000 is empty (erased)
Block at 0x00010000 is empty (erased)
Block at 0x00020000 is empty (erased)
Block at 0x00030000 is empty (erased)
Block at 0x00040000 is empty (erased)
Block at 0x00050000 is empty (erased)
Block at 0x00060000 is empty (erased)
Block at 0x00070000 is empty (erased)
Block at 0x00080000 is empty (erased)
Block at 0x00090000 is empty (erased)
Block at 0x000a0000 is empty (erased)
Block at 0x000b0000 is empty (erased)
Block at 0x000c0000 is empty (erased)
Block at 0x000d0000 is empty (erased)
Block at 0x000e0000 is empty (erased)
Block at 0x000f0000 is empty (erased)
Block at 0x00100000 is empty (erased)
Block at 0x00110000 is empty (erased)
Block at 0x00120000 is empty (erased)
Block at 0x00130000 is empty (erased)
Block at 0x00140000 is empty (erased)
Block at 0x00150000 is empty (erased)
Block at 0x00160000 is empty (erased)
Block at 0x00170000 is empty (erased)
Block at 0x00180000 is empty (erased)
Block at 0x00190000 is empty (erased)
Block at 0x001a0000 is empty (erased)
Block at 0x001b0000 is empty (erased)
Block at 0x001c0000 is empty (erased)
Block at 0x001d0000 is empty (erased)
Block at 0x001e0000 is empty (erased)
Block at 0x001f0000 is empty (erased)
Block at 0x00200000 is empty (erased)
Block at 0x00210000 is empty (erased)
Block at 0x00220000 is empty (erased)
Block at 0x00230000 is empty (erased)
Block at 0x00240000 is empty (erased)
Block at 0x00250000 is empty (erased)
Block at 0x00260000 is empty (erased)
Block at 0x00270000 is empty (erased)
Block at 0x00280000 is empty (erased)
Block at 0x00290000 is empty (erased)
Block at 0x002a0000 is empty (erased)
Block at 0x002b0000 is empty (erased)
Block at 0x002c0000 is empty (erased)
Block at 0x002d0000 is empty (erased)
Block at 0x002e0000 is empty (erased)
Block at 0x002f0000 is empty (erased)
JFFS2 notice: (543) jffs2_build_xattr_subsystem: complete building xattr subsystem, 0 of xdatum (0 unchecked, 0 orphan) and 0 of xref (0 dead, 0 orphan) found.
Warning: Bad CRC, using default environment
Ethernet Channel Bonding Driver: v3.3.0 (June 10, 2008)
bonding: MII link monitoring set to 100 ms
usb_drv.c: usb_init - User defind MAJOR NUM # 222.
usb_init - Request USB Driver IRQ successful., 5
Unhandled fault: external abort on non-linefetch (0x808) at 0xc5800000
Internal error: : 808 [#1]
Modules linked in: video_drv(+) ikvm_vmass bonding
CPU: 0    Not tainted  (2.6.28.9 #1)
pc : [<c01741c4>]    lr : [<00000000>]    psr: 20000013
sp : c40bfdb4  ip : 00000000  fp : c40bfdd4
r10: 00000000  r9 : c40be008  r8 : bf0213fc
r7 : bf021b7e  r6 : 00000000  r5 : bf024d98  r4 : bf022da0
r3 : 00000000  r2 : 00000000  r1 : 003fffc0  r0 : c5800000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 00093177  Table: 44050000  DAC: 00000015
Process insmod (pid: 581, stack limit = 0xc40be268)
Stack: (0xc40bfdb4 to 0xc40c0000)
fda0:                                              bf020cfc fe6e2fff bf021fb4 
fdc0: bf022da0 bf024d98 c40bfe04 c40bfdd8 bf0214c8 bf020c88 bf021b7e 00000001 
fde0: c48e4600 bf022c80 00006150 0008f058 c030b5c0 bf0213fc c40bff7c c40bfe08 
fe00: c00242c4 bf021408 c004be80 c007e69c 20000013 fffffffe c40bfe54 c40bfe28 
fe20: c004c19c c004be5c c40bfe54 00000000 c40bfe30 c40bfe30 c4809000 c033b2a8 
fe40: c49ac3c0 c4809000 c40bfeac c40bfe58 c01767bc c007e69c c03c7520 c030ae3c 
fe60: c40bfe8c c40bfe70 c0064860 c0063f48 00000006 c4b81280 c5095000 00000001 
fe80: c40bfe9c c40bfe90 c00648e4 c0064698 c40bfeac c40bfea0 c0064924 00000007 
fea0: c40bfecc c40bfeb0 c0077c68 c007e69c bf022c80 00000000 c5095000 00000000 
fec0: c40bfedc c40bfed0 c0077cc0 c0077bc0 c40bff7c c40bfee0 c005ae48 c0077c8c 
fee0: 00000000 c40bff38 00006150 00000000 000000e4 c40bff44 000000e4 c509aa08 
ff00: c5098f74 c5099208 c4a10330 00000000 c5099208 00000010 bf022c8c c5098eb1 
ff20: 00000000 c40bff30 c0082fbc c00956e4 00000000 c40bff78 00000000 00000000 
ff40: 00000000 bf022c80 00006150 0008f058 00000000 bf022c80 00006150 0008f058 
ff60: 00000000 c0024f28 c40be000 00000000 c40bffa4 c40bff80 c005b1d8 c002427c 
ff80: c002b244 c002af0c 00006150 bed1dece 00000002 00000080 00000000 c40bffa8 
ffa0: c0024d80 c005b150 00006150 bed1dece 0008f058 00006150 0008f008 bed1dece 
ffc0: 00006150 bed1dece 00000002 00000080 00000000 bed1ddf4 00000000 00000000 
ffe0: bed1dc38 bed1dc28 00013ca0 4019b890 60000010 0008f058 00000000 00000000 
Backtrace: 
Function entered at [<bf020c7c>] from [<bf0214c8>]
 r6:bf024d98 r5:bf022da0 r4:bf021fb4 r3:fe6e2fff
Function entered at [<bf0213fc>] from [<c00242c4>]
 r8:bf0213fc r7:c030b5c0 r6:0008f058 r5:00006150 r4:bf022c80
Function entered at [<c0024270>] from [<c005b1d8>]
Function entered at [<c005b144>] from [<c0024d80>]
 r7:00000080 r6:00000002 r5:bed1dece r4:00006150
Code: e52de004 e1a0c002 e1a0e002 e2511040 (a8a0500c) 
---[ end trace 3c0924dba84c0300 ]---
Segmentation fault
USB HID Module insert, Build Time 18:21:14
RegisterDevice : p_St_Dev->b_DevicesBitMap=1  !! 
usb: DevEnable =====        0!! ====, speed = 0
I2C Module insert, Build Time 18:21:06
[DRIVER] Insert the driver module insmod /bin/module/i2c.ko BoardID=0x0 
[CHE_DBG_I2C] Create file.
[CHE_DBG_I2C] Failed to create file.
=============== Platform Setting ====================
HWConfig= 0, Board ID= 0
Perpherial Lists:
======================================================
[DRIVER] Insert the driver module insmod /bin/module/gpiodrv.ko BoardID=0x0 
can't open file /nv/FRUBlock
[LibFRUTool_LoadData] fail to read FRU1
erase_sector at 0x003d0000
erase_sector at 0x003c0000
erase_sector at 0x003b0000
erase_sector at 0x003a0000
ftgmac: module license 'unspecified' taints kernel.
FTGMAC100: ASPEED FTGMAC Driver, (Linux Kernel 2.6.28.9) 09/13/2010 - by ASPEED
MAC1 Support NCSI
FTGMAC100: eth0:ftgmac100_reset, phyAddr=0x0, miiPhyId=0x0000_0002
Intel NCSI can be supported.
wait for completing PHY reset. count 0
FTGMAC100: eth1:ftgmac100_reset, phyAddr=0x0, miiPhyId=0x001c_c915
RTL8211 PHY chip can be supported.
PHY Link speed 10M
erase_sector at 0x00390000
erase_sector at 0x00380000
erase_sector at 0x00370000
erase_sector at 0x00360000
erase_sector at 0x00350000
erase_sector at 0x00340000
erase_sector at 0x00330000
[DRIVER] Insert the driver module insmod /bin/module/ftgmac.ko BoardID=0x0 
Retry open file /nv/FRUBlock ....
Load Default FRU from firmware(/etc/conf)
FRU recovery because of checksum error
erase_sector at 0x00320000
Retry open file /nv/SDRBlock ....
Load Default SDR from firmware(/etc/conf)
open /nv/platform.conf failed
NVRamInit fails to initial SDR
NVRamInit fails to initial
Retry open file /nv/PSBlock ....
Retry open file /nv/OEMPSBlock ....
===============PS.c:NVRamInit fail=================
===============PS.c:recovery OEMPS=================
erase_sector at 0x00310000
erase_sector at 0x00300000
erase_sector at 0x002f0000
Retry open file /nv/OEMPSBlock ....
erase_sector at 0x002e0000
erase_sector at 0x002d0000
erase_sector at 0x002c0000
===============PS.c:recovery ps=================
Warning: Bad CRC, using default environment
Got the default zero MAC address !
erase_sector at 0x002b0000
Retry open file /nv/PSBlock ....
erase_sector at 0x002a0000
erase_sector at 0x00290000
erase_sector at 0x00280000
erase_sector at 0x00270000
erase_sector at 0x00260000
erase_sector at 0x00250000
erase_sector at 0x00240000
erase_sector at 0x00230000
Adding password for user ADMIN
erase_sector at 0x00220000
erase_sector at 0x00210000
erase_sector at 0x00200000
erase_sector at 0x001f0000
erase_sector at 0x001e0000
erase_sector at 0x001d0000
erase_sector at 0x001c0000
erase_sector at 0x001b0000
erase_sector at 0x001a0000
erase_sector at 0x00190000
erase_sector at 0x00180000
erase_sector at 0x00170000
erase_sector at 0x00160000
erase_sector at 0x00150000
erase_sector at 0x00140000
erase_sector at 0x00130000
erase_sector at 0x00120000
erase_sector at 0x00110000
erase_sector at 0x00100000
erase_sector at 0x003f0000
IPMB Module insert, Build Time 18:21:06
IPMB num = 2
[IPMB] Channel=4  Slave address 0x20
[IPMB] Channel=5  Slave address 0x20
[DRIVER] Insert the driver module insmod /bin/module/ipmb.ko BoardID=0x0  bmc_address=32 ipmb_channel=4,5
[DRIVER] Insert the driver module insmod /bin/module/wdt_drv.ko BoardID=0x0 
[GPIOTypeSetup]
[GPIOTypeSetup]
[DRIVER] Insert the driver module insmod /bin/module/uart_drv.ko BoardID=0x0 
Retry open file /nv/SELBlock ....
Retry open file /nv/SELBlock ....
Warning: Bad CRC, using default environment
Update uboot env ipaddr = 192.168.42.27
Warning: Bad CRC, using default environment
erase_sector at 0x01fc0000
Update uboot env netmask = 0.0.0.0
erase_sector at 0x01fc0000
configure mouse mode!
UnRegisterDevice : p_St_Dev->b_DevicesBitMap=0  !! 
RegisterDevice : p_St_Dev->b_DevicesBitMap=1  !! 
usb: DevEnable =====        0!! ====, speed = 0
[UtilUsbHidSetMouseMode] The current Modes Absolute Mode
[DRIVER] Insert the driver module insmod /bin/module/peci.ko BoardID=0x0 
[DRIVER] Insert the driver module insmod /bin/module/ast_mctp.ko BoardID=0x0 
[UtilSDRCmdsInit] SDR records: 0
[UtilSDRCmdsInit] Sensor number: 0
[GPIOTypeSetup]
Loading the configuration of the riser card
can't open file /nv/riser_card.conf
Load Riser Card error , reset information of Riser
/nv/sum_toggling.conf not exists!
/nv/sum_toggling.conf is changed! (st_size=0, size=3)
DCMI_module initialize .... 
Create debug files - /tmp/message
config /nv/service.conf doesn't exist. Copy the default file.
Starting VM daemon .....
Unhandled fault: external abort on non-linefetch (0x008) at 0xc50f0000
Internal error: : 8 [#2]
Modules linked in: kcs_drv(+) ast_mctp peci uart_drv wdt_drv ipmb ftgmac(P) gpiodrv i2c usb_hid video_drv(+) ikvm_vmass bonding
CPU: 0    Tainted: P      D     (2.6.28.9 #1)
pc : [<bf0612c0>]    lr : [<bf065160>]    psr: 80000013
sp : c3985d40  ip : c3985d58  fp : c3985d54
r10: 00000000  r9 : c3984008  r8 : 00000000
r7 : bf062af8  r6 : 00000000  r5 : 00000000  r4 : bf062440
r3 : bf062440  r2 : c50f0000  r1 : 00000020  r0 : 00000000
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 00093177  Table: 439d8000  DAC: 00000015
Process insmod (pid: 706, stack limit = 0xc3984268)
Stack: (0xc3985d40 to 0xc3986000)
5d40: 00000000 00000000 c3985e04 c3985d58 bf065160 bf0612a4 c3985d60 c030c020 
5d60: 74736f70 646f635f c0280065 c0038754 60000013 7fffffff c3985e2c c3984000 
5d80: 00000002 00000000 c4805280 c39a100c c3985dd4 c3985da0 c0282194 c0281d28 
5da0: c3985e2c 00000000 00000000 c4805280 c3985ddc c3985dc0 c0039dd0 7fffffff 
5dc0: c3985e2c c3984000 c3985e14 c3985dd8 c0281ab8 c0282180 c004c3a8 00000001 
5de0: c397f800 bf062320 000033e9 0008f060 c030b5c0 bf065000 c3985f7c c3985e08 
5e00: c00242c4 bf06500c c004be80 c007e69c 20000013 fffffffe c3985e54 c3985e28 
5e20: c004c19c c004be5c c3985e54 00000000 c3985e30 c3985e30 c39a1000 c033b2a8 
5e40: c39b8240 c39a1000 c3985eac c3985e58 c01767bc c007e69c c03c7f60 c030ae3c 
5e60: c3985e8c c3985e70 c0064860 c0063f48 00000003 c437e200 c50e9000 00000001 
5e80: c3985e9c c3985e90 c00648e4 c0064698 c3985eac c3985ea0 c0064924 00000004 
5ea0: c3985ecc c3985eb0 c0077c68 c007e69c bf062320 00000000 c50e9000 00000000 
5ec0: c3985edc c3985ed0 c0077cc0 c0077bc0 c3985f7c c3985ee0 c005ae48 c0077c8c 
5ee0: 00000000 c3985f38 000033e9 00000000 000000ac c3985f44 000000ac c50ebed4 
5f00: bf0303a4 c50eaddc c43c6c50 bf062290 c3985f38 bf062288 bf06232c c50ea871 
5f20: 00000001 bf062130 c0080001 c00956e4 00000000 c3985f78 00000000 00000001 
5f40: 00000000 bf062320 000033e9 0008f060 00000000 bf062320 000033e9 0008f060 
5f60: 00000000 c0024f28 c3984000 00000000 c3985fa4 c3985f80 c005b1d8 c002427c 
5f80: c002b244 c002af0c 000033e9 becf5f95 00000003 00000080 00000000 c3985fa8 
5fa0: c0024d80 c005b150 000033e9 becf5f95 0008f060 000033e9 0008f008 becf5f95 
5fc0: 000033e9 becf5f95 00000003 00000080 00000000 becf5ed4 00000000 00000000 
5fe0: becf5d18 becf5d08 00013ca0 4019b890 60000010 0008f060 00000000 00000000 
Backtrace: 
Function entered at [<bf061298>] from [<bf065160>]
Function entered at [<bf065000>] from [<c00242c4>]
 r8:bf065000 r7:c030b5c0 r6:0008f060 r5:000033e9 r4:bf062320
Function entered at [<c0024270>] from [<c005b1d8>]
Function entered at [<c005b144>] from [<c0024d80>]
 r7:00000080 r6:00000003 r5:becf5f95 r4:000033e9
Code: e59326e0 8a00000a e3510001 e3a01020 (e5d23000) 
---[ end trace 3c0924dba84c0300 ]---
Segmentation fault
[DRIVER] Insert the driver module insmod /bin/module/kcs_drv.ko BoardID=0x0 
can't open /dev/kcs2 phychno 2
Waiting for ready message from kernel
Recieve Events from NIC Drive
LAN Notifier Ready
get_vm_port(NoForStunnel:63631)
Unhandled fault: external abort on non-linefetch (0x008) at 0xc50f003c
Internal error: : 8 [#3]
Modules linked in: kcs_drv(+) ast_mctp peci uart_drv wdt_drv ipmb ftgmac(P) gpiodrv i2c usb_hid video_drv(+) ikvm_vmass bonding
CPU: 0    Tainted: P      D     (2.6.28.9 #1)
pc : [<bf06166c>]    lr : [<c0084b48>]    psr: 80000013
sp : c394de18  ip : c394de38  fp : c394de34
r10: 00000000  r9 : c0084a08  r8 : c3a37680
r7 : c3991510  r6 : bf062558  r5 : 00000000  r4 : 00000000
r3 : c50f003c  r2 : bf062440  r1 : 0000003c  r0 : c3991510
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 00093177  Table: 43958000  DAC: 00000015
Process ipmi_kcs (pid: 695, stack limit = 0xc394c268)
Stack: (0xc394de18 to 0xc394e000)
de00:                                                       00000000 00000000 
de20: bf062558 c3991510 c394de64 c394de38 c0084b48 bf06163c c008aa08 00000000 
de40: c48aa700 c3a37680 c3991510 c48e1a80 c44c1880 00000000 c394de8c c394de68 
de60: c0080208 c0084a14 c3a37680 00000003 c39a2000 00000006 ffffff9c 000000ac 
de80: c394deac c394de90 c00813e4 c0080094 00000000 00000002 00000003 00000000 
dea0: c394df64 c394deb0 c008bef4 c00813b4 00000003 c394dec0 c005324c c0178d34 
dec0: c394df84 c394ded0 c002b098 00000002 00000000 00000026 c02828f0 c0052998 
dee0: 0000c350 00000001 c48e1a80 c44c1880 befb58f4 00000001 00000001 00000101 
df00: 00000001 00000000 c00530e8 c0282858 0000c350 00000000 00000000 00000005 
df20: c4315cc8 c4315cc0 00000002 00000003 00000000 c3a37680 c0094330 00000002 
df40: 00000005 c39a2000 000000ac ffffff9c c394c000 00000000 c394df94 c394df68 
df60: c0081458 c008bbb0 000000a5 0000000c 000000a4 0001413c 0000000c 00000000 
df80: 00000005 c0024f28 c394dfa4 c394df98 c008150c c0081408 00000000 c394dfa8 
dfa0: c0024d80 c00814f0 0001413c 0000000c 00014210 00000002 000000ac 00000032 
dfc0: 0001413c 0000000c 00000000 00000005 0000000c 000000a4 00014210 00000000 
dfe0: 00000000 befb5aac 00009214 404b1f9c 60000010 00014210 00000000 00000000 
Backtrace: 
Function entered at [<bf061630>] from [<c0084b48>]
 r7:c3991510 r6:bf062558 r5:00000000 r4:00000000
Function entered at [<c0084a08>] from [<c0080208>]
 r8:00000000 r7:c44c1880 r6:c48e1a80 r5:c3991510 r4:c3a37680
Function entered at [<c0080088>] from [<c00813e4>]
 r9:000000ac r8:ffffff9c r7:00000006 r6:c39a2000 r5:00000003
r4:c3a37680
Function entered at [<c00813a8>] from [<c008bef4>]
 r4:00000000
Function entered at [<c008bba4>] from [<c0081458>]
Function entered at [<c00813fc>] from [<c008150c>]
 r8:c0024f28 r7:00000005 r6:00000000 r5:0000000c r4:0001413c
Function entered at [<c00814e4>] from [<c0024d80>]
Code: d283103c c28310ec e59236e0 e0833001 (e5d31000) 
---[ end trace 3c0924dba84c0300 ]---
ADDRCONF(NETDEV_UP): bond0: link is not ready
ifenslave: bond0: can't set hw address
ifenslave: can't enslave eth0 to bond0: Cannot assign requested address
ifenslave: bond0: can't set hw address
ifenslave: can't enslave eth1 to bond0: Cannot assign requested address
[debug] cmd = ip link set bond0 down
ip: SIOCSIFHWADDR: Cannot assign requested address
[UtilSetMACAddr Debug] cmd = ip link set eth0 addr 00:00:00:00:00:00
ip: SIOCSIFHWADDR: Cannot assign requested address
[UtilSetMACAddr Debug] cmd = ip link set eth1 addr 00:00:00:00:00:00
ADDRCONF(NETDEV_UP): bond0: link is not ready
ifenslave: bond0: can't set hw address
ifenslave: can't enslave eth0 to bond0: Cannot assign requested address
ifenslave: bond0: can't set hw address
ifenslave: can't enslave eth1 to bond0: Cannot assign requested address
udhcpc (v1.23.1) started
Starting IKVM daemon .....
[LanConfigApply Debug] arpping , cmd = arping -b -c 2 0.0.0.0 -I bond0 >>/dev/null
Sending discover...
arping: can't connect to remote host (0.0.0.0): Invalid argument
start Web server .............
config /nv/lighttpd_port.conf doesn't exist. Copy the default file.
enable IPv4 and IPv6 addressing...
ip: RTNETLINK answers: No such process
route: SIOCADDRT: Invalid argument
route: SIOCADDRT: Invalid argument
config /nv/lighttpd.conf doesn't exist. Copy the default file.
get_ikvm_port(NoForStunnel:63630)
get_ikvm_port(NoForStunnel:63630)
Making SSL certificate ...
Sending discover...
UART Set SerialMode = 0
Enable UtilEnableHWSOL COM2
UART no hardware flow control
Sending discover...
2019-11-20 10:30:50: (network.c.260) warning: please use server.use-ipv6 only for hostnames, not without server.bind / empty address; your config will break if the kernel default for IPV6_V6ONLY changes 
-n Starting sfcb: 
done.
udhcpc leasefail
No lease, forking to background
config /nv//wsman/openwsman.conf doesn't exist. Copy the default file.
config /nv/syslog.conf doesn't exist. Copy the default file.
Generating Dropbear RSA key. Please wait.
Starting STUNNEL .....
i2c_master_write_read ret = ffffffff
getPSFruData 0 failed

Please press Enter to activate this console. getPSFruData 1 failed
getPSFruData 2 failed
getPSFruData 3 failed

main, 814, /redfish_task_msg_queue3
ipmi[891]: RedfishAttachMsgQueue, own a valid message queue, ID = 3

Generating Dropbear DSS key. Please wait.
UtilGetSystemResetStatus=0
Starting SMASH daemon .....
process ipmi_kcs has problem!
starting pid 938, tty '': 'umount -a -r'
BusyBox v1.23.1 (2019-11-20 18:32:33 CST) multi-call binary.

Usage: umount [OPTIONS] FILESYSTEM|DIRECTORY

Unmount file systems

	-r	Try to remount devices as read-only if mount is busy
	-l	Lazy umount (detach filesystem)
	-f	Force umount (i.e., unreachable NFS server)
	-D	Don't free loop device even if it has been used

starting pid 939, tty '': 'swapoff -a'
The system is going down NOW!
'wait_event_interruptible' fail
usb terminated!
Sent SIGTERM to all processes
udevd[361]: worker [364] did not accept message -1 (Connection refused), kill it

Sent SIGKILL to all processes
Requesting system reboot
release vitual hub
Restarting system.

