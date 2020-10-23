Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9B9C388F7
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 01:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 604A020760
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 01:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLwxEagz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604A020760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVlZp-000123-65
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 21:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kVlZC-0000cq-Tq
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 21:08:26 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:45188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kVlZB-000881-32
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 21:08:26 -0400
Received: by mail-io1-xd42.google.com with SMTP id n6so3650162ioc.12
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 18:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9QMJBruv/JjodSlEZKQmSWlUBuTN5E0hPHPDqKAfA/0=;
 b=YLwxEagzKPaIShiaN8aT/UmdZjiZfc5iHXJ/PDXHFjfpgTAtW86AbWdoc+gUfdbSdk
 HQoyLrRt1qNkfbjXrS9FTTDI4jwSzZ7UV+SDBZUfRF8OzRg80jcEbekKC6YRGo4ti3SW
 jZqxMPEFUBvMBTxpkt2PojIBQ5Eeybym3wCZ4Z2QpoVaMOGJhoOd07HF+DKmGS6wZxfW
 O/ffOGH7he2lXMgZyVZjMNAEK2osxg9gDG1/0e2bq+6rYutXO+o2gGRZIkPBVLS9zgXr
 uablngn2dY9VtDY/FAugYELV2mLpvfqY99zcR2ZQECJ3MOEcEnm2Z+fB4LgabayVzbOC
 fU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9QMJBruv/JjodSlEZKQmSWlUBuTN5E0hPHPDqKAfA/0=;
 b=a4S6ditKkCVCVWCzYHVIV7IOj1OI496UUVT4/20HO/JDoLAdrg9+EVpwYGGXP1/VpF
 TY/Iqv5izRxg0aBHlepvb4WE2JcpGqcbCMcsnz+XmKkodnosr4X1Z2OAbVMP6zb4um4K
 UG5tckbIETaPGs9DuyYpm1KvUuYYFCjIoKM2gGjZwvNeFfctSNXFxg9MrTaaR/WjzqI9
 eaLPWbwOEfP1uMtFeKyggzvi38qjPIY2F1yt2J6Nm2GvZhCoBuLD/+pfNRDyVpFuBptV
 k8P1rwqy+YPPz9f7WY6PV+X9S2IZ0XG99nrcJQW8KgeDo9fYb+RH7JyKH+Yx1o9sEZjM
 93TQ==
X-Gm-Message-State: AOAM533kzBPV232biRt8QKUZMtM/4xRvVamkByZxZFHh6HjI037krkbI
 gxesyymT9PJhT9JmUrAWGiNyH9iiXs0ttvQa4hQ=
X-Google-Smtp-Source: ABdhPJx+E2qI3XZL4+mOftO3zrkOoimDwPyF08ofBObzg4RajSV74XmUk4oAFEj+u9r2T+lKrh37O80g7fIC6NlWLsY=
X-Received: by 2002:a6b:8ec7:: with SMTP id q190mr3830006iod.42.1603415303618; 
 Thu, 22 Oct 2020 18:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAKBBNisk7n6i9HcgKwTo3sSZ4BVxFkhnoPuu6MgTxTtWJZcdOQ@mail.gmail.com>
In-Reply-To: <CAKBBNisk7n6i9HcgKwTo3sSZ4BVxFkhnoPuu6MgTxTtWJZcdOQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 22 Oct 2020 17:56:38 -0700
Message-ID: <CAKmqyKNoUg9f-NdgAoGrq_DuBwWv_ZgusArvOobxEYM1mpzbRA@mail.gmail.com>
Subject: Re: Emulation for riscv
To: Moises Arreola <moyarrezam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 22, 2020 at 4:58 PM Moises Arreola <moyarrezam@gmail.com> wrote:
>
> Hello everyone, my name is Moses and I'm trying to set up a VM for a risc-v processor, I'm using the Risc-V Getting Started Guide and on the final step I'm getting an error while trying to launch the virtual machine using the cmd:

Hello,

Please don't use the RISC-V Getting Started Guide. Pretty much all of
the information there is out of date and wrong. Unfortunately we are
unable to correct it.

The QEMU wiki is a much better place for information:
https://wiki.qemu.org/Documentation/Platforms/RISCV

>
> sudo qemu-system-riscv64 -nographic -machine virt \
> -kernel linux/arch/riscv/boot/Image -append "root=/dev/vda ro console=ttyS0" \
> -drive file=busybox,format=raw,id=hd0 \
> -device virtio-blk-device,drive=hd0
>
> But what I get in return is a message telling me that the file I gave wasn't the right one, the actual output is:
>
> qemu-system-riscv64: -drive file=busybox,format=raw,id=hd0: A regular file was expected by the 'file' driver, but something else was given
>
> And I checked the file busybox with de cmd "file" and got the following :
> busybox: ELF 64-bit LSB executable, UCB RISC-V, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-riscv64-lp64d.so.1, for GNU/Linux 4.15.0, stripped

That looks like an ELF, which won't work when attached as a drive.

How are you building this rootFS?

Alistair

>
> So I was wondering if the error message was related to qemu.
> Thanks in advance for answering any suggestions are welcome

