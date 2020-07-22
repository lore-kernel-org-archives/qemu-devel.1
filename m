Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423E0C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA612065F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OB3G+paD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA612065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyHe9-0004U6-6b
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 12:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyHcu-0003Yh-G9
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:29:52 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyHcs-0006VO-T9
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:29:52 -0400
Received: by mail-wm1-x341.google.com with SMTP id p14so2099620wmg.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 09:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+rG3qvT7ySzAQUCoeVQPFrcWS7ra7WD2Vh84T2cZ9Bs=;
 b=OB3G+paDppI2H/szTjq4diWkRzxzqUBxGTM7lPj8ZdXpNIXmHOt4wn2XcjX2RUDzNE
 vBR/3/du4Qy92DGdVUygAPkYngeAK8WxRCNSb5zRrYcMYUStvNQkF+RZOeeE6BoZXFik
 SIelJQaJHxySkcsRcwpakYQjxphdSnj155+Tvt2QigrOg9MyYuZRJKG/dzYdab1DSotg
 zOoxJ1eNiAQzW5h/BnKECaUmceh56DIyIsSZgWBZMjBQYuOXtAHuCtuinw/gjBapypmb
 c3yDLeZrGyXiv3QHs+2hztHkimpLQWZjJP7V5I372MmbRnLsgLuicU258HRZ/xnzcBxJ
 E08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+rG3qvT7ySzAQUCoeVQPFrcWS7ra7WD2Vh84T2cZ9Bs=;
 b=nxet8gCgpq7EB5/JjKVi6IuNLroRslEekL/LfulgJPpCeWG8FZuKPraLH1niltmSdn
 T3pCs1PftaE9aM/9VbK293GQ+iM0gvO4CYDJYT88RYhloFk26mJnoNR2MGszkkN337+F
 phjEq3NHVvpBHhSyFDmL4nM2ezWCW6q6YcOy7I1DPsMo3QmNfiCGzrjE4rZ1EFvgju5Y
 8OQ3TlLfH1DbKt7oCtjoqBIa1g1dZ/TB3rpI6VanQZBgFEMh/e164CCcSHxD0YusNFBm
 7Rx+GFoen7bfNO5oVAY6tASp9Y187EKJzg9rlqNDcV03NmhxSHP5WsYO46nbhLXaI6wF
 tTXA==
X-Gm-Message-State: AOAM530E7x2btQbiaNOHXgyZf6LtmKLl7AxP24STf06NxD+1OFiZ9RFR
 lCBdFRLDzSHSENxEyi2XRBMSaA==
X-Google-Smtp-Source: ABdhPJxZwDuZWDpUWl8yz7lSZcVGjmfBluJqLHGMaHyhcmw/vWFZtg4V1xJjsbzXrN2RTHz+COhKhg==
X-Received: by 2002:a1c:7416:: with SMTP id p22mr449584wmc.32.1595435388749;
 Wed, 22 Jul 2020 09:29:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 129sm208845wmd.48.2020.07.22.09.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 09:29:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 59D071FF7E;
 Wed, 22 Jul 2020 17:29:46 +0100 (BST)
References: <20200722062902.24509-1-alex.bennee@linaro.org>
 <20200722062902.24509-7-alex.bennee@linaro.org>
 <5d26e26f-55f7-5b74-bb9e-b97ea1040c05@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 06/12] accel/tcg: better handle memory constrained
 systems
In-reply-to: <5d26e26f-55f7-5b74-bb9e-b97ea1040c05@linaro.org>
Date: Wed, 22 Jul 2020 17:29:46 +0100
Message-ID: <87ft9jtsw5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>, f4bug@amsat.org,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 7/21/20 11:28 PM, Alex Benn=C3=A9e wrote:
>> +        size_t phys_mem =3D qemu_get_host_physmem();
>> +        if (phys_mem > 0 && phys_mem < (2 * DEFAULT_CODE_GEN_BUFFER_SIZ=
E)) {
>> +            tb_size =3D phys_mem / 8;
>> +        } else {
>> +            tb_size =3D DEFAULT_CODE_GEN_BUFFER_SIZE;
>> +        }
>
> I don't understand the 2 * DEFAULT part.

I figured once you had at least twice as much memory you could use the
full amount but...


> Does this make more sense as
>
>     if (phys_mem =3D=3D 0) {
>         tb_size =3D default;
>     } else {
>         tb_size =3D MIN(default, phys_mem / 8);
>     }

This is probably a less aggressive tapering off which still doesn't
affect my 32gb dev machine ;-)

--=20
Alex Benn=C3=A9e

