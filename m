Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A203C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 192D32071A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="syQfzhn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192D32071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdzBF-0006dd-A4
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 12:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdzA4-0004dk-6m
 for qemu-devel@nongnu.org; Wed, 27 May 2020 12:44:12 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdzA2-0004g3-PR
 for qemu-devel@nongnu.org; Wed, 27 May 2020 12:44:11 -0400
Received: by mail-wm1-x344.google.com with SMTP id l26so56430wme.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 09:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=02zUOmkfvRVsbxtzctVFRG39dFShY4HkuvNZZh0bvyA=;
 b=syQfzhn0/+F9zSOk9N5cqJPfg24CURbO5c2FqA7HffIOZiyNBX+B+ksm5uDaGvPZcY
 PRzUlXq0B8knAW0Geh6b4kNK/PxN8/Y+UesWre05x8MWGo9V8rTd9nYTyqxhZiX1dkt4
 9VVssKooUVo5l+du4wT71vAN/auH73BwriwkFZwOVmqwhN96KkZzQ4eXEn8rZweQRbvj
 y7TRwpmiKT77le41aK5WqqtWSdek8iOSBIM7ev+d7Lkk5Qdmjn0HL0f24BSykTc/TRPl
 N+uzakM55eiFjSQegoGm81z/z0zSQ1lyHUQOhiOQ5pTz3DMQ3BbjXbagUNf7uFb+PtVv
 a3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=02zUOmkfvRVsbxtzctVFRG39dFShY4HkuvNZZh0bvyA=;
 b=EXlRj3iFu9a4FbPu/5g82E2M+nSoeiVmDSqdG4wpEf346xvPAH64uqTsoQUrKkIFoI
 QyL/88XAhRyUnTOpXeFppgN7DIx7C/iIhTLtm79etVAdDt3qQ3zz1RxV5TXFaTH1oaKX
 wgMZQyR4cExYpWtuSoEAnCp4Lq78PU23izP6XrfnU3SzkGxVRHzx/u7oGeees0wgn+17
 tEnzi21NLEc6/E5xvk4AgaWWVScAULutkHnFv3KrwOghz+OxwJsI4B03Jyn5Njg7vm4v
 ebMb41i4gkPC3t0pkpHg1umpCVMI5XW0lR7oWM2W0yOLiRN5vMGoXxPzSMAHo4GIPVEF
 vy7Q==
X-Gm-Message-State: AOAM533fyg4GVgKwDoMcV3mWQV9POMvELnpKpHezxPNDSH3mjPGz3Q78
 0QMwv2uxfrlqv4mif3FgEhMTGA==
X-Google-Smtp-Source: ABdhPJz2ioeSjJ0kF4e6gJ9v4oAULn67/J3J7YFZ9LgGiwOvpGGphVcIpnnEkUKU5oVHy1hzXTp/3A==
X-Received: by 2002:a1c:998f:: with SMTP id b137mr4775039wme.166.1590597848834; 
 Wed, 27 May 2020 09:44:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x186sm3636977wmg.8.2020.05.27.09.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 09:44:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EA3631FF7E;
 Wed, 27 May 2020 17:44:06 +0100 (BST)
References: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
 <159057550026.16818.11665839081165803832.stgit@pasha-ThinkPad-X280>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
Subject: Re: [PATCH v2 11/11] tests/acceptance: Linux boot test for
 record/replay
In-reply-to: <159057550026.16818.11665839081165803832.stgit@pasha-ThinkPad-X280>
Date: Wed, 27 May 2020 17:44:06 +0100
Message-ID: <87ftbl5nvt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: wrampazz@redhat.com, qemu-devel@nongnu.org, dovgaluk@ispras.ru,
 pavel.dovgaluk@ispras.ru, crosa@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com> writes:

> This patch adds a test for record/replay, which boots Linux
> image from the disk and interacts with the network.
> The idea and code of this test is borrowed from boot_linux.py
> However, currently record/replay works only for x86_64,
> therefore other tests were excluded.
>
> Each test consists of the following phases:
>  - downloading the disk image
>  - recording the execution
>  - replaying the execution
>
> Replay does not validates the output, but waits until QEMU
> finishes the execution. This is reasonable, because
> QEMU usually hangs when replay goes wrong.

Two things:

 - We need to tag these tests as slow so they aren't run by default
 - 1800s is a long timeout to wait for to know it's a problem

Looking at the log shows my test is still running? Maybe we can check
the output as we go?

