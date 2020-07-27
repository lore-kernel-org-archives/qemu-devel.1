Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E84C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:04:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96FA82075A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xeIBEm06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FA82075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02o4-0007Ql-Rm
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02my-0006LT-6N
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:03:32 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54187)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02ms-0003eB-Rr
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:03:31 -0400
Received: by mail-wm1-x342.google.com with SMTP id g8so2930199wmk.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 06:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=iPNkiEZ36lwp1ViZSV/1+m3coDrljwAl5D+Clz90/+g=;
 b=xeIBEm06dxk/JI/FOo5ewu1bxV0l5lHkkn0q7y9o8Xh93AFfo9VKuiHT8EIrGRRDlF
 8IRn8OsoLpStQ7hEL5288Ka05juuPtvG0UjX+fE6vUJRH1OJ1Pi0JrSB85UYsMAkYMjx
 7o0fPZT5U+PHbwQ6cI1DMQEzxhgL8AHX1nkNihNhw/O5OmNG3SHcEsqOKjMQV4rE69Hn
 p9RUDmTuf0T6lN7VcfaRcpOjt59O/N0BiFBWkuiHSCYmiBmZy3RTfjvN1gH68ONgD6Cu
 uAuRX6xpX+Q/k/3+7a7IajSoDb5XYYXKYVCrpK759mRqeLFjc2OUbrVBUuThEwOT0YMH
 cPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=iPNkiEZ36lwp1ViZSV/1+m3coDrljwAl5D+Clz90/+g=;
 b=Q4EOEMBQJzp0msgQf5/EP3yD/GXFBhP0t7oxyhkQJGY96vWF2aK89Z+X+d3mJNduwq
 Jn0Wt9TSHuj4P4FkqxVyzfZOMbcFTs1KraMLD3RA/Ng9iR7v9cjLD06crXvAFh8wnP6b
 0LGvs3JuMUD4cucQ+iCz6B51zpYoMg5pvpw8XalDp6c7S5a3ab5diHGujlOo/6klV3wC
 g0vyF2kIUoWN9XQWZ5mVYngUgyZgk/bjyufnoAoP+fjDSn4rvCg+SeabMdBAhcrY1j5S
 FbHwTGC2kCVbrHFO/+TcEiFb47xT5Q0TNTlFSY72ZhoWnm3i0oehB/Y72stWAsWS7oWA
 4ldg==
X-Gm-Message-State: AOAM533omwHw4N9S8Ca4Vf830uz2AUFIPR0hBwf20pDqPelyihRuoiE1
 ttuagofR4ObTsOHME8u7kMuQbg==
X-Google-Smtp-Source: ABdhPJzNedqj09EbCMBwEzeaQGrbstYilyDHLA0OUWs+wfR+oBF2mz+DowJQSxUxqI92MU8ZhUsFQg==
X-Received: by 2002:a1c:b6c4:: with SMTP id
 g187mr11927944wmf.149.1595855004886; 
 Mon, 27 Jul 2020 06:03:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s19sm13885396wrb.54.2020.07.27.06.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 06:03:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BBEB21FF7E;
 Mon, 27 Jul 2020 14:03:22 +0100 (BST)
References: <CAFEAcA__RiZoe9qRTT_ZCbm_FmXZMO2MseGkimtL459Uoaoi9A@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: tests/vm/openbsd script (etc) excessive CPU usage
In-reply-to: <CAFEAcA__RiZoe9qRTT_ZCbm_FmXZMO2MseGkimtL459Uoaoi9A@mail.gmail.com>
Date: Mon, 27 Jul 2020 14:03:22 +0100
Message-ID: <87blk13yat.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> I noticed that when running the BSD VMs, the Python script that launches
> QEMU seems to eat CPU:
>
> peter.m+ 19024  0.0  0.0  20296 11692 pts/12   S+   15:04   0:00
>    \_ make -C build vm-build-openbsd J=3D8 V=3D1
> peter.m+ 19858 98.8  0.0 126272 15220 pts/12   Sl+  15:04  12:04
>        \_ /usr/bin/python3 -B
> /home/peter.maydell/qemu-openbsd/tests/vm/openbsd --debug --jobs 8
> --verbose --efi-aarch64
> /home/peter.maydell/qemu-openbsd/build/pc-bios/edk2-aarch64-code.fd
> --image /home/peter.maydell/.cache/qemu-vm/images/openbsd.img
> --snapshot --build-qemu /home/peter.maydell/qemu-openbsd --
> peter.m+ 22878  711  3.2 10506236 3192896 pts/12 Sl+ 15:04  86:08
>             \_ qemu-system-x86_64 -display none -vga none -chardev
> socket,id=3Dmon,path=3D/var/tmp/qemu-19858-monitor.sock -mon
> chardev=3Dmon,mode=3Dcontrol -machine pc -chardev
> socket,id=3Dconsole,path=3D/var/tmp/qemu-19858-console.sock,server,nowait
> -serial chardev:console -nodefaults -m 4G -cpu max -netdev
> user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22 -device
> virtio-net-pci,netdev=3Dvnet -vnc 127.0.0.1:0,to=3D20 -smp 8 -enable-kvm
> -drive file=3D/home/peter.maydell/.cache/qemu-vm/images/openbsd.img,snaps=
hot=3Don,if=3Dnone,id=3Ddrive0,cache=3Dwriteback
> -device virtio-blk,drive=3Ddrive0,bootindex=3D0 -drive
> file=3D/home/peter.maydell/qemu-openbsd/build/vm-test-g6q_po6_.tmp/data-9=
93a1.tar,if=3Dnone,id=3Ddata-993a1,cache=3Dwriteback,format=3Draw
> -device virtio-blk,drive=3Ddata-993a1,serial=3Ddata-993a1,bootindex=3D1
> peter.m+ 29304  0.0  0.0  63612  4996 pts/12   S+   15:05   0:00
>            \_ ssh -t -o StrictHostKeyChecking=3Dno -o
> UserKnownHostsFile=3D/dev/null -o ConnectTimeout=3D1 -p 38491 -i
> /home/peter.maydell/qemu-openbsd/build/vm-test-g6q_po6_.tmp/id_rsa -o
> SendEnv=3Dhttps_proxy -o SendEnv=3Dhttp_proxy -o SendEnv=3Dftp_proxy -o
> SendEnv=3Dno_proxy qemu@127.0.0.1          set -e;         rm -rf
> /home/qemu/qemu-test.*         cd $(mktemp -d
> /home/qemu/qemu-test.XXXXXX);         mkdir src build; cd src;
> tar -xf /dev/rsd1c;         cd ../build         ../src/configure
> --cc=3Dcc --python=3Dpython3 ;
>
>
> Notice that process 19858 (the python script) is at 98.8% CPU.
> This isn't specific to the OpenBSD script, the other BSD scripts
> do this too.
>
> Why is this script using so much CPU when it should basically just be
> waiting for the QEMU VM to finish ?
>
> I think this is probably a recent regression, though I'm not certain.

Robert thinks this is fixed up with the latest clean-ups for the console
drain thread which is in today's PR. I've not seen it while testing the
PR so I think it's gone.

--=20
Alex Benn=C3=A9e

