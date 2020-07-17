Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3863C433EA
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C7962070E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k/cYPPvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7962070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwQ5s-0007A9-Uw
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 09:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwPzK-0005GU-Cu
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:01:19 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:40949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwPzI-0000rn-HR
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:01:18 -0400
Received: by mail-ot1-x336.google.com with SMTP id c25so6785447otf.7
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 06:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HZahT6cWITW2wLuTimD0a3i/92r4xWl5ViO1bRx2RwA=;
 b=k/cYPPvbEUqW0q6Coj/ObIjP8wCAO1XjcSg6G0A2NsWEmGzbtiAITm50H5u/1Qe/qc
 4o5txzUwx9kHJDABNVV/q/E3IdOenddYnpOEXKqRUP6pVYj4Ulc65Hc6eIo/Rh1uiete
 uzuPa3elrglps3ken228cnlzrVbeYvm0e4gWlQXGubOkr/I37UebOvX5pULdTxh1AoQp
 scVkpgeKgseUikgI1iQrggC7koARDACk4xDVpkenWtxNlTgQTulB6PKHn19TsGkZmf4A
 GRHq3l6rERcCHb+qR3KmoRpjKz/j6BbhWQUQeDB08m8TcRnq2qqyV85X7fYPv13s8nRi
 3WZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HZahT6cWITW2wLuTimD0a3i/92r4xWl5ViO1bRx2RwA=;
 b=VMdzePkrw2frHJpWgmQnnywnHtYOOvhLh5XuUzsHVTrlaWUBqKykU4TGnhTuST/gyI
 C5Hr0EiPXJ7m2BgO2+O2gTdX3yer93hF4ekPT6nJqXIHJBBo0h8sDSJCd6fL/Sb2wDE/
 VE4K1Y8MyxZPpdaYq1JcajUMREPuQwjSI8h7fcVNK7HWZGn0R9q/r1club/G6bR3xSwA
 OnA7DIBwoq1bcG3jxD1wegj3UzElADlgVnK2NXbmiOTaWtFJaFIrmjfjglUtr3gOjJZ0
 uBc43gghu0n1lTq8roSsOT27sNUJ7svLXjRYnXu8Ib8U5HyFefwgeNX5gBRKYl1RGB3h
 TFig==
X-Gm-Message-State: AOAM531E7dPb5o7YzceuaHBu53pQPFVm2P8puzcPpFWhh5Yes2Of1M0x
 Ie2lbacHjmutuu+oEa8cHFfyGvi1ww2NrQjf6Oo0VQ==
X-Google-Smtp-Source: ABdhPJwM99JzwrHMQ5/eTxC5sFPafj9FTndvmcq0yd2bWLl4BvpX7BlHC4wZPcp1qVkfzDczj2LH+6H04/OOjTvzHsw=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr8560115ota.91.1594990871724; 
 Fri, 17 Jul 2020 06:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200706164155.24696-1-pbonzini@redhat.com>
 <20200706164155.24696-29-pbonzini@redhat.com>
 <CAFEAcA-Ha4+ub=QQASREraok747+U2tUcNkSYu6PFnoc29_Jrw@mail.gmail.com>
 <CABgObfaFYmsiR-aYsq5vBEruL5Z2=qD0Z6Zf0d0C2N1cbfq4kQ@mail.gmail.com>
In-Reply-To: <CABgObfaFYmsiR-aYsq5vBEruL5Z2=qD0Z6Zf0d0C2N1cbfq4kQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jul 2020 14:01:00 +0100
Message-ID: <CAFEAcA_ncNaas_22k=07RUH-VGwp+pe7hYjt-OVoXdEEzLVXKg@mail.gmail.com>
Subject: Re: [PULL 28/53] Makefile: simplify MINIKCONF rules
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 QEMU Developers <qemu-devel@nongnu.org>, Corey Minyard <minyard@acm.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jul 2020 at 12:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Il ven 17 lug 2020, 13:03 Peter Maydell <peter.maydell@linaro.org> ha scritto:
>> There doesn't seem to be any machinery for creating .d
>> files for make to include to tell it that Kconfig has a
>> dependency on hw/Kconfig which has a dependency on hw/i2c/Kconfig etc.
>> How is this intended to work ?
>
>
> I cannot look at a build tree right now, but shouldn't that be in the .d file produced by minikconf.py Those are passed to minikconf.py as the second argument and included with "include $(SUBDIR_DEVICES_MAK_DEP)".

When you do a "make clean" those .d files get deleted
(but the config-devices.mak files do not). There is no rule
for rebuilding a config-devices.mak.d:

$ make -C build/x86 -n arm-softmmu/config-devices.mak.d
make: Entering directory '/home/petmay01/linaro/qemu-from-laptop/qemu/build/x86'
make[1]: Entering directory '/home/petmay01/linaro/qemu-from-laptop/qemu/slirp'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/home/petmay01/linaro/qemu-from-laptop/qemu/slirp'
make: *** No rule to make target 'arm-softmmu/config-devices.mak.d'. Stop.
make: Leaving directory '/home/petmay01/linaro/qemu-from-laptop/qemu/build/x86'

and we include them with "-include", so Make silently
proceeds without the dependency information.

My guess is that we need to tell make that this rule:
$(SUBDIR_DEVICES_MAK): %/config-devices.mak: default-configs/%.mak
$(SRC_PATH)/Kconfig $(BUILD_DIR)/config-host.mak

also produces the .mak.d file somehow.

thanks
-- PMM

