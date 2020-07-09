Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70061C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FEDD2073A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVU9JI36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FEDD2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtXlm-0004zZ-Gj
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 10:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtXlE-0004aU-QA
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:42:52 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtXlD-000451-BW
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:42:52 -0400
Received: by mail-wm1-x344.google.com with SMTP id l17so2115248wmj.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vVUaXQnGNVtO5rchH5MPobalxu6xwpyy7RUg7ZiViho=;
 b=bVU9JI36PH9V9pz/VJ2EUVwEClwb+Lx6Z5GUEw1fNx7XYy6p4ADidspx5z+MamD6Da
 KPfOgXwiR1XekEEnspIq1Lw3Qvbsd5EZAcGcga7tpuU495k5WnVefDXG0HXSS/kPywe7
 QOdbSfrGRq8Mdg3SL07Vi+UBybDuixu8+zDhRhZ9BicbqkTTdBbf69OPUPuc5Cbh9Q8K
 +ROcjvLyt9F9pCziak9CdG8Nmp2DgGYjOovdnLrSapBKbIAwiWUAvsTrk7EASMnAh+wL
 Xw9bpNDQxEzTkp3ctcjoB9Ny0arolGzE+LKzrMeKpD9htfaktckTQlJv8wk2Sb8FjYKA
 UtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vVUaXQnGNVtO5rchH5MPobalxu6xwpyy7RUg7ZiViho=;
 b=a6m4ZbVyj7lpgbvEqIetVIibSENYVR62bZ48JCxjOeEUiR9lD7yx8XQzeAP/iW6tPC
 3FrWSVpjgsjQ3bNaMWx6q26IvtWNXy+AUBd3CFTEKI/JKlA5sRZRjJIo8IVGcucL1EiV
 rD8NQfx3AjeYY/84yLtQkSRJWJBBmRv5uw87ZUB3kkwUBazh07DioMuPWPeP/PGHMSg/
 AaJrufUAsJlRJhTwecUOsZ+ps4ue3rnUrElXtJgy3o7zn4Ws0BbxzZC1VZTmbwXaIfRk
 b3SOPe1qZuEMyRlcDqC+6E5rEPd9Gi01qUwTQI4dPGrU7nMyaxVl9Cck7tGVJ6ngNqAm
 lIgQ==
X-Gm-Message-State: AOAM532UWfDuho9wO7pHxPNaCQFkSk/PTJcX1hcNr/pg/hbOf/kmEO6z
 gfSzEilJqMUQPWs9Na8L51Y=
X-Google-Smtp-Source: ABdhPJzNJPdPsjR6hhmwtZmL2Tc5a8kJ1oz+meoElaP6vMgYb2XuKHnJx/QfVjSMh3e5vteJIKcxww==
X-Received: by 2002:a1c:bb89:: with SMTP id l131mr322965wmf.125.1594305769904; 
 Thu, 09 Jul 2020 07:42:49 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id c136sm5298706wmd.10.2020.07.09.07.42.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 07:42:49 -0700 (PDT)
Subject: Re: [PATCH v1 09/13] target/sh4: revert to using cpu_lduw_code to
 decode gusa
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200709141327.14631-1-alex.bennee@linaro.org>
 <20200709141327.14631-10-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <53ca2ee2-9c14-aeb2-d88a-1d1836e3cf9d@amsat.org>
Date: Thu, 9 Jul 2020 16:42:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200709141327.14631-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, richard.henderson@linaro.org,
 robhenry@microsoft.com, aaron@os.amperecomputing.com, cota@braap.org,
 Claudio Fontana <cfontana@suse.de>, peter.puhov@linaro.org,
 kuhn.chenqun@huawei.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 4:13 PM, Alex Bennée wrote:
> The translator_ld* functions very much expect us to be decoding one
> instruction at a time. Otherwise we will see weirdness such as:
> 
>   qemu-sh4: warning: plugin_disas: 6 bytes left over
> 
> when we use the disas functions. For what SH4 is doing here (scanning
> ahead in the instruction stream) this is the right function to use.
> 
> Reported-by: Claudio Fontana <cfontana@suse.de>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/sh4/translate.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 6192d83e8c66..919da72a0c98 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -1915,9 +1915,13 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
>          goto fail;
>      }
>  
> -    /* Read all of the insns for the region.  */
> +    /*
> +     * Read all of the insns for the region. We do this directly with
> +     * cpu_lduw_code to avoid confusing the plugins by decoding
> +     * multiple instructions.
> +     */
>      for (i = 0; i < max_insns; ++i) {
> -        insns[i] = translator_lduw(env, pc + i * 2);
> +        insns[i] = cpu_lduw_code(env, pc + i * 2);

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>      }
>  
>      ld_adr = ld_dst = ld_mop = -1;
> 

