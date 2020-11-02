Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA7BC388F9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E4CA22226
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="urTvqsWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4CA22226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZeHn-0006UX-Fe
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 13:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZeGk-00062I-Jk
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:09:26 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636]:33206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZeGi-0005Sb-Kn
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:09:26 -0500
Received: by mail-ej1-x636.google.com with SMTP id 7so20188607ejm.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 10:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TDurXYaDM+ntRMioVlHvoUA/j0IhQnnVxlI4VCKxzN8=;
 b=urTvqsWC15C2LyWIYaOmNweeE+kNMSp4e8wR1y7Ccx/oMlC8mApyGbH3cNbGVxIHf9
 5QGX0S7mqeWxYRGvxTSt9SBwvwx/ROJtoQebhPsfVJHQkZOPVG5RIPKg1EY4AbGBDWVp
 fTml0b174JzczvuUoJGtX6nsIs5MroPJyC9ODm6qr/lwf8TPOc+yV87Q3ZFby4fFFXM0
 RsveZHkNRg6WV5CIoMEGbW5zi7dy3cq04ogvBta64vM1pR+Obb8PdlJ6KAYH/VzolPz6
 yjxxfkZcESG2/9fkZ9+rHky5fOSwdxBE0YWsRWMkf5METU+6ZvY8dMoedPKl82o6LNDQ
 OWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TDurXYaDM+ntRMioVlHvoUA/j0IhQnnVxlI4VCKxzN8=;
 b=WjMSanj5cWUeX2DVCJqU9YeFgtE+6QPYBdNGiB6o+UWfCvi8/D+wSuTt+hjAR812Kx
 o5WqPLQ/zjoIQBY0EudfyqnXNz3vBCdhLXEKw70Yi3SzmNLHy1T0n+9aQbD/Y4g1WM4B
 iSHEyAKgYQZg3n2RQgCO+upbRW7EInW7t1wB30nI7OlmzfUY4VGm52LAppbku5xic074
 ReXeQ/mse7e/Bful4NaQC10aeu/1D9Ub70C1rwM/0QSK3Us7+I7Ri8DajMv0dGvsGRRa
 WUMCreIeqB5NhKZTpsIYLejq9WOjdnVy7hyCTnKvg4b/oeh1U94ROSTxEmwbPbaunneu
 4ffg==
X-Gm-Message-State: AOAM5307cnw++5IrrIj8cl+/mJIgyhgqkAjzM/4uZp2LxPyF1Pjx/HWu
 Ibg06k0KGVL62RSHPQNHVBwyWS+xYfJRHKk5Q+J9LQ==
X-Google-Smtp-Source: ABdhPJxUuY0/uHYLKDhZjHa4T3JgVWeeiAH7QfEUDyjmMWEPcVOERpNSNdY8D335cvp7YK2ebojPj4inaqsqqdEniQg=
X-Received: by 2002:a17:906:af8c:: with SMTP id
 mj12mr15930554ejb.85.1604340563038; 
 Mon, 02 Nov 2020 10:09:23 -0800 (PST)
MIME-Version: 1.0
References: <20200924092314.1722645-1-pbonzini@redhat.com>
 <20200924092314.1722645-43-pbonzini@redhat.com>
 <CAFEAcA_uk5VOeEQNyU9R-1kF9UE-MFpaC+2WMvbRXcwxYNa5xQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_uk5VOeEQNyU9R-1kF9UE-MFpaC+2WMvbRXcwxYNa5xQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 18:09:11 +0000
Message-ID: <CAFEAcA9rNhi6siSndxK1MWEh74G+A7sQ7G_+7BZCeN+ueC+Rpw@mail.gmail.com>
Subject: Re: [PULL 42/92] cutils: introduce get_relocated_path
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Nov 2020 at 18:05, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 24 Sep 2020 at 10:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > Add the function that will compute a relocated version of the
> > directories in CONFIG_QEMU_*DIR and CONFIG_QEMU_*PATH.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Hi; Coverity (CID 1432882)

Also 1432863 1432865 1432867 1432868 1432870 1432872 1432873
1432877 1432881, as it has helpfully filed a separate issue
for each callsite :-)

thanks
-- PMM

