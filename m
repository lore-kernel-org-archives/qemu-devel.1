Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A82C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A14BD206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLKi8sXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14BD206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnRYs-0006l8-UV
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 14:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jnRY4-0005qX-Oz
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 14:52:04 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e]:43881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jnRY3-0002X4-56
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 14:52:04 -0400
Received: by mail-il1-x12e.google.com with SMTP id i18so5547839ilk.10
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 11:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kLY3nZ2/B8/ZtnGTB5iP2z2VW7n45Xu7BYGE1Z6VMd0=;
 b=YLKi8sXeAqkBmJP2KUHaP1EOovfDmvGVcxyq4cZYaHHW60dusQdhaQWTo0MOPbSHOE
 u9eLcUA1jAoa3Q+IXGTSnOepiQ1euaBv/ralr1XLYd8RMwjzL3lyBOU/1CJ4yszHHwUT
 kabDVzXLCZV98ApWXSOfrzHtqMLtIkoraNt1lB17yKP10LHll0NX44wHIKT4EqPXjT5J
 MpxT8hCjcVasVyTkzI8uMY6T2ODpaVRaHM/vN2P13TElLw1V/+bw8VHAlLPXzL1Yran4
 StIk/IDxajXhvS9OAXwVRnIHGUtbjWDtEQY45fqha6ap5gP11Rlsc6nBh8Qzh5XYQgAO
 zlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kLY3nZ2/B8/ZtnGTB5iP2z2VW7n45Xu7BYGE1Z6VMd0=;
 b=eolw//Hq8nsZYGdBSom64q7J3r1qsVP5Ho6tnehzIb9rqPvswei4Y5vmoAekHMEzSE
 ZxfxEdTJR80Kw5esfPsVn26+VNVb8VwLsKTt1f3Ek+bK/apRm8VmLyfd7lObLax6m4GK
 jM/UbbJvLAlPiCLrCNKBWKHWa9hSGLGiZVKFDIyEo1ioVWSP4U+IiP/w8XmEnwZjV3BH
 QR396FogC+LcIz3poY4lWtYK//OOKZRaaPUNw8pxIM1P7FaijYyHx0RyG7MeH8ShWjp2
 2eCFBF5goKVSVuv2LZnOdgEQTbeMep1wAG8sx6z2HsxKocbugcMXfmoSyraEPw6jiGh5
 L6bg==
X-Gm-Message-State: AOAM530QTnuYjv1EZboE4BCnAML0riXRn+N3Q5CtFwq9OF7wVguPX6En
 WXTa6EXFXJ3xHUSU4wMTeFHAhmapo0TznMKqeNA=
X-Google-Smtp-Source: ABdhPJwmkDchhmMbBdWQQlwx7pXvRitcuC3WAyFCQ6Z8YEJ2t+mCVDJ9uN1jDrlfkDA/+2SWMwTwUhbmDcgAk5AQjdo=
X-Received: by 2002:a05:6e02:13c5:: with SMTP id
 v5mr17311115ilj.126.1592851921602; 
 Mon, 22 Jun 2020 11:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200612141917.9446-1-mst@redhat.com>
 <20200612141917.9446-40-mst@redhat.com>
 <CAFEAcA9aoOXR4L_0KHAvjodhoBtKF4g8vhOb9gntcdWDNxijDg@mail.gmail.com>
In-Reply-To: <CAFEAcA9aoOXR4L_0KHAvjodhoBtKF4g8vhOb9gntcdWDNxijDg@mail.gmail.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 22 Jun 2020 11:51:50 -0700
Message-ID: <CAFubqFseP_zX_BtwNcEMK4GG-2-fhTx=Bsp7n_baVN=fLp_Q-w@mail.gmail.com>
Subject: Re: [PULL v2 39/58] Transmit vhost-user memory regions individually
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x12e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Mike Cui <cui@nutanix.com>, Peter Turschmid <peter.turschm@nutanix.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 6:03 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
>
> As noted in my other email, I think the best fix for this is to
> have vhost_user_fill_msg_region() take an extra mmap_offset
> argument to fill in the mmap_offset itself. In this callsite in
> send_add_regions() we would pass in 'offset' and delete the manual
> assignment to .mmap_offset. I'm not sure about the call in
> send_remove_regions() but I guess if the intention is that the
> payload field is not relevant then passing in '0' would be right.
>

Yes - for the places where the mmap_offset isn't needed 0 is right.

Sounds good to me - I just sent in a patch.

> thanks
> -- PMM
>

