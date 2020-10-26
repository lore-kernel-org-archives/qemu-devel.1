Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2A4C5DF9D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E21A21D7B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="paLescDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E21A21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6BA-0001fC-0m
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kX62M-0007uQ-SX
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:12:05 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kX62J-0007Rr-2p
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:12:01 -0400
Received: by mail-wr1-x444.google.com with SMTP id s9so13497988wro.8
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 10:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=CHReHQKDJrja+FKBRMIXSdtczg7pjWEYw3/nHoHY9As=;
 b=paLescDdWXSCaojoqnsHg0a2Vo7zskIWcB697jFHP8zVxWZolCk/wLUF6mGM30UlF3
 l3Jeq6MkRtottPLx+92Pmw18LfKVTNO8mnWlIJ7kvhwiUfj5zz7Gv4lV/yGUfSh2UHr9
 XQmS3Tkp039O1KDPeoPx8W4RtSbHa2Zx5og15E/MtvMxwLWYPnpuisK/LCXBcneraQX+
 9umuWiJn5fLxuoh9h3DEBHjXZvUlOdVTBiYwl7ygrQ6JzYAjeqjVvKyoMmK84wqFISOh
 7LY/zWPlc2FmJxgK6hkh5vOu9N3MOjTOybkYxhKxFYRPQGo8RDoT0OWUjnS2GwCnSVqw
 rxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=CHReHQKDJrja+FKBRMIXSdtczg7pjWEYw3/nHoHY9As=;
 b=JmOnb/WvRgJoCEmPaCk5e7ROi7HmVTmjdenV0rus4FxxvXj6ay3jsqnbDIo761CO2Z
 ZEhYJvHlf7g0071LBzHSDuOerS6RXoCVCBgS17hNt/SXt2mJuxQvutC6PRwIkMTYV/tM
 1ILMAallO9uA1xZtS7/JC3i6Kb1sZYkrCDjwiDDUI2yLvOpt9pV3blXOvFV7Gg7IS+7H
 y3CY3b4hrHz5TLO80riWPzK9mXr8tGWO/6ktrrVwWzB4+FPrInKty09fcU1oDXhCjOh0
 71VGHB8Dop3gi3ZBMolqRIbUFtCaMNzz8cVOnbje8nXZhjMXHZY45R4eQLLPx6jAOmGP
 tB+w==
X-Gm-Message-State: AOAM532KRGGw7RWL4NVV/Uhx3b4aWyerlWwJqsiVrtVknJoKwMSTAjh8
 jklYtpMED67kazUkezNc+kkO8A==
X-Google-Smtp-Source: ABdhPJw1JsTq29cWFoOK702AD8TSNRgduzyP365FmBdmxO/9IbaGvqKEmmCvGMT/aAbgVZRr3LYDUg==
X-Received: by 2002:a5d:4d0d:: with SMTP id z13mr18295643wrt.23.1603732315242; 
 Mon, 26 Oct 2020 10:11:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 24sm20457253wmf.44.2020.10.26.10.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 10:11:53 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2FCFD1FF7E;
 Mon, 26 Oct 2020 17:11:53 +0000 (GMT)
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-4-pbonzini@redhat.com>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 03/15] arm: remove bios_name
In-reply-to: <20201026143028.3034018-4-pbonzini@redhat.com>
Date: Mon, 26 Oct 2020 17:11:53 +0000
Message-ID: <878sbshpye.fsf@linaro.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> Get the firmware name from the MachineState object.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