>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  0 files changed
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9a9ce4f66..97f066a9b2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2498,6 +2498,7 @@ F: include/sysemu/replay.h
>  F: docs/replay.txt
>  F: stubs/replay.c
>  F: tests/acceptance/replay_kernel.py
> +F: tests/acceptance/replay_linux.py
>=20=20
>  IOVA Tree
>  M: Peter Xu <peterx@redhat.com>
> diff --git a/tests/acceptance/replay_linux.py b/tests/acceptance/replay_l=
inux.py
> new file mode 100644
> index 0000000000..7c5971f156
> --- /dev/null
> +++ b/tests/acceptance/replay_linux.py
> @@ -0,0 +1,97 @@
> +# Record/replay test that boots a complete Linux system via a cloud image
> +#
> +# Copyright (c) 2020 ISP RAS
> +#
> +# Author:
> +#  Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import os
> +
> +from avocado.utils import cloudinit
> +from avocado.utils import network
> +from avocado.utils import vmimage
> +from avocado.utils import datadrainer
> +from avocado.utils.path import find_command
> +from boot_linux import BootLinuxBase
> +
> +class ReplayLinux(BootLinuxBase):
> +    """
> +    Boots a Linux system, checking for a successful initialization
> +    """
> +
> +    timeout =3D 1800
> +    chksum =3D None
> +    hdd =3D 'ide-hd'
> +    cd =3D 'ide-cd'
> +    bus =3D 'ide'
> +
> +    def setUp(self):
> +        super(ReplayLinux, self).setUp()
> +        self.boot_path =3D self.download_boot()
> +        self.cloudinit_path =3D self.download_cloudinit()
> +
> +    def vm_add_disk(self, vm, path, id, device):
> +        bus_string =3D ''
> +        if self.bus:
> +            bus_string =3D ',bus=3D%s.%d' % (self.bus, id,)
> +        vm.add_args('-drive', 'file=3D%s,snapshot,id=3Ddisk%s,if=3Dnone'=
 % (path, id))
> +        vm.add_args('-drive', 'driver=3Dblkreplay,id=3Ddisk%s-rr,if=3Dno=
ne,image=3Ddisk%s' % (id, id))
> +        vm.add_args('-device', '%s,drive=3Ddisk%s-rr%s' % (device, id, b=
us_string))
> +
> +    def launch_and_wait(self, record, args, shift):
> +        vm =3D self.get_vm()
> +        vm.add_args('-smp', '1')
> +        vm.add_args('-m', '1024')
> +        vm.add_args('-object', 'filter-replay,id=3Dreplay,netdev=3Dhub0p=
ort0')
> +        if args:
> +            vm.add_args(*args)
> +        self.vm_add_disk(vm, self.boot_path, 0, self.hdd)
> +        self.vm_add_disk(vm, self.cloudinit_path, 1, self.cd)
> +        if record:
> +            mode =3D 'record'
> +        else:
> +            mode =3D 'replay'
> +        vm.add_args('-icount', 'shift=3D%s,rr=3D%s,rrfile=3D%s' %
> +                    (shift, mode, os.path.join(self.workdir, 'replay.bin=
')))
> +
> +        vm.set_console()
> +        vm.launch()
> +        console_drainer =3D datadrainer.LineLogger(vm.console_socket.fil=
eno(),
> +                                                 logger=3Dself.log.getCh=
ild('console'),
> +                                                 stop_check=3D(lambda : =
not vm.is_running()))
> +        console_drainer.start()
> +        if record:
> +            self.log.info('VM launched, waiting for boot confirmation fr=
om guest')
> +            cloudinit.wait_for_phone_home(('0.0.0.0', self.phone_home_po=
rt), self.name)
> +            vm.shutdown()
> +        else:
> +            self.log.info('VM launched, waiting the recorded execution t=
o be replayed')
> +            vm.wait()
> +
> +    def run_rr(self, args=3DNone, shift=3D7):
> +        self.launch_and_wait(True, args, shift)
> +        self.launch_and_wait(False, args, shift)
> +
> +class ReplayLinuxX8664(ReplayLinux):
> +    """
> +    :avocado: tags=3Darch:x86_64
> +    """
> +
> +    chksum =3D 'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f=
3c5c27a0'
> +
> +    def test_pc_i440fx(self):
> +        """
> +        :avocado: tags=3Dmachine:pc
> +        :avocado: tags=3Daccel:tcg
> +        """
> +        self.run_rr(shift=3D1)
> +
> +    def test_pc_q35(self):
> +        """
> +        :avocado: tags=3Dmachine:q35
> +        :avocado: tags=3Daccel:tcg
> +        """
> +        self.run_rr(shift=3D3)


--=20
Alex Benn=C3=A9e

