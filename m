Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FF0C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 19:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C13F2076D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 19:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gIupHBB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C13F2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYDQl-0002pL-Iu
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 15:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYDPm-0002Nb-Ee
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 15:16:50 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:43236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYDPk-0002ra-30
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 15:16:50 -0400
Received: by mail-ed1-x542.google.com with SMTP id dn5so4165739edb.10
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 12:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/A5L1/K8qlb1MjtFyspUqtApQWnd8kLE9fhgV2JvYjc=;
 b=gIupHBB+nz8yAkQlVDfLPx5r8yGWdFVjhz4Jnx8ATAE6Ffne1ArknjjZuy9Rdg9jZ2
 wR0wKg4gNX21gXCbY3tQaNxPlxFXbFoHzefSXXdaJnLDTc6Z9/2fJKnY9phe8lYZnl7E
 d795eNlo6hoHeNTbFam7Vr0W9RhE6k5DcQhoU4fa4zGocGJkWA7bnTG3TW91iD0n9zlw
 QnZwv4eOfseqlsv1kyFKdXnT4KMWW9MMxLKfYTlnbxRo/zkFrGGM/m7ynswivKXB7yhe
 2Hm6qUjfUozZXyUI7kRf7piNcU8bEWTYuUOLEVJ9V9AbtlLafDefQsXGXJXww3PcX72N
 hmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/A5L1/K8qlb1MjtFyspUqtApQWnd8kLE9fhgV2JvYjc=;
 b=kSDkVq+HR6rAFNDHCK5x124eW7dECCbJRdZywsC4b/0jyWmkP1r9VXVV6G6GEa+VBj
 rjuE+uQCn5Ta4FmY5ZSvk3vq2GHsUmalwXt9aSSCQ0IXkaB7UB0z0UMr4tClWAku8xau
 zw907B4g99UtoIlbfVXbT45VaX9sErtyBwy4CMBcPfjoH6me3cAVG1o3msEzZHAlyTNA
 XWxGhpvYd9UmRpQ36Yc+wS36eJadf1jDZ5YnjPsPG0DLFDGYpN4dtEmfo9kFvNSVJKE1
 CNIV6Cai1Hn3y/TotV7zOShC21e6reLlzUdMPL3IX6DaAVpwI9j0O8kKXaW6DCP5D1NB
 bSiQ==
X-Gm-Message-State: AOAM530T1wk00bYb7xxYvX0M/qjG40eOeuqd1LvXMSh+b6KUwBwfE183
 rSnN9c2nH8CXCUkvlg1xpb7Q3QQz3G9pz5aIQoEtVQ==
X-Google-Smtp-Source: ABdhPJw3MCMK4zf3XfteBhkjsmaYQxD4v5n/IQjMHbtti7UXAE9srwCJniln1jIjMnfrl1ac5GiYvzg8yjVVWpd27qQ=
X-Received: by 2002:aa7:c683:: with SMTP id n3mr5539759edq.146.1603999006560; 
 Thu, 29 Oct 2020 12:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201029185506.1241912-1-f4bug@amsat.org>
 <CAFEAcA-spK9H6SWkx9FLZ2tjMZUS5qz7bJ9rFBwxLVW_fxLRGg@mail.gmail.com>
In-Reply-To: <CAFEAcA-spK9H6SWkx9FLZ2tjMZUS5qz7bJ9rFBwxLVW_fxLRGg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2020 19:16:35 +0000
Message-ID: <CAFEAcA_YEfwbUXj8ypGqpR+b4-kCV==6brGiAxLsRfz88OGvfA@mail.gmail.com>
Subject: Re: [PATCH] util/cutils: Silent Coverity array overrun warning in
 freq_to_str()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
 Richard Henderson <rth@twiddle.net>, Luc Michel <luc@lmichel.fr>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Oct 2020 at 19:13, Peter Maydell <peter.maydell@linaro.org> wrote:
> We should either consistently assume that idx can never
> get to 7 (ie don't check it in the while loop condition
> because that test can never return true) or we should
> consistently guard against it happening (by switching the
> while loop to "<=", or by handling the idx==ARRAY_SIZE(suffixes)
> case specially.)

Oops; "switching to <=" isn't the right thing; you'd need to switch
to "< ARRAY_SIZE(suffixes) - 1". Anyway I think we should
do the other of the two options, not this one.

-- PMM

