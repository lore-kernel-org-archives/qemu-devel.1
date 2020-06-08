Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FD3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:16:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3239E206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MFQN2VKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3239E206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiEpT-0004o2-HQ
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 06:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiEoS-0003wj-4s
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:15:28 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiEoR-0007gi-7a
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:15:27 -0400
Received: by mail-wr1-x441.google.com with SMTP id e1so16759721wrt.5
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 03:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=MRJ9looly59dt6FICitChIYMa62xwM5z535LewPFeQ0=;
 b=MFQN2VKrjGhN/U/rYI9G1MYLZsYnEWsXdr3hrX+kJCLq5JYh2zJ0Nldsx51NSDAjEx
 U3TxT3jYvcKvRb8QXBYVKvi+qy5iG/nmQDYV6Skn4f7bLTYcZq2Ukg3TRSBRhoC6pvgG
 mbEa1+NbJgj5y4Dp4LQUCbRgkPmgXSkbcBS6L8cLD70gOtpcLq4S51izGr+igEl93QGS
 95t0S0kYfg2Ut9/Mei3teT9+JgqVeoggIpao0tUc1FFJLA7Xugvi5bcjw2+9GADJEJea
 xIvDZ1QUYU9mRoIYXhbIUGGoAuRKwOqt66BQle/FTOm7zfj7CgvpLL+UJLKyqWkFlhkI
 D+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=MRJ9looly59dt6FICitChIYMa62xwM5z535LewPFeQ0=;
 b=MMv57aMjjve3iydwazKPtPNMohi0kN+WY+hiQkxp5bU24wFR4u36geIFav13Bc6mSJ
 6hk7HGGLotf2mAXASvoUwjncJBnd3LIlclwoFIkRsby79q064IQa5Twsk1vDLqObmCNU
 8akwKLscYrXnMz1BqpEBr7N7QOEq9xu6fqh33i4Wswyhy0BcwmOkZDGNA42BSkucdAzw
 syNI/wPt70bi5LHD3rz4EUaLJMjQdYupFXkRkXFc6OfKOH6mwgHcusd+8bjRKxy82bkK
 lLJfEJ7sezfOPMaBzX/KTD/XBX9SXHOIRgrYIr4cJn7z+Ar5yhocbLBgdIT9gHkgJtYp
 XXfQ==
X-Gm-Message-State: AOAM53243DQS7uHw3hRKAnCy8Ox9p7HgFKqzcZPajNeyeyuOEy3KZYS/
 jjE3G6xabUtYppZ7kP9YOYLacBQ6euI=
X-Google-Smtp-Source: ABdhPJwDQdBPs0ZsyCeG6ZARnCoKhNCnovIf1qTtO3jQ7+p3BQew7AzjHi+bBesge8UGYfa04zsaqQ==
X-Received: by 2002:a05:6000:90:: with SMTP id
 m16mr23570077wrx.191.1591611325831; 
 Mon, 08 Jun 2020 03:15:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j16sm9945855wre.21.2020.06.08.03.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 03:15:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DB5B11FF7E;
 Mon,  8 Jun 2020 11:15:23 +0100 (BST)
References: <20200605093256.30351-1-philmd@redhat.com>
 <20200605093256.30351-10-philmd@redhat.com>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v6 09/11] accel/Kconfig: Add the TCG selector
In-reply-to: <20200605093256.30351-10-philmd@redhat.com>
Date: Mon, 08 Jun 2020 11:15:23 +0100
Message-ID: <87ftb57tj8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Expose the CONFIG_TCG selector to let minikconf.py uses it.
>
> When building with --disable-tcg build, this helps to deselect
> devices that are TCG-dependent.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

