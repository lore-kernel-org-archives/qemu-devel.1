Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24EDC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904BF206BB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mVdbBmRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904BF206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59528 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hahjH-0006h2-SR
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 10:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38457)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hahfh-00044G-71
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 10:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hahbq-0006N8-Nz
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 10:18:49 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hahbq-0006MA-CD
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 10:18:46 -0400
Received: by mail-wr1-x443.google.com with SMTP id b17so13236133wrq.11
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 07:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ccGa8m2CGQbywg1TG0qnG5KDFt/+u2vkYy5Famx+s1I=;
 b=mVdbBmRXnlOFl6nXbXVuVB6cSSopineq/uvFrxriUQ+I4IV+QDLXcxv8Y8yLI6uLaY
 n+jDKVZuP0yVap3H+IVaTN6icur+yw9uOQRTpXwIMFloEntwm39p4dbhbG2GxLlrhhSc
 iV5bZtSqw7difRJ/4gX+G8Wk7TIOsYV4MQdfWEWVzwkZhaXh+WjvoMXymCBjcZqqRd84
 uCivGFRJXe7adKc1yyqOx525fWVBoO90bY8bAo9xrhPzXqe0W4NsIf7ZlW/AenkkAj7B
 2BrI6+bM297FmHVBNMQtkpeDqYUj45LrLlIPBDmQyj6Nn10+OzqMyX5ggW2vYAjdO9so
 2Wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ccGa8m2CGQbywg1TG0qnG5KDFt/+u2vkYy5Famx+s1I=;
 b=Lfts8geuD1uCIcTMVIjSJDh7jJQOQWu61jIZ9/o38UcTz0YRyeFVWczOcfp4bd8wu6
 Dfm63NBG6p/7hacnDkN2rDwrX3k7RiL3eGt649Cmvco5IamwsexTaMcIqf0iEOS54Ul7
 4HXkfg5PVYTx5zxKVYdEdoWZ3pTnKQy+sEuoQhAwHB1io0FqVPYNncdZ73pKDOR6gxML
 Ko0mZaN211j178s52JMcfMFNUG9cdfLu6ObjQPFr2Swxd/f33LD/s23g+DaZ+2IZ5d1W
 EDD+RSHJ5Qzn9bsxkP5mQWDMBxVKkLczmfVXvipJemFVuFyvuLAxXKcGvNkoxVkVeRw2
 MbVA==
X-Gm-Message-State: APjAAAU2fmWF0sLICKtSRXzONv3QWSxvY67+zxluhfEu9yvZhqeuBj6O
 ewTSyFzbo3yNaV22oTzrQ5Gy8Q==
X-Google-Smtp-Source: APXvYqwHc2r/S/9MtMep9oCCTae+h53ksyaG08rLfJOtBdmweTgVDqoXvyGiOm9vVyF5EXIydT2Few==
X-Received: by 2002:adf:8044:: with SMTP id 62mr2880744wrk.20.1560262724329;
 Tue, 11 Jun 2019 07:18:44 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id h90sm31139916wrh.15.2019.06.11.07.18.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 11 Jun 2019 07:18:43 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2E1411FF87;
 Tue, 11 Jun 2019 15:18:43 +0100 (BST)
References: <20190607090552.12434-1-alex.bennee@linaro.org>
 <CAFEAcA8uT68z7dd85JH30v6PDzABtwZs6MjLui5jJFEW3Niybw@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA8uT68z7dd85JH30v6PDzABtwZs6MjLui5jJFEW3Niybw@mail.gmail.com>
