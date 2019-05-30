Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48939C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CCD725758
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CCD725758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51032 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIQp-0002LU-BK
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:37:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWIKS-000676-Dw
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWIKQ-0005yU-Dc
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:30:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hWIKQ-0005x9-6T
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:30:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id f204so3635962wme.0
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=sanlyHAOkqVfYtUFycb1axnvnWG6/1zxegu7b3POhns=;
	b=GsSzh26jE8ndqpg3z+F30Q4k83rFjcDTgBW0KL/SGj3uN5bxeCNlSUFyhckOnKquie
	7lEVaOHdqA5De4b++1lNzgeGAIr+7wt8awl27TvNWdxT25kGct4ZKIKdTdDy/RrttVJb
	6ET6eyqUB/DSlwIMu1axW9LjbG8XcWuDfgcw1paSrjHiTXljvt8FeaiEd9/SG8E2rdVi
	I0O1JJ5a9sS2dqsT1BYX8gF88I4tt5p6p300bLNoSS9Tp6yC9+2RudxTIuajKZEuP2Qn
	1T44S5fqHent9qU69dZ4+ZIBDXCa8Y4WFCbqtdy5WY+s5rZXgRpvB8BuoLEpLghDAc5j
	tO5Q==
X-Gm-Message-State: APjAAAUjvEMmLqTICJ6HBKSXT5X4PAGp0CqJpz5wyXbULze06Ly/4syx
	rc+9zVJ+fKZ6Ak7nmbMZd9BPSw==
X-Google-Smtp-Source: APXvYqyNoFDYtq0oVFEaQdicaYSB5E7hlspEnvcgt5hg2iO0r2SlvsjchrTViW6F783DPZ794TQf7w==
X-Received: by 2002:a1c:9eca:: with SMTP id h193mr1794366wme.125.1559212233030;
	Thu, 30 May 2019 03:30:33 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id r4sm1495201wrv.34.2019.05.30.03.30.31
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 03:30:32 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190520124716.30472-1-kraxel@redhat.com>
	<878suo5ls0.fsf@zen.linaroharston>
	<f77a0c5b-c36e-4c44-5c3b-580e977682d5@redhat.com>
	<874l5c5jpc.fsf@zen.linaroharston>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <25dd04eb-61d3-fea2-5a28-c3e536396be9@redhat.com>
Date: Thu, 30 May 2019 12:30:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <874l5c5jpc.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Cleber Rosa <crosa@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
	Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing the Python team.

