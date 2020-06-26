Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26995C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:16:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4392208C7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hoHReGnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4392208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jovhr-0000QO-8S
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 17:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jovgx-0008Nm-7x
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:15:23 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jovgv-0006wn-Co
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:15:22 -0400
Received: by mail-pg1-x543.google.com with SMTP id p3so5476456pgh.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 14:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TnsxSYtlyD5UdfYpwfgVJO4ttCMw5H2Cc++Mk71mCI4=;
 b=hoHReGnX3ahhebK/9Px/YPKbYInGaSP+LGvKhxmFxC2k5pCGA+8guA/TDKiitQHYzI
 AXFN+0Cq6v5rEzVomB5WooLpmP3UsqMtKCuIRzUeCK59o10d7fysagjPJSzG/OMPhwak
 h06YaNYHI5BTnrLGUC1ksDKBgLksEzOD5Ack/b2PRueXAwq2mboVHGQWAJSrTU5omUCh
 h/uJPfLZLxP76kv965RgImlcyepzifQZ2yx+qpHxZN2g9/wCybxl885lO+3kwMOgSmRe
 6ZT0mgntt8zb+0i6RD/3LokuJ0Rf5XEV3su4y0BDSZUfyj18xrJST2NPkQu5xkhc0fIq
 2zEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TnsxSYtlyD5UdfYpwfgVJO4ttCMw5H2Cc++Mk71mCI4=;
 b=GqBgjvFgme8StPnOQFPnO99M4UHvPCM76dAz/vT6SupqZnCr+6PjdNeRZzut4tRmQ7
 qtr/8Cj4xmD6wnj1a540Z4uL9xO8BO8diaTepvqzFXSxLIG4/uWfL5KaSapHmFVZ4OPx
 v01nsQgxCN43TaUZfksBA6aRSsf1IpsRacvTixxWz6F5C6pMDxMExR/PVXoF5/LFv4nm
 eCuJMZhYBIPKYNvT0a3/cc2KpTukYiaB0k4Z43NFq/Yoe7Ry8vrvgQwxXIGPTKCVDZ6s
 JSL61UroVL1YBmrsuHeGQP5nNevOil3n/iE2V0dTlBfskUFNo11qCeTh9iIOAAExJaFw
 LrGA==
X-Gm-Message-State: AOAM533LF0fNgx+N4B/7np1ekXfjpzEe4ex7Z6Mcv6ObJX2UGM+Pfrlc
 MQ1mZ+lDr54/GVsbQtuD9gBghQ==
X-Google-Smtp-Source: ABdhPJxVErUgS9PceqHZNqMIEbnAMIuoq93wtlHFFl//r+xz5F6Ue5KrHxJEUt489yHF+8S/V1/hXA==
X-Received: by 2002:a63:3d42:: with SMTP id k63mr617268pga.330.1593206119722; 
 Fri, 26 Jun 2020 14:15:19 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id fv7sm8550561pjb.22.2020.06.26.14.15.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 14:15:18 -0700 (PDT)
Subject: Re: [PATCH] hw/core/null-machine: Do not initialize unused chardev
 backends
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200624105611.1049-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <26bed6d5-cbca-bf97-f44f-5bb4ecf6d91c@linaro.org>
Date: Fri, 26 Jun 2020 14:15:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624105611.1049-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/20 3:56 AM, Philippe Mathieu-Daudé wrote:
> The MachineClass uses an inverted logic (inherited from the
> PC machines [*]) to create the chardev backends for the default
> devices (see commits 998bbd74b9d..aa40fc9c964 and ac33f8fad14).
> 
> As the none-machine doesn't have any hardware device, it is
> pointless to initialize chardev backends. Fix by setting the
> 'no_defaults' bits in its MachineClass.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/core/null-machine.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

