Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97948C4346E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B61216C4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w9p8H/cK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B61216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKRN2-0001xc-T5
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 15:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKRLF-0000Qb-Dj
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:19:14 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKRLC-0004FS-LM
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:19:13 -0400
Received: by mail-wr1-x443.google.com with SMTP id a17so13972164wrn.6
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 12:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=p/46lf7KgoRWxFjDc8zVc/mnSwdV96dR3E3d2SDzyV4=;
 b=w9p8H/cKCsJCnrRIhXpnMHSdta0hlx9iqE3hdNSMkDatvW+3xNwjMnIovGAuFp+A1G
 gnXX4OD7IrMP+k54jDxsJUWDAXhRkdbHB/KL55L6MkX0eRZ6PqEkyiKrHHIzUhanHZVa
 uGMxyVW+0g1I4ClxhmYMUHV+WSKKpeVgSqt0PLT0iEFTaAK32OiUMgkLLyTToAayK9w8
 lBeGZ2mi1egm5zdME2sMjKSGlD/g9GFgY/Fb/gHw/fLdfyBCD6kzcCNAHFOwyZY3UURn
 BqPQ0WP/ZQPTODt3TMdC2vkXk83I1tOTbKm0LfbQyCoViIiDCcNPty4pdgJjZME4g3MW
 4i2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=p/46lf7KgoRWxFjDc8zVc/mnSwdV96dR3E3d2SDzyV4=;
 b=jn8kBfoYYDBPMu6sJa4vzS+KXfCgOR+pgTgGtjenzjsSCJQ9keqk+XpGwkDKRIU7gu
 14v3sRbG7S7Kox/kOB1mTcAHiEFnlWkqNfxR6sh0AbZ1BbHDBTxJElxnvPKhFUgJaitC
 C+RyXNzTkaM+7EyLNdqw/sc3av4TWU1OIEc+3LRafDBSsRpRiGpWqsvys7nyaF2E14G3
 pyiyX5lf05f8gK4O2xTkUnrFRZC/xiOuCxwxVc9N6Ga/F9OM1xuM3sOgXtIrW2wXwwAz
 GUUtdu+PPYE5Ka/Gpf2gMReo8pddcyE1tPOnoC5tFJ8HxvgJe5ajj42CQjvb8WBJr/UB
 7+ew==
X-Gm-Message-State: AOAM532Nrzr0QQ6gooQ2T7i51nuwAM2uqHf9rRxP2KNciBjzP9NIIqq3
 58of2KJwCvXc9pbtHsdvBscd2lgvkdcM3A==
X-Google-Smtp-Source: ABdhPJzcNWJjsvhPqxKKYxKNvymO/bcmBVf5w1z3emQRenC/4tqafTRlZ7VLe5phfKYnIShkpNPILw==
X-Received: by 2002:a5d:4910:: with SMTP id x16mr1434916wrq.204.1600715949310; 
 Mon, 21 Sep 2020 12:19:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 185sm770965wma.18.2020.09.21.12.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 12:19:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 48D241FF7E;
 Mon, 21 Sep 2020 20:19:07 +0100 (BST)
References: <20200921174118.39352-1-richard.henderson@linaro.org>
 <20200921174118.39352-4-richard.henderson@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 03/11] capstone: Require version 4.0 from a system
 library
In-reply-to: <20200921174118.39352-4-richard.henderson@linaro.org>
Date: Mon, 21 Sep 2020 20:19:07 +0100
Message-ID: <87ft7bndjo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> We're about to use a portion of the 4.0 API.
> Reject a system library version prior to that.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/meson.build b/meson.build
> index 4c92b43fe5..114b136129 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -613,7 +613,7 @@ if capstone_opt =3D=3D 'no'
>    capstone_opt =3D false
>  elif capstone_opt in ['yes', 'auto', 'system']
>    have_internal =3D fs.exists('capstone/Makefile')
> -  capstone =3D dependency('capstone', static: enable_static,
> +  capstone =3D dependency('capstone', version: '>=3D4.0', static: enable=
_static,
>                          required: capstone_opt =3D=3D 'system' or
>                                    capstone_opt =3D=3D 'yes' and not have=
_internal)
>    if capstone.found()


--=20
Alex Benn=C3=A9e

