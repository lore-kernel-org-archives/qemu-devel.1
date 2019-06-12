Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D19FC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DBA5208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lAXwixuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBA5208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33764 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb6LR-0008AW-7r
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 12:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55188)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hb6K4-0006zV-2b
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hb6K2-00048o-8T
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:42:04 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33011)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hb6K1-00045c-U6
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:42:02 -0400
Received: by mail-wr1-x444.google.com with SMTP id n9so17704656wru.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 09:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dRbmtXM9cpyVTd8ejdSwNx7Aep6niyPDXG8YhtL4dEM=;
 b=lAXwixuDXaAijvAZyaXZ9sOKDbyObzw67+9gyqnUrCLLoM8tsEo+UBoTeMZTj9BNL5
 xRKmkmHr9jbPJppjnab+kCI2KQGG3rL7A0fNcRbWptiTLbAfcFpY3KAr9awL6+8INEwu
 nmND/1evFuueAmLbrFr81KGA3ROSbIt++Zdo9eR+IEqPAjKOlbQhMjhrY6reysBgMaVR
 kem2MTXIr8DsNmpWr9KarbFAZ2+HPU/YnFh0rxQ5CzCLwTf3S43r7CYSgBTJXRYBtPwD
 GQdt0mOtdpOAWfnumd5Ovcp977MsNFW4uaJXrWjBU7JthVdR+UgUtcb/NSshXIjmYFKK
 DAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dRbmtXM9cpyVTd8ejdSwNx7Aep6niyPDXG8YhtL4dEM=;
 b=Yg6G1gbrTF2hYJsMf3vZjjM8ejLlYiHBY2Ki/rOvnnhEHp5HWCkm4gSowp2H0RShDw
 evpJlEXxUzHQK/I8d1Ucrv68kVVHCiwgHuGh/OjTZJ/+z1U9+O1bKs81a0HScZVOrEXK
 tfiEKBH3Zen9xRfmSiS7E0Zn/ISVLwxnoXPiaJ38+ihVMOhdZXpsB2eZ409cFVGXVNw5
 ohQRLye27MdJYsl16acb+gwNu3p90z9UK9tc2flxUhmsF+OyQGbNHROMDTYbu6uFAru/
 v6GANXvGmyFsd5XprtrH3UTaGP9J9zuKl6709OIV276vMvKe0mSDABhknt7ZZybBECnm
 AzoQ==
X-Gm-Message-State: APjAAAWPAs7m3W4l2DeY9igAdc5f1EfOJJ07Mt4kvjTDt+b7SQI1cGHv
 Da/EBJpNauVP2q1j8/qLHFNl4xsFj203mVGk801F4Q==
X-Google-Smtp-Source: APXvYqxEv0QbfaZFXtLnJ6tTdpV0Q5EShFHMiH3PM4DOi067BK34z8sB/1TlLIGtow45nW8VkC5d7qcdnKulFSeBrYc=
X-Received: by 2002:a5d:4e83:: with SMTP id e3mr22148593wru.263.1560357719452; 
 Wed, 12 Jun 2019 09:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190612111949.25117-1-alex.bennee@linaro.org>
 <CAFEAcA9cKcTpyU_SpzVH91JnQfU2g14bNuk_oWkObbbYYxdXQw@mail.gmail.com>
In-Reply-To: <CAFEAcA9cKcTpyU_SpzVH91JnQfU2g14bNuk_oWkObbbYYxdXQw@mail.gmail.com>
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Date: Wed, 12 Jun 2019 17:41:47 +0100
Message-ID: <CAHDbmO0+DV0EP=xrHfXa8SUFC5TWWZvwPOE_D0ZpT8c0SPnoNw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PULL v2 00/52] testing, gdbstub and cputlb fixes
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It looks like it's still trying to use the system QEMU (which is
broken for this in hackbox) to launch. Is there a built
qemu-system-x86_64 in your build directory?

