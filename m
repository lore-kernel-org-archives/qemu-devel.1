Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC1FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376B12074B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sBFxRoK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376B12074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiJSI-0004MX-HS
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 11:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiJPr-0002eN-O4
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:10:23 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiJPq-0005xw-Hc
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:10:23 -0400
Received: by mail-wm1-x343.google.com with SMTP id l26so15662982wme.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 08:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=idibzcqk96scOi8C0MNothYOQF1dUHEWWSxh05tz2DQ=;
 b=sBFxRoK9lND9YfQxsNWwR5frV8YdkMUzRZpWpzlk43Y7AOfKqTR7LWQ1RbFV1UIv9q
 0I4aG0MMWxzWymlwRe9fzpG3qKCzkxFntAMJlKieR8GYuF6la6fB2r3wpEvbGWq13QPT
 Rei7EM61QB58lvsAdIKV2ubMZ3E3O9XasxSUm2ouhIfBPRlKeFTloI36EKTQwrsaGjXi
 gr2ynPobwPtFdQ6AUlrEdND4923lmqS9BrmhzTaRVzlHtwAbTY3wPoz6S4EZrsucZb5T
 Km3yi36fww/ByufFeDSUIApK1S7ki5eTrzM7RbLiKagAkVtMxnLmr8kIn/KuQDksxCe4
 2//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=idibzcqk96scOi8C0MNothYOQF1dUHEWWSxh05tz2DQ=;
 b=kzJYJYlEJUFWejRq5LNKhybwQDSUXqhEg6B6z+l6N6bfhGSJngb6RiTHaSd+rvgJQf
 zNaZdIlqyn6R6RmQrIfhRv1MUwqGPYe/1kBg2d7B7VOKeEBl0WPip1t3QJzCcJVFpjyY
 hjWtyY4KVUBm0BXJEGjtuttVUnTduiTdmK+PwXY9Ag4XR5tPKXrLbwk7MFZGjcVFSE8o
 c+BdyoYG/dlLln40nl8sZ9YLOWWUa+gqJvJWhQeHqe1ihLm/U8H/nPChuhr4icDTeROZ
 Me8+QKsDcukGGOzMmVl2u9rTy8ziOfeB5Q4lR3TWr4UoGIlEWUlcf3SMCgGeqGr2j9cs
 jPeQ==
X-Gm-Message-State: AOAM532jEH82IooYhsbtpQkvNbA4On654XLh6vi9qoGBV5brO+zd+4lR
 TNXBn/OzLShu5TD66V0u8GV/lA==
X-Google-Smtp-Source: ABdhPJwCkpTRu55Sh2p92MRnnFnVdo7D2Y9c2cu2dhch8cptGtnIV4vfQtD6jyC/kqjGyP6ObpiLyA==
X-Received: by 2002:a1c:4857:: with SMTP id v84mr16379492wma.96.1591629019942; 
 Mon, 08 Jun 2020 08:10:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z8sm29380wru.33.2020.06.08.08.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 08:10:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 568711FF7E;
 Mon,  8 Jun 2020 16:10:17 +0100 (BST)
References: <20200605173422.1490-1-robert.foley@linaro.org>
 <20200605173422.1490-11-robert.foley@linaro.org>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v2 10/13] include/qemu: Added tsan.h for annotations.
In-reply-to: <20200605173422.1490-11-robert.foley@linaro.org>
Date: Mon, 08 Jun 2020 16:10:17 +0100
Message-ID: <87tuzl61ba.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: peter.puhov@linaro.org, cota@braap.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> These annotations will allow us to give tsan
> additional hints.  For example, we can inform
> tsan about reads/writes to ignore to silence certain
> classes of warnings.
> We can also annotate threads so that the proper thread
> naming shows up in tsan warning results.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

