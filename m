Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB98C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED8802072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yX8KpvCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8802072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jneO5-0006Xf-2Z
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 04:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jneNO-0005kp-Jo
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:33:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jneNM-00075i-TJ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:33:54 -0400
Received: by mail-wr1-x442.google.com with SMTP id l10so19576205wrr.10
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 01:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Hdg6kn0fwIHVdKp93JW+WKTFwlYtz+QHOsWefKiM3ec=;
 b=yX8KpvCl5DbuAwKs/Uy/SbjeKJZakhhv+qwaXcQpZVl9uvNPKBum7riwWNjd+bqfQE
 4lIhxlgK/sO6ZIdeqFnMH/aeWM6LxBdqBKnSQk3G8tuskCA2e8JsRIOkdM7jcCVnaqj5
 DlGXRc/Bd+jCjJdAXiZUQgMYc48e39WOft9SbwrxvyzwXFOlDzUqkelofLEo62EqW6el
 /CCtgxj/S1KdWxOQIzi2LBxlOCmo3tiyzWUd4fGLytGIaqlJtkE62hgJY8JWRKA1UIUC
 R3dv3E3x1UzDVWkxUtGztgr174spOI2ANjBenQMymk2+PlqMz/K1qDOQpdUIUDfedlGm
 Qt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Hdg6kn0fwIHVdKp93JW+WKTFwlYtz+QHOsWefKiM3ec=;
 b=mjAR/x5NwVXc9M5AKDo5ek2f87UwvsNPTjxuCxBU3VZB16/BK3tkGhx/kkzoNGCqfy
 xOaPVmudzNoFpcB2mNSfYbc1ic5NROMw9lM3yNngUT3Obih3Wtr+a7l6fhw4H2yKPk02
 SSfEYfs5QaHQ376U0IxfONi+KWXdMq3OqR4alhStlSYclxCJ7abCMxpElqPK8KfepbfB
 yX+EHSzvsyjVYuupk6aecX/lfWV+eoAlH4yn6rUFB/47HSR1HLKUxrAzjc7a2PWQFPrN
 5o921HJS2tVcuxFZ86In3Qkv1prDeSsefWism3jz6yjlIc5kK1+f7bjMpVU8rnIaFuQr
 r7LQ==
X-Gm-Message-State: AOAM530T2zHu20Xbu/MLlxdpY3+NH/xoksv9E88fbaZcVXq7bECKj8Tv
 bxde6YnaD2+c3lTydo8ERSZ48w==
X-Google-Smtp-Source: ABdhPJxDdTNdeYJf/7zKeKc5kF6RYPRHznh5nmb0odPD1H/+lwoqPEb6k0yHWgTNgehdnokCuc671A==
X-Received: by 2002:a5d:6a06:: with SMTP id m6mr8062262wru.321.1592901230759; 
 Tue, 23 Jun 2020 01:33:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p9sm2581668wma.48.2020.06.23.01.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 01:33:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0728D1FF7E;
 Tue, 23 Jun 2020 09:33:49 +0100 (BST)
References: <20200522023440.26261-1-richard.henderson@linaro.org>
 <20200522023440.26261-15-richard.henderson@linaro.org>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 14/25] Merge reginfo.c into risu.c
In-reply-to: <20200522023440.26261-15-richard.henderson@linaro.org>
Date: Tue, 23 Jun 2020 09:33:48 +0100
Message-ID: <871rm69o5v.fsf@linaro.org>
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
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

> The distinction between the two is artificial.  Following
> patches will rearrange the functions involved to make it
> easier for dumping of the trace file.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

