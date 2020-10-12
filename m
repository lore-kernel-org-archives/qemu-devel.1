Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C8DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A1602080A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQJcBOuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1602080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0Q7-0007Vr-Au
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzzn-0003Bv-6P
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:44:20 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:37886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzzk-0008TR-SC
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:44:18 -0400
Received: by mail-ej1-x641.google.com with SMTP id e22so23869835ejr.4
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qCapRmoFaam/UUfcbHWT+v9WbVZVL68DDBiSNXMmIXk=;
 b=RQJcBOujfDbxmMYNul04sRcksqSKxc477XsbtxYBPHxS/bnd+oMmaLf1ESIxTPP0G3
 OtoBbz4/hwvVE6mB/vWzL5PKhC6Dm4b8oWhs7ti2Q1PTTYOkVHPbKpeBAkXxnqtDebZP
 mMkn7oCaXqz2O6iC81acuOv30/H7veWwnm0K9IbjZFAO1xa1j7L4FpLUvlj6NsJbAZbe
 wOoL3Ap9Prw8y4MfhspWYzbODveUIgNYxT3lTiLiRmoFmzFpxqwe7R2qoLNQbCd315VN
 yPl2M/Pfjx8ihGzerG1xGqBWMU0raxUB2BbP2C2tVuPxggc+KINQZE8G7Zwk7sg4OwSW
 dw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qCapRmoFaam/UUfcbHWT+v9WbVZVL68DDBiSNXMmIXk=;
 b=KIeCM1NwSTWzSqLyrwjUhNEBNmEIRiSbbQIMr8gU1cWht2zHbCuqdWqt/FnkQZIt/d
 tb5OcbL/HT/dRtzlltvxfqNYhlI/iczClOl3EDrHsqO0agLfxF3wdP4yPAjUklfzSLDT
 4NgxUAnZjq9D6yhB2VCU7s6jC5s0XiBqhepgj6q4+hsmSId0nzrmVrztHBV5qw8D5obb
 GOyuiTpbV/gVmEgpAsF3tcA9O/VdewyOLCj2qFRlh/5qk1f2tTx3fGA/m/mmpxgmbKDc
 pUrr3/5uPb/RYQC7Rsy3SGh6bROWMiyWgpoqmAGaz7T/iLLQax6UPPlXrM/7J9tu0Tzk
 nj0g==
X-Gm-Message-State: AOAM532bNRlhsrKJdtaM2d2gGJ6YFlaCKgrS7BoZcHIzbSuIu8QCD0fO
 Kkb980v1mK75uAOLXZgnYBCtW/i6g+9f7Oumf/MfMw==
X-Google-Smtp-Source: ABdhPJx/8f/1rpGyvkH6YhWVerceIVEVDX+MBXdv13+zWjvCakZs9X/OzLm6JGL6xJaNVlmtPSHCDg7qvzHbYMVEEto=
X-Received: by 2002:a17:907:4365:: with SMTP id
 nd5mr29488808ejb.56.1602517454650; 
 Mon, 12 Oct 2020 08:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201012153408.9747-1-peter.maydell@linaro.org>
 <20201012153408.9747-2-peter.maydell@linaro.org>
 <d5d29e6-3fb9-927f-ae9e-67c67786391f@eik.bme.hu>
In-Reply-To: <d5d29e6-3fb9-927f-ae9e-67c67786391f@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Oct 2020 16:44:03 +0100
Message-ID: <CAFEAcA87S8yN+hvgew1nPE2V7fcMziht4XofLyF37xY7hRM+GQ@mail.gmail.com>
Subject: Re: [PATCH] Deprecate TileGX port
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Oct 2020 at 16:42, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Mon, 12 Oct 2020, Peter Maydell wrote:
> > Deprecate our TileGX target support:
> Is that 5.2?

This mail was patch of an accidental mailbomb of the list
with a couple of dozen stale (already sent weeks/months back)
patches that were hanging around in a directory that I ran
'git send-email *.patch' on by mistake. Please ignore it, and
sorry for the confusion :-(

thanks
-- PMM

