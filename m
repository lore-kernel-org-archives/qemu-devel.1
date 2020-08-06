Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE22BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 21:04:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91F72173E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 21:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2K4os7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91F72173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3n3d-0006am-Qd
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 17:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3n27-0003kC-19
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 17:02:40 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3n23-0001WZ-Pn
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 17:02:38 -0400
Received: by mail-ot1-x341.google.com with SMTP id 93so27143754otx.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 14:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=twvwAXYUNDVTSkZJ/PJvFN7yNR1MPCyqjMvgNMvDnlk=;
 b=J2K4os7sJzxpkdJoqV0pZ2mFcFz3UGlavJeGAfLuF50ucmR25QnSnd67POAp8UIGDc
 qNwKJqO12Y61XAxIR422goAouvY7ujeLzQPafvKR+O22hcL7Ac9qib3xgT6bBKQiP2SL
 xZni3KW7+oRZU5SV/uDOy3YjbhAqq17YNRVZpR7Q/Nm0gQyEeDar2ZEwJjB9dVhjWlKC
 VjZoGuCl1BJVKbwQzdYesqMAMzeIXULFMeiQMso6adQCxHf6SSKTDhPai/gK1PyU8bzC
 vCKwdySoG9HoNjQDMgP7cS3oXDSCpXinA/ZEiKEMIivn1Kj1c+xO4Bb16zDIj3zK8dRs
 ofpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=twvwAXYUNDVTSkZJ/PJvFN7yNR1MPCyqjMvgNMvDnlk=;
 b=hk1ib9JqAltHPxpmlUeaxAKcdC3wtpfBfIpQW18alnLv2+fCn/7olYo46nLPyUViFy
 M5oSAJw0WaHcJvsfeMU4CerBB7glEfUJ+Ojp/VtB901kxMWkh3JdVegQ927gmdrdP//b
 UpKVcc9Y3+xvfEE8zUE97rmJLJ1Zpx5J0JVoVCFih7GnmHeK4XLD2U2UkLZ1zbpszUGS
 XdaxQG6MmtG6ak0w0nYnZk0F9THEmGkVBC+QinW1keK0zNOsmV7KodH43+MqXGEpLVN5
 2/K1p2EvrBjwIPWKPrax+JRiNAs3aIULYGVyLzEtM+tGVMBIhVaMcuOdfuJDwVJlobAK
 MWVA==
X-Gm-Message-State: AOAM531PBZKLHDM9Ghn2RfsqyfQFVq3VteBICw0Zd9q1qYxjEAyIxfiy
 oIJYG9fn25P96kYR9p7KHEetYjY+KYjisyIs9YIVLA==
X-Google-Smtp-Source: ABdhPJwKUH22clWQzq1CC9ktT3Z7m9ySEel+hNMoMG9dthGtCAm7FPRq43t3EGd5WFaPhjL2imlwIa01ydlgR2mVqYA=
X-Received: by 2002:a9d:39c2:: with SMTP id y60mr8938620otb.91.1596747754131; 
 Thu, 06 Aug 2020 14:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-109-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-109-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Aug 2020 22:02:23 +0100
Message-ID: <CAFEAcA_j2N1ee3Aqjcw3cKF1ksJ9Ls4qF6eXBH058A8oNBObfw@mail.gmail.com>
Subject: Re: [PATCH 108/143] meson: convert hw/intc
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 at 21:10, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Compared to:

> -common-obj-$(CONFIG_HEATHROW_PIC) +=3D heathrow_pic.o

> +softmmu_ss.add(when: 'CONFIG_HEATHROW_PIC', if_true: files('heathrow_pic=
.c'))

this feels pretty clunky. Doesn't Meson have a nicer
way of expressing this kind of thing? It's really
common and I'd hope that a build system language
would provide less long-winded ways to write common
operations...

thanks
-- PMM

