Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F25C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6DC22070E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgG3JVFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DC22070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwQ7R-0000aR-1D
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 09:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwQ6a-00089C-1Q
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:08:48 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwQ6X-0002JB-5r
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:08:47 -0400
Received: by mail-ot1-x344.google.com with SMTP id n24so6789681otr.13
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 06:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=Tmu/bv39bd7aLaLFv+Ixw4iW7DvmHjUfrjUx+njOZ1o=;
 b=dgG3JVFzofuSPsWQu7kYWO0hZErR/o+jAjtjOs6EFe93LllH3epdblsXLoQp2unR/m
 mhU4CDtCVdN2L56nZqOEIQs+QdG8xAXDZXWuoA0OY6PCLI12E5jnRZYsOZhbujpj0PjZ
 dFa2pRWHjKklVssj1Ife5WaHNKpq00C8LcG4d9xyy/Ce7vXDPrgqyB+qGOBNkJl1hrDj
 OpSdflu6vFz0PqoN+UYX5yXQaOdtwp4jrRNmHZIhR2N6gmoLSuDL/lgaUGNYdDHyaaFp
 izKNayCPR7mIO8AsTaRQQ3H4VTxmGlvLnecTnm8dmAI+htZHP23qQF+584xsx5yMQYmV
 dVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=Tmu/bv39bd7aLaLFv+Ixw4iW7DvmHjUfrjUx+njOZ1o=;
 b=mMYvjHeOns+Z2YYtYedmuRyN3dFLGdsppwzD26QT4VfBgNjnib9wXm+ZZTM1Bg9I1N
 MraNAINHwOzC9cJJXAdM93IPzAQHNH31K0qTLW+M4sRAmnwr6u4vVSOuELXt3PeyGuMX
 dPMKpj7ej1sqXxbZmlhGQRENxII/tasuO5VYfM8yL8Qc6+irFMAlrVv+1Ly1EQv/rjd/
 HMd+SSAgMZbXMl/pFuILQHcU4ffcQYTYWBoTiEzpxfdn9aTJOo8oyqlsRWBjz5nc0VS8
 5VeyaLY53FT8pOTifslQnQF6cG2qvqJTrm04hpPOuhX//HFLj6T6g4LwZ412002N8Wl7
 AS/A==
X-Gm-Message-State: AOAM531IpScC3qGuYLMwDZtL/n5RURA4QtPpWnqaRlp5JjNd5qRBSuHN
 VfOAyE44xJphlT6SiFzS4YX/fgcEtlsvMBChLQWvYpD0Yg4=
X-Google-Smtp-Source: ABdhPJyl7afu9ijS9fFQWETIrcCyjmLiRNNABK8hHKvGTUDbccxtMd/U0P4u745dLnw/coaOH6HlnM4nUSw66BJgseQ=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr8601566ota.91.1594991323443; 
 Fri, 17 Jul 2020 06:08:43 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jul 2020 14:08:32 +0100
Message-ID: <CAFEAcA8iKKDKEdq8TtbZNwqfsH=ZO78eEXWfrVbYTDjdy9DYDw@mail.gmail.com>
Subject: tests/vm infrastructure fails to notice that QEMU dying is a failure
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If you run vm-build-openbsd, our makefile/scripting infrastructure
seems to fail to notice that death of the QEMU process that's
running the VM should be a failure, and ends up allowing make
to return a success condition.

I have a script which runs a VM build which basically does:

  #!/bin/sh -e
  make -C "build" "vm-build-openbsd" J=8 V=1
  echo "OK DONE openbsd"

It just gave me this output (tail end of logfile). We're executing tests,
and then the qemu-system-x86_64 that's running the OpenBSD VM gets
a signal 9 (sigkill), for unclear reasons (oom killer??). The python
scripting gets an exception, but doesn't exit with a failure status to
make, which then thinks all is fine, exits success itself and allows
the set -e script to proceed to print the "OK DONE" line...


