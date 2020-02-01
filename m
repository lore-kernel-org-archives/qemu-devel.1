Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9907BC33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:32:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647F620663
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkLbd51c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647F620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixheM-0001YH-K0
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1ixhdU-0000ic-LU
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:31:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1ixhdT-0008A1-8i
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:31:48 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d]:33081)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1ixhdT-00086T-26
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:31:47 -0500
Received: by mail-lj1-x22d.google.com with SMTP id y6so9026067lji.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 17:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zmHxMYEtq+iYTHnafhADNs66vokuqA2zehixrxpR7jQ=;
 b=MkLbd51cI9atmuVrIgzqzBQIOLHlZR3rc1+vz2Due6He0Z6Rm8Qn53Fkr9qOEs8NDu
 u+hYJ7O9Byqjc1ZfZDfBdaBMP9YmpJE6hhQsdxiOMQ43r+wIWPAEu6zXBPIG6lOZJCjB
 l4Q5LlboM+lXJHcwQGEJPON6iaqHujAZkEYigNGdEtIfzpxOBxbVUN0lkw7k6abKysTM
 fL4ROHeCxAkUlaaKWp0/a4pDagsjcJaJmMHRbSS8v5BmnHUN3fvwXZysf7S8lk6sB+VM
 5Jnx2UmLV4CxGuznaoZKBa4NInoSHeQpD4UITgiGcAMiwVvaV1JSTT1LHsdPl7T4Ol87
 0bDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zmHxMYEtq+iYTHnafhADNs66vokuqA2zehixrxpR7jQ=;
 b=mi33ecHDHCPjGjjD9sJSf8baMn4+2hhvdv4vh9LVoN49b0duguYgF+/sk/sevyN8qs
 MOQDc6kz/4tJ5vNY/RMSp5k4wfxvC7IRVm3X52redmCY5BM6lTeuUidz5d5V2UEOyShI
 XnfwCepAWiySy8B9kyXY2XY2/j7vC3edZedqvF9ZkuRgf5ixQ+q0aa7HbrsaJZVBh4eX
 YdDOGNWwiwoaphJVrObA0uQSekS1jKiREFwNls1JUnw0WWjnQ/Vw7AGfkk+Z1x4CBWlg
 12WCU8lV2TFtVHfAJzv3sSrz5w34jXU4y07qVJTnfJW7z1SWg+riiZNV67vzw8+4d+W1
 95Fw==
X-Gm-Message-State: APjAAAXpqcKrHda2B9o/amVJ2BDwTVuajscK1cm65Q9p2t+tV2VN/0M8
 ht4nZDhasutDLiSlMCQNhez6GozR6UhJc27noAM1Omcd
X-Google-Smtp-Source: APXvYqxxKZJUDqsBs7tDFAo/yiKbO/K5SghiH78Otnn3Y8huJG2HFmPiv4Dz8RtJQn6alZ3/qmZrGQ1rRBi7cGbG4Dk=
X-Received: by 2002:a2e:b4ac:: with SMTP id q12mr7224230ljm.285.1580520705139; 
 Fri, 31 Jan 2020 17:31:45 -0800 (PST)
MIME-Version: 1.0
References: <157875755996.2711.225801499083245592.malonedeb@soybean.canonical.com>
In-Reply-To: <157875755996.2711.225801499083245592.malonedeb@soybean.canonical.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Jan 2020 17:24:41 -0800
Message-ID: <CAKmqyKPnkfPCg3O6C3f80d6RRB_6UMGQjXni8OoFRVUq9=SNKg@mail.gmail.com>
Subject: Re: [Bug 1859291] [NEW] RISC-V incorrect exception generated
To: Bug 1859291 <1859291@bugs.launchpad.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::22d
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

Do you have steps to reproduce this?

Alistair

On Sat, Jan 11, 2020 at 8:25 AM Teodori Serge <teodori.serge@gmail.com> wrote:
>
> Public bug reported:
>
> When using 'ecall' from supervisor mode, user exception is raised
> instead of supervisor exception. The problem is located under
> 'target/riscv/insn_trans/trans_priviledged.inc.c' in function 'static
> bool trans_ecall(DisasContext *ctx, arg_ecall *a)'. Best regards, Serge
> Teodori
>
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>
>
> ** Tags: risc-v
>
> --
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1859291
>
> Title:
>   RISC-V incorrect exception generated
>
> Status in QEMU:
>   New
>
> Bug description:
>   When using 'ecall' from supervisor mode, user exception is raised
>   instead of supervisor exception. The problem is located under
>   'target/riscv/insn_trans/trans_priviledged.inc.c' in function 'static
>   bool trans_ecall(DisasContext *ctx, arg_ecall *a)'. Best regards,
>   Serge Teodori
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1859291/+subscriptions
>

