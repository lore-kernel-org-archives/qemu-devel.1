Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09A6C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:42:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F6D218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAJrkUxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F6D218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPEj-00038h-GJ
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kXP3v-0005kh-Rn
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:30:55 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:37053)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kXP3s-0008Rk-Ex
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:30:55 -0400
Received: by mail-lf1-x141.google.com with SMTP id j30so2345098lfp.4
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PYqRpy3+23XxNj36s2ZNs+yQYIS+87qHEdvuW6ev+Lw=;
 b=AAJrkUxov81rogrCte0ZEjuGtf9F9jXEWsSMPxsGThCSDcLRO3sEWDa8boRArUE2+i
 oAU0y6UbeFyoOPw0Lcw87QJWUKOMCMDINd5Nb+lrGhmrLrQGDOn/hCesfCmYoMwGAfT1
 DmNqypfmRhdL1CV7C1nx57MOhqmOePTbeuL1JTEAvto8Td/yjS/0G/7y0qxNtmrepJXn
 yJVEufeO648m+wSsouHyifvgFhyHoZ8g4fLDry1JPyKN04nLIb9copiFFteFSSaPPqAc
 u7+b/8SXu/FGvfDteZBLl2gKuZ3LIkbEWT2M8kuyIBBQJkBPXYj+Wk7F5TY/y/7ZZi3M
 fYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PYqRpy3+23XxNj36s2ZNs+yQYIS+87qHEdvuW6ev+Lw=;
 b=LKD+A2fC8ZPXeFP/S7+VtPE778zI2y+EyVkRyD2hNQkai20LewufXeCYUAhBzySBKv
 xLZY6qQhCyQT7f4nPQnmTijX0oBRQKrzLCCm2IXsL+CG3pF3YEow2LMmHSiiyFyoFWu5
 tbJiRvVIQvS9/CAXJVIfFc7IWbfgHN44M/8z9JSyDt9/HhZkoJyOGGtLNOYT6YRGKrqw
 wszaFBG35kGWguR6gfFQm6u0iZRJ384nMRrdSCTTRLp+A2W6XZi5x21rq2v9t7EbJ66N
 kCZJSHnh35Hkc7FjM6nEYGYVW335mgb60UFSN97hlz4cy9iHqsg5JXMDDYL0FMdDJ2s4
 VmLw==
X-Gm-Message-State: AOAM530QmNczLN2kFgbQAR5JZgs3q8PrbVZNqUljVf1+FJPz7ATjsmRj
 p24KGSX0ja9Q1FiI90JK4V6hr6H3CTDCSnTFsrA=
X-Google-Smtp-Source: ABdhPJzfzEyVnOY4d98ajUsb3HjPt3FUABmbAANKPMpj8hRCgwPMjfOD6Qw8viCh/8JkriD5TuOwxEZPG+v9pwDfC1o=
X-Received: by 2002:a19:8b8b:: with SMTP id n133mr909957lfd.202.1603805447914; 
 Tue, 27 Oct 2020 06:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
 <20201026083401.13231-9-mark.cave-ayland@ilande.co.uk>
 <20201026095450.ko6snc4dusk3pvnw@function>
 <547c0ea5-dad4-d246-1de8-844a2e9a9507@ilande.co.uk>
 <20201026111406.jvpexlkh53g4fxff@function>
 <CAKf6xpvcnmEs+v3+Tm1srQfo=m37EAGRPynJDJy4HkMuCmD6NQ@mail.gmail.com>
 <38110b4a-34b1-3e97-5a7f-4fad1bfff080@ilande.co.uk>
 <20201026150432.yqkyceke5uppqom5@function>
 <a141714c-158f-0099-34ab-92fc27be6975@ilande.co.uk>
In-Reply-To: <a141714c-158f-0099-34ab-92fc27be6975@ilande.co.uk>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Tue, 27 Oct 2020 09:30:36 -0400
Message-ID: <CAKf6xptUpBmKMQ1HeNkRKqv8YipbeAGsjZViZ_2pLOZGF=G_rg@mail.gmail.com>
Subject: Re: [PATCH 8/9] dev-serial: fix FTDI_GET_MDM_ST response
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=jandryuk@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@gnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 27, 2020 at 9:18 AM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> I spent a bit of time this morning doing some further tests on Linux using 2 machines
> and a test program to check CTS and usbmon:
>
> usbmon when adapter unplugged:
> ffff95a4bf2dd300 2366831506 S Ci:4:004:0 s c0 05 0000 0000 0002 2 <
> ffff95a4bf2dd300 2366831607 C Ci:4:004:0 0 2 = 0160
>
> usbmon when adapter plugged in and remote connected to minicom:
> ffff95a4452a79c0 2457273895 S Ci:4:004:0 s c0 05 0000 0000 0002 2 <
> ffff95a4452a79c0 2457274057 C Ci:4:004:0 0 2 = 3160
>
> It seems I made a mistake here since the response is interpreted as 2 bytes rather
> than a single little-endian word: with CTS asserted on the remote the first byte is
> 0x31 == FTDI_CTS | FTDI_DSR | 1, whilst the 2nd byte is 0x60 == FTDI_THRE | FTDI_TEMT
> which matches the existing QEMU code rather than the comments in ftdi_sio.h.
>
> So sorry for the noise: I'll drop this patch from the series and post a v2 shortly.

No worries.  Thanks for investigating.

(I had the thought that maybe reserve bit 0 differentiates one and two
byte responses? Bit 0 clear indicates a 1-byte response and set
indicates a 2 bit response.  But I'm just guessing.)

Regards,
Jason

