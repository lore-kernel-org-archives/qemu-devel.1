Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A879C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 19:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F3AF2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 19:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MUtzX8fX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3AF2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb7Zl-0000KO-Jw
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 15:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jb7ZE-0008Ls-H2
 for qemu-devel@nongnu.org; Tue, 19 May 2020 15:06:20 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:40692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jb7ZD-0002uT-EU
 for qemu-devel@nongnu.org; Tue, 19 May 2020 15:06:19 -0400
Received: by mail-ej1-x630.google.com with SMTP id d7so232825eja.7
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 12:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=QgPKpQQtuYrSNnmPv6E5B/ynxwy2ocKd85IWF8vvndc=;
 b=MUtzX8fXusvLYNw5cxPh7n3zriNDxLEFMajc4jgZdAlw3BHSuDxqMmrpgGaw6YM0rz
 TkV89z65xVOgqSd1NEEprf4TB5grDfX//MWzhb/3TDC4ejmxhqbBUT706ibqFCZvf/BN
 VF9FCoalREVGBYr4ZHLl+9rMdzzn1b6ACWReHvNvlinBAA/aQqxAG9OiajS2tZfjTGXN
 1n+hysdB8jHVpsFiy/yrc3AWehMG+2y/2LaWrc009KgHp7ofiJ6C+wjroAGDlc7yBi0D
 cdUHTbE/5mZ7Z38G++1gzPaBQXbKDzU+Z5AxH40mrUwl2pS12nUVGrfYgyZMif5Q3MXK
 MKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=QgPKpQQtuYrSNnmPv6E5B/ynxwy2ocKd85IWF8vvndc=;
 b=dIde8J6UYOuDFCqPg45ARRoH1zQt4KOkykuNLVfVQ1iRuvOZfy89YX5go7xvr540Oi
 0tiKGZcf5uCFQOfapJ6HbSOqe3x2yw5+obBERXraCl65SUgJwkdJr4w9rXJ6ODdO1WJ8
 w19AwuQLPpW+aY/6qZG/l6xv9Ua+dwu4ANIqPTMNaMOUsKnFlFsN0a4ti7oZWx7lf0AV
 iMyoyTWkk9JncVEV3EiRELacNgfKu6uVOho9cqIa0qKGMFF+DEraU/k7wZf/O8MnAQc4
 x6sUGLmBH7bA89oloGBpzMQ6rveTQEpOmcCRyRogEMICiiurHMPpJRemJ0QzEUR0tNev
 A7Rw==
X-Gm-Message-State: AOAM531Gfb4HIsiSimkXjFtk5Oy2fzb2FYgvsTYcEpJzDbCCQVDMRz9C
 zTAWJENNDFnx9WrnEyh47+hC+A==
X-Google-Smtp-Source: ABdhPJxmu+47BDvNTIG9a9QHC8dP1OKMIfGCTUsOpeEpKbK46DJi9yZq/92KyRkT0eqDbnvF7cipBw==
X-Received: by 2002:a17:907:20ee:: with SMTP id
 rh14mr681251ejb.158.1589915177508; 
 Tue, 19 May 2020 12:06:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m2sm194267ejb.33.2020.05.19.12.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 12:06:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 707421FF7E;
 Tue, 19 May 2020 20:06:15 +0100 (BST)
References: <20200519025355.4420-1-richard.henderson@linaro.org>
 <20200519025355.4420-9-richard.henderson@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RISU v2 08/17] Add enum RisuResult
In-reply-to: <20200519025355.4420-9-richard.henderson@linaro.org>
Date: Tue, 19 May 2020 20:06:15 +0100
Message-ID: <87lflnhhi0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Formalize the random set of numbers into an enum.  Doing this
> makes it easy to see that one of the responses in
> recv_and_compare_register_info was inconsistent.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

