Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED7BC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 22:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A03E2074B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 22:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzqXvGzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A03E2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCsmb-0006nq-OL
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 18:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jCslp-0006It-MZ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 18:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jCslo-0007ec-Nu
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 18:27:09 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:34483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jCslo-0007dQ-GP; Fri, 13 Mar 2020 18:27:08 -0400
Received: by mail-ua1-x943.google.com with SMTP id g21so4228910uaj.1;
 Fri, 13 Mar 2020 15:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hjrk1RSYoPPLiFmW2tKrZHbwnLGZUr0D7yWhYjGg1fs=;
 b=mzqXvGzsZpfyohuHNos4iRRQSvSlqpdww+hrQLr+54bj4Vx7UMhZyPSSroLF77fjp2
 kIvFihb0sYrpHmLIKUduKUTkxyLairnY1hP5hTJhfpml2+oAQ0lm/GxzxbCI5wGU5KF9
 j3QTSadjMeVKzfRxlcfjZ+lP58X0LonqtsuyudDnxhW8oIEDLsS8F9pSFwi0xTz++OCm
 5XcSfn8rTXSZs9ZpWX4a+IBUzLUkJbcsOKs/se5FWZwE7ocPU0gZ8UHmIdK8XRnvx962
 LN7m0CfZnZiRBQ/hNfHFd/UlggY+kAALh1COmhMxWsZGqdBBw9TZTw8NNRK1USGhscD9
 j+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hjrk1RSYoPPLiFmW2tKrZHbwnLGZUr0D7yWhYjGg1fs=;
 b=mTalqf3sc+PimcmIV+NBoJBkRrGo1AQ3v6+xhuuhcQNrdNGraxY4VE+E/vXZ1BDT1x
 lb34DFk8kHGfbnBOw2GWaAThX1rbE4VES5DMCMSoUQl46Y42cOsKRZBexXUemmq7/KGj
 CX//YlhxR+auJEcknnjsRIbZmI6ssvvcoXMZKVrBzvY2vJgtPhn9TPKuVLOj8DZ45gcf
 D58dbMqkdHWf89jQJRlE2gvg9aXQmejhy1LB4u3vNA3CKtFEeobJ2hy+oKfFzzO2odAj
 dLFes4dJUMGx1n2wlZoUR/uz6q+48tWUTFyx3Gh1ypLRO1yFcUJ1I/M1iN56uXb4MCQe
 pSHw==
X-Gm-Message-State: ANhLgQ1mqlOYKTUfhU7/D+NhmGvHRh1tdfrMx8f0PyA/Xu6zywo8beKR
 0qoPdx6oWQ2RX0xSDO1A12UMy2q8LG6AiYmHQfoB1Nkb
X-Google-Smtp-Source: ADFU+vvAtG/0+8x8AmEHxrxjbxcZLVQHDYxf9pJkdaZ+Z+3HsoI9Y+O5yxTO6qkQhw/FnI9+6/h/2BoAdioWmzvHUIQ=
X-Received: by 2002:ab0:2881:: with SMTP id s1mr6934174uap.8.1584138427814;
 Fri, 13 Mar 2020 15:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <c827880a47774cd3a6bcd59b79657f380da11d5d.1583284602.git.alistair.francis@wdc.com>
 <e8498727-03f8-7e04-efd3-c04763dcbfac@linaro.org>
 <CAKmqyKOnb+CpnugoUkeL_kabyiCfZCmWyNF9uV5GUBT_pek=0g@mail.gmail.com>
 <47b0bc38-6384-9ab4-7c3e-d5ed405ea90d@linaro.org>
In-Reply-To: <47b0bc38-6384-9ab4-7c3e-d5ed405ea90d@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 13 Mar 2020 15:26:41 -0700
Message-ID: <CAKmqyKO5hztm3icsGpDGL5D9Uo6sHV2dSMizTtgAzsY06S59wg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] target/riscv: Don't set write permissions on dirty
 PTEs
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::943
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
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 10:26 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 3/12/20 3:10 PM, Alistair Francis wrote:
> >> I still think this must be a guest (or nested guest) bug related to clearing
> >> PTE bits and failing to flush the TLB properly.
> >
> > It think so as well now. I have changed the Linux guest and Hypervisor
> > to be very aggressive with flushing but still can't get guest user
> > space working. I'll keep digging and see if I can figure out what's
> > going on.
> >
> >>
> >> I don't see how it could be a qemu tlb flushing bug.  The only primitive,
> >> sfence.vma, is quite heavy-handed and explicitly local to the thread.
> >
> > Yes, both sfence and hfence flush all TLBs, so that doesn't seem to be
> > the problem.
>
> Here's an idea: change the tlb_flush() calls to tlb_flush_all_cpus_synced().
>
> If that works, it suggests a guest interprocessor interrupt bug in the tlb
> shoot-down.

No change. I'll keep looking.

Alistair

>
>
> r~

