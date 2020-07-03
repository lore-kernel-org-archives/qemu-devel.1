Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD849C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A827720870
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eiag0zTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A827720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrM7R-0004NV-U9
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrM6S-0002WW-If
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:51:44 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:39996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrM6R-0000Bt-1g
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:51:44 -0400
Received: by mail-oo1-xc44.google.com with SMTP id p26so371119oos.7
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 06:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MepMru1D/YzxkLb8PygMuGCrjLYZWIayt5cr0f568H8=;
 b=Eiag0zTBE7cpOlvQwPP1wlqH/nJvE860KgI7Qvwy3oOSwmCnv0g/jHFHNIfCotvG02
 oo40uCwywc1u23IvObbezda7CqxlRfesRRrV80Fc5cyvjUWVCX733dZcwLzscPgH9HQ3
 m7ZYk17+3a8IIAAGV0kcYXEBa1kMBwmXJMRPLX5EOpDAWansDbqL0DOp70DxoZ4+nVcU
 4QxmggfY3YbBZ47+vWrcCv8VKi+xOchADhIYGhUC1cMCV9lgR0g79sgo17MZhjXd4gJP
 M6aHz6G/1WwXndqCX/vqNuwl7SwpA5p4+rjCMfYKPL/okHt01RvtX3/0Ppvci1erUM04
 U6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MepMru1D/YzxkLb8PygMuGCrjLYZWIayt5cr0f568H8=;
 b=oKmA7q+E27h1xVcqrzF+0juayWg6iYWqxoq4725aw3Oku9Cj+GWtDwAT0IiYUEHuXi
 /5B1UEfMRe6sr2KRPLHNzrK0x+IxU9J1ZbRBWT0PkYbGTFrzM6vegAb9Is2DtVsdtdEP
 UOhHPJ7flmVwkRA1eJD2EHWtvSsYymReAqU7sizyAhzDyCkASUmrbVLT3Lz3J48a51Od
 EovZvLtevVtp7FuKIfm0RSAd3N4EFxrvapo7PTEDxo0bCHe8o5xVWf3O0G/XL5K+EOv5
 HxOj2+mNYcO83GRYZtn9ToMs/UkTCuwy6en8bRZAy9EM5gXKKsb+mwQhXrkk0xuHOWZV
 KJmw==
X-Gm-Message-State: AOAM533pFRtqqMmnPM4ti+P31qv8IwLaNwpVjEjzZ2BkwpYqDSqP044H
 sdA+f933z3igMTX05Ch93jDUTUajO+IoGmlpStYgRA==
X-Google-Smtp-Source: ABdhPJz6P3hDD/Jv0VznMIYmst/45TfzXqmMJVCvH5SfRtuWzNifw3TYD+S03wq+ekS47qi3e8rQTX7OlLO3s51xpY8=
X-Received: by 2002:a4a:9653:: with SMTP id r19mr9262711ooi.85.1593784301704; 
 Fri, 03 Jul 2020 06:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqztrEOU5KQQ91qkNMrXZOxfnKQDFhC_UiJP8MkoyVoquw@mail.gmail.com>
In-Reply-To: <CA+XhMqztrEOU5KQQ91qkNMrXZOxfnKQDFhC_UiJP8MkoyVoquw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 14:51:30 +0100
Message-ID: <CAFEAcA9X12n5XE1Jx9rgHLUt_hE6Tgc2QcsyDxAcow4zSjxZJw@mail.gmail.com>
Subject: Re: [PATCH 4/9] Checking sys/signal.h presence.
To: David CARLIER <devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 at 01:46, David CARLIER <devnexen@gmail.com> wrote:
>
> From 9d43c8cd1611d0347db9066b1df1dc34431b2028 Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Mon, 29 Jun 2020 22:17:53 +0000
> Subject: [PATCH 4/9] Checking sys/signal.h presence.
>
> Signed-off-by: David Carlier <devnexen@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