On 5/30/19 12:18 PM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> On 5/30/19 11:33 AM, Alex Bennée wrote:
>>>
>>> Gerd Hoffmann <kraxel@redhat.com> writes:
>>>
>>>> This patch series changes the way virtual machines for test builds are
>>>> managed.  They are created locally on the developer machine now.  The
>>>> installer is booted on the serial console and the scripts walks through
>>>> the dialogs to install and configure the guest.
>>>>
>>>> That takes the download.patchew.org server out of the loop and makes it
>>>> alot easier to tweak the guest images (adding build dependencies for
>>>> example).
>>>>
>>>> The install scripts take care to apply host proxy settings (from *_proxy
>>>> environment variables) to the guest, so any package downloads will be
>>>> routed through the proxy and can be cached that way.  This also makes
>>>> them work behind strict firewalls.
>>>>
>>>> There are also a bunch of smaller tweaks for tests/vm to fix issues I
>>>> was struggling with.  See commit messages of individual patches for
>>>> details.
>>>
>>> Queued to testing/next, thanks.
>>>
>>> One of the machines I'm testing on seems to have problems with getting
>>> the installer working over the serial link but it works on my main dev
>>> box and others have it working as well so I suspect it might be a local
>>> problem.
>>
>> Is this the same issue I described there?
>> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg06784.html
> 
> Not quite.. on the failing machine I see it hang at:
> 
>   make[1]: Leaving directory '/home/alex.bennee/lsrc/qemu.git/dtc'
>   python3 -B /home/alex.bennee/lsrc/qemu.git/tests/vm/openbsd  --debug --image "/home/alex.bennee/.cache/qemu-vm/images/openbsd.img" --force --build-image /home/alex.bennee/.cache/qemu-vm/images/openbsd.img
>   ### Downloading install iso ...
>   ### Preparing iso and disk image ...
>   Formatting '/home/alex.bennee/.cache/qemu-vm/images/openbsd.img.tmp', fmt=qcow2 size=21474836480 cluster_size=65536 lazy_refcounts=off refcount_bits=16
>   ### Booting installer ...
>   DEBUG:root:QEMU args: -nodefaults -m 4G -cpu max -netdev user,id=vnet,hostfwd=:127.0.0.1:0-:22 -device virtio-net-pci,netdev=vnet -vnc 127.0.0.1:0,to=20 -smp 18 -enable-kvm
>   -device VGA -drive file=/home/alex.bennee/.cache/qemu-vm/images/openbsd.img.tmp,if=none,id=drive0,cache=writeback -device virtio-blk,drive=drive0,bootindex=0 -machine graphics=off -cdrom /home/alex.bennee/.cache/qemu-vm/images/openbsd.img.install.iso
>   DEBUG:qemu:VM launch command: 'qemu-system-x86_64 -chardev socket,id=mon,path=/var/tmp/tmp0uvsee9z/qemu-18506-monitor.sock -mon chardev=mon,mode=control -display none -vga none -machine pc -chardev socket,id=console,path=/var/tmp/tmp0uvsee9z/qemu-18506-console.sock,server,nowait -serial chardev:console -nodefaults -m 4G -cpu max -netdev user,id=vnet,hostfwd=:127.0.0.1:0-:22 -device virtio-net-pci,netdev=vnet -vnc 127.0.0.1:0,to=20 -smp 18 -enable-kvm -device VGA -drive file=/home/alex.bennee/.cache/qemu-vm/images/openbsd.img.tmp,if=none,id=drive0,cache=writeback -device virtio-blk,drive=drive0,bootindex=0 -machine graphics=off -cdrom /home/alex.bennee/.cache/qemu-vm/images/openbsd.img.install.iso'
>   DEBUG:QMP:>>> {'execute': 'qmp_capabilities'}
>   DEBUG:QMP:<<< {'return': {}}
>   DEBUG:QMP:>>> {'execute': 'human-monitor-command', 'arguments': {'command-line': 'info usernet'}}
>   DEBUG:QMP:<<< {'return': 'VLAN -1 (vnet):\r\n  Protocol[State]    FD  Source Address  Port   Dest. Address  Port RecvQ SendQ\r\n  TCP[HOST_FORWARD]  13       127.0.0.1 33465       10.0.2.15    22     0     0\r\n'}
>   console: *** read timeout ***
>   console: waiting for: 'boot>'
>   console: line buffer:
> 
> 
>   Failed to prepare guest environment
>   Traceback (most recent call last):
>     File "/home/alex.bennee/lsrc/qemu.git/tests/vm/basevm.py", line 350, in main
>       return vm.build_image(args.image)
>     File "/home/alex.bennee/lsrc/qemu.git/tests/vm/openbsd", line 85, in build_image
>       self.console_wait_send("boot>", "set tty com0\n")
>     File "/home/alex.bennee/lsrc/qemu.git/tests/vm/basevm.py", line 250, in console_wait_send
>       self.console_wait(wait)
>     File "/home/alex.bennee/lsrc/qemu.git/tests/vm/basevm.py", line 212, in console_wait
>       chars = vm.console_socket.recv(1024)
>   socket.timeout: timed out
>   DEBUG:QMP:>>> {'execute': 'quit'}
>   DEBUG:QMP:<<< {'return': {}}
>   /home/alex.bennee/lsrc/qemu.git/tests/vm/Makefile.include:47: recipe for target '/home/alex.bennee/.cache/qemu-vm/images/openbsd.img' failed
>   make: *** [/home/alex.bennee/.cache/qemu-vm/images/openbsd.img] Error 2
> 
> I can see the machine has actually booted as VNC can connect but for
> some reason the serial isn't working.

Looks related IMO :) Some desync with the serial. Maybe some Python
detail we are missing (like an Exception we are silently ignoring).

BTW I can reproduce my case, and it looks you can reproduce yours too.

