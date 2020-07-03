Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86031C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:54:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 533A320870
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PL2jWyzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533A320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrM8f-0006TR-KT
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrM7N-0004mJ-9P
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:52:41 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrM7L-0000ta-OD
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:52:40 -0400
Received: by mail-ot1-x343.google.com with SMTP id c25so9125817otf.7
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 06:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QrnTEd+QEvPrsXhOfKMJN36kN5dABOeyqo4GoYHhfog=;
 b=PL2jWyzBT0zYogzk15TB9sjj+IZCLD2ZgbzefED4yt/SFgFlTYSsAN+yiX15/7PRCQ
 3d1iSxLoVJfVxtqfw5S3c0nrVmwBcdgVC2hh6svVbjl/QUAFnu4Tyrbgx87jASVDf0Nu
 ED7ikGKRuWiFI5iPM9xc3LGNqjCd0sWQ8+0k5Mp8cSPQKpmSlYiI+tSublXwAaHFUgIc
 +bh1IXrvo08XQhglqQAVGYUQOnXUcWA+4CWzOc1lHSxQHtef7tZ2qtErArchZo2oeIzk
 ZtAXEJe0kREoVd++KQd7aH3LPfUn0MfdUNx98Zu1ceAzZ4HY6A0WPqGnucuWWwmRdtXT
 K8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QrnTEd+QEvPrsXhOfKMJN36kN5dABOeyqo4GoYHhfog=;
 b=JGpnHzXVUNV7OpAQhb1mfIJZRuzCPALJPNKeeAHAPWKRsNFYinXmscY6ok+ecYckOu
 47qPdU28jZeLCECT2+A8lIlDCx5DKh0v28v+bjokc3y/ldgwLNuYcBWWdKWBtIKhUxX1
 i2NpKX+kn+qtsS09IfSFjRXj5uY2jorHwUtaknkdhviK70a01dB142j6WgVEW/1ZyiWc
 hJK0lYUVchufoEoXnvkYahjxFb2T6OX37yBfJUx1VYnXCXRd5kmLzSYESWkUHhnXhnq3
 cbncYsvbvwzbY887cG09em87dtUm8ygwjhB1yZyGMkV7ujtj/iWeN7/ItG4AoPdRH+Sb
 uHgQ==
X-Gm-Message-State: AOAM531+bYvi3lO/k3Uy4H5T9vbWEn0GvNv58j7EAJmavW5G4GY3D8RR
 1K83vhLvQBTtq/cW47fh0pjnVerjSemenrRfJ3Vb9g==
X-Google-Smtp-Source: ABdhPJxKv8zYmfFwXf8EJkVGU0PJLDe/BfhqZfozllUQiXiobusUmeJJhiowynu0MZNu8UTya9GkBouqvthTK6c3BNY=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr23290967oto.135.1593784358577; 
 Fri, 03 Jul 2020 06:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqzZaXorKXQKXRNue9bhbrE3iawtM6EHNUVjGOuSayuvAw@mail.gmail.com>
In-Reply-To: <CA+XhMqzZaXorKXQKXRNue9bhbrE3iawtM6EHNUVjGOuSayuvAw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 14:52:26 +0100
Message-ID: <CAFEAcA-xqdBJS+yd5AYbhqzZEd7ZxfqpDQpXAcXE3pdZrMDVyA@mail.gmail.com>
Subject: Re: [PATCH 8/9] Skipping sys/syscall.h inclusion as only used in
 qemu_signalfd anyway
To: David CARLIER <devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 at 01:49, David CARLIER <devnexen@gmail.com> wrote:
>
> From b821b7e9bbf1f327058ee858a92c7a7ee6740e63 Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Mon, 29 Jun 2020 22:20:39 +0000
> Subject: [PATCH 8/9] Skipping sys/syscall.h inclusion as only used in
>  qemu_signalfd anyway.
>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  util/compatfd.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

