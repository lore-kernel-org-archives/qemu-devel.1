Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BABC2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 10:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEEE6206E4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 10:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEEE6206E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asm.pp.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ils0w-0003v1-2O
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 05:11:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bsdasm@gmail.com>) id 1ils0M-0003Q3-Sq
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 05:10:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bsdasm@gmail.com>) id 1ils0L-0004fi-Mp
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 05:10:30 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33354)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bsdasm@gmail.com>) id 1ils0K-0004eY-43
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 05:10:28 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so23891596otp.0
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2019 02:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hg7BfoJV1wrWmPVCeiaS0MVIu+FLVeAedRvD3TIzpO8=;
 b=U//l4X2zrDWjcwu8YoriIKF3p1gOCKBOv+wl7weqOCr2uPGtonIbV+KeDycQ9B69hW
 J9YuUHcArV+AknL0UA6tN/NeK7ewml3lmO0z5Ui1B0TsTtVHq9inYtSgygRungtk1ZYW
 NnmWkOOChjXfSOOa9iCim4jztrYiuGjTVbmFpn2lOdhDm96d0DFD/VmEML6uCnyrSdY5
 LGSOkqP4bgVqzCX8T9lVu55o016rsuw/F0pMLkm1KnW1M/riE1K7XBMUlyRZj4duXczJ
 QJvo7jGch7magpEHUso0+Z4UatzFFmrEh7Mw31qi3sa5O9UqTY3yAzPc1JzPNOT9634U
 RyOQ==
X-Gm-Message-State: APjAAAUKWLBIHWEdigG4n8KA2igbjvbKWhUbWKIsok8CDEItxmt++Ug1
 jX/sTF/Jpqw1LxB836Y2o89FS7zRnSTxL6/iZh4=
X-Google-Smtp-Source: APXvYqy+N5GLtCwgKsiUmcW1AKl2wZSTCKBebfdkoB8Xjy1yEjnw227u8FGqQ2tMnCH62PWgW8Bkd4xdoPaujkvVRds=
X-Received: by 2002:a05:6830:1112:: with SMTP id
 w18mr67559536otq.356.1577700626499; 
 Mon, 30 Dec 2019 02:10:26 -0800 (PST)
MIME-Version: 1.0
References: <CAMmAVbWzrYWZBXwKxSd-f5SXmq6qP1ok8abvyKJhp3=REEaMPA@mail.gmail.com>
 <CAMmAVbXNMjk=FasuySEcUa0U8CqGkCghehsJsWbVV2VHCAPA-w@mail.gmail.com>
 <20191121140502.GX439743@stefanha-x1.localdomain>
 <CAMmAVbW5a+v_dJ6NM3erwouOqpXyTzL36_W566SL1KuPFPFSEw@mail.gmail.com>
 <20191219145817.GG1624084@stefanha-x1.localdomain>
In-Reply-To: <20191219145817.GG1624084@stefanha-x1.localdomain>
From: ASM <asm@asm.pp.ru>
Date: Mon, 30 Dec 2019 13:10:15 +0300
Message-ID: <CAMmAVbVoHcTiBnOVtFb5MS3V-in0u=4k4WPHcpxGtYF8Pv5bKQ@mail.gmail.com>
Subject: Re: PCI memory sync question (kvm,dpdk,e1000,packet stalled)
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.66
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, dmitry.fleytman@gmail.com,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> It could be a bug in QEMU's e1000 emulation - maybe it's not doing
> things in the correct order and causes a race condition with the DPDK
> polling driver - or it could be a bug in the DPDK e1000 driver regarding
> the order in which the descriptor ring and RX Head/Tail MMIO registers
> are updated.


What did I understand:
* DPDK and Kernel drivers work like simular with ring. It don't
analize Head, but check STATUS.
This is a bit strange but completely correct driver behavior. If the
driver writes to memory, it expects
this value to be written. The problem is definitely not in the DPDK
and in the kernel driver.
* This problem appears on KVM, but not appears on tcg.
* Most similar to a bug in QEMU e1000 emulation. The e1000 emulation
read and writes to some
memory and same times, same as dpdk driver.


As I understand it, KVM explicitly prohibits access to shared memory.
It is obvious that us need to
protect (RCU) all STATUS registers of all buffers. There can be a lot
of buffers and they can be
scattered throughout the memory.

>
> Did you find the root cause?

I think yes, see above, but I can't understand how I can fix it.

For those who are interested in this problem, I made a project that
easily repeats this error:
https://github.com/BASM/qemu_dpdk_e1000_test

Unfortunately I don=E2=80=99t think that I can fix it on my own, without an=
y help.

---
Best regards,
Leonid Myravjev

