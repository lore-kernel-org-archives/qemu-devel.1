Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C069AC28CC2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:24:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82FD725725
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VTm0d7bd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FD725725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50638 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIEe-0000Kg-M1
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:24:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI90-0004NO-BU
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI8y-0000Zc-Ps
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:18:46 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWI8x-0000XC-1y
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:18:44 -0400
Received: by mail-wr1-x444.google.com with SMTP id b18so3784663wrq.12
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=2XI14DR6u5bbhjtYZyFcs2wYwEyUJYWQly5Qr1ehVoo=;
	b=VTm0d7bd5nY2glhZ/GCZqxpMR6EWAg198UkvXNe4TwOXB3fA/1pEE/mM10YeJAIrkh
	kCqBVe54BNhqVFeAScTs+2wVlKeAzYDMXYTIu9zZIfP5cqM1rphC7ybI/Nn0lzOqUjiN
	EYrjTPKEvPQc4sHmgwM/xzI0PJTYizG1vfK6wqeuZRghM5IZqAIs8VdAaMJTVssW1DQk
	NginEBXwHPhBl6u0taKjd7Q+tqHXcj55E6VloIfFw54sKDWuiL1PzTVNw5eFO330gC6B
	e58ARZeUs128n1FYIkq5DHitDXy3asYN1eAtqCWkI4cJRnFeN/bPCtfJx25C/hOiHeso
	qErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=2XI14DR6u5bbhjtYZyFcs2wYwEyUJYWQly5Qr1ehVoo=;
	b=YSzC/7V7a+ZQbCLvMgiIhrtzHpGM+uhn4ID8h4UGs3Lw5LBKsNgO9qi9d1ux6xy+X2
	wR/g9prQajf+im4O4PbXQ7mdMaDfnZqhtPf927QFD7CmCb18UwqCLEFfAy3AmUsMc6ZB
	hmrmTB9Pw5XPYDaKeNmSDNmy8Vkp1vsiv38Buer/YQ39cmAb0V9hMAVwn7Ljop6KGbVG
	fZ6B/IQOX3k4hKZBugiKoeNqYb5VVI20/QCzHgtVuC3XQgGLZ7b3eZXvlcLnrQIHpWzp
	Zv45RnsUKnovft7xKhLC/Av+aqQo4kQ6fhx+omS7JJg6CEu0sAP3Y9Zy92E6UNubUvPF
	GW0Q==
X-Gm-Message-State: APjAAAXV5yKYXcEm6jST8iSghqrv2vEfLVlNn5dyXDTszzW7RcJEW7QV
	TM+cIE6f64MVnfvraKXUJ1xrhg==
X-Google-Smtp-Source: APXvYqyVU8bvUU+ztSqhRl8lObqOLKrsc+JASA4aHeEPj0ezvm3f1MhHbWo+S8pDAtZuTuCD/ncHTg==
X-Received: by 2002:adf:fc0e:: with SMTP id i14mr2057582wrr.163.1559211521969; 
	Thu, 30 May 2019 03:18:41 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	s13sm1517928wmh.31.2019.05.30.03.18.40
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 03:18:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 09D7D1FF96;
	Thu, 30 May 2019 11:18:40 +0100 (BST)
References: <20190520124716.30472-1-kraxel@redhat.com>
	<878suo5ls0.fsf@zen.linaroharston>
	<f77a0c5b-c36e-4c44-5c3b-580e977682d5@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <f77a0c5b-c36e-4c44-5c3b-580e977682d5@redhat.com>
Date: Thu, 30 May 2019 11:18:39 +0100
Message-ID: <874l5c5jpc.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
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
	qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 5/30/19 11:33 AM, Alex Benn=C3=A9e wrote:
>>
>> Gerd Hoffmann <kraxel@redhat.com> writes:
>>
>>> This patch series changes the way virtual machines for test builds are
>>> managed.  They are created locally on the developer machine now.  The
>>> installer is booted on the serial console and the scripts walks through
>>> the dialogs to install and configure the guest.
>>>
>>> That takes the download.patchew.org server out of the loop and makes it
>>> alot easier to tweak the guest images (adding build dependencies for
>>> example).
>>>
>>> The install scripts take care to apply host proxy settings (from *_proxy
>>> environment variables) to the guest, so any package downloads will be
>>> routed through the proxy and can be cached that way.  This also makes
>>> them work behind strict firewalls.
>>>
>>> There are also a bunch of smaller tweaks for tests/vm to fix issues I
>>> was struggling with.  See commit messages of individual patches for
>>> details.
>>
>> Queued to testing/next, thanks.
>>
>> One of the machines I'm testing on seems to have problems with getting
>> the installer working over the serial link but it works on my main dev
>> box and others have it working as well so I suspect it might be a local
>> problem.
>
> Is this the same issue I described there?
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg06784.html

