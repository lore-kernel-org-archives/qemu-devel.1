Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73812C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB1C20721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB1C20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVYJt-00060N-ET
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lwhsu.freebsd@gmail.com>)
 id 1jVYIs-000556-TA
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:26:26 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lwhsu.freebsd@gmail.com>)
 id 1jVYIr-000110-W3
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:26:26 -0400
Received: by mail-yb1-f196.google.com with SMTP id b8so1150276ybn.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 03:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=E17RNeAf4MBZIQQPpmt1wwqpLY6INEh+p/cWtWoJ7Xo=;
 b=dDwYF02jJtOlmUdQs2QedSXVTl2Va9p5/5EUuBLaY8+CwK1PfiMCs9CIV1OEsqOscw
 uZpqkGCNr6XjgUXoddSfLm/SMR70ZrIavEzSDfueaoLvSS1gy4SI6GGnrCAnoUzpZcGq
 RvAEloZ8iudmLXP9xRXEojufwuqbK0rtQJDc8RJdSO7L8YpzFYKVrLIhbT1RRLFyk4Ss
 pPP2YGVvd7wbxpKZIqFVg1kT75fn9MFwC4OyuR829cUym2e3MWHLEj4QDFIIlAMUWsOJ
 1TKKTzjuhRuIPBTmIepxxTmXKVFE8mp76nXMuOJzJrIHVL5SAa0f8/glAJBiwCokSl5P
 4cDA==
X-Gm-Message-State: AGi0PuYJ8dUY4kurekbkOtXBIKHG4w4FkIaGj2uVMHeD6s6u2sRV6P+A
 ZHynh1s2T3tqpDey96Xdr+Lep//Xu57jnaMHQ/w=
X-Google-Smtp-Source: APiQypJWqPA2tr927tXxB8Un67O9ZZ3TNdhHWpWR3CP2V0UeE6nap8xFjj2wBON6uIlghT1j25JinKivO3i677vt/CQ=
X-Received: by 2002:a25:d7c5:: with SMTP id
 o188mr25001549ybg.241.1588587984490; 
 Mon, 04 May 2020 03:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200501111505.4225-1-alex.bennee@linaro.org>
 <20200501111505.4225-4-alex.bennee@linaro.org>
In-Reply-To: <20200501111505.4225-4-alex.bennee@linaro.org>
From: Li-Wen Hsu <lwhsu@freebsd.org>
Date: Mon, 4 May 2020 18:26:13 +0800
Message-ID: <CAKBkRUzicxphjjkkxdgzB3cDSv=AszD5V4X499jT2BjiAaazGw@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] .cirrus.yml: bump FreeBSD to the current stable
 release
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.219.196;
 envelope-from=lwhsu.freebsd@gmail.com; helo=mail-yb1-f196.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 06:26:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Ed Maste <emaste@freebsd.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 1, 2020 at 7:15 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
> Hopefully this will un-stick the test which has been broken for a long
> time.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .cirrus.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.cirrus.yml b/.cirrus.yml
> index 90645fede6..f06f5af2b9 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -3,7 +3,7 @@ env:
>
>  freebsd_12_task:
>    freebsd_instance:
> -    image: freebsd-12-0-release-amd64
> +    image_family: freebsd-12-1
>      cpu: 8
>      memory: 8G
>    install_script: pkg install -y
> --
> 2.20.1
>

Reviewed-by: Li-Wen Hsu <lwhsu@freebsd.org>
Tested-by: Li-Wen Hsu <lwhsu@freebsd.org>

I would be nice to also add this patch:
https://github.com/lwhsu/qemu/commit/ac699f79b4d86d8195d76c3befada65ade449c=
c0.patch
To prevent problems in the future.

The error was due to the pkg version got "fixed" when building image,
and was too old when VM got provisioned, then it cannot be not
compatible with the package repository. Ref:
https://lists.freebsd.org/pipermail/freebsd-cloud/2020-April/000234.html

Best,
Li-Wen

