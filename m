Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D445BC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:45:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5533820738
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mpw3dBJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5533820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLUMd-0004nH-39
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLU0g-0000Au-8d
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:22:18 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:46352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLU0e-0006eT-0H
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:22:17 -0400
Received: by mail-ej1-x62a.google.com with SMTP id z23so5251067ejr.13
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=slPG/S0MtQpwq1K+pNBL57CNsqF+eiWE7QulASXCjhs=;
 b=Mpw3dBJWrEgaqXw6gpVt3iONa9kZZY9vI6y3XL9B6hQZHeWqksW83516JwEThnv4Ek
 HjGSPclv5/0uEgUrCl37ezKbQs4SS5RQQH9HEFYf5VcFkzpr761s/FN7z3XXo7WsDNVe
 YXR5z6l2/wpc1w+MieJJQqfx2MHqpbvWMK1dvfZwfgE68rnCN9ulu4htJqARAmpEU8Vf
 5XYgcvIm/ee0Q+DGxivsFzF2u5udeTnxhjWQ7fETsMlNgF/C+eZbRfC0oD8YQjf65P4a
 7KNHUCkxFh4k5jxnNPq7gUx67QSYW/DsoKLhn37LDed52wkgnbWSXhLNkSgzgJ8UNtbZ
 kxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=slPG/S0MtQpwq1K+pNBL57CNsqF+eiWE7QulASXCjhs=;
 b=PUMlmdd472I6MLPrJV1ap+ggY8q0OfgD62XxrItYudyY7j2O6OxW81O9FUgb9xHdFW
 9A9uSlIsGAFxC0m8mCfQbRJtn4BbYeqFsON0mPg8Mn5v4OAcwK5Xc4xffEBTkfdPo45K
 zN3ERW5DNbAFeaUU+pUMReTMBKh1xNI+mExcGcFQ/ExSI49jokopMy2AqLcTqnoQFYgo
 SjL3HcTUnuJ6o8pAMNhB5/Khn28Iitjp9SLGZWI+9l/5ih+8Ul6IvMmn3OIH8TJRwsre
 HKwc3Exh/vcQ/NdPgypNYRKiMwWaicu+QYQfhjmjrgf2Ni/EtCt2BESPIy8Yz6tyhLZj
 Miaw==
X-Gm-Message-State: AOAM531IoWTvaCNLb3hTCVttlj4t1KFjfaJwbjQ8gTmkYt/qxQ/3BVs8
 GDD8/OJXY+5VaYHFGhZXNI45aBbLCXYP1wsGDRPpeg==
X-Google-Smtp-Source: ABdhPJyCRzUHcFV31dGPj8rk2j/K6jQFCtmAX9MTTC9glRkI6rzlikrt8SKW1zMSSWZR+2KcaUXfMrWqL+t086xEU28=
X-Received: by 2002:a17:906:d936:: with SMTP id
 rn22mr742249ejb.4.1600964533615; 
 Thu, 24 Sep 2020 09:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200922222542.2354748-1-ehabkost@redhat.com>
In-Reply-To: <20200922222542.2354748-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Sep 2020 17:22:02 +0100
Message-ID: <CAFEAcA-n7Wk_je_WQVnE3RR+V1xfAujyCzjZq6JxBUg2OTZBQQ@mail.gmail.com>
Subject: Re: [PULL 00/11] machine + QOM queue, 2020-09-22
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 22 Sep 2020 at 23:25, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 834b9273d5cdab68180dc8c84d641aaa4344b0=
57:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-for-5=
.2-pull-request' into staging (2020-09-22 15:42:23 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 418b473e8f586247475e8adc5d048598e5721361:
>
>   sifive_u: Register "start-in-flash" as class property (2020-09-22 16:48=
:29 -0400)
>
> ----------------------------------------------------------------
> machine + QOM queue, 2020-09-22
>
> QOM cleanups:
> * Convert instance properties to class properties
>   (Eduardo Habkost)
> * simplify object_find_property / object_class_find_property
>   (Daniel P. Berrang=C3=A9)
>
> Deprecated feature removal:
> * Drop support for invalid topologies (Igor Mammedov)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

