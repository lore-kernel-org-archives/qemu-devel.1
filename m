Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C857FC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 14:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D342395C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 14:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TF39uwx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D342395C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKjXL-0004m4-Rn
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 10:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKjUy-0003OH-CA
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 10:42:28 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:41120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKjUu-0000oT-JR
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 10:42:27 -0400
Received: by mail-ed1-x52f.google.com with SMTP id ay8so16396393edb.8
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 07:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ozyeyaVl2QVJIHlT5pS6A/AEadHYI2UgPVUNTUpbHB8=;
 b=TF39uwx6Gz2JfIx2zNQpbTo20jZZJShZh/ahTjApkLod0vkRfQNTXCm/2UyCC3k9q+
 Lj72o/wlHUul0egO1UKwtgEQAu/0AFFVU2pIriUsZV26eM7sqJqDmsZNjCtY/2OCO/al
 3woSbN4Hl5LjnHZO01wxS7FqdWWFka4/A4gkRKs4k8gPmz6pNQdfl7gFpLKqLacVtYCF
 XvQTw+jheZmHsCt3If74Fk+ka4FhU486gGyhfombQM5/VQ5DqeNxikwv0yGnsv9HB8BQ
 8f1CoYiGPzfvCtDQOGqtl1Gore3hFqbqpZrlVzvRk+8Jetdfc6GDUzCM17T5/uh6XJ0z
 tYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ozyeyaVl2QVJIHlT5pS6A/AEadHYI2UgPVUNTUpbHB8=;
 b=hJcR2K06sMgJZHAjBYUd0eiG/V6qqSUiGaVscrKP8AVm9+I+7xL3cv2m6M1fayVFh0
 O1mDK50TA8jah/lR4d22Po/Zl1dZ+6Uv5Imk09Wv1S+Xv+R/Skm74cvUqu8BVTJaTVkz
 Evk3xfQyO7zW+S2tQ5/D8BaIQfJN3VaSjE1DtrBP9LnLw6dUQQGPGBPka3OfvjTTteyb
 RaCzaO60MyY+wKysgj8J6ABA1S6t3sYXP1Hfifw/fpjUy/dvMwXRXDZGyyueLCkImNoy
 DJ2H52cJEklkhogKVCauS/vKDc7+dQ6gKnIEqRt07C1tlhGlLZjIpXpSunzm6T5FfDN7
 dzNA==
X-Gm-Message-State: AOAM531bRI9hBOY/IeXzKSFdh/FAD73mWqtmpvteJY9yxyIGCeSUOTaO
 NtQtEZ0LV9OWwmIsvz18rG7gFg3T1JFOYLhlPbbjDw==
X-Google-Smtp-Source: ABdhPJyIXtQcsb/P2BerFim1Sa5Pw6Z95AN2We4PHA6v/EnzcvUqP4qQ+c4lFEYlbuM3ZW6zWKYTgkXbqQTLimMOi8U=
X-Received: by 2002:a50:f1cf:: with SMTP id y15mr4301083edl.204.1600785742504; 
 Tue, 22 Sep 2020 07:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200918204714.27276-1-ehabkost@redhat.com>
In-Reply-To: <20200918204714.27276-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Sep 2020 15:42:10 +0100
Message-ID: <CAFEAcA8JZz3DBGMrMTWvePnLZQuTB48kcqPH=bJyixog9TWzGQ@mail.gmail.com>
Subject: Re: [PULL 00/17] QOM queue, 2020-09-18
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Sep 2020 at 21:47, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 053a4177817db307ec854356e95b5b350800a216:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-20200918' into staging (2020-09-18 16:34:26 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 8063396bf3459a810d24e3efd6110b8480f0de5b:
>
>   Use OBJECT_DECLARE_SIMPLE_TYPE when possible (2020-09-18 14:12:32 -0400)
>
> ----------------------------------------------------------------
> QOM queue, 2020-09-18
>
> Fixes:
> * Error value corrections (Markus Armbruster)
> * Correct object_class_dynamic_cast_assert() documentation (Eduardo Habkost)
> * Ensure objects using QEMU_ALIGNED are properly aligned (Richard Henderson)
>
> QOM cleanups (Eduardo Habkost):
> * Rename some constants
> * Simplify parameters of OBJECT_DECLARE* macros
> * Additional DECLARE_*CHECKER* usage
> * Additional OBJECT_DECLARE_TYPE usage
> * Additional OBJECT_DECLARE_SIMPLE_TYPE usage
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

