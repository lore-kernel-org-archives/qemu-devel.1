Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA77C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA186206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2lj1INA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA186206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3eL0-0005QA-6r
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3eKI-0004op-Jh
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 07:44:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3eKF-0006fm-V8
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 07:44:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id c15so7466450wrs.11
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 04:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=cMatXE/DVSsnWTfBdSTx8J7Ctss0zXNvDVRfCtEXC+k=;
 b=A2lj1INAuAiNWJ40RUVSrufDsi7MsUZnWigXW8pA9vgeOir+c+xtslUnT4zOhZcVLy
 mV4rgD4dgLQEjPp7qgxOjvFv5eC9rKzDKJJiAcfqlmgLE1+2kn3QQzrvWvYfsdO6VvI4
 UO94C0JXzJsqULgYcVxvIQUkK9w/l8H18mJ2oM4W1e9LGYDzCHpbf3krUSxzX6pr1RxL
 Ldv3l4MWMEroaG8MHtoo3nWjwwl5qg4M0/M2FHWOpl5R9z7Las/F35tJ+t4ULWW4UHV4
 YBBMtxixh+gXKlGzaYE51d/c2p7GWiMpm1+2C3ztVCdCDUm+6KeSgJWnVdYnCiNPwUHn
 DRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=cMatXE/DVSsnWTfBdSTx8J7Ctss0zXNvDVRfCtEXC+k=;
 b=e/rVDo6EfHmwX8CUdMKMrP6h2iaMm9CGlT/0bbgZ9XAciW6zOstR0pRDA2ap2XySet
 vJ/Qn1wPM5LigGVs0fwI1/hY8fUR397pMo3dcjrvHZuG1D6W10ZqQ+RRWw5UJsQGoZsi
 ewVgSdGhCvbaTLOqjOBuh0Q9QlxmoA3PF29GdZMnkdXIE42Ak0cKD8Z6eZ+9LhDCIpkR
 0CVlWfaVXWXPN71r3v2EOBmU8EWaCo01FKnYrI7cPbmqMYBYriWG1CHie9wl723Bedtb
 bruALoI24ViX0WDKjx4hN3XLTm1y2ZuAse+m2aWBNH76JDyUIeBrjtOgdBuVrlVQr9G1
 0kWA==
X-Gm-Message-State: AOAM533PM/SAKqLnASda0OYeJaoeWmSzIuf4evkC42TlD3zcoGZigSJe
 svwc3NPviKv/AQvXV8BMdhh84X/J+wY=
X-Google-Smtp-Source: ABdhPJx5up9LNTBPyZcv0nFpkmitYI9x4VG55RBdZlypuW0bpDL8qbhlVIya3RIBIVezJ18cfJDI/w==
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr7585835wrs.132.1596714285813; 
 Thu, 06 Aug 2020 04:44:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j2sm6626781wrp.46.2020.08.06.04.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 04:44:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B1D311FF7E;
 Thu,  6 Aug 2020 12:44:43 +0100 (BST)
References: <20200806104453.30393-1-peter.maydell@linaro.org>
 <20200806104453.30393-2-peter.maydell@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/4] target/arm: Replace A64 get_fpstatus_ptr() with
 generic fpstatus_ptr()
In-reply-to: <20200806104453.30393-2-peter.maydell@linaro.org>
Date: Thu, 06 Aug 2020 12:44:43 +0100
Message-ID: <87lfisknh0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> We currently have two versions of get_fpstatus_ptr(), which both take
> an effectively boolean argument:
>  * the one for A64 takes "bool is_f16" to distinguish fp16 from other ops
>  * the one for A32/T32 takes "int neon" to distinguish Neon from other ops
>
> This is confusing, and to implement ARMv8.2-FP16 the A32/T32 one will
> need to make a four-way distinction between "non-Neon, FP16",
> "non-Neon, single/double", "Neon, FP16" and "Neon, single/double".
> The A64 version will then be a strict subset of the A32/T32 version.
>
> To clean this all up, we want to go to a single implementation which
> takes an enum argument with values FPST_FPCR, FPST_STD,
> FPST_FPCR_F16, and FPST_STD_F16.  We rename the function to
> fpstatus_ptr() so that unconverted code gets a compilation error
> rather than silently passing the wrong thing to the new function.
>
> This commit implements that new API, and converts A64 to use it:
>  get_fpstatus_ptr(false) -> fpstatus_ptr(FPST_FPCR)
>  get_fpstatus_ptr(true) -> fpstatus_ptr(FPST_FPCR_F16)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

How many more can they add ;-)

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