On Wed, 12 Jun 2019 at 16:57, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Wed, 12 Jun 2019 at 12:19, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> >
> > The following changes since commit 219dca61ebf41625831d4f96a720852baf44=
b762:
> >
> >   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-req=
uest' into staging (2019-06-11 16:02:07 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/stsquad/qemu.git tags/pull-testing-gdbstub-cputlb-=
120619-2
> >
> > for you to fetch changes up to dfffdccbf6984ad7042b3123cba9e29c4f3c9a2b=
:
> >
> >   gdbstub: Implement qemu physical memory mode (2019-06-12 11:23:08 +01=
00)
> >
> > ----------------------------------------------------------------
> > Various fixes and updates:
> >
> >   - editor config tweak for shell scripts
> >   - iotest updates (still not default for make check)
> >   - various docker updates
> >   - gcc/ubsan updates for travis
> >   - clean-ups for tests/vm including autoinstall (-netbsd)
> >   - semihosting fix for Coverity
> >   - fixes for cputlb in 64-on-32 cases
> >   - gdbstub re-factor + maintainership update
>
> OpenBSD:
>
> make: Entering directory '/home/peter.maydell/qemu-openbsd/build'
> python3 -B /home/peter.maydell/qemu-openbsd/tests/vm/openbsd  --debug
> --build-dir /home/peter.maydell/qemu-openbsd/build --image
> "/home/peter.maydell/.cache/qemu-vm/images/openbsd.img" --force
> --build-image /home/peter.maydell/.cache/qemu-vm/images/openbsd.img
> Formatting '/home/peter.maydell/.cache/qemu-vm/images/openbsd.img.tmp',
> fmt=3Dqcow2 size=3D21474836480 cluster_size=3D65536 lazy_refcounts=3Doff
> refcount_bits=3D16
> ### Downloading install iso ...
> ### Preparing iso and disk image ...
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
> socket,id=3Dmon,path=3D/var/tmp/tmpnelhp5du/qemu-20711-monitor.sock -mon
> chardev=3Dmon,mode=3Dcontrol -display none -vga none -machine pc -chardev
> socket,id=3Dconsole,path=3D/var/tmp/tmpnelhp5du/qemu-20711-console.sock,s=
erver,nowait
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
> TCP[HOST_FORWARD]  13       127.0.0.1 46357       10.0.2.15    22
> 0     0\r\n'}
> console: *** read timeout ***
> console: waiting for: 'boot>'
> console: line buffer:
>
>
> Failed to prepare guest environment
> Traceback (most recent call last):
>   File "/home/peter.maydell/qemu-openbsd/tests/vm/basevm.py", line 370, i=
n main
>     return vm.build_image(args.image)
>   File "/home/peter.maydell/qemu-openbsd/tests/vm/openbsd", line 85,
> in build_image
>     self.console_wait_send("boot>", "set tty com0\n")
>   File "/home/peter.maydell/qemu-openbsd/tests/vm/basevm.py", line
> 267, in console_wait_send
>     self.console_wait(wait)
>   File "/home/peter.maydell/qemu-openbsd/tests/vm/basevm.py", line
> 229, in console_wait
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
>
> FreeBSD:
>
> make: Entering directory '/home/peter.maydell/qemu-freebsd/build'
> python3 -B /home/peter.maydell/qemu-freebsd/tests/vm/freebsd  --debug
> --build-dir /home/peter.maydell/qemu-freebsd/build --image
> "/home/peter.maydell/.cache/qemu-vm/images/freebsd.img" --force
> --build-image /home/peter.maydell/.cache/qemu-vm/images/freebsd.img
> /home/peter.maydell/.cache/qemu-vm/images/freebsd.img.install.iso.xz:
> 595.0 MiB / 851.1 MiB =3D 0.699, 78 MiB/s, 0:10
> Formatting '/home/peter.maydell/.cache/qemu-vm/images/freebsd.img.tmp',
> fmt=3Dqcow2 size=3D21474836480 cluster_size=3D65536 lazy_refcounts=3Doff
> refcount_bits=3D16
> ### Downloading install iso ...
> ### Preparing iso and disk image ...
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
> socket,id=3Dmon,path=3D/var/tmp/tmpxwprc886/qemu-20701-monitor.sock -mon
> chardev=3Dmon,mode=3Dcontrol -display none -vga none -machine pc -chardev
> socket,id=3Dconsole,path=3D/var/tmp/tmpxwprc886/qemu-20701-console.sock,s=
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
> TCP[HOST_FORWARD]  13       127.0.0.1 39777       10.0.2.15    22
> 0     0\r\n'}
> console: *** read timeout ***
> console: waiting for: 'Autoboot'
> console: line buffer:
>
>
> Failed to prepare guest environment
> Traceback (most recent call last):
>   File "/home/peter.maydell/qemu-freebsd/tests/vm/basevm.py", line 370, i=
n main
>     return vm.build_image(args.image)
>   File "/home/peter.maydell/qemu-freebsd/tests/vm/freebsd", line 94,
> in build_image
>     self.console_boot_serial()
>   File "/home/peter.maydell/qemu-freebsd/tests/vm/freebsd", line 71,
> in console_boot_serial
>     self.console_wait_send("Autoboot", "3")
>   File "/home/peter.maydell/qemu-freebsd/tests/vm/basevm.py", line
> 267, in console_wait_send
>     self.console_wait(wait)
>   File "/home/peter.maydell/qemu-freebsd/tests/vm/basevm.py", line
> 229, in console_wait
>     chars =3D vm.console_socket.recv(1024)
> socket.timeout: timed out
> DEBUG:QMP:>>> {'execute': 'quit'}
> DEBUG:QMP:<<< {'timestamp': {'seconds': 1560354157, 'microseconds':
> 358016}, 'event': 'NIC_RX_FILTER_CHANGED', 'data': {'path':
> '/machine/peripheral-anon/device[0]/virtio-backend'}}
> DEBUG:QMP:<<< {'return': {}}
> /home/peter.maydell/qemu-freebsd/tests/vm/Makefile.include:47: recipe
> for target '/home/peter.maydell/.cache/qemu-vm/images/freebsd.img'
> failed
> make: *** [/home/peter.maydell/.cache/qemu-vm/images/freebsd.img] Error 2
> make: Leaving directory '/home/peter.maydell/qemu-freebsd/build'
>
> thanks
> -- PMM



--=20
Alex Benn=C3=A9e
KVM/QEMU Hacker for Linaro

