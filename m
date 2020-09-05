Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FB9C433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 14:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24303206A5
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 14:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sTjI5pZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24303206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEZCD-0003yE-8i
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 10:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEZBB-00035C-1Z
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 10:28:33 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:42185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEZB9-0004N8-3g
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 10:28:32 -0400
Received: by mail-ed1-x544.google.com with SMTP id l63so8641948edl.9
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 07:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iiOjp8lAjwIRb2ImGuyEi0G0UaI7iZtX5u7UBLV325U=;
 b=sTjI5pZqh8eY7wZPc58o6J9jL41/vL6ImCvloGzMSTAeYUN9sS/SsbqdXgY+Vw1xio
 Sj11bJ6xvsHkHTgh5BvHqNOx2Hjn9/LgCzrD7KsNxhxSgQ03OxsitF0DC5kbLU8XmWih
 XLRIwyKfoX7OOPLqWc1GMrPtjyirPQo8lZRWP2i+A4i+vYmNorO4ZS8aLL0MfdlBJ4Ii
 kqhwsu1TjFI+Jzr3lAr47/uGfUQs1mIWG5joDzVIx3Y03WQVorfD0zYkZUcMDMwqQWki
 33sZUFuR1gQcnfd60OWXUfDh0gBXdADypD7jWVdQ2R3lPjcEnWM3ocw9qH85DzyOEjAJ
 gBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iiOjp8lAjwIRb2ImGuyEi0G0UaI7iZtX5u7UBLV325U=;
 b=WtLXq9tEYTjSjc0Qmzj0tAKBdsP2HgHYXuBpfZU4lYLn4nxuSmnkUM3s7aLhik+OTS
 q4BrSBZApb+Sh0COr6Remr6pWGQfL5g9Q7pciWZyrcXd9i7GYDHwWlOwGh72Eez3lC1w
 Kt0z0nGucx7F/Z9ssG8KjSL2uKJ/c0kR8uHkIdYncI11h1jcwmfOrUXuz9IBVG6Db1lc
 ehSIPNWs9Sqtihc5P2IV/Ejr5eOmZUd24NGDmXQrJBbdANVeKFYO8Jz7kyQAmvNZceXy
 hax11iJ4BkLBV5TkvcbnXBXOqVBfaxB9r0gA2yjXhM0ch7892nN3S7nvZ/oTncOchZEu
 dKPw==
X-Gm-Message-State: AOAM531nHdtx16GDkNPAJvG0virDCRskGVKXtFWpkrBS0Z0FfeGZFwnp
 Gr6Xqr8g3UMdmKO2HCnJ1xWAJuDDLBXmqFHegbse4g==
X-Google-Smtp-Source: ABdhPJw9gM+Kn7CPb9/He0rFM3QKavZ3jsX2e6wcJPb+PLj1+/phRcIdoeTbaNDtY7IBtiuKe27B2XGrOD3A3oe1H44=
X-Received: by 2002:a50:f1cf:: with SMTP id y15mr7032832edl.204.1599316109203; 
 Sat, 05 Sep 2020 07:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200905062333.1087-1-luoyonggang@gmail.com>
 <20200905062333.1087-4-luoyonggang@gmail.com>
 <c71e8760-39d6-6448-40b2-ba4b2468d42b@ilande.co.uk>
 <CAE2XoE_VmhJWasoaZE93A6sJsLJABKNy11AD4hr3TCowex8OFA@mail.gmail.com>
In-Reply-To: <CAE2XoE_VmhJWasoaZE93A6sJsLJABKNy11AD4hr3TCowex8OFA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 5 Sep 2020 15:28:18 +0100
Message-ID: <CAFEAcA-GqyuPv2Rz4R8UOjeVt5t-K_6f+vk__9bX2=aGkTpydw@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] ci: fixes msys2 build by upgrading capstone to
 4.0.2
To: Yonggang Luo <luoyonggang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-level <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 5 Sep 2020 at 14:23, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luo=
yonggang@gmail.com> wrote:
> Who is responsible for capstone?

Richard Henderson generally looks after it. (We don't have an
entry for it in MAINTAINERS, which is an oversight.)

-- PMM

