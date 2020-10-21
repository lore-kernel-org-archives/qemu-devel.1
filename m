Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AA3C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:17:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55054208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XnymqPru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55054208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVHk7-0002NA-A1
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVHjB-00013P-Hi
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:16:45 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVHjA-0003WH-29
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:16:45 -0400
Received: by mail-wr1-x442.google.com with SMTP id n18so3966014wrs.5
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=PhuciOTxGzyt42NozTpQG7KL1ETjDSYk2QrBi6IxQio=;
 b=XnymqPruu8B33A+4+7J0tV69W8urQp+aCj8z9FrZYzpZNT1UGBPBXAI9oUauRk1l03
 v0MlHRRE6sUYOlJ8/Bdmb7iPaLZKLNOwztkrVJDBf9l77WZ70ILFd63MPYLHbqPJisBI
 wM0RZbwRQTkCSs6ePusxR0rto1espHvchkT2xNJnzaXzy/sYJQ3ipCS4ZaHUvysAo+n6
 zh9VghS4ZvlAeLslkI9FemjwhZvifek1lFJWDNf506jnaSVQRabWV6cOTDbyc0uSI1HB
 dn8rNt9PSFdRWfNOI26dNvjyxhrUjYsMriEBSY1HVnDPKq+P/Sfd30wuWamci/Yu3J87
 W6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=PhuciOTxGzyt42NozTpQG7KL1ETjDSYk2QrBi6IxQio=;
 b=VCXJjW3vjhvc/iK/lev/Oen7INp0bjtvfQB8UQF/01vwXtkGBHuoyW8Zr6KxPkPwDs
 N09CYDEZEYW2UziUORO/eIsvMqxQgK8EJolzFenr/nP0kfJNwLuGPcglejgXqsdmaMe/
 fn4ZxaVCCH8OpQ2cXXwnDgLnlwfasBObUCrNzYh9CBWf7WZxCRcpuk+kU4h8SNaWYBOO
 ZYTJNPtOnrnR/FigPVWPj1lPRurzrqlMTuukJg9kX17SM2ye5EX5TmtTBuKfjjR+jOEN
 GEAXEx/U4Bal0bZrdvl3yqRQjpZrngTAgcBZqCjh/CYU4bAAY7J5zL27UD72iHCe0H45
 zbwg==
X-Gm-Message-State: AOAM533zhwK4fUOJwvoUypn3vt0VZ+FgDXc2hmiYPPOjxz8n50/YYfTo
 AoLaddYQ5azihPaZP7y19Z5Gvg==
X-Google-Smtp-Source: ABdhPJxoEvkI6H2pohUU76CJFm0877TFxVW9i1SSCYTv7tycMCKuoQd6SuTtlUCEsvlsWSZsSJC56g==
X-Received: by 2002:adf:fc08:: with SMTP id i8mr6277923wrr.116.1603300601956; 
 Wed, 21 Oct 2020 10:16:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a15sm5017805wro.3.2020.10.21.10.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:16:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 146C41FF7E;
 Wed, 21 Oct 2020 18:16:39 +0100 (BST)
References: <20201021045149.1582203-1-richard.henderson@linaro.org>
 <20201021045149.1582203-11-richard.henderson@linaro.org>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH 10/15] softfloat: Inline float_raise
In-reply-to: <20201021045149.1582203-11-richard.henderson@linaro.org>
Date: Wed, 21 Oct 2020 18:16:38 +0100
Message-ID: <87r1prv6rt.fsf@linaro.org>
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

