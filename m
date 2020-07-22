Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B94C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F045320787
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxatE4Sd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F045320787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy8OG-0002ur-Ac
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 02:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jy8Lh-0000TJ-96
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:35:29 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:44875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jy8Lc-0007lp-9L
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:35:28 -0400
Received: by mail-ej1-x641.google.com with SMTP id ga4so950532ejb.11
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 23:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ljySE/dOrg+f6q53LdCSkpQXUiABIRqtBLwhDuj/0ds=;
 b=PxatE4SdtkftVLqfFZgbW0t84MLmZlB/a38Ubv/49ouuMoOC9COktbwpOZP2uLtSSs
 /YsscTu4DLlAhoF8CQ0bBSFmKEk9lLqbySMU1A8YRVsNyYrCgbq90v27RBu8sELTNaO0
 /g+Ptwoz79nhjqOMtQ6DIinuK1OsvhzvGJgIv+DmMHM2Fkj2Z3IIsXArZWufvMbFJxZx
 4EXxD5IKkF19RnGaE3e33dqg95eGtlB4ly4G4qmHt5LMBXQm3XgVMttA2xfwyAIeCr5Q
 7ToDOaSHCy2H93fMZLZOyAu7fsiOJPq5l4ZQs+v+b8HvpP/tPwY6P3hKk2QdJsL279dR
 Ko6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ljySE/dOrg+f6q53LdCSkpQXUiABIRqtBLwhDuj/0ds=;
 b=Qxa7U4icV1nhYhHAgAYcx+XOgRuhZQRWe73n/37C92VzoBJCCS2KMBfGfWhL84/W00
 lWkDHSAM4O1fFwvrgmufkr4nRWHaN6vnSoBW9gGC4x6oyT1h1cLaUc/Nj3dDWLN9r0og
 uc0Nx6uMIzDd4Ewvnc2L6ur1pEleu6zvGZyiOIrohpC2c+L6T6aqzSFwheVxSRsRO3EW
 eE/P15ZykpRiakzAbi/7gJQXhfJ93qnW24sRJ/zTTx0t3L4KXHk7GlHmsY/FUjf4A0xo
 LCs/9IUBtcNKDaetLaKkmcdVRgBulGi8jrj6sxFI6Ju0tr2qmPY57seiSUul+siImiuK
 s9sA==
X-Gm-Message-State: AOAM53352Q5dFFcPCrxDu4Q3vIs+3QKkT/nPTBWd/G4gTacUgh6S5hSb
 tBjm/lGJDh9pWbxLXS+4Pvk=
X-Google-Smtp-Source: ABdhPJzefB0tWkajFgnaCbCa0CugBBdz2dq6HgJpiQxkygFqDu8OQF2s4ohlhXo+KL7jiuXhE5JgcA==
X-Received: by 2002:a17:907:1189:: with SMTP id
 uz9mr29527161ejb.478.1595399722253; 
 Tue, 21 Jul 2020 23:35:22 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id d23sm17778561ejj.74.2020.07.21.23.35.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2020 23:35:21 -0700 (PDT)
Subject: Re: [PATCH v2 10/12] tests/docker: fix binfmt_misc image building
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200722062902.24509-1-alex.bennee@linaro.org>
 <20200722062902.24509-11-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3bfa19b6-1da8-1ced-2c5e-87a8650d25e2@amsat.org>
Date: Wed, 22 Jul 2020 08:35:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200722062902.24509-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 8:29 AM, Alex Bennée wrote:
> When we updated the arguments for docker.py we missed a bit.
>

Oops.

> Fixes: dfae6284

Fixes: dfae628459 ("docker.py/build: support -t and -f arguments")

(see https://www.mail-archive.com/qemu-devel@nongnu.org/msg711059.html)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index a104e9df281..9119dff97de 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -78,7 +78,7 @@ docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
>  			DEB_ARCH=$(DEB_ARCH)					\
>  			DEB_TYPE=$(DEB_TYPE) 					\
>  			$(if $(DEB_URL),DEB_URL=$(DEB_URL),)			\
> -			$(DOCKER_SCRIPT) build qemu/debian-$* $< 		\
> +			$(DOCKER_SCRIPT) build -t qemu/debian-$* -f $< 		\
>  			$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) 		\
>  			$(if $(NOUSER),,--add-current-user) 			\
>  			$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))	\
> 

