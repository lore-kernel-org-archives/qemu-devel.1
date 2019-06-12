Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1459AC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D318921019
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V91mLDHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D318921019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33378 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb5jH-0002sr-Ll
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 12:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45063)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hb5ck-0000OF-F0
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:57:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hb5ci-0003Ct-7x
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:57:18 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:45948)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hb5ch-00039o-W2
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:57:16 -0400
Received: by mail-oi1-x22b.google.com with SMTP id m206so12036876oib.12
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 08:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OVZjgFxQbBJIXxx0KtfzhMWKXqTWuZmgSTTJZwzhfrM=;
 b=V91mLDHZ5ObY1qF+g4jukVF2WDSIT63U/FdCCJ8EyhMUu2eVu99iSdmP/84rEntnsL
 yHmU05NInZ4SFFhLNq9juA1OCRH3a47AVDUaD3+lgAGYiZo76cXPCvlZ6cONh9/yjowQ
 dQ1suCr9TWigUxUq5xK6xuQRc1EIySjr6ewjaR+OtN9Y8dD5uW6XmJE2FHfuSVV81avO
 JOtxk0M2V1w2l2On3z3t6QAtbg/AKleIYROlat5hrwl72dL2A8toaHN88XN3GxyP+wdW
 wConXOo2bxH4QMZUi83h4zeNVLrBjIxVFSKmXTi6i2s4DQys7JkE4lg96UJmCmlpYROG
 drpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OVZjgFxQbBJIXxx0KtfzhMWKXqTWuZmgSTTJZwzhfrM=;
 b=PIkhikbdLDHOrSHqRBlwI6js6wvwgDa4pjYwXlsBXlLLG+eaAEyZLo1KeQnKxPiQSM
 18zae9Ywz/UZdmp2MJeTum6WF5ccc1POpTxbVqhjf/xubWFoy42bkhG+YqPgpupACBad
 L3kyp0L2gZHh4RDb+mENVIMJ+oSs8UPS31V5V6wG6GSf+J/U5Er/BSAWkpUfo5Z3KUZ3
 91GocI4iaCrZP2bUw8AxefDr1ScrQkqgXbFMTCSzNWmXmlOsM2TQS15DEak61hH+A6J8
 V1qU76ksylrBdFauNu4u/77oPhS/UilOIyjClvDPnKRzljFPQIqxwTSeYoaFFlILN5D9
 KSRQ==
X-Gm-Message-State: APjAAAXM1MoFx9M+s/xK5v+fo7NdphuLIKjZisw2ESgkU2hTt+Ti7OLD
 lXVxgvakRIowSQjApJwYhxBEe/VFiupR1lcGSpjrRg==
X-Google-Smtp-Source: APXvYqxFmVP4edCbTn0nNcVT+36d4wmBviGGgR6hlRkPkeukAEwUA4YBjlgG3ehxLfSoluavLAUNG0ZsMVqnndUCE/Q=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr7301305oij.98.1560355031203; 
 Wed, 12 Jun 2019 08:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190612111949.25117-1-alex.bennee@linaro.org>
In-Reply-To: <20190612111949.25117-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Jun 2019 16:57:00 +0100
Message-ID: <CAFEAcA9cKcTpyU_SpzVH91JnQfU2g14bNuk_oWkObbbYYxdXQw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22b
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

On Wed, 12 Jun 2019 at 12:19, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 219dca61ebf41625831d4f96a720852baf44b7=
62:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-reque=
st' into staging (2019-06-11 16:02:07 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-gdbstub-cputlb-12=
0619-2
>
> for you to fetch changes up to dfffdccbf6984ad7042b3123cba9e29c4f3c9a2b:
>
>   gdbstub: Implement qemu physical memory mode (2019-06-12 11:23:08 +0100=
)
>
> ----------------------------------------------------------------
> Various fixes and updates:
>
>   - editor config tweak for shell scripts
>   - iotest updates (still not default for make check)
>   - various docker updates
>   - gcc/ubsan updates for travis
>   - clean-ups for tests/vm including autoinstall (-netbsd)
>   - semihosting fix for Coverity
>   - fixes for cputlb in 64-on-32 cases
>   - gdbstub re-factor + maintainership update

OpenBSD:

