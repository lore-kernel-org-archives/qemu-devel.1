Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC8BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 10:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27F2920767
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 10:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTj9Ie77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F2920767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtqQx-0008Hy-DC
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 06:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jtqPt-0007iO-6Z
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:38:05 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jtqPr-0004qE-It
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:38:04 -0400
Received: by mail-oi1-x241.google.com with SMTP id j11so4383183oiw.12
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jA7kcmdz/StLRdLNk02A347atjQiR3nH3pe9TdcT+HU=;
 b=pTj9Ie77qFm4md4gcZi1EmofpHyO7jFZ5noEtotjghck45ObL/V2gFpS9Mz8dozbC0
 gb9FE8DDmWpS1B9caaKPR1Vc4y/AzShrXi2AAzPfVQ0bxWUfuoIEqBLWkYqoi/igYP+e
 rsFTbcx4ULKZbqqmOwNNGZeG4osyV33CD+BdR1NUf4EZwc416q4G5Df/66Su6tD6g+Sm
 2QHwZshBdlWfkQrLP/3EQ9oVZs76wdRyj2LblDcDfXhiVFDj5bLuAxBWfIgpn0og/Hl3
 NWX9yUkVxxc8LRbrobJ9oKVN5qz5/oG16ZVEYNQxA3wJORSVoUP39k1Wg/0AV8R3kRMP
 X/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jA7kcmdz/StLRdLNk02A347atjQiR3nH3pe9TdcT+HU=;
 b=dFbEdUJkYPiD+j123yKEf4ff9CHKarrH2IHiCof4NEiP6xB5UQDvMC7SKE+fMAyIP9
 NjgJFxDg4XxK1l0WBxQfWTpSdMKIWdIcixYOWOo+R9rGMjZAhH0RglU2hZW66fdlhVMo
 GCqlFNadWR8GyOboBfaHpHPvMnBBE5Z0mnA5Z/kJwK5YWeNngSKaKTZNli9vwBAMV10U
 hjf5NJ8FxZ4qnwecyo6RYWv+cricL+0VyY4WwX2rwOAjkmP0I9Oemjmrg6ScXwSOZjbD
 K5eFV8qtz7BKzlCgptEUWLbLJgvO5jLO5CUjYZPGEMvw/6tZQut3hLfmiqbIwXYQseBp
 J2Ig==
X-Gm-Message-State: AOAM5332U5hwRMeSiOVfD6x65ejoqm9fYijT2YshGe4o5kkBIgnWH4bj
 Xsn2clXvqRaMdwy6R5bW8hYBk2H52dZr4xEkDqI=
X-Google-Smtp-Source: ABdhPJwFtriuirmsxD7uv5EBUtw3gK4PbxwU8IHKX3R1nBvSRE42SnI1qXGTZUE7okdnpihl09catYYzq26a7niuBr0=
X-Received: by 2002:aca:494d:: with SMTP id w74mr3721256oia.97.1594377482417; 
 Fri, 10 Jul 2020 03:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <159400349818.1851.7243060688419202620.malonedeb@wampee.canonical.com>
 <CAKXe6S+J3nARveToQjECbwV224gs66WkqGHybUhfw35t1+V8og@mail.gmail.com>
 <2cbdf822-c74c-1af9-e5e6-7dd71412201e@redhat.com>
In-Reply-To: <2cbdf822-c74c-1af9-e5e6-7dd71412201e@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 10 Jul 2020 18:37:26 +0800
Message-ID: <CAKXe6S+ct7D+ibGmrAMJnqKBBKyUpwVnCem8=d=jB-0tUT-N2Q@mail.gmail.com>
Subject: Re: [Bug 1886362] [NEW] Heap use-after-free in lduw_he_p through
 e1000e_write_to_rx_buffers
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x241.google.com
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
Cc: Bug 1886362 <1886362@bugs.launchpad.net>, Jason Wang <jasowang@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8810=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:36=E5=86=99=E9=81=93=EF=BC=9A
>
> On 09/07/20 17:51, Li Qiang wrote:
> > Maybe we should check whether the address is a RAM address in 'dma_memo=
ry_rw'?
> > But it is a hot path. I'm not sure it is right. Hope more discussion.
>
> Half of the purpose of dma-helpers.c (as opposed to address_space_*
> functions in exec.c) is exactly to support writes to MMIO.  This is

Hi Paolo,

Could you please explain more about this(to support writes to MMIO).
I can just see the dma helpers with sg DMA, not related with MMIO.


> especially true of dma_blk_io, which takes care of doing the DMA via a
> bounce buffer, possibly in multiple steps and even blocking due to
> cpu_register_map_client.
>
> For dma_memory_rw this is not needed, so it only needs to handle
> QEMUSGList, but I think the design should be the same.
>
> However, this is indeed a nightmare for re-entrancy.  The easiest
> solution is to delay processing of descriptors to a bottom half whenever
> MMIO is doing something complicated.  This is also better for latency
> because it will free the vCPU thread more quickly and leave the work to
> the I/O thread.

Do you mean we define a per-e1000e bottom half. And in the MMIO write
or packet send
trigger this bh? So even if we again trigger the MMIO write, then
second bh will not be executed?


Thanks,
Li Qiang

>
> Paolo
>

