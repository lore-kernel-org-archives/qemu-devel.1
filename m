Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3016C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:14:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB9C207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bug1KHu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB9C207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtoAb-0006fl-OA
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 04:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jto5r-0004EY-0Y
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:09:15 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44177)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jto5p-0002ZR-FH
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:09:14 -0400
Received: by mail-ot1-x344.google.com with SMTP id 5so3584712oty.11
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 01:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tdo/JqiaNsp9LECei1PvVs6KFP17g9QYXiYUTy1eg34=;
 b=Bug1KHu7z7KA7ZPo1RdFLjFhbEL0YNFrrgMHwR5MOd3s7IsLiLwQpbFPbhXkZL4cfs
 YHEyIiWUHZul43ZXaDbvWNuC57y5P308fDFjzjGcL+Z3DRmdwoUjDd/Qj4gK7K7YOOQs
 OYrJJ/366U5OdP9ElZTQcwhH47xpvWKf9WNFHtqRWN9Ry2HKsaeHXhrA43xuv3yHDicP
 LCHZiCiFM/M2EUCTnl4qf4hOsN0b0OJrw1FIXi+SyQUnQFcYrPGHsrHtvuKvX3GqaNe4
 PilQdV+AcOtrDJ51wzyNOg+Al1b07WfvBU2QIiyqkCzqCMjxA5Ezho88N9m1jcmXRRNl
 +tJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tdo/JqiaNsp9LECei1PvVs6KFP17g9QYXiYUTy1eg34=;
 b=sddmEE7q5eOVvByvV28OF6f8rQmeZtJLd5/Lu+zz5t3hUus/M3+hMUsM99XleadZxR
 aMN6x6ASYE08CZg/89jxJaBAPccjJMjDnKK9E1Js64TTcPsKyxog7E0Ug20cEvZMIMY6
 zIOrRBIqrkSQRmJrdo5PYu0A8zDwgaCvNhR1odCypvAzUL+4TjH//l9Juqbpfd17fV2y
 efP+bSUzLcDmEjn2yGJ0GZB8WQhrwEFv3ogDNkf6eoE3B4tk8hJNmXkYJqwWfUBzYFUf
 ud3I5ya5qcZaAclHiFrUjb0Glwoyq3CFQYr8pxywcComajASm8K0BK3oIt1XXznn5f9o
 r35w==
X-Gm-Message-State: AOAM531lNi5GDou2/Pb6sofFduX06FADw2TjjeIbZ6tNFnb8tYM9T14v
 Zggj7qeDo3IzV0LVPQ/haSsThSgDLlTiCcQdWv7crQ==
X-Google-Smtp-Source: ABdhPJyCOKz4+fCcfU7FziXjftQDfDLlEt9UYpLp7XARkD7cMVjyn1M95PlwaAQR/wuDkZJ5MzOh1BJuR5o4+N/gwZg=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr54747359ota.91.1594368552071; 
 Fri, 10 Jul 2020 01:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200709184728.2051009-1-marcandre.lureau@redhat.com>
In-Reply-To: <20200709184728.2051009-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 09:09:01 +0100
Message-ID: <CAFEAcA8M0YdS8NpsSSFbkn-sqDU=bSKrA0SnX66o_E_2OnHj1Q@mail.gmail.com>
Subject: Re: [PATCH] Remove VXHS block device
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 ashmit602@gmail.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Jul 2020 at 19:49, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The vxhs code doesn't compile since v2.12.0. There's no point in fixing
> and then adding CI for a config that our users have demonstrated that
> they do not use; better to just remove it.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  configure                        |  39 --
>  qapi/block-core.json             |  22 +-
>  block/vxhs.c                     | 590 -------------------------------
>  block/Makefile.objs              |   2 -
>  block/trace-events               |  17 -
>  tests/qemu-iotests/017           |   1 -
>  tests/qemu-iotests/029           |   1 -
>  tests/qemu-iotests/073           |   1 -
>  tests/qemu-iotests/114           |   1 -
>  tests/qemu-iotests/130           |   1 -
>  tests/qemu-iotests/134           |   1 -
>  tests/qemu-iotests/156           |   1 -
>  tests/qemu-iotests/158           |   1 -
>  tests/qemu-iotests/282           |   1 -
>  tests/qemu-iotests/check         |  10 -
>  tests/qemu-iotests/common.filter |   1 -
>  tests/qemu-iotests/common.rc     |  33 --
>  17 files changed, 2 insertions(+), 721 deletions(-)
>  delete mode 100644 block/vxhs.c

Could you add a subsection to the "Recently removed features"
section of docs/system/deprecated.rst noting the removal, please?

thanks
-- PMM

