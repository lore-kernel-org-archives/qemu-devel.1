Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C23C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 18:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0925E21531
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 18:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aW141iA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0925E21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHAQX-0007qI-SF
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 14:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHAPx-0007PO-5w
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 14:38:33 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633]:36945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHAPv-0007cX-HA
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 14:38:32 -0400
Received: by mail-ej1-x633.google.com with SMTP id nw23so17762657ejb.4
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2020 11:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9f+vSqgbdl4GxYDj/U/qyhSeSOCsUeHXdwWnajP7zbg=;
 b=aW141iA6wXrv2op+B2D4gvYwFa0BZBhl1geqCJxfw0qQMSoVl6zokfhoIdL+e3VxXv
 eERnioISKP4cWA0ZkTUn6nLqqgD3YJT2qPnF0ekYN/CITTOrweVqNIe68rE2khL9GMsy
 KLL4hT/H50sHSENRqyenk3G65oqfr+Bc8X8VbidQKT/uvuI3lVuAuClCJL9j+nnKvsxB
 jsj9MGmXNEGVNgwL0OHKtBVl5p2o7DEXGPMOs5C6NlpDhXTEvILfoQUy/zAbHT16xx6M
 iBNxJ5GjIfnrUygebUIneI6XJY37K0O44UMRdDuUk4ayXx/SpEJsJTW1/yf+raSo0j3P
 hg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9f+vSqgbdl4GxYDj/U/qyhSeSOCsUeHXdwWnajP7zbg=;
 b=BOXs+poBpM6HsmvXQ3AZGSNLswhhdZ3AxvFYfYM+8mEbecWRlvoStQR87q+aYpXVmT
 FP+FTZKMS8WsAMHIstPMgZ5ujCcMv3XVhSkqQ0UyRDAAXqj3+eHoC80fCj2lDoCkxlja
 Cvr5xxNNL7yjJvtKUGEB+buMkEU7qSmvGn949FyRhrkNPgwB/cAl4Wo43xmPJttPQS7b
 Qj49gX6pnBNPekudFUQIcixj4+vjNZtnEAbI0wu5UNaMssJz0xtRsiEedeEm2CvtE5PK
 DXDEhOzvFdKs8C5DnRtuMpIHJxIzMl5pcmYmAS7GOjsRUtZZnJ33iNyrlOP+T+zq4SPH
 KScg==
X-Gm-Message-State: AOAM533R1u2gzi9h18Uri1YPTgFb1TfaTnF3cVkwI2M5P9VQaDPLIQFg
 bXOw0ZyFsH25A16543iC2K6smfYXql10NgxxLw1iQA==
X-Google-Smtp-Source: ABdhPJwNpa+GPaFybBe+TIWMFP5+hqLEe5D0BiQzTq482O2C+rfhhYMu0pPPGOV/cmdnpUQ7fueF5Z9Te4/eoL5PxWg=
X-Received: by 2002:a17:906:2cc2:: with SMTP id
 r2mr6939745ejr.482.1599935909590; 
 Sat, 12 Sep 2020 11:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200908115322.325832-1-kwolf@redhat.com>
 <CAFEAcA-wrgOC9oqdqBuVSTiidaRcwbgQWF08zD=TSetSwn_tjA@mail.gmail.com>
 <480db253-9aa4-39c3-592f-bc5cfea1997b@redhat.com>
 <06214b2c-adc7-1e3b-a15f-fe3c16ff0983@redhat.com>
In-Reply-To: <06214b2c-adc7-1e3b-a15f-fe3c16ff0983@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 12 Sep 2020 19:38:18 +0100
Message-ID: <CAFEAcA99YnJ2nC-Cw6JaYJMSMmvy-idC+625KYfOVUx_wb60=A@mail.gmail.com>
Subject: Re: [PULL v2] Block layer patches
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 12 Sep 2020 at 13:27, Thomas Huth <thuth@redhat.com> wrote:
> Peter, why did this slip through your merge tests, do you still skip the
> iotests there?

I forget what the reason for them being skipped is, maybe
it's because they demand a gnu sed ?

thanks
-- PMM

