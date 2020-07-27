Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DC5C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A5D6206D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6flMsnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5D6206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02yA-00067V-DR
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02xX-0005gp-7i
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:14:27 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02xV-0005GH-ED
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:14:26 -0400
Received: by mail-wr1-x443.google.com with SMTP id a14so14864583wra.5
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 06:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=72GUZQSf+Ot20SlVo+Mi4z4cEgEaT9CcoVXfsmzRCkE=;
 b=s6flMsnKFUIlo6oodIc+Allq+WTU1yTVm/N+elfTY1KuIDdY8+mGb/ZltNc3L3FxDN
 EDcpuuymDk8/vUgxNTa9T4DYcO1Q3BbprJbV6HdHVu6bPFH9fvDogSW9y9JzSfq1MxWO
 llFJYHmBwhHRq01zfxe5aC8ln8NBMW1mXMCvplRli3U39cQJA9+S7gD+8fnfcws8u1kl
 C1QUc0/PkKS/0xkw1jYU+7DBwqinQkJU2C5n1zqP5s70kK1fJZs8mfoe9wtz1h1ZMcCM
 Z4l0N6nNzXaZ+GW/gdA3V19jthh7kceYTrBWRxc6BiWaBdQ8LEUr6UlQMMsBCQuNplbB
 gGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=72GUZQSf+Ot20SlVo+Mi4z4cEgEaT9CcoVXfsmzRCkE=;
 b=MwWMAMHhADPJ0SLAiG0bC5JuYHUcuwt3sMf8cRsRcveh5dNTMOfElVXPuI8fNqZnyI
 i5sMcZ2yiZghT0SC950rVeEQWQ/uJwAEr7oPFnQXe2CgqNes4APvc5ZrZx/uQL1pae46
 +WVr/tT+GhubaCYOrR17tU4QUNxTJ0gzH1iIm8Er5eR5KN+8ExB0vD8HsUXpXQAruQDv
 NxJN0QbysrQaweGz2mG+9GroGFFRSaZ+rsaDUF9dCR8NmsC1Z8iSWozQAESxnZXqPxWg
 xJlkhKVMKGIyyhzyV+smpYBnoSqOPdd/CHy+yTASzKGEgPtnnnN8GJESBLoOnINvP12Y
 L2NA==
X-Gm-Message-State: AOAM532PbqmfJsx/2zvRW0wyCzqgvoiRp99KQ3W2xOtut9dVLGyC7qQs
 v1UfNO8VluUY0d+dJ26zizhv/g==
X-Google-Smtp-Source: ABdhPJyvReqfvQfjqsQNXMsSvuO174Yp/cscVi/Ddbg2o9gafIprv2uaDXq9Z74L2bKWN9zVeB6SaQ==
X-Received: by 2002:adf:ffc1:: with SMTP id x1mr6889618wrs.54.1595855663615;
 Mon, 27 Jul 2020 06:14:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i6sm11667070wrp.92.2020.07.27.06.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 06:14:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 65D511FF7E;
 Mon, 27 Jul 2020 14:14:21 +0100 (BST)
References: <20200724143220.32751-1-thuth@redhat.com>
 <20200724143220.32751-2-thuth@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/3] configure: Fix atomic64 test for --enable-werror on
 macOS
In-reply-to: <20200724143220.32751-2-thuth@redhat.com>
Date: Mon, 27 Jul 2020 14:14:21 +0100
Message-ID: <878sf53xsi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Ed Maste <emaste@freebsd.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> When using --enable-werror for the macOS builders in the Cirrus-CI,
> the atomic64 test is currently failing, and config.log shows a bunch
> of error messages like this:
>
>  config-temp/qemu-conf.c:6:7: error: implicit declaration of function
>  '__atomic_load_8' is invalid in C99 [-Werror,-Wimplicit-function-declara=
tion]
>   y =3D __atomic_load_8(&x, 0);
>       ^
>  config-temp/qemu-conf.c:6:7: error: this function declaration is not a
>  prototype [-Werror,-Wstrict-prototypes]
>
> Seems like these __atomic_*_8 functions are available in one of the
> libraries there, so that the test links and passes there when not
> using --enable-werror. But there does not seem to be a valid prototype
> for them in any of the header files, so that the test fails when using
> --enable-werror.
>
> Fix it by using the "official" built-in functions instead (see e.g.
> https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html).
> We are not using the *_8 variants in QEMU anyway.
>
> Suggested-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

This also fixes the failure to set CONFIG_ATOMIC64 for clang (9 and
others) which didn't fail on my box but was certainly missing.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

