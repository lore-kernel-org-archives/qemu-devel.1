Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3571C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 20:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0122173C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 20:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LR6H+qLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0122173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvSye-000826-Nj
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 16:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37182)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@sifive.com>) id 1hvSyC-0007Ui-Ux
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 16:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1hvSyB-0005iW-0o
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 16:55:40 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:42442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hvSy9-0005f1-3c
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 16:55:38 -0400
Received: by mail-qt1-x844.google.com with SMTP id t12so1270677qtp.9
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 13:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DsTVPJ/DCS/XHwwomqEBWk2jvUt0gA/a5hzs5Z9Hmp8=;
 b=LR6H+qLJzHnPdPMgX0legLNFr5sOzSAWo6nEiwXDRRwgGTg/JWZBpXujvLqWs1Jxhv
 oQRqJALTf7ifR99SyiL9QoTH/d/lElrXqLam2E6Za0qYq9XDzWn8MfZnn3TQkZSNC2dS
 4Yk986RK0LImxzevrLS3V3gaDf76M11XWke3bKJENuk+iP19cOyEK7XzlbwUapB6RG4A
 8r8+NcYKwCIT6CpLtdEhzQrY5wpc55gp8ZPYgH8HTKskPLedyDkWvARXmL+qQu70QxL/
 e2NFIU1g3dLlR3346VY96mO6aLKbCv71f66hSwPP0wt8GaOvtSqggFE1SGjbxtwPVLPi
 9rVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DsTVPJ/DCS/XHwwomqEBWk2jvUt0gA/a5hzs5Z9Hmp8=;
 b=ah2fyWYjap5Wf57ezbhrWCiX7sT6X8zP0Y38Q379uF6LJ5wmZbBh5EXKEZxOnvuBuF
 L+20mvHu39jLyUb3y/LydgsnOs4K1gTu3uYzvOxC8MvqZ6r17G1TLIBbukKlzoC6eSW6
 rLn1d2hwwM/lhXSOfxFrbKm9Tv32X5cVD1R1cYoEQ6pWmSYihekj5BLicy6WPw7Aise5
 rhvuSK3c8/bmbbFbLt6sTNNgJ+US9URfwFDHVB7BMsXZzE1rmS4q9Yw0FeUIfP/+Zr9w
 YmM3ijiZ0IXUqNY8iPjR8Pr7SPI2e6gS5nWV1S7ZvDbl7VFzOAUlz8XWDme57mf5qg05
 3A5g==
X-Gm-Message-State: APjAAAX9od2DwOblau7ljWEjxhIDoSJWPwzEUIaIiSoApZxiMpgNVUx7
 GKx8oKW7/ngaE7CcK26x8rlrNJ+FLzE=
X-Google-Smtp-Source: APXvYqyUjVUateWnXRnTvgnOLh6ueZx+gCNPieSbQl4x1Qv1MXF8NSWiAScriFpfPRFSW4tctt3iTA==
X-Received: by 2002:ac8:4117:: with SMTP id q23mr1128675qtl.305.1565211336035; 
 Wed, 07 Aug 2019 13:55:36 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com.
 [209.85.160.180])
 by smtp.gmail.com with ESMTPSA id j22sm37991276qtp.0.2019.08.07.13.55.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 13:55:35 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id k10so20705362qtq.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 13:55:34 -0700 (PDT)
X-Received: by 2002:ac8:23b3:: with SMTP id q48mr37884qtq.110.1565211334655;
 Wed, 07 Aug 2019 13:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <1564577101-29020-1-git-send-email-bmeng.cn@gmail.com>
 <581a0284-c658-265f-1b0f-6f4be5406cee@linaro.org>
 <CAEUhbmVXC6GeHYFST514cLRJHQOo5ki=ZPG=OsLzV2YA0ChQgA@mail.gmail.com>
 <ac4453de-81cd-c32a-17f8-283fa3569ed0@linaro.org>
 <CAEUhbmX2C_FbW_m=Mri19hpz0c74SQTt3ogsatGgveH09t3_4g@mail.gmail.com>
In-Reply-To: <CAEUhbmX2C_FbW_m=Mri19hpz0c74SQTt3ogsatGgveH09t3_4g@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Date: Wed, 7 Aug 2019 13:55:23 -0700
X-Gmail-Original-Message-ID: <CANs6eMkRQ1-Gb42DhHGz++4Q79JbH4S3MnccwmwKKEB-sdozag@mail.gmail.com>
Message-ID: <CANs6eMkRQ1-Gb42DhHGz++4Q79JbH4S3MnccwmwKKEB-sdozag@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] riscv: rv32: Root page table address can
 be larger than 32-bit
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
Cc: QEMU riscv <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU devel <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 1, 2019 at 7:58 AM Bin Meng <bmeng.cn@gmail.com> wrote:

> On Thu, Aug 1, 2019 at 10:16 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 7/31/19 6:53 PM, Bin Meng wrote:
> > > I am not sure how (idx * ptesize) could overflow. It represents the
> > > offset by a page table which is [0, 4096).
> >
> > You're right, I mis-read what was going on there.
> >
> > However, lower down, "target_ulong ppn" needs to be promoted to hwaddr,
> so that
> >
> >     ppn = pte >> PTE_PPN_SHIFT;
> >     ...
> >     base = ppn << PGSHIFT;
> >
> > does not overflow.  (Which is the part of the page table walk that I
> thought I
> > had gleaned from the patch without actually reading the entire function.)
>
> Ah, yes. ppn should be promoted. Thanks for the review!
>

Did I miss a v2?