Date: Tue, 11 Jun 2019 15:18:43 +0100
Message-ID: <87zhmodx30.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PULL 00/52] testing, gdbstub and cputlb fixes
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
Cc: Thomas Huth <thuth@redhat.com>, Kamil Rytarowski <n54@gmx.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 7 Jun 2019 at 10:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> The following changes since commit 0d74f3b4277a7ecb0ccb80c865797d11f8e46=
6f5:
>>
>>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull=
-request' into staging (2019-06-06 14:09:14 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/stsquad/qemu.git tags/pull-testing-gdbstub-cputlb-0=
70619-1
>>
>> for you to fetch changes up to 611a3db380ef9f670c5c82837c4889f7e19ded10:
>>
>>   gdbstub: Implement qemu physical memory mode (2019-06-07 08:39:03 +010=
0)
>>
>> ----------------------------------------------------------------
>> Various fixes and updates:
>>
>>   - editor config tweak for shell scripts
>>   - iotest updates (still not default for make check)
>>   - various docker updates
>>   - gcc/ubsan updates for travis
>>   - clean-ups for tests/vm including autoinstall
>>   - semihosting fix for Coverity
>>   - fixes for cputlb in 64-on-32 cases
>>   - gdbstub re-factor + maintainership update
>>
>
> This seems to break the tests/vm testing I do. Eg openbsd:
>
> hackbox mergebuild: seq openbsd
> make: Entering directory '/home/peter.maydell/qemu-openbsd/build'
> python3 -B /home/peter.maydell/qemu-openbsd/tests/vm/openbsd  --debug
> --image "/home/peter.maydell/.cache/qemu-vm/images/openbsd.img"
> --force --build-image
> /home/peter.maydell/.cache/qemu-vm/images/openbsd.img
> ### Downloading install iso ...
> ### Preparing iso and disk image ...
> Formatting '/home/peter.maydell/.cache/qemu-vm/images/openbsd.img.tmp',
> fmt=3Dqcow2 size=3D21474836480 cluster_size=3D65536 lazy_refcounts=3Doff
> refcount_bits=3D16
> ### Booting installer ...
> DEBUG:root:QEMU args: -nodefaults -m 4G -cpu max -netdev
> user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22 -device
> virtio-net-pci,netdev=3Dvnet -vnc 127.0.0.1:0,to=3D20 -smp 18 -enable-kvm
> -device VGA -drive
> file=3D/home/peter.maydell/.cache/qemu-vm/images/openbsd.img.tmp,if=3Dnon=
e,id=3Ddrive0,cache=3Dwriteback
> -device virtio-blk,drive=3Ddrive0,bootindex=3D0 -machine graphics=3Doff
> -cdrom /home/peter.maydell/.cache/qemu-vm/images/openbsd.img.install.iso
> DEBUG:qemu:VM launch command: 'qemu-system-x86_64 -chardev
> socket,id=3Dmon,path=3D/var/tmp/tmpcex0zicz/qemu-6023-monitor.sock -mon
> chardev=3Dmon,mode=3Dcontrol -display none -vga none -machine pc -chardev
> socket,id=3Dconsole,path=3D/var/tmp/tmpcex0zicz/qemu-6023-console.sock,se=
rver,nowait
> -serial chardev:console -nodefaults -m 4G -cpu max -netdev
> user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22 -device
> virtio-net-pci,netdev=3Dvnet -vnc 127.0.0.1:0,to=3D20 -smp 18 -enable-kvm
> -device VGA -drive
> file=3D/home/peter.maydell/.cache/qemu-vm/images/openbsd.img.tmp,if=3Dnon=
e,id=3Ddrive0,cache=3Dwriteback
> -device virtio-blk,drive=3Ddrive0,bootindex=3D0 -machine graphics=3Doff
> -cdrom /home/peter.maydell/.cache/qemu-vm/images/openbsd.img.install.iso'
> DEBUG:QMP:>>> {'execute': 'qmp_capabilities'}
> DEBUG:QMP:<<< {'return': {}}
> DEBUG:QMP:>>> {'execute': 'human-monitor-command', 'arguments':
> {'command-line': 'info usernet'}}
> DEBUG:QMP:<<< {'return': 'VLAN -1 (vnet):\r\n  Protocol[State]    FD
> Source Address  Port   Dest. Address  Port RecvQ SendQ\r\n
> TCP[HOST_FORWARD]  13       127.0.0.1 37043       10.0.2.15    22
> 0     0\r\n'}
> console: *** read timeout ***
> console: waiting for: 'boot>'
> console: line buffer:
>
>
> Failed to prepare guest environment
> Traceback (most recent call last):
>   File "/home/peter.maydell/qemu-openbsd/tests/vm/basevm.py", line 351, i=
n main
>     return vm.build_image(args.image)
>   File "/home/peter.maydell/qemu-openbsd/tests/vm/openbsd", line 85,
> in build_image
>     self.console_wait_send("boot>", "set tty com0\n")
>   File "/home/peter.maydell/qemu-openbsd/tests/vm/basevm.py", line
> 251, in console_wait_send
>     self.console_wait(wait)
>   File "/home/peter.maydell/qemu-openbsd/tests/vm/basevm.py", line
> 213, in console_wait
>     chars =3D vm.console_socket.recv(1024)
> socket.timeout: timed out
> DEBUG:QMP:>>> {'execute': 'quit'}
> DEBUG:QMP:<<< {'return': {}}
> /home/peter.maydell/qemu-openbsd/tests/vm/Makefile.include:47: recipe
> for target '/home/peter.maydell/.cache/qemu-vm/images/openbsd.img'
> failed
> make: *** [/home/peter.maydell/.cache/qemu-vm/images/openbsd.img] Error 2
> make: Leaving directory '/home/peter.maydell/qemu-openbsd/build'
>
> ---
> NetBSD:
>
> peter.maydell@hackbox2.linaro.org:~$ mergebuild netbsd
> hackbox mergebuild: seq netbsd
> make: Entering directory '/home/peter.maydell/qemu-netbsd/build'
> python3 -B /home/peter.maydell/qemu-netbsd/tests/vm/netbsd  --debug
> --image "/home/peter.maydell/.cache/qemu-vm/images/netbsd.img" --force
> --build-image /home/peter.maydell/.cache/qemu-vm/images/netbsd.img
> ### Preparing iso and disk image ...
> Formatting '/home/peter.maydell/.cache/qemu-vm/images/netbsd.img.tmp',
> fmt=3Dqcow2 size=3D21474836480 cluster_size=3D65536 lazy_refcounts=3Doff
> refcount_bits=3D16
> ### Booting installer ...
> DEBUG:root:QEMU args: -nodefaults -m 4G -cpu max -netdev
> user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22 -device
> virtio-net-pci,netdev=3Dvnet -vnc 127.0.0.1:0,to=3D20 -smp 18 -enable-kvm
> -device VGA -drive
> file=3D/home/peter.maydell/.cache/qemu-vm/images/netbsd.img.tmp,if=3Dnone=
,id=3Ddrive0,cache=3Dwriteback
> -device virtio-blk,drive=3Ddrive0,bootindex=3D0 -device VGA -machine
> graphics=3Doff -cdrom
> /home/peter.maydell/.cache/qemu-vm/images/netbsd.img.install.iso
> DEBUG:qemu:VM launch command: 'qemu-system-x86_64 -chardev
> socket,id=3Dmon,path=3D/var/tmp/tmpp_t16skr/qemu-13312-monitor.sock -mon
> chardev=3Dmon,mode=3Dcontrol -display none -vga none -machine pc -chardev
> socket,id=3Dconsole,path=3D/var/tmp/tmpp_t16skr/qemu-13312-console.sock,s=
erver,nowait
> -serial chardev:console -nodefaults -m 4G -cpu max -netdev
> user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22 -device
> virtio-net-pci,netdev=3Dvnet -vnc 127.0.0.1:0,to=3D20 -smp 18 -enable-kvm
> -device VGA -drive
> file=3D/home/peter.maydell/.cache/qemu-vm/images/netbsd.img.tmp,if=3Dnone=
,id=3Ddrive0,cache=3Dwriteback
> -device virtio-blk,drive=3Ddrive0,bootindex=3D0 -device VGA -machine
> graphics=3Doff -cdrom
> /home/peter.maydell/.cache/qemu-vm/images/netbsd.img.install.iso'
> DEBUG:QMP:>>> {'execute': 'qmp_capabilities'}
> DEBUG:QMP:>>> {'execute': 'quit'}
> WARNING:qemu:qemu received signal 6: qemu-system-x86_64 -chardev
> socket,id=3Dmon,path=3D/var/tmp/tmpp_t16skr/qemu-13312-monitor.sock -mon
> chardev=3Dmon,mode=3Dcontrol -display none -vga none -machine pc -chardev
> socket,id=3Dconsole,path=3D/var/tmp/tmpp_t16skr/qemu-13312-console.sock,s=
erver,nowait
> -serial chardev:console -nodefaults -m 4G -cpu max -netdev
> user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22 -device
> virtio-net-pci,netdev=3Dvnet -vnc 127.0.0.1:0,to=3D20 -smp 18 -enable-kvm
> -device VGA -drive
> file=3D/home/peter.maydell/.cache/qemu-vm/images/netbsd.img.tmp,if=3Dnone=
,id=3Ddrive0,cache=3Dwriteback
> -device virtio-blk,drive=3Ddrive0,bootindex=3D0 -device VGA -machine
> graphics=3Doff -cdrom
> /home/peter.maydell/.cache/qemu-vm/images/netbsd.img.install.iso
> DEBUG:qemu:Error launching VM
> DEBUG:qemu:Command: 'qemu-system-x86_64 -chardev
> socket,id=3Dmon,path=3D/var/tmp/tmpp_t16skr/qemu-13312-monitor.sock -mon
> chardev=3Dmon,mode=3Dcontrol -display none -vga none -machine pc -chardev
> socket,id=3Dconsole,path=3D/var/tmp/tmpp_t16skr/qemu-13312-console.sock,s=
erver,nowait
> -serial chardev:console -nodefaults -m 4G -cpu max -netdev
> user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22 -device
> virtio-net-pci,netdev=3Dvnet -vnc 127.0.0.1:0,to=3D20 -smp 18 -enable-kvm
> -device VGA -drive
> file=3D/home/peter.maydell/.cache/qemu-vm/images/netbsd.img.tmp,if=3Dnone=
,id=3Ddrive0,cache=3Dwriteback
> -device virtio-blk,drive=3Ddrive0,bootindex=3D0 -device VGA -machine
> graphics=3Doff -cdrom
> /home/peter.maydell/.cache/qemu-vm/images/netbsd.img.install.iso'
> DEBUG:qemu:Output: 'RAMBlock "vga.vram" already registered, abort!\n'
> ERROR:root:Failed to launch QEMU, command line:
> ERROR:root:qemu-system-x86_64 -nodefaults -m 4G -cpu max -netdev
> user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22 -device
> virtio-net-pci,netdev=3Dvnet -vnc 127.0.0.1:0,to=3D20 -smp 18 -enable-kvm
> -device VGA -drive
> file=3D/home/peter.maydell/.cache/qemu-vm/images/netbsd.img.tmp,if=3Dnone=
,id=3Ddrive0,cache=3Dwriteback
> -device virtio-blk,drive=3Ddrive0,bootindex=3D0 -device VGA -machine
> graphics=3Doff -cdrom
> /home/peter.maydell/.cache/qemu-vm/images/netbsd.img.install.iso
> ERROR:root:Log:
> ERROR:root:RAMBlock "vga.vram" already registered, abort!
>
> ERROR:root:QEMU version >=3D 2.10 is required
> Failed to prepare guest environment
> Traceback (most recent call last):
>   File "/home/peter.maydell/qemu-netbsd/tests/vm/basevm.py", line 351, in=
 main
>     return vm.build_image(args.image)
>   File "/home/peter.maydell/qemu-netbsd/tests/vm/netbsd", line 79, in
> build_image
>     "-cdrom", iso
>   File "/home/peter.maydell/qemu-netbsd/tests/vm/basevm.py", line 170, in=
 boot
>     guest.launch()
>   File "/home/peter.maydell/qemu-netbsd/tests/vm/../../python/qemu/__init=
__.py",
> line 297, in launch
>     self._launch()
>   File "/home/peter.maydell/qemu-netbsd/tests/vm/../../python/qemu/__init=
__.py",
> line 324, in _launch
>     self._post_launch()
>   File "/home/peter.maydell/qemu-netbsd/tests/vm/../../python/qemu/__init=
__.py",
> line 268, in _post_launch
>     self._qmp.accept()
>   File "/home/peter.maydell/qemu-netbsd/tests/vm/../../python/qemu/qmp.py=
",
> line 157, in accept
>     return self.__negotiate_capabilities()
>   File "/home/peter.maydell/qemu-netbsd/tests/vm/../../python/qemu/qmp.py=
",
> line 75, in __negotiate_capabilities
>     resp =3D self.cmd('qmp_capabilities')
>   File "/home/peter.maydell/qemu-netbsd/tests/vm/../../python/qemu/qmp.py=
",
> line 191, in cmd
>     return self.cmd_obj(qmp_cmd)
>   File "/home/peter.maydell/qemu-netbsd/tests/vm/../../python/qemu/qmp.py=
",
> line 174, in cmd_obj
>     resp =3D self.__json_read()
>   File "/home/peter.maydell/qemu-netbsd/tests/vm/../../python/qemu/qmp.py=
",
> line 82, in __json_read
>     data =3D self.__sockfile.readline()
>   File "/usr/lib/python3.6/socket.py", line 586, in readinto
>     return self._sock.recv_into(b)
> ConnectionResetError: [Errno 104] Connection reset by peer
> /home/peter.maydell/qemu-netbsd/tests/vm/Makefile.include:47: recipe
> for target '/home/peter.maydell/.cache/qemu-vm/images/netbsd.img'
> failed
> make: *** [/home/peter.maydell/.cache/qemu-vm/images/netbsd.img] Error 2
> make: Leaving directory '/home/peter.maydell/qemu-netbsd/build'
>
>
> FreeBSD:
>
> peter.maydell@hackbox2.linaro.org:~$ mergebuild freebsd
> hackbox mergebuild: seq freebsd
> make: Entering directory '/home/peter.maydell/qemu-freebsd/build'
> python3 -B /home/peter.maydell/qemu-freebsd/tests/vm/freebsd  --debug
> --image "/home/peter.maydell/.cache/qemu-vm/images/freebsd.img"
> --force --build-image
> /home/peter.maydell/.cache/qemu-vm/images/freebsd.img
> ### Downloading install iso ...
> ### Preparing iso and disk image ...
> /home/peter.maydell/.cache/qemu-vm/images/freebsd.img.install.iso.xz (1/1)
>   100 %       595.0 MiB / 851.1 MiB =3D 0.699   117 MiB/s       0:07
> Formatting '/home/peter.maydell/.cache/qemu-vm/images/freebsd.img.tmp',
> fmt=3Dqcow2 size=3D21474836480 cluster_size=3D65536 lazy_refcounts=3Doff
> refcount_bits=3D16
> ### Booting installer ...
> DEBUG:root:QEMU args: -nodefaults -m 4G -cpu max -netdev
> user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22 -device
> virtio-net-pci,netdev=3Dvnet -vnc 127.0.0.1:0,to=3D20 -smp 18 -enable-kvm
> -device VGA -drive
> file=3D/home/peter.maydell/.cache/qemu-vm/images/freebsd.img.tmp,if=3Dnon=
e,id=3Ddrive0,cache=3Dwriteback
> -device virtio-blk,drive=3Ddrive0,bootindex=3D0 -machine graphics=3Doff
> -cdrom /home/peter.maydell/.cache/qemu-vm/images/freebsd.img.install.iso
> DEBUG:qemu:VM launch command: 'qemu-system-x86_64 -chardev
> socket,id=3Dmon,path=3D/var/tmp/tmpc1sqg5ms/qemu-23074-monitor.sock -mon
> chardev=3Dmon,mode=3Dcontrol -display none -vga none -machine pc -chardev
> socket,id=3Dconsole,path=3D/var/tmp/tmpc1sqg5ms/qemu-23074-console.sock,s=
erver,nowait
> -serial chardev:console -nodefaults -m 4G -cpu max -netdev
> user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22 -device
> virtio-net-pci,netdev=3Dvnet -vnc 127.0.0.1:0,to=3D20 -smp 18 -enable-kvm
> -device VGA -drive
> file=3D/home/peter.maydell/.cache/qemu-vm/images/freebsd.img.tmp,if=3Dnon=
e,id=3Ddrive0,cache=3Dwriteback
> -device virtio-blk,drive=3Ddrive0,bootindex=3D0 -machine graphics=3Doff
> -cdrom /home/peter.maydell/.cache/qemu-vm/images/freebsd.img.install.iso'
> DEBUG:QMP:>>> {'execute': 'qmp_capabilities'}
> DEBUG:QMP:<<< {'return': {}}
> DEBUG:QMP:>>> {'execute': 'human-monitor-command', 'arguments':
> {'command-line': 'info usernet'}}
> DEBUG:QMP:<<< {'return': 'VLAN -1 (vnet):\r\n  Protocol[State]    FD
> Source Address  Port   Dest. Address  Port RecvQ SendQ\r\n
> TCP[HOST_FORWARD]  13       127.0.0.1 37719       10.0.2.15    22
> 0     0\r\n'}
> console: *** read timeout ***
> console: waiting for: 'Autoboot'
> console: line buffer:
>
>
> Failed to prepare guest environment
> Traceback (most recent call last):
>   File "/home/peter.maydell/qemu-freebsd/tests/vm/basevm.py", line 351, i=
n main
>     return vm.build_image(args.image)
>   File "/home/peter.maydell/qemu-freebsd/tests/vm/freebsd", line 94,
> in build_image
>     self.console_boot_serial()
>   File "/home/peter.maydell/qemu-freebsd/tests/vm/freebsd", line 71,
> in console_boot_serial
>     self.console_wait_send("Autoboot", "3")
>   File "/home/peter.maydell/qemu-freebsd/tests/vm/basevm.py", line
> 251, in console_wait_send
>     self.console_wait(wait)
>   File "/home/peter.maydell/qemu-freebsd/tests/vm/basevm.py", line
> 213, in console_wait
>     chars =3D vm.console_socket.recv(1024)
> socket.timeout: timed out
> DEBUG:QMP:>>> {'execute': 'quit'}
> DEBUG:QMP:<<< {'timestamp': {'seconds': 1559900897, 'microseconds':
> 206270}, 'event': 'NIC_RX_FILTER_CHANGED', 'data': {'path':
> '/machine/peripheral-anon/device[0]/virtio-backend'}}
> DEBUG:QMP:<<< {'return': {}}
> /home/peter.maydell/qemu-freebsd/tests/vm/Makefile.include:47: recipe
> for target '/home/peter.maydell/.cache/qemu-vm/images/freebsd.img'
> failed
> make: *** [/home/peter.maydell/.cache/qemu-vm/images/freebsd.img] Error 2
> make: Leaving directory '/home/peter.maydell/qemu-freebsd/build'

So I have a branch that works:

  https://github.com/stsquad/qemu/tree/testing/pull-testing-gdbstub-cputlb-=
070619-1

Which has the following additional patch:

  Subject: [PATCH] tests/vm: favour the locally built QEMU for bootstrapping
  Date: Fri,  7 Jun 2019 19:53:37 +0100
  Message-Id: <20190607185337.14524-1-alex.bennee@linaro.org>

And reverts the patch:

  tests/vm: netbsd autoinstall, using serial console

Which seems to have problems running on hackbox (serial works but we
don't step through the install menus, lots of qqqqqqqqqqqqqqqqqqqqqqq's
in the logs).

Should I respin the PR with 1 new and 1 dropped?

--
Alex Benn=C3=A9e

