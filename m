Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC363C5517A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A99722273
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ttdfs8FK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A99722273
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW7EY-0001HP-Ks
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 20:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW7DD-0008Eh-Ep
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 20:15:11 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:39757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW7DB-0007cX-OY
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 20:15:11 -0400
Received: by mail-il1-x143.google.com with SMTP id q1so3056796ilt.6
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 17:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1hR0jtMiVqyiqcatMA5nKnLgP+1fQyAcDDOeu9vbn7Y=;
 b=ttdfs8FKscIgC66xsh4xr+ncXj8t0/3kSIHO68H4klRKzjvVCgTB2qPfnLX/vxvqbj
 dr399l+x3xYqrol8T0RRlNDtJ779g+dt+ASBITO518Tr/Ab71rb8HZ3K2GGwjEPhxgod
 rHTZEg0VqU3u6M2xdzN+Zpd0VkfVX2Rt+DsBcBqtBrUc0J2QUhkfdU6E61pdxkhey6m1
 dhoVF5S2AJ9s21F9lG7T/9mnwYnV7MCFiSShy4LbWJqpXD3Ws8rJiMnq1kudNI41Ofn2
 xSIYc7RH1N7IKgi5XDduOkjtWtoGazfGVCNxlHFaqnJEicXaKp7Nmml+VQEPiRl3jEpC
 DLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1hR0jtMiVqyiqcatMA5nKnLgP+1fQyAcDDOeu9vbn7Y=;
 b=tg571FwoUqpjif799jg+zmmJmwf1NUK7pAoC0oLiqeARl3Yq0Wp41KSOPaP7wB+PZY
 YSE1u7UN6YTZxAIWLJcw5qKWzk+CJ1/YrvuUMK9L+ITE0Dq7MIllbdKuYrjUdoQgP06A
 2SNiryA7B7N6ds2xtaoENM3nde2ByPEpZe8teC7iQc33QFLQLlwpWXo/bG2BvDZe0Nmo
 G+QHzfTfIdYpMYJuIC0FQ4sieC7vJzuRtixyAYfGWnzz/gB3SJc1xVtGRhQzi/j8a9y7
 elnMqjCP8wfRPFgUEmczXRIsbZWTKLo3cEU5k3I56tgsox1eI8Ib5lpYTkSoZgmMljpT
 c6Kg==
X-Gm-Message-State: AOAM532n9I856RtP8oNW56WVWMT8TM49+zYULaNuNedSgzy2KW9/uErG
 +s+u6y4gGqO2vu5JPBWORERxT11+vFAGb3hiuM0=
X-Google-Smtp-Source: ABdhPJxnGEuGbUgSZuc1M9sOV2uiGkmqwYNpSChSu1i5070OguO422x6PIKPnUm+SaeWLCDWYk+x2/vK7ZgmNAiDds8=
X-Received: by 2002:a92:5eda:: with SMTP id f87mr3914341ilg.131.1603498508594; 
 Fri, 23 Oct 2020 17:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201023214506.917601-1-keithp@keithp.com>
 <20201023214506.917601-2-keithp@keithp.com>
 <CAKmqyKN20Fg_cKXmh2-vUaY4gPkE=PtPome5vwoTW9rM1gBTog@mail.gmail.com>
 <87eelo7a7e.fsf@keithp.com>
In-Reply-To: <87eelo7a7e.fsf@keithp.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Oct 2020 17:03:21 -0700
Message-ID: <CAKmqyKNKAwtE6M6zSiP1mneo3GhMzz--GOjW6Yh+kaBLB=zp=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: Add sifive test device to sifive_e target
To: Keith Packard <keithp@keithp.com>
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 23, 2020 at 5:13 PM Keith Packard <keithp@keithp.com> wrote:
>
> Alistair Francis <alistair23@gmail.com> writes:
>
> > I don't see this mentioned in the FE310 data sheet. Is it included in
> > the hardware?
>
> This is strictly a virtual device used to support 'power off' when
> running under QEMU. We need either this or semihosting support for doing

The sifive_u and sifive_e model real hardware (the names are confusing
I agree) so I would rather not add a virtual device.

> automated testing. Our tests currently use this device, but I'd be happy
> to switch them over to using semihosting instead, if you'd be interested
> in getting that merged...

Looking at it now.

Alistair

>
> --
> -keith

