Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52220C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC18C206C1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPUlttRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC18C206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZXlg-0001Br-Ig
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 06:12:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZXfQ-0002mk-T2
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:06:28 -0500
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:41220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZXfO-0001A0-LD
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:06:28 -0500
Received: by mail-ed1-x543.google.com with SMTP id l24so13906958edj.8
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 03:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cFun4X8BiIKg4AxLOSC+4P9kL/vjFc/7S5etlTSF3ic=;
 b=aPUlttRA3aGzLnRAwe9FK0Vtscoycj4iFTBwXQDyqDo9un+/2Six7wsrMk3q1gUd9q
 EcJNO/mwsNOzXZScl7RlVoizVHV3GpN3yLKrTp+RkuUMjUSg0/1uSbjkfFLKiURziwLb
 BREzi0hadhH7p4aWsGxkmgJdqaSvk9D6SXOyM8kXs2HpxdEvlkUH4HWkstn0YOoYrgBo
 QmgaLoPicnYTjzfQhYWaenT03cOPY4hzvQnWUIapR9j0IpTCbFVW2QrEy5cl17ZrpTG8
 Q25r163C1DDaAE6GofuckemoYpHwJiq/isl5+8IKT4yaDQN3dlN5/YzbUPUUIJchzy3l
 pXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cFun4X8BiIKg4AxLOSC+4P9kL/vjFc/7S5etlTSF3ic=;
 b=ojLIAPiHFeW08fZJC95St+aAKQ90JjXTf5+GFxVU6qivC2t45HVNkaSZSUySUayUmK
 KWLVC+n7UKJipWk8yeciOpbwe+gh1AQ0qXxjdgmNeK8oub/qUj+jHpCgsNCv+1CGK257
 KUDbtQeRgi8fOelRuarE0vyxtneX+DVhCXbIVPR0lj7SfrPZUZCowbmSSv41exreJzLc
 G9Pl1GDSBZV1CAYEELwPq6wEhkNY07cSIZ/RWMg1/xdwMR0aCKETlHIHLnNAhE9k7dQ7
 JXFib5b7xC3A+NBlwxnpjLtRH2NonlyV3ji2m+9NmWCc8fB1stHlMorIXJExdN6Bk9oY
 yhhw==
X-Gm-Message-State: AOAM531RDSyTBi6yjAwuCUd2XJCQ4xXxjhTVoAcMb2p4Od+wM1qCuzM8
 C5uYgcPoYAmdd13EXP1lY7r5OznPBhFJRfK6McUOIg==
X-Google-Smtp-Source: ABdhPJykqFJA6TLr2F1sKXLw+9PPAAFJCVU0q0FKHiBmiO6cgLh+YV55zivdHzLbOuTEw/+gV1drcC8dVs9mI5iD0QI=
X-Received: by 2002:aa7:c9cb:: with SMTP id i11mr5778441edt.100.1604315183737; 
 Mon, 02 Nov 2020 03:06:23 -0800 (PST)
MIME-Version: 1.0
References: <2172054.ElGaqSPkdT@basile.remlab.net>
 <20201102105802.39332-1-remi.denis.courmont@huawei.com>
In-Reply-To: <20201102105802.39332-1-remi.denis.courmont@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 11:06:12 +0000
Message-ID: <CAFEAcA9xhfhGToCXk9H+M5=HQKC91o-ED6eWTy32nvjwpFeJOg@mail.gmail.com>
Subject: Re: [PATCH 01/14] target/arm: add arm_is_el2_enabled() helper
To: remi.denis.courmont@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Nov 2020 at 10:58, <remi.denis.courmont@huawei.com> wrote:
>
> From: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com>
>
> This checks if EL2 is enabled (meaning EL2 registers take effects) in
> the current security context.
>
> Signed-off-by: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  target/arm/cpu.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index c18a916766..aaf3671806 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2040,6 +2040,15 @@ static inline bool arm_is_secure(CPUARMState *env)
>      return arm_is_secure_below_el3(env);
>  }
>
> +/* Return true if the current security state has AArch64 EL2 or AArch32 =
Hyp */
> +static inline bool arm_is_el2_enabled(CPUARMState *env)
> +{
> +    if (arm_feature(env, ARM_FEATURE_EL2)) {
> +        return !arm_is_secure_below_el3(env);
> +    }
> +    return false;

You could usefully add a comment mentioning the EL2Enabled()
pseudocode and that we'll need to adjust this if we implement
Secure EL2 in future.

thanks
-- PMM

