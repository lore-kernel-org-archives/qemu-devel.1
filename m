Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E820C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 04:33:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B9C20732
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 04:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Oaz6u8lJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B9C20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIm7G-0005rH-KH
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 00:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anup@brainfault.org>) id 1jIlxh-0000PP-K8
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 00:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anup@brainfault.org>) id 1jIlxg-0003oV-KC
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 00:23:45 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34592)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <anup@brainfault.org>) id 1jIlxg-0003mR-A6
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 00:23:44 -0400
Received: by mail-wr1-x443.google.com with SMTP id 65so19850870wrl.1
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2020 21:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HzG7oyXt/nsBgTi6zmit0T++IzWCAHZ7qmuGbPyQKFo=;
 b=Oaz6u8lJqj2lr0brqtHiA/sBxIkaIKveNonoyhGZWwOBo1q0ZSntJE/7YX7uxL8D0p
 TkccxD5+PflOPfefCd0T76a5e3kfoLxQdr6FI2T+zfYVrACB21rhDyi/pQFAV/XCZyou
 ONwPZwZ5c+dM8OW9GqAgXa6URTx/sAQtG9s82QkSn0aCqH0Wz/EQL8ePv12yp+TdK8tj
 hwcumrjQI71pSyEUnmIUpIA1EL6reJi2XE0A4zJmncQBLS+CtOn8aQpZmOqDvwVbbT6v
 h+EfBl7zpLfBvWlBmW86Eo5eVVNcUBiQl14nPnjeMFvtoKIH0RbgW7rtb3J2dFXLeYXM
 jNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HzG7oyXt/nsBgTi6zmit0T++IzWCAHZ7qmuGbPyQKFo=;
 b=DG0OtOfumlyEQMsJ13Rr7M2Xt+hefn77rulOxg5BCrcMjWUiKz4k98cOZwVxBvK0ND
 t9u14ITxVa4QlUrZimpkrelvh7+ibq2O3f0sUCCrjaZQ3fTRqirb0wfGgcguK8pQfi4Z
 6+GCz4k6LqGUC6jPof6f6uB1ctaTcoEuQnr/mxVBEsx8sk0498MGXdx/L19qK9+4xO+X
 X28HuIy9Ybtio7v5wQH8ee4rByV88h8C/QScq5LXm7IhSNyWT4C6hOu/Q1ua/GizLrlZ
 PP0SsA7sgJyt4N6e9r+S0kTUotLaGE7w3jQmegxX6/iZBcclraO8WJFf/vX3F3xaD27Z
 lmLg==
X-Gm-Message-State: ANhLgQ3PwwgrkNP84qmeuwQu55VXx6rVPwQOp3gSbK/OEuQd60yusN3/
 Bv67c+hKQJ8Pp6SxZFYlH3tYjlmRE0h87zucUMJstg==
X-Google-Smtp-Source: ADFU+vshWyqLWpOrJ9xdCfB6ck/+0gAWWbuyILfFoD+Z2kMBSFsFceasLZxT529BjjoapKRl6E/1UmsBmrDgBmgHztI=
X-Received: by 2002:adf:8187:: with SMTP id 7mr13325645wra.358.1585542222325; 
 Sun, 29 Mar 2020 21:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585262586.git.alistair.francis@wdc.com>
 <mhng-f7361188-1bb2-4ea3-bc25-3076f877aa64@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-f7361188-1bb2-4ea3-bc25-3076f877aa64@palmerdabbelt-glaptop1>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 30 Mar 2020 09:53:30 +0530
Message-ID: <CAAhSdy2PNi-XE94kzSVRZLc_iJOKkBvwB6eo8qu=byBOUH9DDw@mail.gmail.com>
Subject: Re: [PATCH for 5.0 v1 0/2] RISC-V: Fix Hypervisor guest user space
To: Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Palmer,

On Fri, Mar 27, 2020 at 5:30 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Thu, 26 Mar 2020 15:44:04 PDT (-0700), Alistair Francis wrote:
> > This series fixes two bugs in the RISC-V two stage lookup
> > implementation. This fixes the Hypervisor userspace failing to start.
> >
> > Alistair Francis (2):
> >   riscv: Don't use stage-2 PTE lookup protection flags
> >   riscv: AND stage-1 and stage-2 protection flags
> >
> >  target/riscv/cpu_helper.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
>
> Thanks, these are in the queue.
>

I have tested this patch series on latest QEMU master without
"target/riscv: Don't set write permissions on dirty PTEs" workaround
patch. It works fine now.

Tested-by: Anup Patel <anup@brainfault.org>

Please drop the work-around patch  "target/riscv: Don't set write
permissions on dirty PTEs" from your for-next.

Regards,
Anup

