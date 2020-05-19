Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59CFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 09:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CF5206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 09:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vc3aW6xl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CF5206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jayF1-0001BB-My
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 05:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jayEJ-00006u-5u
 for qemu-devel@nongnu.org; Tue, 19 May 2020 05:08:07 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54865)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jayEI-0000xo-CS
 for qemu-devel@nongnu.org; Tue, 19 May 2020 05:08:06 -0400
Received: by mail-wm1-x341.google.com with SMTP id h4so2224592wmb.4
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 02:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ZSwdidLNMH82oiEnZsL7Aji5zoQ8nuCJdCpZ/Zh+Nw8=;
 b=vc3aW6xljuztNUoAlSXTohpkBwoWghfAYaVeMFW5uQZTpsazCfYrCUdK20V7WBAb5E
 D/xDQ9CdsU49JIhD+vEtjaS/PVGRkiVCvLWnSGhT+6eGe6aHnFVMGgHPYN42d7Sy006V
 f1T5Bo7NTp5kQ029hlUbzjdFEcdFYWZLEKlRLO8FNsLnyE9BpgjL5g9MlW/LhM0S2J2Q
 yTHCu7JyWe2b3e98V77p76hlqnxhyZeHAuGGS5GDLy14gyVALD5A42Ulk8f5cdhta82B
 OGnO7jvna44DL3KXNeBuCxuomqIlU2ldRP7yOlqTfipT2gyRMVE1c4DbMiEmzlV5SneH
 uM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ZSwdidLNMH82oiEnZsL7Aji5zoQ8nuCJdCpZ/Zh+Nw8=;
 b=LQkPzYx1Ym3gz1NM8LtFTYbgEa0YsHXb/4PdwmSf8GfdatQw4TW+cri65RRTYjbBP1
 q7P9UTHUMbjnpZC7TYwM45xJjJBOTyg0HzCs57XgNJOK9hM9BamKEACZiEMWXicvCGVV
 kHU+z6mDTRwWj2ehlv1nIdAeulnKbzPdXwM10iql4Jm/5t9zTa5E4a6KnsnihTrKER52
 kMxi1nwNIEdbnjkgkVYGg11AKmQVh1FPFiE1nwgu4eRozldEk3PpUwFeJfX+aUD2mNBq
 7UUdZ6adeVndskUDVuW0y3Yy3Jdli0xMXA3Xt45S7Fl9XHv6nWicv3qg6z3SGbTAetow
 rBBg==
X-Gm-Message-State: AOAM532s9WDGewTcy0gd30xxjLqlZ1r/Q14yk0mo1x38iP5DaNwDw++1
 3RCnDB6gNUX6j/O1eIqj4dm/RA==
X-Google-Smtp-Source: ABdhPJw0bvEXCoTIQkwenYeNvycaSrS/RsZDPYi3PCztzPsGcYyCKEVPwrgakM0ckoRkVXGbsYR/LA==
X-Received: by 2002:a05:600c:2c4e:: with SMTP id
 r14mr4482036wmg.118.1589879284802; 
 Tue, 19 May 2020 02:08:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r2sm20314636wrg.84.2020.05.19.02.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 02:08:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2D0AB1FF7E;
 Tue, 19 May 2020 10:08:02 +0100 (BST)
References: <20200515190153.6017-1-richard.henderson@linaro.org>
 <20200515190153.6017-6-richard.henderson@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 05/10] softfloat: Name compare relation enum
In-reply-to: <20200515190153.6017-6-richard.henderson@linaro.org>
Date: Tue, 19 May 2020 10:08:02 +0100
Message-ID: <87y2poi971.fsf@linaro.org>
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Give the previously unnamed enum a typedef name.  Use it in the
> prototypes of compare functions.  Use it to hold the results
> of the compare functions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

