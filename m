Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0ABC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 14:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A8920720
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 14:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVavvIzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A8920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw5EA-0004KS-8Q
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 09:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ianjiang.ict@gmail.com>) id 1iw5D1-0003sO-RT
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:17:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ianjiang.ict@gmail.com>) id 1iw5D0-0005gv-Us
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:17:47 -0500
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:44344)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ianjiang.ict@gmail.com>)
 id 1iw5D0-0005gZ-QU
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:17:46 -0500
Received: by mail-il1-x143.google.com with SMTP id f16so7543257ilk.11
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 06:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ApLsVbLBfCJOddy90ZYc387E28RoImjgrhmzGj7FuzQ=;
 b=UVavvIzSDd89zdAqsOe/UokdrpyVMCgJVCGNUVdU1LC+qKGE702mSSWjoxfBzLIjo7
 JeboTc6QU+go9e/VWYW4w3+iKbKjcnsjleccLyq553/WB1XELBJbVxdf3P1tnAXyYvit
 kPRvII6CSxdfu3UPoSc+gfBRaDcJDFN1f0LQSHgGrVPKOw1qC+9LXOrQrmQXOaKKALM2
 79Ts0rLdHqRY+Pp83Je/DvlOv/BgCsIs+G4uEXlV2T0Ve5d/9+JDHgCkGNNkMRlS8UEq
 6lfN7Lm7QBGFdcil5CI6ekE72QaTUk0WRvpe34O9nJ5bCoUvf+9R+nSirxtAQT7CWAPQ
 cWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ApLsVbLBfCJOddy90ZYc387E28RoImjgrhmzGj7FuzQ=;
 b=ivCmTxdvjUbxHuUaMqLzBEETPPd1m5Uri3BVTbWZIeUswXjMM55WcqvUSZChkOwBmq
 QgJkYPqCtf09XuTWF7WkWfOlEd7sVXzyONDRvTyxRxl+2edqlxfxKvqFxJGeZCna5HEG
 0iBkiuvGUZIJ7qrEIqXmN7pPqqB8f0QBjQZ/rjmE2JvpErjlXe8S/3WFbNH+g6Isb2NE
 KUMq4jeh5nh1ymks5o98FixWjuKXrwsEmNEO/B2/ixpuCRFR7HpubreZjbPi38q4VoKq
 RisjcvaiDWDf4H8uMS++fMkVdohlSkzJ7MkzAtd9t4Hi6Do8I6UXhwMydR0XItuZ81+J
 dNUA==
X-Gm-Message-State: APjAAAUC8+OogVUi3lrZFiu1LKkoImbka0qdAqzB9ZshR76X10tnbxtt
 qN2aSMxorSqCYBIWQnBzeYy2VExE4BIZPcroyyE=
X-Google-Smtp-Source: APXvYqxDRTbG/xjzCTC3DEda2BqHpsf1avPOHEuwrt8Px6IDGf+B+jjuey6OBhc477MOp/WYcxs5yMHc/6fbpAL2gp8=
X-Received: by 2002:a92:af4b:: with SMTP id n72mr15398880ili.288.1580134666147; 
 Mon, 27 Jan 2020 06:17:46 -0800 (PST)
MIME-Version: 1.0
References: <20200122072448.18510-1-ianjiang.ict@gmail.com>
 <b9084f13-0836-7f74-a870-608bf3f8f6a9@linaro.org>
 <CAMAD20=RS=tt04db3NfiPfXJo2Cr5PfCF-39E8qeuehnVGMdKg@mail.gmail.com>
 <25fb635f-6d92-70d0-9bcd-7f5a5de1a97b@linaro.org>
 <CAMAD20mgs=wBbsXAa6KsPP7SjNu1xfcM3wnqsAVExps3oufrtw@mail.gmail.com>
 <a7b4ec6a-1f41-45c3-d7a6-0b69fef1f379@linaro.org>
 <CAMAD20nWyApK7-uFNvMpXmzfiTohLOhPgD+TTNr+ZWVn+QA7Tg@mail.gmail.com>
 <ddd76565-4139-35e6-a23d-9e2c13fc613c@linaro.org>
In-Reply-To: <ddd76565-4139-35e6-a23d-9e2c13fc613c@linaro.org>
From: Ian Jiang <ianjiang.ict@gmail.com>
Date: Mon, 27 Jan 2020 22:17:35 +0800
Message-ID: <CAMAD20k20TaR+SQrj4X_m7qW=aiwrjy_aiWwsXuKBoQ54a58hg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Format Rd of FMV.W.X with NoN-boxing
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::143
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Got it.
As the first step, I just summit a new patch:
[PATCH] riscv: Add helper to make NaN-boxing for FP register
I'd like to carry out other fixes after this patch is reviewed.

Richard Henderson <richard.henderson@linaro.org> =E4=BA=8E2020=E5=B9=B41=E6=
=9C=8824=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=882:53=E5=86=99=E9=81=
=93=EF=BC=9A
>
> On 1/22/20 6:05 PM, Ian Jiang wrote:
> > But I am not clear where to call this new helper gen_nanbox_fpr(). Is
> > there a position that could affect all floating-point instructions? So
> > that we don't have to modify so many translating functions. Please
> > give more details.
>
> No, this will have to be called for each instruction individually.
>
> That said, all of the insns that use helper functions, such as fsqrt_s, s=
hould
> be doing the nan-boxing within the helper function.  Thus you'll want a
> different helper function for use within fpu_helper.c.
>
>
> r~

