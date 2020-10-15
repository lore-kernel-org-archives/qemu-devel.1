Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DBBC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 12:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B91922258
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 12:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B+tnHb1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B91922258
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT2YR-0007ru-9b
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 08:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kT2XD-000769-Kx
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 08:39:08 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634]:37326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kT2X9-0000oC-0C
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 08:39:07 -0400
Received: by mail-ej1-x634.google.com with SMTP id e22so3402169ejr.4
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 05:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7Ba4crU9J7ctwHEooCVnFHvoXA/4gAGBnLfB5+Pbvqs=;
 b=B+tnHb1QiNtTvyQ4y+jTy0wjx41JlmoI0yi9O3LrqNyLjyKIuWyXaj/9qh/5+2It3V
 xmx7tX1JWJQ8Q2DhnwL1/ug5l320nPjVhvXRY4xDgmLZZLAT6U6f9VHrIRmXqcTGIQ7g
 6UV0QajXYaFLRtB1nOWdNSlRJ4jzojSUGxIA2C+3xq8eUnWE7gu2ICfWG737DIKnnix0
 61suJ7ciW+dD8OdJHhJGIdYiizfZBO099LaRXp4gXWBuitkpUnwTre5ReUPFdzdzTcSc
 +5CwVnEjSi0Chwo1tG4Y9XJ8WICj9fzZpafokEwAjO06cNGpeMu7FrdGg5NqjaoDjyoU
 MR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7Ba4crU9J7ctwHEooCVnFHvoXA/4gAGBnLfB5+Pbvqs=;
 b=SgB8L/qd4A4oiAxl2O25OO6uNEWLtsGk8glAzBCENr5y5bLJmPAGYxh/gV1hdvalDP
 4LlL9Y3dX6Z/4A6y2oGX9Mfmjw4Q1dmEcvdmJVgHmhIGetSum+iTBtHtAWcF0yljNu5Z
 UTJRPXVMdsNH4NJBWUoYJOQuYXE6DCl9JrrsLh5+GJf9SbUJzuDO4VUjjfzvUEaReXai
 K3KwT7gwHNtIiCfGxZSIaQ30i6hB/0BqEkn/XJCO497C0C1Z5gou/Me4RKHV+JWrFVjD
 5UHfB0Pc5G2ndJitNfTtrgXbcSzo7e45sB/jDMkjkZgQ1hQTwKtiRzkQLwt4vdme7bFG
 0Scg==
X-Gm-Message-State: AOAM531mPVrGQ2wNontetv4f0EBdS/+C/+rcsaPi6KGdeW6kWKVjz10v
 wVpBOD3sXN8Y9L5xVMouaeTU63YmHxfbjEaE/aqU4g==
X-Google-Smtp-Source: ABdhPJxDhUJ1TjCdPNs52Usb6LahtHa+uo4RzYgDG2tQtTRBS2s0ufpZGftHHjQaUZdJ+EP480mGgvROh9CLforcsLI=
X-Received: by 2002:a17:906:c7d9:: with SMTP id
 dc25mr4165339ejb.482.1602765540087; 
 Thu, 15 Oct 2020 05:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201014223356.324990-1-ehabkost@redhat.com>
In-Reply-To: <20201014223356.324990-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2020 13:38:49 +0100
Message-ID: <CAFEAcA_pqLT5BNuw8tEyuiBZj1LJCLTqh-ucFoA9aNPecWsfWg@mail.gmail.com>
Subject: Re: [PATCH] docs: Print warning when running Sphinx 3.x and newer
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 14 Oct 2020 at 23:34, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> This won't prevent the docs from being built, but will let people
> know Sphinx 3.x is not fully supported yet.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Sphinx 3.0.1 works fine for me, so I think we probably
want to set the cutoff somewhere else than just 3.0.

thanks
-- PMM

