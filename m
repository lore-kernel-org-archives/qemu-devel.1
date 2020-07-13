Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3252FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 01:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE1C2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 01:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQ+mJ3Y2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE1C2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1junFf-0003LH-8i
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 21:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1junEz-0002ua-7d; Sun, 12 Jul 2020 21:26:45 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:44012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1junEx-0002aR-Hu; Sun, 12 Jul 2020 21:26:44 -0400
Received: by mail-yb1-xb42.google.com with SMTP id y13so5633212ybj.10;
 Sun, 12 Jul 2020 18:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tEtTDo5REdLq/Ft8mJWQbjnZEzjfGBVsty3PG91N6Ck=;
 b=NQ+mJ3Y2wStvMtsBjFPyJY42wFcZlqUOA814twsa16N6o4BjDSUfFVQJteCaNHVvCj
 6an336dUI36ZG6PQbwya/MURZjIjFfYsIFjXrh7H/dsd8eAoLH7+D8pZx6lE50w9tZ7V
 bSDt/5mIyRqIH9EhjFJLa+JcKJc1Ddoti5OFr8HB+kaS58LMAfFzt9u3Bm71Wft3VqVs
 M7oCAgAHDh3LRNiE5yxpknUvk6AgRqYVRLSmkt8h8UkSoQf1PM93DJZh7N8AIxQ6DSaG
 uCBY+6P7WsqSkwQbQy8Hp1J/Lwu7ojC87/qH0phOv0KAglxm6CscXNRhcNSiZ3smb0Dv
 EuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tEtTDo5REdLq/Ft8mJWQbjnZEzjfGBVsty3PG91N6Ck=;
 b=WJhsbjXT7klDqSrBZEPRdcpEjaJ7ecM8BIYTPzkBojxYzCeN8QUuQsCwB8XhXbwagq
 JKZ2FNtL8SAelN7pQ1BYSV1zyP2u/6fUF+6elkfWa/dG8Z9uy0TD6qvCqc8BCpN+ptuR
 kctaudDnJm/CKPXAju9uDZRaoUK83IKIyv8MLw71s0RovJd0UkJHrGvGcc2GkDFgs7+8
 FwWFT92iFSsRR+YItpcgPIuovO086a4KNAUapEPQvPBe1q4QE7O7+DtJj1tDYB3GjvNT
 0yUG2xtJuHzwvpk1+uKlFd1gigGu5hlzFRWlctqinkJmRMYwfe4YvkcWlMnTu8DT2LfF
 M8fw==
X-Gm-Message-State: AOAM532kzgNbeYgvtqYW5J9xt4zSTGOIn6jq5TFWmZcnmrFa8QbE5kEh
 IHKtDjmbm9StqI568e7+fhSUUEldmtAsE5t4vaU=
X-Google-Smtp-Source: ABdhPJwSgETaxRTBhkJrxb0mX959Z41iAqZYnM9w62e+aGr47SzHrp+nI42Q7IZVxYnjSQlyU3vyIdYdbne+WwpRKRE=
X-Received: by 2002:a25:c342:: with SMTP id
 t63mr128410615ybf.122.1594603602235; 
 Sun, 12 Jul 2020 18:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <1594357499-29068-1-git-send-email-bmeng.cn@gmail.com>
 <1594357499-29068-8-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKPf4YH9Ut1mTLRoRdk-aja6wTKS-FhA-5LynbCeajh-_Q@mail.gmail.com>
 <CAKmqyKOQM4pZLAnt42m-MC2cFOxM_+_-tw7FHxe1RbDf84q0Nw@mail.gmail.com>
In-Reply-To: <CAKmqyKOQM4pZLAnt42m-MC2cFOxM_+_-tw7FHxe1RbDf84q0Nw@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 13 Jul 2020 09:26:31 +0800
Message-ID: <CAEUhbmXAfN5zjpAF-pZmjrERUsoZZ0z4OQO+2_Q6MU_RxvX=EA@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] Makefile: Ship the generic platform bios images
 for RISC-V
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jul 12, 2020 at 1:28 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Fri, Jul 10, 2020 at 11:36 AM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Thu, Jul 9, 2020 at 10:11 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > From: Bin Meng <bin.meng@windriver.com>
> > >
> > > Update the install blob list to include the generic platform
> > > fw_dynamic bios images.
> > >
> > > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> >
> > You didn't address the comments in v3.
> >
> > Thinking about this more though it looks like we currently don't
> > install anything, so this is an improvement.
> >
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Nope, I was wrong. This should be squashed into patch 4 where you
> remove the installed binaries.

Not entirely correct. The .bin changes should go to patch 4, and .elf
changes should remain in this patch I think.

Regards,
Bin

