Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE416C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96BE320748
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ihuhqcgx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96BE320748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3zGe-0001uo-Sd
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3zFP-0000Dh-0C
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:05:11 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50774)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3zFN-0006fX-8u
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:05:10 -0400
Received: by mail-wm1-x342.google.com with SMTP id c80so1232836wme.0
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=jvVGkH0LBNinaxafxZkfuyP+UftXUjgg+H7EUQ6vlJ4=;
 b=IhuhqcgxaztKFm/1FZIJjjmft1BrKDEWQZQ/ez9TKosDmxEB8pEtMaYKwXK/LmXX7U
 zJLQX68wG2IVfNd3/OXqfHGnTd1P2kRlMc+i9S1v02LFdb8afqSv1rWlPRx4KjoSxeTN
 uvQr9rJJsI/i83TGXheFGoMeBcw+zNNvAw96qLGplWQWbJUePyGGj/BX5gfDoGs3ErUC
 P40av2u7X0dJvcZgwbXxQRI7MqoH3eEI42mJ6kAAGsdQbapK2mY6afgg5CgF3hdmExog
 mb9deSotlcFJQ3d9lCf001IgyavyddhvvEd83Uu7TrfCnP951EDhA/EuSYmUjGoF3a8F
 hJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=jvVGkH0LBNinaxafxZkfuyP+UftXUjgg+H7EUQ6vlJ4=;
 b=PzAOk0PwhXHjXkwnhSAR9vWtHtk1BV6z0cIZsfXBwu1eujtVWWi7D7D5hqfkSuFpvA
 yQowLUhhxhlvdFgaPuuHHlbcBYnOBPos4y3l3VI/vbvJqUSrYCxAj8BcgSap10OVl5jG
 tSz1AbsOiK/cgvhStJ+qXJIROBck4y1GMuzknx4iqG7myMlln66U/UsbHypm7aXdgZ2Y
 2WDBACYnRGWf7pIaSR9+jAdxxTw8Y4un9rQsSVbHhAvZABteVV+pnWtdm3Nwc2emedIU
 rsR7XCyQJYQn4Hlhm1qlXSvikYCqiWKK8nUn3nnpSJv2+yXDRP+0/1st4fbqHvVKqb1N
 rCCg==
X-Gm-Message-State: AOAM530UFGjc/UkdsYz2btgbFVu0ngel0gHgDdirkhx6CHx6dFt73Z3B
 Wk7IQT1GMQ4of/+xdtNd0SryiA==
X-Google-Smtp-Source: ABdhPJzmM7rnFsXhxl+j8Djn3ELkHahwh15d6sJb08noS6CqItSDXhxOMWz0UB7HZ/5B8gPE2icONA==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr11882000wmc.130.1596794707505; 
 Fri, 07 Aug 2020 03:05:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l81sm9889502wmf.4.2020.08.07.03.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 03:05:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 764431FF7E;
 Fri,  7 Aug 2020 11:05:05 +0100 (BST)
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <20200807085302.7d7616df.cohuck@redhat.com>
 <CAE2XoE_eMv_=zoEe-v1HiqcKX+FNobKSKzV=9eLkJNivnuYg-A@mail.gmail.com>
 <4e8addca-7400-f1a1-ee56-991def2959ae@redhat.com>
 <CAE2XoE9HzvHOQ8odXwiOw+nsYOkwTK+jue1i-mQ6Mo29T+9Rog@mail.gmail.com>
 <c6059e0c-ed50-399f-111b-4d4b96c80e85@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
In-reply-to: <c6059e0c-ed50-399f-111b-4d4b96c80e85@redhat.com>
Date: Fri, 07 Aug 2020 11:05:05 +0100
Message-ID: <874kpelqjy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, jsnow@redhat.com,
 Cornelia Huck <cohuck@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 armbru@redhat.com, luoyonggang@gmail.com, stefanha@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 07/08/20 10:31, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
>> Any IDE works with meson properly? Does meson have vs code plugin?
>
> I'm not sure what the plugin would do.  However note that even with
> Meson, QEMU would be built with "./configure && make".

One the subject of IDE's my Emacs tooling (counsel-compile) uses a
mixture of "make -nqp" and "make help" to probe for potential make
targets. I assume these are still probable with the meson generated
files?

--=20
Alex Benn=C3=A9e

