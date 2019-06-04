Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1B1C28CC6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 970EA24485
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970EA24485
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46012 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY26G-0003wp-Ms
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 01:35:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY222-0001M7-UM
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY220-0000i2-Mm
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:30:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hY21w-0000Yj-Te
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:30:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id t5so13259900wmh.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 22:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=m1Sd8+NDAhVeuaFE0e/LtFDuG73bXb0z/vtedid4ULE=;
	b=Ds/o3ir6SaXCoha6yXwq0hb9XHSAfNMLpFmywK/VIKBMs+RTUg1r44egJh3p1p//21
	iA0fuQxbmwtasY50tWHNifew+ko8HUBS15zDq4/mF/EFKFMH0PoryqEUcIZnwd/Tg/Sr
	cC+tbhz3ManCoFEi20M0z3djLlXYARyuN7c0p2aiy5wD2pVhaXtYb6FCYMRLE6aNSemY
	yRvJ9dcDJ9TbHdAC5JTTm1WEeNyE8iwDjs26Bg/IIx3sG2e57cEuS6lrXjBsP8nhPMOl
	UlN7IT8zqiJT6oit1aj3K6aEyQz4stcdmxyO3usDcAHrYTyUdtr+QiDaXphLYEdKA+mr
	bQAQ==
X-Gm-Message-State: APjAAAUkzSJ2KFaRML49ROJ3HQHa9a19OMekyBFPYVuKI5C22YcPaoyD
	PlEvdKudDxB+d/3xi1Kj+cEXyA==
X-Google-Smtp-Source: APXvYqzD14dyZnFGdzc0C8A0HeMaBVZSLdBC1lafouYAOKFPcw0IMIyX1ggfGJg5Qe2IdPFAnZYslg==
X-Received: by 2002:a1c:6555:: with SMTP id z82mr8290878wmb.129.1559626237380; 
	Mon, 03 Jun 2019 22:30:37 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	32sm47614359wra.35.2019.06.03.22.30.36
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 22:30:36 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190520124716.30472-1-kraxel@redhat.com>
	<878suo5ls0.fsf@zen.linaroharston>
	<f77a0c5b-c36e-4c44-5c3b-580e977682d5@redhat.com>
	<874l5c5jpc.fsf@zen.linaroharston>
	<25dd04eb-61d3-fea2-5a28-c3e536396be9@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <028bf850-e44f-451f-a31e-15d5f26768d8@redhat.com>
Date: Tue, 4 Jun 2019 07:30:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <25dd04eb-61d3-fea2-5a28-c3e536396be9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v3 00/14] tests/vm: serial console
 autoinstall, misc fixes.
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
	qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Paolo & Marc-André (and removing the BSD folks).