PASS 30 qos-test /arm/imx25-pdk/imx.i2c/i2c-bus/pca9552/pca9552-tests/tx-rx
PASS 31 qos-test /arm/imx25-pdk/imx.i2c/i2c-bus/pca9552/pca9552-tests/rx-autoinc
PASS 32 qos-test /arm/imx25-pdk/imx.i2c/i2c-bus/ds1338/ds1338-tests/tx-rx
DEBUG:QMP.qemu-26462:>>> {'execute': 'quit'}
DEBUG:QMP.qemu-26462:<<< {'timestamp': {'seconds': 1594984057,
'microseconds': 485197}, 'event': 'NIC_RX_FILTER_CHANGED', 'data':
{'path': '/machine/peripheral-anon/device[0]/virtio-backend'}}
DEBUG:QMP.qemu-26462:<<< {'timestamp': {'seconds': 1594985855,
'microseconds': 169552}, 'event': 'RTC_CHANGE', 'data': {'offset': 0}}
DEBUG:QMP.qemu-26462:<<< {'timestamp': {'seconds': 1594987655,
'microseconds': 169187}, 'event': 'RTC_CHANGE', 'data': {'offset': 0}}
DEBUG:QMP.qemu-26462:<<< {'timestamp': {'seconds': 1594989456,
'microseconds': 88866}, 'event': 'RTC_CHANGE', 'data': {'offset': 0}}
DEBUG:QMP.qemu-26462:<<< {'return': {}}
WARNING:qemu.machine:qemu received signal 9; command:
"qemu-system-x86_64 -display none -vga none -chardev
socket,id=mon,path=/var/tmp/qemu-26462-monitor.sock -mon
chardev=mon,mode=control -machine pc -chardev
socket,id=console,path=/var/tmp/qemu-26462-console.sock,server,nowait
-serial chardev:console -nodefaults -m 4G -cpu max -netdev
user,id=vnet,hostfwd=:127.0.0.1:0-:22 -device
virtio-net-pci,netdev=vnet -vnc 127.0.0.1:0,to=20 -smp 8 -enable-kvm
-drive file=/home/peter.maydell/.cache/qemu-vm/images/openbsd.img,snapshot=on,if=none,id=drive0,cache=writeback
-device virtio-blk,drive=drive0,bootindex=0 -drive
file=/home/peter.maydell/qemu-openbsd/build/vm-test-yzwn6xdc.tmp/data-993a1.tar,if=none,id=data-993a1,cache=writeback,format=raw
-device virtio-blk,drive=data-993a1,serial=data-993a1,bootindex=1"
Error in atexit._run_exitfuncs:
Traceback (most recent call last):
  File "/home/peter.maydell/qemu-openbsd/tests/vm/../../python/qemu/machine.py",
line 436, in _do_shutdown
    self._soft_shutdown(has_quit, timeout)
  File "/home/peter.maydell/qemu-openbsd/tests/vm/../../python/qemu/machine.py",
line 419, in _soft_shutdown
    self._popen.wait(timeout=timeout)
  File "/usr/lib/python3.6/subprocess.py", line 1469, in wait
    raise TimeoutExpired(self.args, timeout)
subprocess.TimeoutExpired: Command '['qemu-system-x86_64', '-display',
'none', '-vga', 'none', '-chardev',
'socket,id=mon,path=/var/tmp/qemu-26462-monitor.sock', '-mon',
'chardev=mon,mode=control', '-machine', 'pc', '-chardev',
'socket,id=console,path=/var/tmp/qemu-26462-console.sock,server,nowait',
'-serial', 'chardev:console', '-nodefaults', '-m', '4G', '-cpu',
'max', '-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22', '-device',
'virtio-net-pci,netdev=vnet', '-vnc', '127.0.0.1:0,to=20', '-smp',
'8', '-enable-kvm', '-drive',
'file=/home/peter.maydell/.cache/qemu-vm/images/openbsd.img,snapshot=on,if=none,id=drive0,cache=writeback',
'-device', 'virtio-blk,drive=drive0,bootindex=0', '-drive',
'file=/home/peter.maydell/qemu-openbsd/build/vm-test-yzwn6xdc.tmp/data-993a1.tar,if=none,id=data-993a1,cache=writeback,format=raw',
'-device', 'virtio-blk,drive=data-993a1,serial=data-993a1,bootindex=1']'
timed out after 3 seconds

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/home/peter.maydell/qemu-openbsd/tests/vm/../../python/qemu/machine.py",
line 466, in shutdown
    self._do_shutdown(has_quit, timeout=timeout)
  File "/home/peter.maydell/qemu-openbsd/tests/vm/../../python/qemu/machine.py",
line 440, in _do_shutdown
    from exc
qemu.machine.AbnormalShutdown: Could not perform graceful shutdown
make: Leaving directory '/home/peter.maydell/qemu-openbsd/build'
OK DONE openbsd

thanks
-- PMM

