Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB5BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:13:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C14C204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gyrz6DPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C14C204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5rVf-0001bb-Lf
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 10:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k5rUu-0000fE-Kp
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 10:12:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k5rUs-0001G4-TZ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 10:12:56 -0400
Received: by mail-wr1-x441.google.com with SMTP id l2so2177778wrc.7
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 07:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=je6VphbiDfG1JG0+cuv27iYamG6VH0o4d0cYjOIwIU4=;
 b=Gyrz6DPoeJr/WN/VCp9M4bBZFUbkGzl7ofF7jzPYD+bKZYaltRQWYfeCGB+RiZXo1g
 MkVLe8Fx2DGElsB8TnScS6rtsuN8OIFABSFVgEz/QR3YMRfGFrj2+rRNZnuNBhiE1omn
 mnmWsJiU25fw07opHDvhXpybhAw+bztBKojp45YOL6TEDC16vbYnJJZw8y38XcdCpiVF
 Qm0FEMpWG+fdhKWqcuEfCyVDPJ/plcA95LZTvlLzt0TgOGwc8yoyS+PU4qz0HbLo80dg
 4ji71EwZ0smFwzBkJ1UU4sU6s1d9VUxpz1MqwUb5sTbkG+AZEk8XfY8xisUP4ozKxQnY
 g4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=je6VphbiDfG1JG0+cuv27iYamG6VH0o4d0cYjOIwIU4=;
 b=BfdCmbJTc8GO+RyaeRXs5UzDO2PhrTyXjlCSSLlWbSAokLQwNeRcfAB8l1ym+3LHc+
 vzplNHu1C227Isyj7IN2SqrL6acfZcGPeh5jRC8sl2AvT/SnqY48gYTo+HBe/h+NIRMQ
 AEi13aYAjFNM+yu3RbPSlkMbA2K8b5FzBmsNY4YmRXmp3rff15K0F81xcGBFZR1oW1Lt
 P8NwGevYe2w2EHVXDPnWKnQA/AnMRLnbXlpI9Yhn7wor7M6yrMHJMk5+cL0Kzyb61bFc
 dF8ZYb75nMuB2k1AI6I8plQpJY2mlDbvvBU7JD5nBRHeGVo2UVA2atcLOfNiFzwJyLC2
 aYjw==
X-Gm-Message-State: AOAM533se1sLbsr5NpRfrhqbJcf55pLgBi3E2fPoOakO5q4MS2byDeaM
 rEIPWxsQugXX7b2d2J/eV4HwPbapT8A=
X-Google-Smtp-Source: ABdhPJxa77GpuoT+D5YGADRK9bSJpYg58KCZ/FxDY4JcYJQMROGch6+b7JheU3bNTMk+ih3bXUDNSA==
X-Received: by 2002:a5d:644b:: with SMTP id d11mr32901022wrw.373.1597241572848; 
 Wed, 12 Aug 2020 07:12:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g14sm4010686wme.16.2020.08.12.07.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 07:12:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 780F21FF7E;
 Wed, 12 Aug 2020 15:12:49 +0100 (BST)
References: <20200812101500.2066-1-zhaolichang@huawei.com>
 <20200812101500.2066-2-zhaolichang@huawei.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: zhaolichang <zhaolichang@huawei.com>
Subject: Re: [PATCH RFC 01/10] qemu/: fix some comment spelling errors
In-reply-to: <20200812101500.2066-2-zhaolichang@huawei.com>
Date: Wed, 12 Aug 2020 15:12:49 +0100
Message-ID: <87eeoc0x7i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


zhaolichang <zhaolichang@huawei.com> writes:

> I found that there are many spelling errors in the comments of qemu,
> so I used the spellcheck tool to check the spelling errors
> and finally found some spelling errors in the folder.
>
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
> ---
<snip>

> diff --git a/gdbstub.c b/gdbstub.c
> index f3a318c..bbe66b5 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -698,7 +698,7 @@ static uint32_t gdb_get_cpu_pid(CPUState *cpu)
>  {
>      /* TODO: In user mode, we should use the task state PID */
>      if (cpu->cluster_index =3D=3D UNASSIGNED_CLUSTER_INDEX) {
> -        /* Return the default process' PID */
> +        /* Return the default process's PID */

Hmm I thought this was correct usage as s's -> s' but apparently that is
only a given rule for possessive plural nouns (processes' PIDs) -
although apparently it is possible to have singular nouns in plural
forms so what do I know :-/

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

