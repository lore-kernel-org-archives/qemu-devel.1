Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A282C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BA8F206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0uKjrT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA8F206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZWrR-0007OQ-4R
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZWqm-0006Vd-KZ
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:41:52 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZWql-00030d-Ig
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:41:52 -0400
Received: by mail-wm1-x343.google.com with SMTP id d207so13441438wmd.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 02:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=27IvqNBZtDe5pUkO8ZNYUfM00vstH55dm6rlxVPzC+E=;
 b=s0uKjrT+lsz7cQI8FqM21WCWh50UUkZ8+stW94oVszbeDGYBT0eRtIF5WgH+lm4Sp8
 rFaVoIezJPjGH/Mt5AyjaUMIW3uL3SpqZd+LsLVkUb2e8Yizy2RGSpSmfMsrjF3hzzuE
 dAKHfl2jf63M/H2OXEsvvPvxAz0hf4uwT3XY0HxOiVZkzWIrkxy+sEWbfBg4wzkL8O9R
 leZy+7rpnRKDguxFIIzZXtC7j/8OQsCyY2MN8QNtkez2kuDoAVubRUwt5tgqTNxUBjdJ
 11q8h/p0M8XYyoGE5b1THagTTOnxljcpc9cex9u0NES/ZWoGcM9O99ayNxlg7la39+VL
 fyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=27IvqNBZtDe5pUkO8ZNYUfM00vstH55dm6rlxVPzC+E=;
 b=LafS1jk6lIG+Xt8HhiILILPNgKjsCOkicYcXFeI2tgpMOvCCzC8sTfmaUpL3a1Rcb8
 JLme5ZGMIUCUs3KbX1c5nvdHQOkOcfyvwgxVbH7Sp/Ew1Xn/AbkTz6l4+5KB9hfGbe+P
 9s+DuAi8FjOCYVESLt1o8t1SAzq21k7EcHITfY4j6GokJX7mfhZHXhdIqwt2Pj3vUg9F
 FHABQCQCwJtgRfXYp4v0tQZjGSsEuhUqHkGGQJV1omg68apUxNkK9wfq4fZDOuBPuyHL
 u109gp69TD1Fks+VL1G8FvW6zUQ+nawNJHT694leAMmUlHwlhemz1O7M/ML3TlB42FZa
 cg4w==
X-Gm-Message-State: AOAM532dQ5kkXs2mrQe5SHY9JU+66fq+xX23Xzn5O02mMSzHLH19xoRX
 5p6qXcH7fEfUbM4Qlvdc6Qa4vg==
X-Google-Smtp-Source: ABdhPJyBWLpMN8i+b4pyBImnMKci3TAssLXkQPYY5ym3aJ8VqzjUOYVlJ3TC+5djmLUNxNb42cTG7g==
X-Received: by 2002:a05:600c:2f97:: with SMTP id
 t23mr3156501wmn.150.1589535709913; 
 Fri, 15 May 2020 02:41:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s17sm2709045wmc.48.2020.05.15.02.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 02:41:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C267C1FF7E;
 Fri, 15 May 2020 10:41:47 +0100 (BST)
References: <20200507151819.28444-1-peter.maydell@linaro.org>
 <20200507151819.28444-3-peter.maydell@linaro.org>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/5] docs/system: Sort Arm board index into alphabetical
 order
In-reply-to: <20200507151819.28444-3-peter.maydell@linaro.org>
Date: Fri, 15 May 2020 10:41:47 +0100
Message-ID: <87mu69cz6s.fsf@linaro.org>
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Sort the board index into alphabetical order.  (Note that we need to
> sort alphabetically by the title text of each file, which isn't the
> same ordering as sorting by the filename.)

Is it possible to leave an inline comment in the rst to this effect so
no one mis-sorts it next time?

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

