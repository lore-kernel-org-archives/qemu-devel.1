Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52716C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 18:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E0620725
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 18:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n0gAtlDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E0620725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juKEv-0002ba-C6
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 14:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juKEB-0002As-Tz
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 14:27:59 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juKEA-0007Om-4B
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 14:27:59 -0400
Received: by mail-ot1-x342.google.com with SMTP id h13so6618193otr.0
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 11:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d2956xdMIj1FLLvFQm2cHPwzAIm3wLMeYwQkKp8o40c=;
 b=n0gAtlDkc5fhFJ6cY1skWPiDoXIgEcAkw8rcNz9e/PMmdSmsN6GyPvFnSn5QWo6ogI
 UvxuXld8apetrNciRYuxgDrRzy3yHmjZYfDZxVDKxzk9ueEsir+bUMTY/Un1A8ID6pKt
 P1+cxyVpC6f1ZFdCkZaFI3w9ImJTxT4IaVCF1l+gIjiZLJTYXMKdgZ57HBpoITHLx2aw
 dlz9Hp67X73RcA5dsrA+X//SAmq2gVzl0Nbzv/qQs10q+7xGRwEreqMhrrqyOmnHSsBH
 ysU6eUySLE99U9R/Dt4k7LOoLvQhqzQxt5Fvq9/E3UICP/sQEoBGrD3043ndPMy1h+Bo
 /2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d2956xdMIj1FLLvFQm2cHPwzAIm3wLMeYwQkKp8o40c=;
 b=mWsu4yLDtabCIpVgwiD/BopHUddUbYxYJErKxjc5d7Fq6//oHCsEE0r+oKLXlJSsW9
 ZPV0y2FIeY/EKFJddwh22Vuq8bAimeJSs7JSPKMl6QvuKhQL4FcbwbP7+L5nPLsBn03n
 sHZpdwOwU5xavKAYqMcClZJk07RL4hgye2dZs57AWAmff/Xn3nEohpjWM3XAIO0cO1/b
 haOkFc216g3O6b0zZFw8bHbUdtH8IF1LeIVCYRJYh8F1q3km0CV6KIaREZRc1ZsgFFNg
 ZaoB4PvtfqeqrwBQUNoyhTb827qe0q5FnN3u7d9+SOeA3L5c3Gf/190YMQN00JLjR0lP
 pfLA==
X-Gm-Message-State: AOAM533iYQcDUrzgpzuG0G0oAR5LLgVYLKwwhZGlpoT+i2369X2g8aAZ
 zK66I2D00DNILisPotjbulqSLX+u/cR8U8/8xB44mQ==
X-Google-Smtp-Source: ABdhPJyiIU4XorbR3gTUVVHbJoFfPPxVfv7jwqiVcDa+v1mjiLTjRu3xabi+Gq4pbqHoKnxqZM+maM2y/nISnXmfzrA=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr55056010otk.221.1594492076393; 
 Sat, 11 Jul 2020 11:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200710234909.21682-1-pbonzini@redhat.com>
In-Reply-To: <20200710234909.21682-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 11 Jul 2020 19:27:45 +0100
Message-ID: <CAFEAcA_i2b3d-1EpHtvr6WNc62xFt9cgp9O0MsPEFZmcnaCz-A@mail.gmail.com>
Subject: Re: [PULL v3 00/47] Misc patches for QEMU 5.1 soft freeze
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 11 Jul 2020 at 00:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 45db94cc90c286a9965a285ba19450f448760a09:
>
>   Merge remote-tracking branch 'remotes/mcayland/tags/qemu-openbios-20200707' into staging (2020-07-10 16:43:40 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 56908dc5041aa424fd1495b6c6beb78c539d93e1:
>
>   linux-headers: update again to 5.8 (2020-07-10 19:26:55 -0400)
>
> ----------------------------------------------------------------
> * Make checkpatch say 'qemu' instead of 'kernel' (Aleksandar)
> * Fix PSE guests with emulated NPT (Alexander B. #1)
> * Fix leak (Alexander B. #2)
> * HVF fixes (Roman, Cameron)
> * New Sapphire Rapids CPUID bits (Cathy)
> * cpus.c and softmmu/ cleanups (Claudio)
> * TAP driver tweaks (Daniel, Havard)
> * object-add bugfix and testcases (Eric A.)
> * Fix Coverity MIN_CONST and MAX_CONST (Eric B.)
> * "info lapic" improvement (Jan)
> * SSE fixes (Joseph)
> * "-msg guest-name" option (Mario)
> * support for AMD nested live migration (myself)
> * Small i386 TCG fixes (myself)
> * improved error reporting for Xen (myself)
> * fix "-cpu host -overcommit cpu-pm=on" (myself)
> * Add accel/Kconfig (Philippe)
> * iscsi sense handling fixes (Yongji)
> * Misc bugfixes
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

