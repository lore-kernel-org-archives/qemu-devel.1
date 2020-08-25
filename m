Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A488C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF29206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kc9G8Ouk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF29206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgef-0005am-FX
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAgYI-0002rX-U3
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:32:22 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:44241)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAgYG-0005cT-WF
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:32:22 -0400
Received: by mail-il1-x143.google.com with SMTP id j9so11328ilc.11
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yQPkC1ZKIRjNb+zN90dXj/UbX0XRcMf7WmndBhDbVxI=;
 b=kc9G8OukMAhjpQ5J2KxcCuaclK3lvWbHapwaOpw0lPbD/No//7DQJHJrwwBmkpfW5q
 4Y5kONanrTAeVQMQNP4EKZnLxMaEgE3OOCt/ruKs3274gVdaZp8Z3d6UEY/XI/88ENii
 c4te5C4ZYmhNx051UBJS/4wjZCJHKutVVMap8rMQJTP4mIrIbkixy0n0upoRT0XLklny
 wSSQqyeoyPK66nmZXO2VT0oYkH0pFvWSU2v0SkAm7kW3jPMYi9ybKf8h9tqIhJd4oNtb
 Z99wHuG7vc4y84roYumSI6klfDZmUszXAgmKllJBxy+O5JsL6d8Mj3hOTCBROqtPolMy
 SVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yQPkC1ZKIRjNb+zN90dXj/UbX0XRcMf7WmndBhDbVxI=;
 b=kT89wMLbTC6FaWe1t3JCs4UjxiF/q988SOCyBteZsg5Ol4D4/cntbQd4vpURZwXNsV
 ltx5d2BMn0H3ZFCUmE7WdF498Ez9mI7bJCCZPTiXNTSQsgO6iUAyRSX3d/8541DMO9Tt
 PQ3aFFGoCQnFAg69jtD+/bflo3x0nZPh3WE08ycW/34MYAT4FLxuQPetAnipPFqJWgLk
 WGRdQW28curXmN417m9jCAp10fqThaFn6xd+eaDW/h3OOogA6lAMDIORy8RCkIYIJ7Vl
 9FMcYhr7OS18hB06xBYC6+Cj1rPZog5qVmjro2+racdUTGEaWbHGZbclhER/3cEs/wIu
 4TwQ==
X-Gm-Message-State: AOAM533G8VTejOy1bfvQI1j4mVlIor6TGvtBTLYnfLDEJcEDqbixUwti
 3wyPHk/IwNrhlkOXRHirCC6c0Cbplrep/vDA2Z4=
X-Google-Smtp-Source: ABdhPJx5IfRgw/WG4P4YAo0ND4ok8Bte84pMt0tEvKA4S29YT0w1obx8MrwVAKRCh0hnsINJHmHIqru68YdtK8vWYt4=
X-Received: by 2002:a05:6e02:ed4:: with SMTP id
 i20mr11014371ilk.267.1598391137048; 
 Tue, 25 Aug 2020 14:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200825184836.1282371-1-alistair.francis@wdc.com>
 <CAFEAcA8=Mf=EPh__tNhJyGv8+ouD-HH+MuMb+HhtTFes+XqUSQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8=Mf=EPh__tNhJyGv8+ouD-HH+MuMb+HhtTFes+XqUSQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 25 Aug 2020 14:21:34 -0700
Message-ID: <CAKmqyKNxURXyNSEePPU1jY7FzcZjRThr2qAvwR393+nqUXBxJQ@mail.gmail.com>
Subject: Re: [PULL 00/18] riscv-to-apply queue
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 2:24 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 25 Aug 2020 at 20:01, Alistair Francis <alistair.francis@wdc.com> wrote:
> >
> > The following changes since commit 7774e403f2ac58b3e87bfe8d2f77676501ba893e:
> >
> >   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20200825-pull-request' into staging (2020-08-25 10:54:51 +0100)
> >
> > are available in the Git repository at:
> >
> >   git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200825
> >
> > for you to fetch changes up to e39a8320b088dd5efc9ebaafe387e52b3d962665:
> >
> >   target/riscv: Support the Virtual Instruction fault (2020-08-25 09:11:36 -0700)
> >
> > ----------------------------------------------------------------
> > This pull request first adds support for multi-socket NUMA RISC-V
> > machines. The Spike and Virt machines both support NUMA sockets.
> >
> > This PR also updates the current experimental Hypervisor support to the
> > v0.6.1 spec.
> >
> > ----------------------------------------------------------------
>
> The hypervisor related patches don't seem to have any
> reviewed-by tags, which seems a shame for a fairly significant
> chunk of work. Is there really nobody who can review them
> for you ?

Unfortunately not. They have been on the list since April and haven't
received any feedback.

There isn't a lot of people reviewing the RISC-V patches unfortunately.

Alistair

>
> thanks
> -- PMM

