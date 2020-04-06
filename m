Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35656C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01A20206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNIYia9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A20206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOxk-0003TI-4g
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jLOvd-0001PI-GD
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jLOva-0001d0-Qx
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:24:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45964
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jLOva-0001bu-Nk
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586168665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FjiifhrLC2UJGaxj4SGQ4znuCgY+VR/nsmZmZTzV1a4=;
 b=dNIYia9IYEuT7lWzLuUADjNBbDjQFWIIgwliAfpSj/A96l8GfJHbORCEK/nCgkIFb5UpYN
 D9MaLNC1smUSayjFGJGIi+p2WC6cDj+2TllaVuBOeOrcPopqVFsLD95yF6ULnbFu5/TBjZ
 PZK7bo7vUAilwYgOEN4KbU9CWNoox/A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-UO5Y1m9VONuNI1uAPk2GjA-1; Mon, 06 Apr 2020 06:24:17 -0400
X-MC-Unique: UO5Y1m9VONuNI1uAPk2GjA-1
Received: by mail-ed1-f70.google.com with SMTP id i61so11337156edc.2
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 03:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FjiifhrLC2UJGaxj4SGQ4znuCgY+VR/nsmZmZTzV1a4=;
 b=cvVsL9mX52Mt27eSGB99OxTb+QW+mXCMNirspuvbQGLDDnguVoXqlufnohoI0OdCxv
 oMxq5+VtarHOzJF+9xXIdovZ5U/wD2+8hLN3gM4rnciCjaGK3C2EfzjZfHZhhOCJQviM
 pKEbmBOgkd1Qt5+Q3MCqgUXFF1xwXOBdbkkkXbbQT4WdmyLnjhec1vOkcbCCz5DqaX8F
 RS2cz3NknT7qy67b4nC9KeZN0lkD8AdZ5tW+GJ5TWD/B3WSQdXMfgyvdXGP1hIi99eAb
 3d+zYz0EVVIMClyx7itw8KLaUJ2FzxXrGol5hv/2NHDeITJqJK/U8mm4kRrqaXLPS/9g
 DNgQ==
X-Gm-Message-State: AGi0PuZwYkjzgQy35XBhLhJqZIbOSsJ70hS4TKuTavJM0Gosf5GVumB7
 FTn3zNXt2Nx7aJDVKhRwuvRQcbLmPgisIJ2cFImstFgzmcEllUL8oURypBgXxe2OX59BYP6bCTx
 zU/sl9RWKOX0dFhY=
X-Received: by 2002:a17:906:1e42:: with SMTP id
 i2mr19766367ejj.317.1586168655725; 
 Mon, 06 Apr 2020 03:24:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypKvSQT421JOTO9LGHDJfMFPuojHw1t8iL7f4Z88MKkcoJPe7jqCzGwb1NJj3NQKx6r9RR9+BQ==
X-Received: by 2002:a17:906:1e42:: with SMTP id
 i2mr19766343ejj.317.1586168655437; 
 Mon, 06 Apr 2020 03:24:15 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id v30sm2419759eda.68.2020.04.06.03.24.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2020 03:24:14 -0700 (PDT)
Subject: Re: [Qemu-devel PATCH v2 0/2] Add SmartFusion2 EMAC block
To: sundeep.lkml@gmail.com, jasowang@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <1586063624-13375-1-git-send-email-sundeep.lkml@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8783e9e6-e013-955b-c953-d203f59225d1@redhat.com>
Date: Mon, 6 Apr 2020 12:24:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1586063624-13375-1-git-send-email-sundeep.lkml@gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sundeep,

