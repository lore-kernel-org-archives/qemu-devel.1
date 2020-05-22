Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9A6C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 14:32:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ABC9223D6
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 14:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XbJslCjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABC9223D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc8iR-0006Pp-Ca
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 10:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jc8g5-0003i7-9W
 for qemu-devel@nongnu.org; Fri, 22 May 2020 10:29:37 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:35381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jc8g0-00010p-BY
 for qemu-devel@nongnu.org; Fri, 22 May 2020 10:29:36 -0400
Received: by mail-ej1-x643.google.com with SMTP id s21so13306918ejd.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 07:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=4VVcLSFHxTQGow1adThb0vRIPh73heIA+x9HtCgOnlU=;
 b=XbJslCjAKM4hFYUiOyg4RAeTadzDZn7ud+AjDQHruRNOuOySSIbkFlVy6V9Bm/ZkPw
 XtSaCWnCrcIZyGHeSyfPXk4fCtY9vFnREqd+KQtviCLG2otQudGF7zaGUrescMKBrwa8
 d+Uf1YVcLYwwHbP0Va9d3ztqDazCV3Nc64M8Yh1rXoR7ZGwsDkSILFvXCLr8IDCsleJM
 k75VE8oslDR41ObKhmDtm5B58dwjt/EmCZxllmDHEvys0ztdlu9SoXj8b+mW4CmXz2Oo
 mLCHwZKpx24EyX4mNqc/whHWfkAK9C46l6S9TKKvFCJviFj5BpvmUm4K/JLxi7Y1tm9m
 dLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=4VVcLSFHxTQGow1adThb0vRIPh73heIA+x9HtCgOnlU=;
 b=VeoI41EDGOfGquxk1EfKnS630GR/ehRyCYll6Dwsx4vrSynF/gthgWArrjmpZBcdtT
 P9I7Mz9v5Jayof40b9IkbtiNlea6m9vXQU8uXSMp7QL9gFH2VROZRjXbFMELJMlYXIZC
 4rtTM/Ag72kw+RuwB1ACNDMEx44ys7w+y20Axb7O6MSyBOr3VEgMNjB+cLWs+FRSAc2w
 joussKg7CqP/l32CEkt5tOYsYyjAeUfGZeeBXpLmVhY6PG4s8BK/QZG33OUJBqPnZelo
 PzgW2ZSeqPP6WKGO4sEJ65DoAg/62WyGQ7+aX346zOKdAtKvaBzfM4EJOm7eJlGUcZAM
 T6Kg==
X-Gm-Message-State: AOAM533jTo7q/lxb7rf8q5t28PTJNRtiUbwegdAawk9ioKJxvVsBuExU
 2t7L0zxa2yQdD2DRA/3BQ6Al1A==
X-Google-Smtp-Source: ABdhPJzYvEzib+RQ/qnGbVFB2MxSWhJyHGhGmMfgrEFxNL+z685WLPVYeEVDkVy0u9RZZxZBhd640g==
X-Received: by 2002:a17:906:8608:: with SMTP id
 o8mr8082527ejx.274.1590157770795; 
 Fri, 22 May 2020 07:29:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o1sm7345361edf.77.2020.05.22.07.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 07:29:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EDD041FF7E;
 Fri, 22 May 2020 15:29:28 +0100 (BST)
References: <20200519132259.405-1-robert.foley@linaro.org>
 <20200519132259.405-7-robert.foley@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v7 06/12] tests/vm: Pass --debug through for vm-boot-ssh.
In-reply-to: <20200519132259.405-7-robert.foley@linaro.org>
Date: Fri, 22 May 2020 15:29:28 +0100
Message-ID: <87eercdovr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_TEMPERROR=0.01,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> This helps debug issues that occur during the boot sequence.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/vm/Makefile.include | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index d9b34eae63..e22c391a2a 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -97,6 +97,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
>  	$(call quiet-command, \
>  		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
>  		$(if $(J),--jobs $(J)) \
> +		$(if $(V)$(DEBUG), --debug) \
>  		--image "$<" \
>  		--interactive \
>  		false, \


--=20
Alex Benn=C3=A9e

