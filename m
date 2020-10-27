Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D549C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9CA720708
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J49vMaxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CA720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXLUz-00060N-JO
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 05:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXLSt-0005O4-DN
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:40:28 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39410)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXLSo-0001pf-4K
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:40:24 -0400
Received: by mail-wr1-x442.google.com with SMTP id y12so1085930wrp.6
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 02:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=F4wCHu4DUVDt6Js7s9qPe25jdZFqFJmRln+6pD6mB08=;
 b=J49vMaxCnranymOcyZR20yuf1rWiQvJf1KQh0tWMnE0x52H7F6UsE604xySqpQrwR6
 AbHkxZRb/zw+57fAqCtEHk1s21NUMOcXYq9LNStCZGWt+szjISLVfJqMycAqawqkXdgV
 PjmH2fN0UJIucKhH4VDiDpCpBqCNMGrpkrdlU7HsBFwIElGJvAG43xZOte/pHAY6OPxU
 ivsH1aMvMWIdbpwXlzLhDtr+77DxFN4yl8u/U8GGtl9kdbxJuqpIvPdrB5bfavwKlaJM
 Fawe3/GKk67do7/2SZbXGfiiknMH09l64UmVG33uVMaQmwmSVFtaOblhGIOsGOezuCrC
 n4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=F4wCHu4DUVDt6Js7s9qPe25jdZFqFJmRln+6pD6mB08=;
 b=aA3/tURXiqvbyaCR38MVdaBHzi1TUCV1JBNtWkz+Re8+/AK8jvVYyI3vx7ifLrp7/Z
 nTubMFrikCEmnpBedG6HLWvnX3+6gVJI5QL8CWsThb0tht2QYkiUqLmGuzpWE72fzL2E
 GKGwCPpVSI+LlQAHvdmIWYjebxapxEb+x2lOPL4FOfHKtTGN+I8MKOx6Al8v0wFIKYkW
 tVFLilZ7cbLqFX3MFNtJmt+QOS0XIkVRiJWoY5HhbkAaI//bCw+XSMGv8LT/Hfyxp/DM
 FsdU/pP/kGqDIZS9GR447h9mcIEeHz6f0D25mEs3aU5TrcBN5P4WPy4TeXtB/e2HYrr7
 Y/bw==
X-Gm-Message-State: AOAM532O23MZVgPTOZGaoDS91PrkVXVsH0vpEb54IOLokplL089e5oae
 h+qOj2NYJJzU79i4wbAyLprzJA==
X-Google-Smtp-Source: ABdhPJxeEbY/JT+He5iF73Kh39mufbEbilgI6MLIWoa179fIklEOyWqH589xxkpzqm+xcOaRA1bb+g==
X-Received: by 2002:adf:f2d1:: with SMTP id d17mr1776393wrp.122.1603791620403; 
 Tue, 27 Oct 2020 02:40:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c1sm1293627wru.49.2020.10.27.02.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 02:40:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D9D521FF7E;
 Tue, 27 Oct 2020 09:40:17 +0000 (GMT)
References: <20201026195131.13848-1-jsnow@redhat.com>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2] CHANGELOG: remove disused file
In-reply-to: <20201026195131.13848-1-jsnow@redhat.com>
Date: Tue, 27 Oct 2020 09:40:17 +0000
Message-ID: <877drcf1mm.fsf@linaro.org>
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
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


John Snow <jsnow@redhat.com> writes:

> There's no reason to keep this here; the versions described are
> ancient. Everything here is still mirrored on
> https://wiki.qemu.org/ChangeLog/old if anyone is curious; otherwise, use
> the git history.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

