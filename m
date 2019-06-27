Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CB1C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 12:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E78D22083B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 12:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78D22083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgTow-0006co-A7
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 08:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53257)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hgTo2-0006B7-QG
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hgTo0-0002RK-Bz
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:47:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35824)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hgTo0-00024e-3N
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:47:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id f15so2433856wrp.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 05:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BK01IBTXq/tRj+nONUGZyRKbu5iQ2bSozEijQ7zP7Ng=;
 b=EFTmNQJzp/bbLddyCLRUAfes7NGDQEjMV38cJkO1AQ5Whw4eoG4fyUhGxKOLwJoN5D
 yE0eZfZ3qmqa6DTRN921IJFoMew0UOF6DzKLhYwwcFA2PI7j5a4PUngSTrMulGJdLwic
 OgTPzZ/REGbHrVRuW+eMst7Eu4vr5KpWNQHEDluJJigFgge37v9ETt9IxXYVOPkD1xwU
 vqcbg7S9fTWo+fpklbrDAkDWqkj1cP/3z+8V2hngvXbcNrCKKh0MmTHYqp9NmjgJI6Wz
 PYBzP83Fm1SzBjQ47UFpuZdcMAEcdRd/bw2NsCVVVUS4fWtcB9UryWCZWHilHhU0xzbb
 linA==
X-Gm-Message-State: APjAAAUcjd3AQ5u+7kDA41fhFh7V85ecpn1Mf1pZYWj5ttk3wSMaQZga
 DQ9KoCCO5UiEsGdot7zl0FkRKg==
X-Google-Smtp-Source: APXvYqxHbQ+neuoZ13y6194ZiZs4Jr6Wrn+bCPA5LJIhJCeAjAmky+R0i0LFmNunhBsoWgp2aHlupA==
X-Received: by 2002:adf:f84f:: with SMTP id d15mr3160143wrq.53.1561639609206; 
 Thu, 27 Jun 2019 05:46:49 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id p140sm3490513wme.31.2019.06.27.05.46.48
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 05:46:48 -0700 (PDT)
To: KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20190627115331.2373-1-f4bug@amsat.org>
 <f27e2a5c-07dd-b118-7a85-c46587ffaf99@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f6a65ae9-11dd-8033-516a-9c12adbd6598@redhat.com>
Date: Thu, 27 Jun 2019 14:46:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f27e2a5c-07dd-b118-7a85-c46587ffaf99@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 0/3] tests/acceptance: Add tests for the
 Leon3 board
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/27/19 2:28 PM, KONRAD Frederic wrote:
> Hi Philippe,
> 
> Thanks for that!
> 
> I'm not aware at all of the tests/acceptance/* stuff.. How can we launch
> those
> tests?

$ make subdir-sparc-softmmu
$ make check-venv
$ tests/venv/bin/python -m avocado --show=app run
tests/acceptance/machine_sparc_leon3.py
JOB ID     : 12900968820fcd9ba2a03b9cfe2d060508c1d91c
JOB LOG    :
/home/phil/avocado/job-results/job-2019-06-27T14.38-1290096/job.log
 (1/2)
tests/acceptance/machine_sparc_leon3.py:Leon3Machine.test_leon3_helenos_uimage:
PASS (1.10 s)
 (2/2)
tests/acceptance/machine_sparc_leon3.py:Leon3Machine.test_leon3_linux_kernel_4_9_busybox:
PASS (3.72 s)
RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 |
CANCEL 0
JOB TIME   : 5.32 s

Due to a pending issue with the chardev console [*] , the Avocado
framework sometime hangs, so meanwhile I run tests in a loop and they
eventually succeed :S

[*] https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg01879.html

To get the console, and filter uimage tests:

$ tests/venv/bin/python -m avocado --show=app,console run -t
binfmt:uimage tests/acceptance/machine_sparc_leon3.py
JOB ID     : b1fb8e8a101c6a45d2f15e57a9faafee94cdf2b5
JOB LOG    :
/home/phil/avocado/job-results/job-2019-06-27T14.41-b1fb8e8/job.log
 (1/1)
tests/acceptance/machine_sparc_leon3.py:Leon3Machine.test_leon3_helenos_uimage:
 console: HelenOS bootloader, release 0.6.0 (Elastic Horse)
console: Built on 2014-12-21 20:17:42 for sparc32
console: Copyright (c) 2001-2014 HelenOS project
console: 0x4000bf20|0x4000bf20: kernel image (496640/128466 bytes)
console: 0x4002b4f2|0x4002b4f2: ns image (154195/66444 bytes)
console: 0x4003b87e|0x4003b87e: loader image (153182/66437 bytes)
console: 0x4004bc03|0x4004bc03: init image (155339/66834 bytes)
console: 0x4005c115|0x4005c115: locsrv image (162063/70267 bytes)
console: 0x4006d390|0x4006d390: rd image (152678/65889 bytes)
console: 0x4007d4f1|0x4007d4f1: vfs image (168480/73394 bytes)
console: 0x4008f3a3|0x4008f3a3: logger image (158034/68368 bytes)
console: 0x4009feb3|0x4009feb3: ext4fs image (234510/100301 bytes)
console: 0x400b8680|0x400b8680: initrd image (8388608/1668901 bytes)
console: ABMA devices:
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: <0:3000> at 0x00000000 irq 0
console: Memory size: 0 MB
console: Inflating components ... initrd ext4fs logger vfs rd locsrv
init loader ns kernel Booting the kernel ...
PASS (1.11 s)
RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 |
CANCEL 0
JOB TIME   : 1.48 s

The other test often timeouts due to [*]:

