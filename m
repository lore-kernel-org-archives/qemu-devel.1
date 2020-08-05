Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9025C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:46:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 747762076E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vYUZbhQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747762076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3MYK-0005GD-Lp
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 12:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3MXO-0004O7-Qr
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 12:45:11 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:36778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3MXL-0003uM-Lw
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 12:45:09 -0400
Received: by mail-wr1-x433.google.com with SMTP id 88so41313482wrh.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 09:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3NW94LMPzCnDG/PqclW9ZM0ecyFoJ5qStb8X/NxQc6w=;
 b=vYUZbhQ+NPbaBW0byaP/kTVaXo1tHOha1TFUAacRj/kAgIL16XwG5JrvTqL0ujv7BL
 tRQgcqX1XsNAph3bRzpZaHoNsxsjipKugy3sWhcHI18wI4qEWBMgTeq6LtCwjOyM5gsD
 1Fff0w5tOCkpaWom+J3QeA97qCvfe3a62TS3x5HundVzrneBl6bzChpPo0phsZ+wjLgT
 ASQP2HhItMpQe9KvzsB95YL/uxyfWss6kan0bLSEMWIJJv1iuSvZR8+X26duDO61EG/R
 e6lF9peJ6T6RlvYjUjrDuk8GTsXhQ+QHsXy00m+WkQwNxsH06/zOutgeyNdPbQUa8bXS
 q57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3NW94LMPzCnDG/PqclW9ZM0ecyFoJ5qStb8X/NxQc6w=;
 b=IwkgF7mVHlz/zgvf4ERDrbvnvG60jaLeXxKeKZ5EA23l8Nq2W9G/fVOyEh7qVdulUA
 MCWUnFNAUShJR6IKWe1hOB/OvqwyOfgbYtIetpuwgSEsNhqxlul0NIu582M2fR313SsO
 rM7XNiypti6+WOTWSaVcBJs+1Ps9M5la8/zUXTANbJXU+YwkzSuYAKFiGC3zrK0kZto+
 4NXCGPiDcPIBCE21u4sPkAckZsedbxPr3ZJg1CtOgW1mvkGBkfLwxmfGeLFz05z9CZcX
 D3i9GyN8zXS7t2QgjR2jQIz2ZnzEI1Kfcmc41vLaCd8xejoMqG0plM4XcddNGLyHNvSm
 dZzw==
X-Gm-Message-State: AOAM532+Pgr7Fo0aLmNuuoy49F7o/Qlvt5LyxNS2lcyIB/wz2C/fC9ps
 X/Syfrf/AFSybvBF3ltkNIJeeg==
X-Google-Smtp-Source: ABdhPJw3lG3jSo8QZK3iQ1akH9vocsUhKGqwpkhfMwWTDr287fNUjuFZah7JXpvZ3l0emF/V2kRrrw==
X-Received: by 2002:adf:f247:: with SMTP id b7mr3773403wrp.128.1596645904043; 
 Wed, 05 Aug 2020 09:45:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i4sm3396892wrw.26.2020.08.05.09.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 09:45:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F02B41FF7E;
 Wed,  5 Aug 2020 17:45:01 +0100 (BST)
References: <CAFEAcA_6zbOfdVi+Tp18seaEy4don1GurVya+E+QXRGrZ_WVLg@mail.gmail.com>
 <2c5ed9d8-6d79-1b53-5588-8fb9efebf0fa@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: v8.1M cpu emulation and target-arm feature-identification strategy
In-reply-to: <2c5ed9d8-6d79-1b53-5588-8fb9efebf0fa@linaro.org>
Date: Wed, 05 Aug 2020 17:45:01 +0100
Message-ID: <87tuxhkpo2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 8/5/20 4:08 AM, Peter Maydell wrote:
>> Mostly recently we've been aiming for QEMU emulation code in
>> target/arm to use ID register fields to determine whether a
>> feature is present or not (the isar_feature_* functions) rather
>> than the old style of defining ARM_FEATURE_* flags. This seems to
>> be working out well for A-profile. However, for v8.1M there are
>> a small handful of minor behaviour differences which don't have an
>> associated ID register field, but which are instead in the spec
>> and pseudocode just called out as "if this is a v8.1M CPU".
>> (The major v8.1M new features do have ID register fields.)
>>=20
>> I can think of two ways to handle this:
>>  (1) define an ARM_FEATURE_V81M flag
>>  (2) define an isar_feature_aa32_v81m() function which under the
>>      hood is actually testing for a specific feature which happens
>>      to be known to be always present in v8.1M, like low-overhead-branch=
es
>>      (ie ID_ISAR0.CmpBranch >=3D3)
>
> I think (2) has the potential to be confusing in odd ways.  If there real=
ly is
> no official flag for this, I think we should use (1).

I wouldn't test other feature bits but what stopping us adding:

    struct ARMISARegisters {
        uint32_t id_isar0;
        ...
        uint64_t id_aa64dfr1;
        /*
         * The following are synthetic flags for features not exposed to
         * the directly exposed to the guest but needed by QEMU's
         * feature detection.
         */
        bool v81m_lob;
    } isar;
=20=20

And having the normal:

    static inline bool isar_feature_aa32_v81m_lob(const ARMISARegisters *id)
    {
        return id->v81m_lob;
    }

That said we still seem to have a number of ARM_FEATURE flags, are we
hoping they all go away eventually?

>
>
> r~


--=20
Alex Benn=C3=A9e

