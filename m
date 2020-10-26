Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F85AC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F63B20706
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wM1vVWyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F63B20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX64e-0002Df-HU
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kX635-0000Ut-E8
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:12:47 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kX633-0007We-Tf
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:12:47 -0400
Received: by mail-wr1-x442.google.com with SMTP id n15so13566673wrq.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 10:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=A3cvVT79n3JsZfAXZXtD6kWKJfj8sCr2NWHDwhO+tks=;
 b=wM1vVWyciBYrf3H1Xpqs+CEpQmY9g7Vl0NrMbWuBcO9hG9V34n3L17qrZVGP5OpND3
 C5TBg26o0YV3Ae1Cvp2guQGbSXu6wFTqfUKiZx9NXRp/A78f3753OF9E3bB2B6FWt3HI
 pEMangVNk7D8ezrHn6RHiaI1TREkTTfpcih2XMGRFDmOpCdP1caNDG9I2Rotf0wXJYoH
 vC3LcKJNT9ekx3XNeu1Ihc6IPgT2igp4XFdWp4/lzwwaV/rn0yqe+myD1iDjZYnFX2aA
 4g3ED8zWg2tSqURJSX/7aM2MpQi98hCxH0n8rEnOTAZ2/BfgIYlMUyf8SFZ72JWyi9Ry
 vWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=A3cvVT79n3JsZfAXZXtD6kWKJfj8sCr2NWHDwhO+tks=;
 b=sdKKzv68Gj2+40G1XGX7c447S49fXwtArAd2qXpW0UnweBBby0nIq23lkiP2a+mTVi
 SHJLUZsf9/CbXsnY+efiqNso98t9AtsyneY11rtHrlz/ZVwUo/UN206h1JOZxflLrWOi
 XwSnNoHr0a828e5KU2/xWOPtQjzACkp132Q5Jk4GI1Q7AQvNmR1Uwaw7y/UHC5Hv8dM4
 KNxE4fGISgRMtlINrbTA4VFXtGDkRx0R15AY86F3E5FZzHXFuXgp77H5rVCZLzeYfR4w
 b78h2Rlqd1s/8z+RcTyZPEJojSNG//LI92WglSOaz1mkebhwPTSi8FUDbHZtE23adIpP
 rM2g==
X-Gm-Message-State: AOAM531b75pfsu+7ZQQwF6ezz7v+ZMuHjeTGbRJSiPAwunFfS1HiER/I
 x5S9R2c7FiVmwSC3dTmPQk8EvQ==
X-Google-Smtp-Source: ABdhPJxwwz48pXGGDC8b9gCPSswjtp3HBchJq0W/jvXUzA685KWDoRgOLuQ5doNC3yMRw71nCSwtjA==
X-Received: by 2002:adf:ef51:: with SMTP id c17mr20375472wrp.301.1603732363806; 
 Mon, 26 Oct 2020 10:12:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o63sm20934186wmo.2.2020.10.26.10.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 10:12:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2A25F1FF7E;
 Mon, 26 Oct 2020 17:12:42 +0000 (GMT)
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-5-pbonzini@redhat.com>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 04/15] hppa: remove bios_name
In-reply-to: <20201026143028.3034018-5-pbonzini@redhat.com>
Date: Mon, 26 Oct 2020 17:12:42 +0000
Message-ID: <875z6whpx1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: philmd@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