make: Entering directory '/home/peter.maydell/qemu-openbsd/build'
python3 -B /home/peter.maydell/qemu-openbsd/tests/vm/openbsd  --debug
--build-dir /home/peter.maydell/qemu-openbsd/build --image
"/home/peter.maydell/.cache/qemu-vm/images/openbsd.img" --force
--build-image /home/peter.maydell/.cache/qemu-vm/images/openbsd.img
Formatting '/home/peter.maydell/.cache/qemu-vm/images/openbsd.img.tmp',
fmt=3Dqcow2 size=3D21474836480 cluster_size=3D65536 lazy_refcounts=3Doff
refcount_bits=3D16
### Downloading install iso ...
### Preparing iso and disk image ...
### Booting installer ...
DEBUG:root:QEMU args: -nodefaults -m 4G -cpu max -netdev
user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22 -device
virtio-net-pci,netdev=3Dvnet -vnc 127.0.0.1:0,to=3D20 -smp 18 -enable-kvm
-device VGA -drive
file=3D/home/peter.maydell/.cache/qemu-vm/images/openbsd.img.tmp,if=3Dnone,=
id=3Ddrive0,cache=3Dwriteback
-device virtio-blk,drive=3Ddrive0,bootindex=3D0 -machine graphics=3Doff
-cdrom /home/peter.maydell/.cache/qemu-vm/images/openbsd.img.install.iso
DEBUG:qemu:VM launch command: 'qemu-system-x86_64 -chardev
socket,id=3Dmon,path=3D/var/tmp/tmpnelhp5du/qemu-20711-monitor.sock -mon
chardev=3Dmon,mode=3Dcontrol -display none -vga none -machine pc -chardev
socket,id=3Dconsole,path=3D/var/tmp/tmpnelhp5du/qemu-20711-console.sock,ser=
ver,nowait
-serial chardev:console -nodefaults -m 4G -cpu max -netdev
user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22 -device
virtio-net-pci,netdev=3Dvnet -vnc 127.0.0.1:0,to=3D20 -smp 18 -enable-kvm
-device VGA -drive
file=3D/home/peter.maydell/.cache/qemu-vm/images/openbsd.img.tmp,if=3Dnone,=
id=3Ddrive0,cache=3Dwriteback
-device virtio-blk,drive=3Ddrive0,bootindex=3D0 -machine graphics=3Doff
-cdrom /home/peter.maydell/.cache/qemu-vm/images/openbsd.img.install.iso'
DEBUG:QMP:>>> {'execute': 'qmp_capabilities'}
DEBUG:QMP:<<< {'return': {}}
DEBUG:QMP:>>> {'execute': 'human-monitor-command', 'arguments':
{'command-line': 'info usernet'}}
DEBUG:QMP:<<< {'return': 'VLAN -1 (vnet):\r\n  Protocol[State]    FD
Source Address  Port   Dest. Address  Port RecvQ SendQ\r\n
TCP[HOST_FORWARD]  13       127.0.0.1 46357       10.0.2.15    22
0     0\r\n'}
console: *** read timeout ***
console: waiting for: 'boot>'
console: line buffer:


Failed to prepare guest environment
Traceback (most recent call last):
  File "/home/peter.maydell/qemu-openbsd/tests/vm/basevm.py", line 370, in =
main
    return vm.build_image(args.image)
  File "/home/peter.maydell/qemu-openbsd/tests/vm/openbsd", line 85,
in build_image
    self.console_wait_send("boot>", "set tty com0\n")
  File "/home/peter.maydell/qemu-openbsd/tests/vm/basevm.py", line
267, in console_wait_send
    self.console_wait(wait)
  File "/home/peter.maydell/qemu-openbsd/tests/vm/basevm.py", line
229, in console_wait
    chars =3D vm.console_socket.recv(1024)
socket.timeout: timed out
DEBUG:QMP:>>> {'execute': 'quit'}
DEBUG:QMP:<<< {'return': {}}
/home/peter.maydell/qemu-openbsd/tests/vm/Makefile.include:47: recipe
for target '/home/peter.maydell/.cache/qemu-vm/images/openbsd.img'
failed
make: *** [/home/peter.maydell/.cache/qemu-vm/images/openbsd.img] Error 2
make: Leaving directory '/home/peter.maydell/qemu-openbsd/build'


FreeBSD:

make: Entering directory '/home/peter.maydell/qemu-freebsd/build'
python3 -B /home/peter.maydell/qemu-freebsd/tests/vm/freebsd  --debug
--build-dir /home/peter.maydell/qemu-freebsd/build --image
"/home/peter.maydell/.cache/qemu-vm/images/freebsd.img" --force
--build-image /home/peter.maydell/.cache/qemu-vm/images/freebsd.img
/home/peter.maydell/.cache/qemu-vm/images/freebsd.img.install.iso.xz:
595.0 MiB / 851.1 MiB =3D 0.699, 78 MiB/s, 0:10
Formatting '/home/peter.maydell/.cache/qemu-vm/images/freebsd.img.tmp',
fmt=3Dqcow2 size=3D21474836480 cluster_size=3D65536 lazy_refcounts=3Doff
refcount_bits=3D16
### Downloading install iso ...
### Preparing iso and disk image ...
### Booting installer ...
DEBUG:root:QEMU args: -nodefaults -m 4G -cpu max -netdev
user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22 -device
virtio-net-pci,netdev=3Dvnet -vnc 127.0.0.1:0,to=3D20 -smp 18 -enable-kvm
-device VGA -drive
file=3D/home/peter.maydell/.cache/qemu-vm/images/freebsd.img.tmp,if=3Dnone,=
id=3Ddrive0,cache=3Dwriteback
-device virtio-blk,drive=3Ddrive0,bootindex=3D0 -machine graphics=3Doff
-cdrom /home/peter.maydell/.cache/qemu-vm/images/freebsd.img.install.iso
DEBUG:qemu:VM launch command: 'qemu-system-x86_64 -chardev
socket,id=3Dmon,path=3D/var/tmp/tmpxwprc886/qemu-20701-monitor.sock -mon
chardev=3Dmon,mode=3Dcontrol -display none -vga none -machine pc -chardev
socket,id=3Dconsole,path=3D/var/tmp/tmpxwprc886/qemu-20701-console.sock,ser=
ver,nowait
-serial chardev:console -nodefaults -m 4G -cpu max -netdev
user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22 -device
virtio-net-pci,netdev=3Dvnet -vnc 127.0.0.1:0,to=3D20 -smp 18 -enable-kvm
-device VGA -drive
file=3D/home/peter.maydell/.cache/qemu-vm/images/freebsd.img.tmp,if=3Dnone,=
id=3Ddrive0,cache=3Dwriteback
-device virtio-blk,drive=3Ddrive0,bootindex=3D0 -machine graphics=3Doff
-cdrom /home/peter.maydell/.cache/qemu-vm/images/freebsd.img.install.iso'
DEBUG:QMP:>>> {'execute': 'qmp_capabilities'}
DEBUG:QMP:<<< {'return': {}}
DEBUG:QMP:>>> {'execute': 'human-monitor-command', 'arguments':
{'command-line': 'info usernet'}}
DEBUG:QMP:<<< {'return': 'VLAN -1 (vnet):\r\n  Protocol[State]    FD
Source Address  Port   Dest. Address  Port RecvQ SendQ\r\n
TCP[HOST_FORWARD]  13       127.0.0.1 39777       10.0.2.15    22
0     0\r\n'}
console: *** read timeout ***
console: waiting for: 'Autoboot'
console: line buffer:


Failed to prepare guest environment
Traceback (most recent call last):
  File "/home/peter.maydell/qemu-freebsd/tests/vm/basevm.py", line 370, in =
main
    return vm.build_image(args.image)
  File "/home/peter.maydell/qemu-freebsd/tests/vm/freebsd", line 94,
in build_image
    self.console_boot_serial()
  File "/home/peter.maydell/qemu-freebsd/tests/vm/freebsd", line 71,
in console_boot_serial
    self.console_wait_send("Autoboot", "3")
  File "/home/peter.maydell/qemu-freebsd/tests/vm/basevm.py", line
267, in console_wait_send
    self.console_wait(wait)
  File "/home/peter.maydell/qemu-freebsd/tests/vm/basevm.py", line
229, in console_wait
    chars =3D vm.console_socket.recv(1024)
socket.timeout: timed out
DEBUG:QMP:>>> {'execute': 'quit'}
DEBUG:QMP:<<< {'timestamp': {'seconds': 1560354157, 'microseconds':
358016}, 'event': 'NIC_RX_FILTER_CHANGED', 'data': {'path':
'/machine/peripheral-anon/device[0]/virtio-backend'}}
DEBUG:QMP:<<< {'return': {}}
/home/peter.maydell/qemu-freebsd/tests/vm/Makefile.include:47: recipe
for target '/home/peter.maydell/.cache/qemu-vm/images/freebsd.img'
failed
make: *** [/home/peter.maydell/.cache/qemu-vm/images/freebsd.img] Error 2
make: Leaving directory '/home/peter.maydell/qemu-freebsd/build'

thanks
-- PMM

