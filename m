Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C739C54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:12:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE5C2075E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w7TiPUJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE5C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY4Ty-0007k8-8h
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 05:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY4TH-0006qO-1l
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:11:35 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:35804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY4TF-0000fU-Bm
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:11:34 -0400
Received: by mail-ot1-x32f.google.com with SMTP id k110so6970843otc.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 02:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lHfmS6rdbcVSa3B7TbZJcWnN4rmbjJ2JIifvGDOKWCw=;
 b=w7TiPUJ5oi1RouMjyWpHVw7fEyWX15gjAoX9bQoIJwuwvxponkrB74/Z6dwvGzaADH
 KOW+uWQe8Oigx8xfLVmnMM3qgcifbZ7dOkd60dp2ZKxvim2wk6rotDW8Br546DOsdEFZ
 J2be4ebw7xj+o1AvrTIaqSGoR6HUVl7jIwkx1pXofvW6rw4qEEuKKwLZ/GGQ31LVKcTa
 dB+atK5U7BY63F3robTzg0SecqJ/Ehp+NreRj3GJqV+SVtVdkB9SaLdlXM7mjDXwc6+7
 N7/n1vmD6OEuV4OnNCghJpogHLPBzGlnzQE4ya/Z5U2WssDymClms65OrZcNXTA9ME5U
 qsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lHfmS6rdbcVSa3B7TbZJcWnN4rmbjJ2JIifvGDOKWCw=;
 b=a08fNmoG3wH/z8JzScUQFLr4i+YOp3OYK2KZfGYn6woe/2CXCGxZBDp3yynEJ1HoI5
 qyZ+uybqGtZrQGYd4SUp4ua6zydgq1d8qaHpQGbQwhe8Jht5VdRD8lV6oGimANxKzVVr
 nhr4BxmO3SU7mFKTeSVbZ9LcNnIvA/HhZxtttS59wwdfH12CqIiIvgbtaPuMU0+6UcbQ
 o3Z73fpf5qGt2lm3c0/nwMvh7nTifs6yHqUPuHCLGZk/7wjZrrUJ3OY9XNMnIUhMOHrZ
 vZAE85H+FFvXDGjRWwpu2n+ntT7YpJYfCjUVtDJqbVPS9ZDwH6MTGTWxaBRjTh64RKrX
 vraA==
X-Gm-Message-State: AGi0PuYfPLKUPX+LNfCp0Q6S4fC1aYDRBfKNMb4TOwoAEoA09r3jFCAe
 ewY+FMrMhob8d8KS33hxNbqiOXkY+AWsKKdc5qML8w==
X-Google-Smtp-Source: APiQypKgQcXV5B3wLZ4xQg3UAT0dRpW70t3A8/+9aKSqbyrdukK/R9hrApALO6Fy3E9UTZWVjR5biIAf1xSghDkxGhA=
X-Received: by 2002:a9d:2c08:: with SMTP id f8mr12073216otb.135.1589188291640; 
 Mon, 11 May 2020 02:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200507162235.1790-1-philmd@redhat.com>
 <20200509151801.780059c3@luklap>
In-Reply-To: <20200509151801.780059c3@luklap>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2020 10:11:20 +0100
Message-ID: <CAFEAcA8g1gq4QsXxfLYSOChd_Nj6u0EKeXO-s8Qww9qA_dBiLw@mail.gmail.com>
Subject: Re: [PATCH] tests/acceptance/boot_linux: Skip slow Aarch64 'virt'
 machine TCG test
To: Lukas Straub <lukasstraub2@web.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 9 May 2020 at 14:18, Lukas Straub <lukasstraub2@web.de> wrote:
> Hi,
> Why not simply add slow tag to the test. Like:
> :avocado: tags=slow
>
> The slow tests can then be skipped with
> $ make check-acceptance AVOCADO_TAGS='-t -slow'

Is it possible to have the default be "do the fast stuff"
and only do the slow stuff if the user asks? That's the
way round that we do the iotests, I think.

thanks
-- PMM

