Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E009C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:15:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 563332064A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563332064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33630 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb5uc-0002q6-SS
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 12:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49180)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hb5st-0002Bz-L9
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hb5sr-0007Ln-5e
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:13:59 -0400
Received: from mail-yb1-f172.google.com ([209.85.219.172]:40177)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hb5sq-0007LH-WE
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:13:57 -0400
Received: by mail-yb1-f172.google.com with SMTP id g62so6590010ybg.7
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 09:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EuyZTiY+BQonV6Eb0GVxJ4rB0f1VVeLxLME+kj3rHAU=;
 b=VqCiwhmv6v6dExkQFAny8+rZ58ewypVEmVLcgLkh6txe6Acccf5pqaN/wFuLXlkf7Q
 j8AGdRkeWkFkiEOtUpo5w6rET+8yWXWSGdl9nz0gDKcAR/kfXfKNfwgbLN3Mb/iP0Xa3
 PD+mANJCvZ2z9OGdELu2NwKrIo7+1ztiNKKwaiH8zLgfByCQq7Ip/CHqf9EZ8VEGbTli
 Y15ZPqRAk/8UqPRIqDKJA1rre99fda7gX8nAkHnz/rp+qMBeYyNqqg/+twDWTdbjL0xL
 A4ShXLtF9MCSaE3MopfF4/LAvYqa+83iDG26kSBp3bv9z6Ex/hsIr1skXDCqduSYqojG
 iWdQ==
X-Gm-Message-State: APjAAAVYVUQo6s6zHVp0fUnLnJSyXXRcn8c2pFh+ESMVtgOCjles6d8I
 KVoV5pGK7b49VXN6q0pSxuQi2SPWSWsfixevIdo=
X-Google-Smtp-Source: APXvYqy0t7ABwbSvRg1Zfqp2h7HvZce7rLykFpUXzTG48EftP3lbHA4ELk+SRVAOc9Bd8F3FkU4BQORqjxveSW7CRgE=
X-Received: by 2002:a5b:706:: with SMTP id g6mr39448599ybq.316.1560356036047; 
 Wed, 12 Jun 2019 09:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190612111949.25117-1-alex.bennee@linaro.org>
 <CAFEAcA9cKcTpyU_SpzVH91JnQfU2g14bNuk_oWkObbbYYxdXQw@mail.gmail.com>
In-Reply-To: <CAFEAcA9cKcTpyU_SpzVH91JnQfU2g14bNuk_oWkObbbYYxdXQw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 12 Jun 2019 18:13:42 +0200
Message-ID: <CAAdtpL4n-DkVhe35yeTVdT7a_XXbUnqaETY_dz_cBtswYcb7CA@mail.gmail.com>
To: Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Eduardo Habkost <ehabkost@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.219.172
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le mer. 12 juin 2019 18:04, Peter Maydell <peter.maydell@linaro.org> a
=C3=A9crit :

> On Wed, 12 Jun 2019 at 12:19, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> >
> > The following changes since commit
> 219dca61ebf41625831d4f96a720852baf44b762:
> >
> >   Merge remote-tracking branch
> 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2019-06-11
> 16:02:07 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/stsquad/qemu.git
> tags/pull-testing-gdbstub-cputlb-120619-2
> >
> > for you to fetch changes up to dfffdccbf6984ad7042b3123cba9e29c4f3c9a2b=
:
> >
> >   gdbstub: Implement qemu physical memory mode (2019-06-12 11:23:08
> +0100)
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
>
> file=3D/home/peter.maydell/.cache/qemu-vm/images/openbsd.img.tmp,if=3Dnon=
e,id=3Ddrive0,cache=3Dwriteback
> -device virtio-blk,drive=3Ddrive0,bootindex=3D0 -machine graphics=3Doff
> -cdrom /home/peter.maydell/.cache/qemu-vm/images/openbsd.img.install.iso
> DEBUG:qemu:VM launch command: 'qemu-system-x86_64 -chardev
> socket,id=3Dmon,path=3D/var/tmp/tmpnelhp5du/qemu-20711-monitor.sock -mon
> chardev=3Dmon,mode=3Dcontrol -display none -vga none -machine pc -chardev
>
> socket,id=3Dconsole,path=3D/var/tmp/tmpnelhp5du/qemu-20711-console.sock,s=
erver,nowait
> -serial chardev:console -nodefaults -m 4G -cpu max -netdev
> user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22 -device
> virtio-net-pci,netdev=3Dvnet -vnc 127.0.0.1:0,to=3D20 -smp 18 -enable-kvm
> -device VGA -drive
>
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
n
> main
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
>
> file=3D/home/peter.maydell/.cache/qemu-vm/images/freebsd.img.tmp,if=3Dnon=
e,id=3Ddrive0,cache=3Dwriteback
> -device virtio-blk,drive=3Ddrive0,bootindex=3D0 -machine graphics=3Doff
> -cdrom /home/peter.maydell/.cache/qemu-vm/images/freebsd.img.install.iso
> DEBUG:qemu:VM launch command: 'qemu-system-x86_64 -chardev
> socket,id=3Dmon,path=3D/var/tmp/tmpxwprc886/qemu-20701-monitor.sock -mon
> chardev=3Dmon,mode=3Dcontrol -display none -vga none -machine pc -chardev
>
> socket,id=3Dconsole,path=3D/var/tmp/tmpxwprc886/qemu-20701-console.sock,s=
erver,nowait
> -serial chardev:console -nodefaults -m 4G -cpu max -netdev
> user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22 -device
> virtio-net-pci,netdev=3Dvnet -vnc 127.0.0.1:0,to=3D20 -smp 18 -enable-kvm
> -device VGA -drive
>
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
n
> main
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

3 errors seems the same Python socket char dropped/missed issue we are
trying to figure out with Cleber.

>