On 4/5/20 7:13 AM, sundeep.lkml@gmail.com wrote:
> From: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> 
> This patch set emulates Ethernet MAC block
> present in Microsemi SmartFusion2 SoC.
> 
> v2:
>    No changes. Fixed Signed-off mail id in patch 2/2
> 
> 
> Testing:
> 
> 1. Download u-boot.bin, uImage and msf2-devkit.dtb from
>     https://github.com/Subbaraya-Sundeep/qemu-test-binaries.git
> 2. Copy uImage and msf2-devkit.dtb to suitable Qemu tftp directory
> 3. Launch Qemu by
>     ./arm-softmmu/qemu-system-arm -M emcraft-sf2 -serial mon:stdio -kernel \
>     u-boot.bin -display none -nic user,tftp=<qemu tftp directory>
> 
> Example:
> ./arm-softmmu/qemu-system-arm -M emcraft-sf2 -serial mon:stdio -kernel u-boot -display none -nic user,tftp=/home/hyd1358/qemu_tftp
> 
> U-Boot 2010.03-00000-ga7695d6 (Apr 04 2020 - 15:07:27)
> 
> CPU  : SmartFusion2 SoC (Cortex-M3 Hard IP)
> Freqs: CORTEX-M3=142MHz,PCLK0=71MHz,PCLK1=71MHz
> Board: M2S-FG484-SOM Rev 1A, www.emcraft.com
> DRAM:  64 MB
> *** Warning - bad CRC, using default environment
> 
> In:    serial
> Out:   serial
> Err:   serial
> Net:   M2S_MAC
> 
> Hit any key to stop autoboot:  3  0
> 
> M2S-FG484-SOM> run netboot
> Using M2S_MAC device
> TFTP from server 10.0.2.2; our IP address is 10.0.2.15
> Filename 'uImage'.
> Load address: 0xa0007fc0
> Loading: *#################################################################
>   #################################################################
>   #################################################################
>   ###############################################################
> done
> Bytes transferred = 3681568 (382d20 hex)
> Using M2S_MAC device
> TFTP from server 10.0.2.2; our IP address is 10.0.2.15
> Filename 'msf2-devkit.dtb'.
> Load address: 0xa0000200
> Loading: *#
> done
> Bytes transferred = 1712 (6b0 hex)
> ## Booting kernel from Legacy Image at a0007fc0 ...
>     Image Name:
>     Image Type:   ARM Linux Kernel Image (uncompressed)
>     Data Size:    3681504 Bytes =  3.5 MB
>     Load Address: a0008000
>     Entry Point:  a0008001
>     Verifying Checksum ... OK
>     Loading Kernel Image ... OK
> OK
> 
> Starting kernel ...
> 
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.5.0-gb0e5502-dirty (hyd1358@hyd1358) (gcc version 4.4.1 (Sourcery G++ Lite 2010q1-189) ) #85 PREEMPT Sat Apr 4 23:26:40 IST 2020
> [    0.000000] CPU: ARMv7-M [410fc231] revision 1 (ARMv7M), cr=00000000
> [    0.000000] CPU: unknown data cache, unknown instruction cache
> [    0.000000] Machine model: Microsemi SmartFusion 2 development board
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
> [    0.000000] Kernel command line: console=ttyS0,115200n8 panic=10 mem=64M@0xa0000000 earlyprintk
> [    0.000000] PID hash table entries: 256 (order: -2, 1024 bytes)
> [    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> [    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> [    0.000000] Memory: 61212K/65536K available (1612K kernel code, 75K rwdata, 680K rodata, 1224K init, 120K bss, 4324K reserved, 0K cma-reserved)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0x00000000 - 0x00001000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> [    0.000000]     vmalloc : 0x00000000 - 0xffffffff   (4095 MB)
> [    0.000000]     lowmem  : 0xa0000000 - 0xa4000000   (  64 MB)
> [    0.000000]     modules : 0xa0000000 - 0xa0800000   (   8 MB)
> [    0.000000]       .text : 0xa0008000 - 0xa02453e8   (2293 kB)
> [    0.000000]       .init : 0xa0246000 - 0xa0378000   (1224 kB)
> [    0.000000]       .data : 0xa0378000 - 0xa038ace0   (  76 kB)
> [    0.000000]        .bss : 0xa038ace0 - 0xa03a8ea0   ( 121 kB)
> [    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> [    0.000000] Preemptible hierarchical RCU implementation.
> .
> .
> .
> [    0.445184] Found M2S MAC at 0x40041000, irq 18
> [    0.448810] libphy: msf2 MII bus: probed
> [    0.527047] ipip: IPv4 over IPv4 tunneling driver
> [    0.532367] NET: Registered protocol family 10
> [    0.542307] sit: IPv6 over IPv4 tunneling driver
> [    0.544655] NET: Registered protocol family 17
> [    0.565395] Freeing unused kernel memory: 1224K (a0246000 - a0378000)
> init started: BusyBox v1.31.1 (2020-01-25 20:01:06 IST)
> starting pid 26, tty '': '/etc/rc'
> starting pid 31, tty '/dev/ttyS0': '/bin/hush -i'
> 
> 
> BusyBox v1.31.1 (2020-01-25 20:01:06 IST) hush - the humble shell
> Enter 'help' for a list of built-in commands.
> 
> / # ifconfig eth0 10.0.2.15
> [   11.116091] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> / # [   11.653634] eth0: link up (100/full)
> [   11.655246] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> 
> / # ls
> dev   proc  sys   etc   usr   bin   tmp   sbin  mnt   init
> / # tftp -gr uImage 10.0.2.2
> [   40.780983] random: nonblocking pool is initialized
> / # ls
> dev     sys     usr     tmp     mnt     uImage
> proc    etc     bin     sbin    init
> / #

Thanks for the use case example!

Do you mind adding it to our test suite? There are various examples in 
tests/acceptance/boot_linux_console.py.

Thanks!

Phil.
> 
> Subbaraya Sundeep (2):
>    hw/net: Add Smartfusion2 emac block
>    msf2: Add EMAC block to SmartFusion2 SoC
> 
>   MAINTAINERS                |   2 +
>   hw/arm/msf2-soc.c          |  21 +-
>   hw/net/Makefile.objs       |   1 +
>   hw/net/msf2-emac.c         | 556 +++++++++++++++++++++++++++++++++++++++++++++
>   include/hw/arm/msf2-soc.h  |   3 +
>   include/hw/net/msf2-emac.h |  50 ++++
>   6 files changed, 632 insertions(+), 1 deletion(-)
>   create mode 100644 hw/net/msf2-emac.c
>   create mode 100644 include/hw/net/msf2-emac.h
> 


