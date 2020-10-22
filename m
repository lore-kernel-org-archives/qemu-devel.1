Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2F4C388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 23:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F206220848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 23:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLakaqYN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F206220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVkUR-0006es-RC
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 19:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <moyarrezam@gmail.com>)
 id 1kVjVW-0007H0-Kz
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 18:56:30 -0400
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f]:32973)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <moyarrezam@gmail.com>)
 id 1kVjVR-0002Ec-5U
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 18:56:30 -0400
Received: by mail-vs1-xe2f.google.com with SMTP id s15so1846644vsm.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 15:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=vtsRf3IHCfspmIQ1Z9me05ZL2ud/MvM4Y8rHrNk+xvM=;
 b=kLakaqYN9ItI9FgnIsrQfwBWQk/yYhvBZ14zgKxpss2a2n3A0PQIkyjLPdJnaNzrbu
 thgaqPbd3vXPOYE94jH0kNh/M1aq+xMOtmsegTOxVKZ3rXNuUlQ1vNsWoDecDuVtQxT+
 Yus3GJDy4ohCHuW0hSf1FM8+k8ILneitMArsuGIWgvDpcnCTSulRBkS5uN5k9TjWSTZx
 mYhIkIhkBEnid7OORKCp4rBMSM8K/k/rlTgP9YanlT2+R/0FyfZ8DT+mtinZlLVrEY5W
 5GXYyyAWTTUz/yP21bSb9TuJdg3kpJeV8nT++NWPjLzR1+YqvFYWYhWrpINQL9OL8/O/
 BRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=vtsRf3IHCfspmIQ1Z9me05ZL2ud/MvM4Y8rHrNk+xvM=;
 b=iLo3owQ2gCByEiJjE4HomuX+RVV9BQG8dB7C60wnSrBwU9MmaVnWetP8qaxzAJYUmP
 0DMm+MeSm+zw8WkluSPkvHuUzQF+eQEMi+FX/+ZciohOjRrqkjLhYuveNBcCtsy4QPn7
 nSmIzAKK9/sMHasn+KTFRBbt2s9slOhMDvHrJ0sgdFmC0WuBsujpgNQ7wo0uEDPvix0t
 sytxUTSJ5MZajAMmKcKRwi86+SlbFJGRbTEbznlJZqV6SXFDJ06nkJqluTHj86WF2z72
 9xWJjn1ZAcyLxM1sC9i+u9lVZCSAAfpTB5PKUlg5Exx1TRhE9hzDqRYuGTqzKL5TyIKT
 1XZw==
X-Gm-Message-State: AOAM533QiqmSp8lfGPyLVketXO2vGEBlQZq/wNpHEgbwSZx3Zh3uHYL6
 rt/tTm3DFrCA0bTRLBGnmYarl2KoOSvpTcNT+cmxjyEbFzxusA==
X-Google-Smtp-Source: ABdhPJyd8DE5IT/1zbYZASxyBMW9bLVvgreFN6A4JPoBOLgSbiBAaZwN++nnRYTShU8TNq4yH4MrjT4klIY+6CgxTnA=
X-Received: by 2002:a05:6102:2266:: with SMTP id
 v6mr4150341vsd.0.1603407383469; 
 Thu, 22 Oct 2020 15:56:23 -0700 (PDT)
MIME-Version: 1.0
From: Moises Arreola <moyarrezam@gmail.com>
Date: Thu, 22 Oct 2020 17:56:12 -0500
Message-ID: <CAKBBNisk7n6i9HcgKwTo3sSZ4BVxFkhnoPuu6MgTxTtWJZcdOQ@mail.gmail.com>
Subject: Emulation for riscv
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000085a17605b24a5f60"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=moyarrezam@gmail.com; helo=mail-vs1-xe2f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 22 Oct 2020 19:58:13 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000085a17605b24a5f60
Content-Type: text/plain; charset="UTF-8"

Hello everyone, my name is Moses and I'm trying to set up a VM for a risc-v
processor, I'm using the Risc-V Getting Started Guide and on the final step
I'm getting an error while trying to launch the virtual machine using the
cmd:

sudo qemu-system-riscv64 -nographic -machine virt \
-kernel linux/arch/riscv/boot/Image -append "root=/dev/vda ro
console=ttyS0" \
-drive file=busybox,format=raw,id=hd0 \
-device virtio-blk-device,drive=hd0

But what I get in return is a message telling me that the file I gave
wasn't the right one, the actual output is:

qemu-system-riscv64: -drive file=busybox,format=raw,id=hd0: A regular file
was expected by the 'file' driver, but something else was given

And I checked the file busybox with de cmd "file" and got the following :
busybox: ELF 64-bit LSB executable, UCB RISC-V, version 1 (SYSV),
dynamically linked, interpreter /lib/ld-linux-riscv64-lp64d.so.1, for
GNU/Linux 4.15.0, stripped

So I was wondering if the error message was related to qemu.
Thanks in advance for answering any suggestions are welcome

--00000000000085a17605b24a5f60
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello everyone, my name is Moses and I&#39;m trying to set=
 up a VM for a risc-v processor, I&#39;m using the Risc-V Getting Started G=
uide and on the final step I&#39;m getting an error while trying to launch =
the virtual machine using the cmd:<br><br>sudo qemu-system-riscv64 -nograph=
ic -machine virt \<br>-kernel linux/arch/riscv/boot/Image -append &quot;roo=
t=3D/dev/vda ro console=3DttyS0&quot; \<br>-drive file=3Dbusybox,format=3Dr=
aw,id=3Dhd0 \<br>-device virtio-blk-device,drive=3Dhd0<br><div><br></div><d=
iv>But what I get in return is a message telling me that the file I gave wa=
sn&#39;t the right one, the actual output is:<br><br>qemu-system-riscv64: -=
drive file=3Dbusybox,format=3Draw,id=3Dhd0: A regular file was expected by =
the &#39;file&#39; driver, but something else was given=C2=A0<br><br></div>=
<div>And I checked the file busybox with de cmd &quot;file&quot; and got th=
e following :<br>busybox: ELF 64-bit LSB executable, UCB RISC-V, version 1 =
(SYSV), dynamically linked, interpreter /lib/ld-linux-riscv64-lp64d.so.1, f=
or GNU/Linux 4.15.0, stripped<br></div><div><br></div><div>So I was wonderi=
ng if the error message was related to qemu.<br>Thanks in advance for answe=
ring any suggestions are welcome=C2=A0</div></div>

--00000000000085a17605b24a5f60--