Not quite.. on the failing machine I see it hang at:

  make[1]: Leaving directory '/home/alex.bennee/lsrc/qemu.git/dtc'
  python3 -B /home/alex.bennee/lsrc/qemu.git/tests/vm/openbsd  --debug --im=
age "/home/alex.bennee/.cache/qemu-vm/images/openbsd.img" --force --build-i=
mage /home/alex.bennee/.cache/qemu-vm/images/openbsd.img
  ### Downloading install iso ...
  ### Preparing iso and disk image ...
  Formatting '/home/alex.bennee/.cache/qemu-vm/images/openbsd.img.tmp', fmt=
=3Dqcow2 size=3D21474836480 cluster_size=3D65536 lazy_refcounts=3Doff refco=
unt_bits=3D16
  ### Booting installer ...
  DEBUG:root:QEMU args: -nodefaults -m 4G -cpu max -netdev user,id=3Dvnet,h=
ostfwd=3D:127.0.0.1:0-:22 -device virtio-net-pci,netdev=3Dvnet -vnc 127.0.0=
.1:0,to=3D20 -smp 18 -enable-kvm
  -device VGA -drive file=3D/home/alex.bennee/.cache/qemu-vm/images/openbsd=
.img.tmp,if=3Dnone,id=3Ddrive0,cache=3Dwriteback -device virtio-blk,drive=
=3Ddrive0,bootindex=3D0 -machine graphics=3Doff -cdrom /home/alex.bennee/.c=
ache/qemu-vm/images/openbsd.img.install.iso
  DEBUG:qemu:VM launch command: 'qemu-system-x86_64 -chardev socket,id=3Dmo=
n,path=3D/var/tmp/tmp0uvsee9z/qemu-18506-monitor.sock -mon chardev=3Dmon,mo=
de=3Dcontrol -display none -vga none -machine pc -chardev socket,id=3Dconso=
le,path=3D/var/tmp/tmp0uvsee9z/qemu-18506-console.sock,server,nowait -seria=
l chardev:console -nodefaults -m 4G -cpu max -netdev user,id=3Dvnet,hostfwd=
=3D:127.0.0.1:0-:22 -device virtio-net-pci,netdev=3Dvnet -vnc 127.0.0.1:0,t=
o=3D20 -smp 18 -enable-kvm -device VGA -drive file=3D/home/alex.bennee/.cac=
he/qemu-vm/images/openbsd.img.tmp,if=3Dnone,id=3Ddrive0,cache=3Dwriteback -=
device virtio-blk,drive=3Ddrive0,bootindex=3D0 -machine graphics=3Doff -cdr=
om /home/alex.bennee/.cache/qemu-vm/images/openbsd.img.install.iso'
  DEBUG:QMP:>>> {'execute': 'qmp_capabilities'}
  DEBUG:QMP:<<< {'return': {}}
  DEBUG:QMP:>>> {'execute': 'human-monitor-command', 'arguments': {'command=
-line': 'info usernet'}}
  DEBUG:QMP:<<< {'return': 'VLAN -1 (vnet):\r\n  Protocol[State]    FD  Sou=
rce Address  Port   Dest. Address  Port RecvQ SendQ\r\n  TCP[HOST_FORWARD] =
 13       127.0.0.1 33465       10.0.2.15    22     0     0\r\n'}
  console: *** read timeout ***
  console: waiting for: 'boot>'
  console: line buffer:


  Failed to prepare guest environment
  Traceback (most recent call last):
    File "/home/alex.bennee/lsrc/qemu.git/tests/vm/basevm.py", line 350, in=
 main
      return vm.build_image(args.image)
    File "/home/alex.bennee/lsrc/qemu.git/tests/vm/openbsd", line 85, in bu=
ild_image
      self.console_wait_send("boot>", "set tty com0\n")
    File "/home/alex.bennee/lsrc/qemu.git/tests/vm/basevm.py", line 250, in=
 console_wait_send
      self.console_wait(wait)
    File "/home/alex.bennee/lsrc/qemu.git/tests/vm/basevm.py", line 212, in=
 console_wait
      chars =3D vm.console_socket.recv(1024)
  socket.timeout: timed out
  DEBUG:QMP:>>> {'execute': 'quit'}
  DEBUG:QMP:<<< {'return': {}}
  /home/alex.bennee/lsrc/qemu.git/tests/vm/Makefile.include:47: recipe for =
target '/home/alex.bennee/.cache/qemu-vm/images/openbsd.img' failed
  make: *** [/home/alex.bennee/.cache/qemu-vm/images/openbsd.img] Error 2

I can see the machine has actually booted as VNC can connect but for
some reason the serial isn't working.

--
Alex Benn=C3=A9e

