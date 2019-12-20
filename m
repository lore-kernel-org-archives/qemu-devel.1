Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5054C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 11:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06552467F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 11:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uL6ObYks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06552467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiGd3-0004Ph-Pa
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 06:39:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iiGbx-0002w2-M4
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:38:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iiGbw-0007fW-8H
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:38:25 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35556)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iiGbv-0007bJ-Vo; Fri, 20 Dec 2019 06:38:24 -0500
Received: by mail-ot1-x341.google.com with SMTP id k16so6970695otb.2;
 Fri, 20 Dec 2019 03:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+BqcUaQqByIjX8vlK2hMlcn+ZhONZRx6S3BzSHAZJNU=;
 b=uL6ObYksZEqeAdnwdogRkDupusDqg5aiz7Fj3rhvllJeaV5OogpEBAtz3ZdKQo/c6K
 sEDGLNMY7fN8mHlKL9sZ2Lm3sTdefxKjXiJkru6+fgiDXN97lB0MWRCyx4oE5LnTvhXL
 Vu9GNxY1Ji0ichFY75FKo1FFkDpFfJh0Ko0oYpcT7pbU1pnQdUC+L3Tp86CTM/pA1u79
 8SjVxqxQiwFao7t8mWPMbDGuJOtMGqH61hmistXHMn8p0d5SD7MMmq0SLxAMj10ckDt8
 2VSsPGvMxBwVva/fRtkL9NmvsLWtcMVtx9dHbuTR0ECzsvJydiabyabYcLUbxdg4pOrT
 k3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+BqcUaQqByIjX8vlK2hMlcn+ZhONZRx6S3BzSHAZJNU=;
 b=JirarZMCwbr60/Fht8R1JxfwmS0+j0pEPEeaPbD6qnmWH9/gaioAm16wf8/WjANb9Y
 5EJhOntpdJZ1TVKKuHTEaFNhBL20Sf8DBuYrXeTRrVZYi9t8SkfvxtcHoK6vAPKdntUS
 dlu8XoZZLEc1KDcbCaiTUZzewlP/8cNpdmimaSj67sfYKTCaNMDwewyow79quPsucfTe
 /jVOMamiDmancJxet4i7eJLsGkl4bM5fjX3H2vwH52CCzgTPRF0mFmc4Xme5OfWzFa+h
 g8L8BD48CgEIpPSM4zZQCWH+86AkYaEbSQ76Jc/p4J+KglbLrZ6+UK1PN2vAXNr6bted
 SpFw==
X-Gm-Message-State: APjAAAUca/151MMj4OqtV0UGH/XysjnH+kwabEzWD3EtAxuBOMh1qxRP
 n/jYQHlQnhapcvYVQnqtYGxMPV1Qdrw6bsGnAnI=
X-Google-Smtp-Source: APXvYqzKhd1E1XZlkuQ+EMFVaZRu3uf3rSugwtSsIA3+1LHcBWpYZpZ8r95aFuZKszR2lFbFhlof0BOJWGoDp/qJA6k=
X-Received: by 2002:a05:6830:3054:: with SMTP id
 p20mr14174952otr.121.1576841902863; 
 Fri, 20 Dec 2019 03:38:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576286757.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1576286757.git.fthain@telegraphics.com.au>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 20 Dec 2019 12:38:12 +0100
Message-ID: <CAL1e-=jN-8zEnCvxq4actoBcrjBviqfxBjGCTT7mBxmSPhiF3w@mail.gmail.com>
Subject: Re: [PATCH 00/10] Fixes for DP8393X SONIC device emulation
To: Finn Thain <fthain@telegraphics.com.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-stable@nongnu.org, Herve Poussineau <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Dec 14, 2019 at 2:29 AM Finn Thain <fthain@telegraphics.com.au> wrote:
>
> Hi All,
>
> There is a bug in the DP8393X emulation that can stop packet reception.
>
> Whilst debugging that issue I found that the receiver algorithm differs
> from the one described in the National Semiconductor datasheet.
>

Finn, could you please provide the link to the exact datasheet that
you used for reference, so that we are on the same page while looking
at your code?

Best regards,
Aleksandar

> These issues and others are addressed by this patch series.
>
> This series has only been tested with Linux/m68k guests. It needs further
> testing with MIPS Jazz guests such as NetBSD or Windows NT.
>
> Thanks.
>
>
> Finn Thain (10):
>   dp8393x: Mask EOL bit from descriptor addresses
>   dp8393x: Clean up endianness hacks
>   dp8393x: Have dp8393x_receive() return the packet size
>   dp8393x: Don't advance RX descriptor twice
>   dp8393x: Update LLFA register
>   dp8393x: Clear RRRA command register bit only when appropriate
>   dp8393x: Implement TBWC0 and TBWC1 registers to restore buffer state
>   dp8393x: Implement packet size limit and RBAE interrupt
>   dp8393x: Don't stop reception upon RBE interrupt assertion
>   dp8393x: Don't clobber packet checksum
>
>  hw/net/dp8393x.c | 80 +++++++++++++++++++++++++++++++-----------------
>  1 file changed, 52 insertions(+), 28 deletions(-)
>
> --
> 2.23.0
>
>

