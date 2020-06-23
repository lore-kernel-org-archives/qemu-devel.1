Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B25C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 16:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 971972076E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 16:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qAoNddkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971972076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnmCe-0002pJ-Qq
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 12:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnmC2-0002Pj-Ms
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 12:54:42 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:32919)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnmC0-0006xN-Pm
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 12:54:42 -0400
Received: by mail-wr1-x444.google.com with SMTP id l11so21312552wru.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 09:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Ch4LbcUZyo/u10MPvsGlPUCFmPf2YewDsgxiuyT7lp8=;
 b=qAoNddkBfur8DS1VqZu5jR4gRMA0JEsD4WEz+HBvK2pe/XR3nWZ0QCLbhmSQl48bKW
 L+KLLfKbN7HY9FctzD/WBdAfPrw/PETlVJy06DDuh8gWgu+V/TBLN1FMW/HblU18fvOS
 mJnrf2MRdRQAOSxLtc1mtFtwznaj+1g8binlnCzq2b237hHjkMw4Lc6LrVSVnMbp1z+D
 n1PcnDy1wwZnhmu8+Pj5BB59wwStCcYI1o5GXt+7XcJKR5q4+1uWqWIv1PnUyKbbZRbG
 iR9uGkoN97a+Ue6uU4pMrSv8Qnb+mvamPFDU89wrYmZLtGzl0dvt4zDF1LALz4UT+9D/
 bSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Ch4LbcUZyo/u10MPvsGlPUCFmPf2YewDsgxiuyT7lp8=;
 b=DrAvPwUgS8jGWBgLyBrUymssQmcRyUk1OibEhicZ370InDfFL/UyKKd2Uiq0S8fdOj
 RJD471vQMjsLxwBQKSXDoExBC4TBJrtVI4ORUZ4EpLiIae6XZ9B10QcJR/LyZjZsXdPK
 G+Yk/wa+lBd4g6Ta5KbmSKP3BhaOU5E6ZvI5fQVIY01x3/F/XgE+BrwhhsQNjQR9H5ME
 JBzowvKsz5wcUgmhXIsxUCvFutPZz8Q+39HWXo9AhxL74kk7sJYkVa6Qg4HGY6kh08d4
 lPpe83Yv4MdYfOoDvZ9iPs1dg1I2IfGEE7jEEwndUBCZxPJPGlwiBU1bW6oW137Tt/eQ
 ynZw==
X-Gm-Message-State: AOAM533Yi2aEhcn/DAPE3bXhEAyS8HoGTtYHkED4pj3ACChHyq4GF9hv
 WpLI5r6UhRzfuTO7iwWhR3PiUg==
X-Google-Smtp-Source: ABdhPJzPTMzhUsq0mBf92JCDgaSTj6UvNHwvvfwYWOATZFSCbGzJKA0nLfnrJKXG/ms6OhjE1WiR1g==
X-Received: by 2002:adf:f452:: with SMTP id f18mr2448200wrp.78.1592931279085; 
 Tue, 23 Jun 2020 09:54:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a81sm4903308wmd.25.2020.06.23.09.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 09:54:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D66421FF7E;
 Tue, 23 Jun 2020 17:54:36 +0100 (BST)
References: <20200522023440.26261-1-richard.henderson@linaro.org>
 <20200522023440.26261-21-richard.henderson@linaro.org>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 20/25] aarch64: Use arch_init to configure sve
In-reply-to: <20200522023440.26261-21-richard.henderson@linaro.org>
Date: Tue, 23 Jun 2020 17:54:36 +0100
Message-ID: <874kr190z7.fsf@linaro.org>
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

> Adjust some of the aarch64 code to look at the reginfo struct
> instead of looking at test_sve, so that we do not need to pass
> the --test-sve option in order to dump sve trace files.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