On 5/30/19 12:30 PM, Philippe Mathieu-Daudé wrote:
> Cc'ing the Python team.
> 
> On 5/30/19 12:18 PM, Alex Bennée wrote:
>>
>> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>>
>>> On 5/30/19 11:33 AM, Alex Bennée wrote:
>>>>
>>>> Gerd Hoffmann <kraxel@redhat.com> writes:
>>>>
>>>>> This patch series changes the way virtual machines for test builds are
>>>>> managed.  They are created locally on the developer machine now.  The
>>>>> installer is booted on the serial console and the scripts walks through
>>>>> the dialogs to install and configure the guest.
>>>>>
>>>>> That takes the download.patchew.org server out of the loop and makes it
>>>>> alot easier to tweak the guest images (adding build dependencies for
>>>>> example).
>>>>>
>>>>> The install scripts take care to apply host proxy settings (from *_proxy
>>>>> environment variables) to the guest, so any package downloads will be
>>>>> routed through the proxy and can be cached that way.  This also makes
>>>>> them work behind strict firewalls.
>>>>>
>>>>> There are also a bunch of smaller tweaks for tests/vm to fix issues I
>>>>> was struggling with.  See commit messages of individual patches for
>>>>> details.
>>>>
>>>> Queued to testing/next, thanks.
>>>>
>>>> One of the machines I'm testing on seems to have problems with getting
>>>> the installer working over the serial link but it works on my main dev
>>>> box and others have it working as well so I suspect it might be a local
>>>> problem.
>>>
>>> Is this the same issue I described there?
>>> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg06784.html
>>
>> Not quite.. on the failing machine I see it hang at:
>>
>>   make[1]: Leaving directory '/home/alex.bennee/lsrc/qemu.git/dtc'
>>   python3 -B /home/alex.bennee/lsrc/qemu.git/tests/vm/openbsd  --debug --image "/home/alex.bennee/.cache/qemu-vm/images/openbsd.img" --force --build-image /home/alex.bennee/.cache/qemu-vm/images/openbsd.img
>>   ### Downloading install iso ...
>>   ### Preparing iso and disk image ...
>>   Formatting '/home/alex.bennee/.cache/qemu-vm/images/openbsd.img.tmp', fmt=qcow2 size=21474836480 cluster_size=65536 lazy_refcounts=off refcount_bits=16
>>   ### Booting installer ...
>>   DEBUG:root:QEMU args: -nodefaults -m 4G -cpu max -netdev user,id=vnet,hostfwd=:127.0.0.1:0-:22 -device virtio-net-pci,netdev=vnet -vnc 127.0.0.1:0,to=20 -smp 18 -enable-kvm
>>   -device VGA -drive file=/home/alex.bennee/.cache/qemu-vm/images/openbsd.img.tmp,if=none,id=drive0,cache=writeback -device virtio-blk,drive=drive0,bootindex=0 -machine graphics=off -cdrom /home/alex.bennee/.cache/qemu-vm/images/openbsd.img.install.iso
>>   DEBUG:qemu:VM launch command: 'qemu-system-x86_64 -chardev socket,id=mon,path=/var/tmp/tmp0uvsee9z/qemu-18506-monitor.sock -mon chardev=mon,mode=control -display none -vga none -machine pc -chardev socket,id=console,path=/var/tmp/tmp0uvsee9z/qemu-18506-console.sock,server,nowait -serial chardev:console -nodefaults -m 4G -cpu max -netdev user,id=vnet,hostfwd=:127.0.0.1:0-:22 -device virtio-net-pci,netdev=vnet -vnc 127.0.0.1:0,to=20 -smp 18 -enable-kvm -device VGA -drive file=/home/alex.bennee/.cache/qemu-vm/images/openbsd.img.tmp,if=none,id=drive0,cache=writeback -device virtio-blk,drive=drive0,bootindex=0 -machine graphics=off -cdrom /home/alex.bennee/.cache/qemu-vm/images/openbsd.img.install.iso'
>>   DEBUG:QMP:>>> {'execute': 'qmp_capabilities'}
>>   DEBUG:QMP:<<< {'return': {}}
>>   DEBUG:QMP:>>> {'execute': 'human-monitor-command', 'arguments': {'command-line': 'info usernet'}}
>>   DEBUG:QMP:<<< {'return': 'VLAN -1 (vnet):\r\n  Protocol[State]    FD  Source Address  Port   Dest. Address  Port RecvQ SendQ\r\n  TCP[HOST_FORWARD]  13       127.0.0.1 33465       10.0.2.15    22     0     0\r\n'}
>>   console: *** read timeout ***
>>   console: waiting for: 'boot>'
>>   console: line buffer:
>>
>>
>>   Failed to prepare guest environment
>>   Traceback (most recent call last):
>>     File "/home/alex.bennee/lsrc/qemu.git/tests/vm/basevm.py", line 350, in main
>>       return vm.build_image(args.image)
>>     File "/home/alex.bennee/lsrc/qemu.git/tests/vm/openbsd", line 85, in build_image
>>       self.console_wait_send("boot>", "set tty com0\n")
>>     File "/home/alex.bennee/lsrc/qemu.git/tests/vm/basevm.py", line 250, in console_wait_send
>>       self.console_wait(wait)
>>     File "/home/alex.bennee/lsrc/qemu.git/tests/vm/basevm.py", line 212, in console_wait
>>       chars = vm.console_socket.recv(1024)
>>   socket.timeout: timed out
>>   DEBUG:QMP:>>> {'execute': 'quit'}
>>   DEBUG:QMP:<<< {'return': {}}
>>   /home/alex.bennee/lsrc/qemu.git/tests/vm/Makefile.include:47: recipe for target '/home/alex.bennee/.cache/qemu-vm/images/openbsd.img' failed
>>   make: *** [/home/alex.bennee/.cache/qemu-vm/images/openbsd.img] Error 2
>>
>> I can see the machine has actually booted as VNC can connect but for
>> some reason the serial isn't working.
> 
> Looks related IMO :) Some desync with the serial. Maybe some Python
> detail we are missing (like an Exception we are silently ignoring).
> 
> BTW I can reproduce my case, and it looks you can reproduce yours too.

I now see a similar issue with Avocado.
Using this patch
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg05747.html
I get:

$ make check-venv
$ ./tests/venv/bin/python -m avocado --show=console run -t arch:rx
tests/acceptance/boot_linux_console.py
console: Linux version 4.19.0+ (yo-satoh@yo-satoh-debian) (gcc version
9.0.0 20181105 (experimental) (GCC)) #137 Wed Feb 20 23:20:02 JST 2019
console: Built 1 zonelists, mobility grouping on.  Total pages: 8128
console: Kernel command line:
console: Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
console: Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
console: Memory: 14648K/32768K available (871K kernel code, 95K rwdata,
140K rodata, 96K init, 175K bss, 18120K reserved, 0K cma-reserved)
console: NR_IRQS: 256
console: rx-cmt: used for periodic clock events
console: clocksource: rx-tpu: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 1274173631191 ns
console: 96.00 BogoMIPS (lpj=480000)
console: pid_max: default: 4096 minimum: 301
console: Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
console: Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
console: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 19112604462750000 ns
console: clocksource: Switched to clocksource rx-tpu
console: workingset: timestamp_bits=30 max_order=12 bucket_order=0
console: SuperH (H)SCI(F) driver initialized
console: 88240.serial: ttySC0 at MMIO 0x88240 (irq = 215, base_baud = 0)
is a sci
console: console [ttySC0] enabled
console: 88248.serial: ttySC1 at MMIO 0x88248 (irq = 219, base_baud = 0)
is a sci
console: random: get_random_bytes called from 0x01002e48 with crng_init=0
console: Freeing unused kernel memory: 96K
console: This architecture does not have kernel memory protection.
console: Run /sbin/init as init process
console: Run /etc/init as init process
console: Run /bin/init as init process
console: Run /bin/sh as init process
console:
console: Sash command shell (version 1.1.1)
console: />sh-sci 88240.serial: overrun error
console: sh-sci 88240.serial: frame error
console: sh-sci 88240.serial: parity error
console: prrandom: fast init done
[HANG]

Most of the time this test succeed.

console: This architecture does not have kernel memory protection.
console: Run /sbin/init as init process
console: Run /etc/init as init process
console: Run /bin/init as init process
console: Run /bin/sh as init process
console:
console: Sash command shell (version 1.1.1)
console: /> printenv
console: HOME=/
console: TERM=linux
$ echo $?
0

