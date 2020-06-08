Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6A7C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF2E206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x2FAQ4HJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF2E206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiJvT-0005u6-3D
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 11:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiJuY-00054A-C9
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:42:06 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39672)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiJuX-0004BR-GJ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:42:06 -0400
Received: by mail-wm1-x342.google.com with SMTP id k26so17010750wmi.4
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 08:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=EgJQGp1lKEC025IE68sporKdJn77kzXSbO8DYbWiUPY=;
 b=x2FAQ4HJYGoaOCbze+y3huqmHqm/1x4Sbyw+k3ceyjTHu6nX/9U4fFvSMNWtbapZki
 blJh2RzEQk4MLKo0EALJDUY2uYjQTKjXrwYFRvG1gKhlSlKsUH42VJ06MSYbzGyOeDBD
 N3IcH/6DMoGqP3H7e3pTRnCFrHvGuI10bP6b8d43Coqz82z3dN51HCGhjdBsQLsSC8Jf
 PmwNZiFkBdm3mXMY16VfM9I96TpCNHkrP8yCzNucBXeVl80AUvM5SAStJKppu4hsja4a
 PsgDgSyGjXqeog/kN2uK7lZ1aik+S+ssGYOKvHzGKllluwRv1fyDOwh68gcAQ9LxIs1b
 FiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=EgJQGp1lKEC025IE68sporKdJn77kzXSbO8DYbWiUPY=;
 b=HJjP+IQwfDHdEiqbr9EymXV6P1GiGSKVjKpJkJv/3IavJvJRQl5k/NuT7yAhWjiXc+
 V1O3HVoILD1OEJlQoSTTTotrgeME4XKe7Poqw1UbDK+DRmTcbLy51rw96u+MlivXVZRU
 o1N+ocN/x/9Pk64/NjN/cUWoDMt2KPu4A2wOT4g7Oi1E/PeyGkMOQGjspx1EZu2mYuqn
 LtMgqKbWYsXr18poU0hgXrz6MkFAS/lsoZCoNR4EUV+gsaf2lBwMmZLE4vdDNkJTr5nQ
 bO9cAXe9RAGSuzD8EofXFg//BnNuknvMieHTa7LRh2CESpTZMhCJuOtZDHEJoNX8puZ+
 cLOA==
X-Gm-Message-State: AOAM530P/Ilmwl5Gr4fJw+2ZAlyJteUA5s2aJPYI7pgUB7qPHqXAr7cX
 VhMd6fm4su200bkgiLWZg0stYg==
X-Google-Smtp-Source: ABdhPJxL4eks/2C7ef5GzI58R7HppDVz0IwvuI/+9Z3Lhm7ofIJN7LWjApAq15QiY+v56hbhKXb01Q==
X-Received: by 2002:a7b:c5d5:: with SMTP id n21mr3249309wmk.106.1591630923753; 
 Mon, 08 Jun 2020 08:42:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j5sm117252wrq.39.2020.06.08.08.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 08:42:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BAF211FF7E;
 Mon,  8 Jun 2020 16:42:01 +0100 (BST)
References: <20200605173422.1490-1-robert.foley@linaro.org>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v2 00/13] Add Thread Sanitizer support to QEMU
In-reply-to: <20200605173422.1490-1-robert.foley@linaro.org>
Date: Mon, 08 Jun 2020 16:42:01 +0100
Message-ID: <87lfkx5zue.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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

> v1: https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08302.html
>
> Changes in v2:
> - Fixed make check under TSan.  With the below fixes, make check=20
>   under TSan completes successfully, albeit with TSan warnings.
>   - We found that several unit tests and the qtests hit an issue in TSan,
>     which results in a hung test.  This is a known issue:=20
>     https://github.com/google/sanitizers/issues/1116
>   - Under TSan, disable the 3 unit tests that hit this above issue.
>   - Under TSan, disable the qtests since they hit this issue too.
> - Split out the docker testing for tsan into its own test (test-tsan).
> - configure:  Error out if tsan and other sanitizers are used together.
> - configure: Cleaned up warnings during tsan build caused by tsan librari=
es.
<snip>

I've complete my pass. I think we are looking pretty good and once the
tracepoints and function pointer stuff is dealt with I think we are
ready to merge.

--=20
Alex Benn=C3=A9e