$ tests/venv/bin/python -m avocado --show=app,console run
tests/acceptance/machine_sparc_leon3.py
 (1/2)
tests/acceptance/machine_sparc_leon3.py:Leon3Machine.test_leon3_helenos_uimage:
PASS (1.19 s)
 (2/2)
tests/acceptance/machine_sparc_leon3.py:Leon3Machine.test_leon3_linux_kernel_4_9_busybox:
 console: PROMLIB: Sun Boot Prom Version 0 Revision 0
console: Linux version 4.9.54-00018-g62dab2c (andreas@andreas) (gcc
version 4.9.4 (Cobham Gaisler Linux 4.9 Toolchain 1.0) ) #2 Wed Oct 18
09:45:51 CEST 2017
console: bootconsole [earlyprom0] enabled
console: ARCH: LEON
console: TYPE: Leon3 System-on-a-Chip
console: Ethernet address: 00:00:7c:cc:01:45
console: CACHE: direct mapped cache, set size 1k
console: CACHE: not flushing on every context switch
console: OF stdout device is: /a::a
console: PROM: Built device tree with 8629 bytes of memory.
console: Booting Linux...
console: Built 1 zonelists in Zone order, mobility grouping on.  Total
pages: 30732
console: Kernel command line: console=ttyS0,38400 init=/sbin/init
console: PID hash table entries: 512 (order: -1, 2048 bytes)
console: Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
console: Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
console: Sorting __ex_table...
console: Memory: 120576K/123952K available (3894K kernel code, 155K
rwdata, 692K rodata, 2188K init, 129K bss, 3376K reserved, 0K
cma-reserved, 0K highmem)
console: NR_IRQS:64
console: Console: colour dummy device 80x25
console: console [ttyS0] enabled
console: console [ttyS0] enabled
console: bootconsole [earlyprom0] disabled
console: bootconsole [earlyprom0] disabled
console: clocksource: timer_cs: mask: 0xffffffffffffffff max_cycles:
0x1d854df40, max_idle_ns: 3526361616960 ns
console: Calibrating delay loop... 133.01 BogoMIPS (lpj=665088)
console: pid_max: default: 32768 minimum: 301
console: Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
console: Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
console: devtmpfs: initialized
console: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 19112604462750000 ns
console: futex hash table entries: 256 (order: -1, 3072 bytes)
console: NET: Registered protocol family 16
console: SCSI subsystem initialized
console: clocksource: Switched to clocksource timer_cs
console: FS-Cache: Loaded
console: CacheFiles: Loaded
console: NET: Registered protocol family 2
console: TCP established hash table entries: 1024 (order: 0, 4096 bytes)
console: TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
console: TCP: Hash tables configured (established 1024 bind 1024)
console: UDP hash table entries: 256 (order: 0, 4096 bytes)
console: UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
console: NET: Registered protocol family 1
console: RPC: Registered named UNIX socket transport module.
console: RPC: Registered udp transport module.
console: RPC: Registered tcp transport module.
console: RPC: Registered tcp NFSv4.1 backchannel transport module.
|console: workingset: timestamp_bits=30 max_order=15 bucket_order=0
console: FS-Cache: Netfs 'nfs' registered for caching
console: NFS: Registering the id_resolver key type
console: Key type id_resolver registered
console: Key type id_legacy registered
console: jitterentropy: Initialization failed with host not compliant
with requirements: 2
console: io scheduler noop registered
console: io scheduler deadline registered
console: io scheduler cfq registered (default)
console: Serial: GRLIB APBUART driver
console: ffd0fce4: ttyS0 at MMIO 0x80000100 (irq = 3, base_baud =
2500000) is a GRLIB/APBUART
console: grlib-apbuart at 0x80000100, irq 3
console: brd: module loaded
console: loop: module loaded
console: NET: Registered protocol family 10
console: sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
console: NET: Registered protocol family 17
console: Key type dns_resolver registered
console: leon: power management initialized
console: Freeing unused kernel memory: 2188K
console: This architecture does not have kernel memory protection.
/console: Starting lograndom: fast init done
console: ging: OK
-console: Initializing random number generator... done.
console: Starting network: OK
console: Welcome to Buildroot
INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout
reached\nOriginal status: ERROR\n{'name':
'2-tests/acceptance/machine_sparc_leon3.py:Leon3Machine.test_leon3_linux_kernel_4_9_busybox',
'logdir': '/home/phil/avocado/job-results/job-2019-06-27T14.43... (60.44 s)
RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 1 |
CANCEL 0
JOB TIME   : 62.10 s

I guess Cleber is working on a fix, but it is unrelated to this series.

> Appart of that it looks good to me :).

Thanks!

> Regards,
> Fred
> 
> Le 6/27/19 à 1:53 PM, Philippe Mathieu-Daudé a écrit :
>> Quick tests worth to avoid regressions, idea from
>> https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04177.html
>> "Maintainers, please tell us how to boot your machines"
>>
>> Regards,
>>
>> Phil.
>>
>> Philippe Mathieu-Daudé (3):
>>    tests/acceptance: Add test that boots the HelenOS microkernel on Leon3
>>    tests/acceptance: Add test that boots Linux up to BusyBox on Leon3
>>    .travis.yml: Let the avocado job run the Leon3 test
>>
>>   .travis.yml                             |  2 +-
>>   MAINTAINERS                             |  1 +
>>   tests/acceptance/machine_sparc_leon3.py | 89 +++++++++++++++++++++++++
>>   3 files changed, 91 insertions(+), 1 deletion(-)
>>   create mode 100644 tests/acceptance/machine_sparc_leon3.py
>>

