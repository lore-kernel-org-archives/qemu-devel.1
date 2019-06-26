Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0157DC4646B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 07:00:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 851CC2086D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 07:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dErTe2Jg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851CC2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg1us-0005IC-Rd
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 03:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53182)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hg1tH-0004lZ-MG
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 02:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hg1tG-00056J-Az
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 02:58:47 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:37285)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hg1tG-00055P-4V; Wed, 26 Jun 2019 02:58:46 -0400
Received: by mail-ed1-x542.google.com with SMTP id w13so1710501eds.4;
 Tue, 25 Jun 2019 23:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Vrr7b/zXwP4IqY1cQUW2IQ5IAQcDF1OFR1nWAzAybNE=;
 b=dErTe2JgbEKiwNsIVauDAHm5Ts+bY9kEocjQ7JrA1EjIMOD+O3S6bqT+kmGmUEKKSW
 ikQ+vddde6yEpiQAqr0kVKck5JTAAKZQSA9AV4jkf1QAaoAk8fiVZWoBdXQl59tI6xhB
 REcSX/UtzOtTKekn1iLzxulpWXIn5DxJVkPxDrSMFMzwqg5r2CkNeXztKY5QCk/reSPr
 dFc6Cc80vj8MKasSxAd5OLOpuhgU8tO7tzxw2qjPxecKoffDtJEkR2UMM2gkezY6yro3
 JOczvUIBMkM6IPessaIimJwxjBMNILxgWq835D6Q/g3sRyVEIKsPyhQZekV9aW/xGuO/
 6jjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Vrr7b/zXwP4IqY1cQUW2IQ5IAQcDF1OFR1nWAzAybNE=;
 b=FiaZAn3qINgcLVWKoQMvJ963t/cHxOPCqjVKmvXVHrdLG6dQSQ8cEjAtFoOhY0XFW4
 yOrQCU3OgVtpHXNKIfToHz78hBBbz6lDOp8yeyOsRMHlGEsxxEC1iBNE+djCa6p925hW
 c0Jy5wx5q6Or/4+BJJVOIvTq+Ajz67XnMIEljTrj+zqoq4ZD5qI6TPdOupFCn/SwVbYB
 x+67B3yCMf+75Vg4WlII8ZYOi58E38zpsw/t3in5EEBEOhwckfqwDgDEmF1Z+5AWogDl
 eDNd9/+cG3QvzztLzT35aPaLhharjGnCkLpsRFUyUqihBQ7DNfiwKSazNjpkQjMbMdkt
 4AxQ==
X-Gm-Message-State: APjAAAWhY/5CfhuzMzJj4kFUvzxQLpLKw+ZVoOk0MDinuNK9LY01bBl5
 CcT8gmafBuCUr/GpHbTRIO2pS4I/+16wP74Xmcs=
X-Google-Smtp-Source: APXvYqy1s9iIZnuTThkarGGqyXW6NXLF2Ss/o4beAUKX+a8IAHuLN1J5s7WUiJPiVieYr1/efi6owkO0Y/J/k7scuos=
X-Received: by 2002:a50:c28a:: with SMTP id o10mr3168671edf.182.1561532325055; 
 Tue, 25 Jun 2019 23:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <CANnJOVF7DUabc6ut92dQQUjxWud7zfdgBEkj=GPn1P+2tKw-ag@mail.gmail.com>
 <mhng-94c196fb-ebb6-4075-afa9-96989bbc037c@palmer-si-x1e>
 <CANnJOVE3m9nxkbLW95nY2rCViBj1HG5HxVTKAWU+NS5ETsgsuQ@mail.gmail.com>
In-Reply-To: <CANnJOVE3m9nxkbLW95nY2rCViBj1HG5HxVTKAWU+NS5ETsgsuQ@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 26 Jun 2019 14:58:34 +0800
Message-ID: <CAEUhbmVZm-dhvT40Ck4d159SHin_D-U47+CHShjajzM1f-P9Gw@mail.gmail.com>
To: Jonathan Behrens <fintelia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [PATCH for 4.1 v3] target/riscv: Expose time CSRs
 when allowed by [m|s]counteren
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 26, 2019 at 4:23 AM Jonathan Behrens <fintelia@gmail.com> wrote:
>
> I just did some testing on a HiFive Unleashed board and can confirm what
> you are saying. The low 5 bits of both mcounteren and scounteren are
> writable (if you try to write 0xFFFFFFFF to them, they'll take on the value
> 0x1F) but even with the TM bit set in both mcounteren and scounteren the
> rdtime instruction always generates an illegal instruction exception.
>

Then I would think the FU540 is not spec complaint :)

> Reading through the relevant chapter of the spec, I still think that having
> mcounteren.TM be writable but making rdtime unconditionally trap is
> non-conformant. If other people feel strongly that rdtime should always

Agree. To test hardware (FU540) compatibility in QEMU, maybe we can
add a cpu property to allow hard-wiring mcounteren.TM to zero?

> require trapping into firmware then the natural change would be to simply
> hardwire mcounteren.TM to zero (the value in scounteren wouldn't matter in
> that case so it could be left writable). My own (biased) personal feeling
> is that this full implementation makes sense at least for the `virt`
> machine type because it represents a clear case where deviating from
> current hardware enables a performance boost, and would not break
> compatibility with any current software: both OpenSBI and BBL try to enable
> hardware handling of rdtime when the platform claims to support it.
>

Regards,
Bin

