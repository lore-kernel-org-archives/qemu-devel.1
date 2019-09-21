Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDA9C49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 12:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC962086A
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 12:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvyaLbCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC962086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBedW-0008SH-2m
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 08:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iBecZ-00081Y-IP
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 08:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iBecY-0002tH-Lj
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 08:36:15 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:44300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iBecY-0002qn-HJ; Sat, 21 Sep 2019 08:36:14 -0400
Received: by mail-yb1-xb44.google.com with SMTP id f1so3461596ybq.11;
 Sat, 21 Sep 2019 05:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TXBd93KAs24bxiz8SZaxncJGIf8FJxZkPGIs9goyUM0=;
 b=FvyaLbCGsk2cdlzKcuzGwyVayU9i1cMKhE4X0D1Ts63aVUKEFOZY2Ex9UcskOc0BnP
 S60pTmpagzwwOEW1uCFm2vT2BC4f9EbGg5Qy90eCmVRe+vqGzh9A5lg5alhIXSCiEq4O
 o/g1cTE37mQWYp4fKfdE46dB5i4bd1z3tIiBMJVRNClWTn/5TqexgV2J6UNCF9yobVkL
 itzZblmczFelPW53d5xxy82fQXYk1GjtAZchgRQzwEvk6KfWeb+3sbMUTYNMTDgSPyxV
 divveAsjfoIWGOdAulm0FXmuShhdKjH+IJUE7dVTQURl/PGXpi47I9y7oMrfcVi3CE7l
 D1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TXBd93KAs24bxiz8SZaxncJGIf8FJxZkPGIs9goyUM0=;
 b=PXyE5vqDrRUAAKYLNnyFpPtER9l/jvM2+uH8iCewvtOBXbIv+Hs3v51/TRbDsgb9e9
 3M0J29yXnzu+XKCeE5G2iTtb5pGpzya3N6aDCvjSYk0lNUZjrFQjXtRyviwlOuJZFhvd
 RU2T/1kjvvlwSPPb7oozLMWxcfwJykz0PPnCFziQhd+/dwEnw4Yj6fNyBbc8Hxmyq0Mz
 8TNTIyNJtCnLdwTz75AiU2hD+U29dmaPA1TpA6nLecAE5bz+nv5YQpHC7kcWOiIVQGEC
 UGiVvIQKxl/J4CGeOmqiQsg5eNyP+iZ+hNFiEC7wamdv1g3X9RFTv3jsB2oitkm5KCvB
 K36A==
X-Gm-Message-State: APjAAAXmBe6jArlwBVbSaOzaQQ/1L42vzRCgNnn5+cRae/gq0xUtkb7V
 oohnbCQe+aqNYBW9Irfqr5rj+nPThp6jcAFcZ2k=
X-Google-Smtp-Source: APXvYqz9ruEaYB36JVR54q90qPbLz3ghXTUNbvM1YCdWXIPaR9bN7q1vhJY/5z3Mz6DU6PkQjFwmJaTth0nugUp5e8A=
X-Received: by 2002:a25:ae09:: with SMTP id a9mr14874688ybj.11.1569069372483; 
 Sat, 21 Sep 2019 05:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <1569044491-7875-1-git-send-email-bmeng.cn@gmail.com>
 <fad9668d-14e8-40c1-2c02-9a6197e88397@redhat.com>
In-Reply-To: <fad9668d-14e8-40c1-2c02-9a6197e88397@redhat.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 21 Sep 2019 20:36:01 +0800
Message-ID: <CAEUhbmUM8jPc=qkHkm2yJU2YVsv7ppRdrn+ZODtfSKpHO=nC7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] riscv: hw: Drop "clock-frequency" property of cpu
 nodes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
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
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Sat, Sep 21, 2019 at 4:51 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi Bin,
>
> On 9/21/19 7:41 AM, Bin Meng wrote:
> > The "clock-frequency" property of cpu nodes isn't required. Drop it.
> >
> > This is to keep in sync with Linux kernel commit below:
> > https://patchwork.kernel.org/patch/11133031/
>
> What happens if you run a older kernel that doesn't contain the
> referenced patch?
>

This property has never been required by the kernel since the beginning.

Regards,
Bin

