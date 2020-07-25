Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0948CC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 14:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2274206C1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 14:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J+q2Ekn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2274206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzL2l-00039t-1N
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 10:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jzL2C-0002e6-Jg
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 10:20:20 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:46270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jzL2A-0001kF-R4
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 10:20:20 -0400
Received: by mail-ot1-x335.google.com with SMTP id n24so9111059otr.13
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2020 07:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=K4GdX75QZDQQXSWA0jOG833i4Irw+5g3QF+6YNRRxi0=;
 b=J+q2Ekn1nKGA/vDPXrLLj2+2w9U3oEGIhnzN5/KSUqqGCnQQI2WFTommPuyoUIKoQJ
 so2HlCWvEL52IPwAzncv8mDnalQOWiRpMhHPn1hqLOWpg9APUJm18HzvKPWs4t6By6CZ
 ZPa9LFKFWXAUSw+JotQvruMlWbeNxYmFOWfjpshaVVcWDGIgwnrHbH9q/a/pOuplw2Mh
 t30wUVzkYMXBNsDyxlewADFWPsPuHxoFuIQe5kVxCCQ9PYPE/FZj4RoWur16wQreWmlx
 1TBqj/2vhW5RSKLFTTYrIBxaEyKJafl09cvYJy6LKX75Y78F+YnGHfExK52ljtAyRTSD
 NT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=K4GdX75QZDQQXSWA0jOG833i4Irw+5g3QF+6YNRRxi0=;
 b=RqhQ41gGSFjtmF451ClTRwlJYAfhtmryf5eOCGGOdcy5uOj+ZHKB/DE6gfTT6X/gp8
 h1SzaKh+cbCz97fxKBpBWg9aE8NSeJFapIHRtPUIBsgvuv4Io5OFSuWlG12Q4ItytKus
 CCVea6q6OrlZAwvgjMMP+emYtHi5u69nMjaMpDdBTTRRcKs0waKGw5MqhX9rq+FWNkK1
 grbMjpTeLartFjr5qq0wmCMXwIFb5QWR6fyaIZif2BYM5LeJPxxcoQ6Y0ufVLLTomw4f
 0qGcT4PMQ/wRTjc82OayGwGiA47xnJk2V9H1s6XS0cf4d2/DdOHC3MSUiKbIPsltzjbT
 +t2g==
X-Gm-Message-State: AOAM5320fCXOhXLmIu17AnPxF04N80EQTHDTDdNTum5p+JfKj/DQa0nv
 TNLbPn0IfYVx/rjHEdwjduB/9NiCRhVEF5tp/v9ygndP/1k=
X-Google-Smtp-Source: ABdhPJzjD4NaIMGx5zVTB8W8DSSqD0Hhv5p75hVVpONQr9ENFlf5aILvOYH6AN856WuP/meIHDu+CjOLDQs3aWtoqu4=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr13224505ota.91.1595686816924; 
 Sat, 25 Jul 2020 07:20:16 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 Jul 2020 15:20:06 +0100
Message-ID: <CAFEAcA__RiZoe9qRTT_ZCbm_FmXZMO2MseGkimtL459Uoaoi9A@mail.gmail.com>
Subject: tests/vm/openbsd script (etc) excessive CPU usage
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <famz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I noticed that when running the BSD VMs, the Python script that launches
QEMU seems to eat CPU:

peter.m+ 19024  0.0  0.0  20296 11692 pts/12   S+   15:04   0:00
   \_ make -C build vm-build-openbsd J=8 V=1
peter.m+ 19858 98.8  0.0 126272 15220 pts/12   Sl+  15:04  12:04
       \_ /usr/bin/python3 -B
/home/peter.maydell/qemu-openbsd/tests/vm/openbsd --debug --jobs 8
--verbose --efi-aarch64
/home/peter.maydell/qemu-openbsd/build/pc-bios/edk2-aarch64-code.fd
--image /home/peter.maydell/.cache/qemu-vm/images/openbsd.img
--snapshot --build-qemu /home/peter.maydell/qemu-openbsd --
peter.m+ 22878  711  3.2 10506236 3192896 pts/12 Sl+ 15:04  86:08
            \_ qemu-system-x86_64 -display none -vga none -chardev
socket,id=mon,path=/var/tmp/qemu-19858-monitor.sock -mon
chardev=mon,mode=control -machine pc -chardev
socket,id=console,path=/var/tmp/qemu-19858-console.sock,server,nowait
-serial chardev:console -nodefaults -m 4G -cpu max -netdev
user,id=vnet,hostfwd=:127.0.0.1:0-:22 -device
virtio-net-pci,netdev=vnet -vnc 127.0.0.1:0,to=20 -smp 8 -enable-kvm
-drive file=/home/peter.maydell/.cache/qemu-vm/images/openbsd.img,snapshot=on,if=none,id=drive0,cache=writeback
-device virtio-blk,drive=drive0,bootindex=0 -drive
file=/home/peter.maydell/qemu-openbsd/build/vm-test-g6q_po6_.tmp/data-993a1.tar,if=none,id=data-993a1,cache=writeback,format=raw
-device virtio-blk,drive=data-993a1,serial=data-993a1,bootindex=1
peter.m+ 29304  0.0  0.0  63612  4996 pts/12   S+   15:05   0:00
           \_ ssh -t -o StrictHostKeyChecking=no -o
UserKnownHostsFile=/dev/null -o ConnectTimeout=1 -p 38491 -i
/home/peter.maydell/qemu-openbsd/build/vm-test-g6q_po6_.tmp/id_rsa -o
SendEnv=https_proxy -o SendEnv=http_proxy -o SendEnv=ftp_proxy -o
SendEnv=no_proxy qemu@127.0.0.1          set -e;         rm -rf
/home/qemu/qemu-test.*         cd $(mktemp -d
/home/qemu/qemu-test.XXXXXX);         mkdir src build; cd src;
tar -xf /dev/rsd1c;         cd ../build         ../src/configure
--cc=cc --python=python3 ;


Notice that process 19858 (the python script) is at 98.8% CPU.
This isn't specific to the OpenBSD script, the other BSD scripts
do this too.

Why is this script using so much CPU when it should basically just be
waiting for the QEMU VM to finish ?

I think this is probably a recent regression, though I'm not certain.

thanks
-- PMM

