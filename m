Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA29C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 11:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A232070E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 11:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+CLiGWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A232070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwOD2-0002aD-PI
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 07:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwO8z-0000Ju-NT
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 07:03:09 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:45503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwO8x-0006Ml-OR
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 07:03:09 -0400
Received: by mail-ot1-x333.google.com with SMTP id h1so6561031otq.12
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 04:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O6CZsI+625lXhasW/yNh1JhZqNPQ06L4VkDOMyWz8Mo=;
 b=Q+CLiGWTa5WH+75RMOZidrB34/1mlbQSwBQi/TUtqclSfahpXhh29BR1wAnYWqLm3s
 oFIeKZ61uwsWT6Fs51UwJIuUUxIjYBCgc6LMx2Ev8w4+KJHRckKjjYnZSzbB2kN6WDAK
 JPQnB4uK0CfPbpwc8K0s/nF/8tNjWQs39b8BB/peL/qRtXZWBNWG/wfeDVn4ajjLEErS
 xjZX14qE0it4VELpa9dfuQMGk+QJIFSeTG/5Yc/PvDw1YDR6H28+wX6UfaWpPD0oMkjl
 VxZpqoeUe+L0jJlyTbtZKQ4GXy59Zb6+5CyEK9Tari3j1Oe8gIeM4L3dif4pdXLYONFn
 r/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O6CZsI+625lXhasW/yNh1JhZqNPQ06L4VkDOMyWz8Mo=;
 b=HN3V60aR5DMtUj2QrOwLo0RmyGzh33seS9nD6+kkmwMsrqt72xdROrgbg+7gLb25p7
 uH5MUz2Y70OQKXM2utujvav0gl+T4Tl5mo4bxV/xvWxo3JdMmD5qWq4FTfdSlodNiU3N
 R26We+4UnA2ja4S0+y6ktqwvM8ZLfauIo3eXhnA2MYah45a3w6XMfx+6SqFgBfrSGVIz
 k2NLbxMGGnmqWDd5Aqz23vubOL6bdf5wDUMvFIxXQLFMx5ngLqDFQetf4ghJMCthSCes
 c46Bx9A20VF3Dn+yUJwNQpK2HUMy36EoJw7KXCGyBgduPC5FukDHDL8XQ/je17SWnEsN
 Gh3g==
X-Gm-Message-State: AOAM532O3u9tVfgYk2rpAzCW8JZFyhd+THEx4ihEITD/YupczOENxrEf
 KHuXZc8O8y2mxuVO9LHuRZAVL+TgV1qJeCdYXJ+7Aw==
X-Google-Smtp-Source: ABdhPJzgh92hucMlCCsVkbVzaX1vwO+Mk8FCwujoi8ouTr5oMNDAoZlUavRi7cOTtSD1WUI8X73DLxIyfwp/fsE1Vug=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr8536266oto.135.1594983786247; 
 Fri, 17 Jul 2020 04:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200706164155.24696-1-pbonzini@redhat.com>
 <20200706164155.24696-29-pbonzini@redhat.com>
In-Reply-To: <20200706164155.24696-29-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jul 2020 12:02:54 +0100
Message-ID: <CAFEAcA-Ha4+ub=QQASREraok747+U2tUcNkSYu6PFnoc29_Jrw@mail.gmail.com>
Subject: Re: [PULL 28/53] Makefile: simplify MINIKCONF rules
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x333.google.com
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

On Mon, 6 Jul 2020 at 18:03, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> There is no reason to write MINIKCONF_DEPS manually, since minikconf.py
> emits a dependency file, and also no reason to list multiple Kconfig
> files on the command line since they can be included from a master file
> in the top-level source directory.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Hi Paolo. With this change Make seems no longer to realise
that a change to a Kconfig file means it needs to rebuild
the config-devices.mak, which means that we tend to get
weird compile failures for changes which update Kconfig files.

Specifically, this is preventing me getting a clean set of
builds for Corey's latest i2c pullreq. Reverting this
commit allows the pullreq to build on all configs.

> --- a/Makefile
> +++ b/Makefile
> @@ -404,7 +404,7 @@ endif
>  # This has to be kept in sync with Kconfig.host.
>  MINIKCONF_ARGS = \
>      $(CONFIG_MINIKCONF_MODE) \
> -    $@ $*/config-devices.mak.d $< $(MINIKCONF_INPUTS) \
> +    $@ $*/config-devices.mak.d $< $(SRC_PATH)/Kconfig \
>      CONFIG_TCG=$(CONFIG_TCG) \
>      CONFIG_KVM=$(CONFIG_KVM) \
>      CONFIG_SPICE=$(CONFIG_SPICE) \
> @@ -419,15 +419,9 @@ MINIKCONF_ARGS = \
>      CONFIG_LINUX=$(CONFIG_LINUX) \
>      CONFIG_PVRDMA=$(CONFIG_PVRDMA)
>
> -MINIKCONF_INPUTS = $(SRC_PATH)/Kconfig.host \
> -                   $(SRC_PATH)/backends/Kconfig \
> -                   $(SRC_PATH)/accel/Kconfig \
> -                   $(SRC_PATH)/hw/Kconfig
> -MINIKCONF_DEPS = $(MINIKCONF_INPUTS) \
> -                 $(wildcard $(SRC_PATH)/hw/*/Kconfig)
>  MINIKCONF = $(PYTHON) $(SRC_PATH)/scripts/minikconf.py
>
> -$(SUBDIR_DEVICES_MAK): %/config-devices.mak: default-configs/%.mak $(MINIKCONF_DEPS) $(BUILD_DIR)/config-host.mak
> +$(SUBDIR_DEVICES_MAK): %/config-devices.mak: default-configs/%.mak $(SRC_PATH)/Kconfig $(BUILD_DIR)/config-host.mak

Specifically here, the $(MINIKCONF_DEPS) long list of Kconfig
files has been removed from the dependency list of
config-devices.mak.

There doesn't seem to be any machinery for creating .d
files for make to include to tell it that Kconfig has a
dependency on hw/Kconfig which has a dependency on hw/i2c/Kconfig etc.
How is this intended to work ?

For 5.1, should we just revert this commit ?

thanks
-- PMM

