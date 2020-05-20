Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B9AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1186B20671
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oXGOfpHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1186B20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbR0B-0003Jn-5z
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 11:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbQzE-00029L-Cz
 for qemu-devel@nongnu.org; Wed, 20 May 2020 11:50:28 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635]:46792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbQzC-0000W8-2X
 for qemu-devel@nongnu.org; Wed, 20 May 2020 11:50:27 -0400
Received: by mail-ej1-x635.google.com with SMTP id e2so4388674eje.13
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 08:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=JYySXSGBzvnYQydgCEKyuRrWuQWLku8R683GWpWrstQ=;
 b=oXGOfpHv5I/xLnQ3cwdVGSEYKYIkZn8sbvwkWDXlZ/xjL/CdsOEhrsC7uLXnQ40Su+
 Ym4GRBNjmgjXKRoNMFMapeAOschSbDMudsTU6Ha0sYac6xFdtLux0gyyzEUEddDigG5v
 3+WFGQJZY3rocxy3tPNLhnpthMEKT68lP2APwGiN7rzsH1hHKdoksRr6kfl+OeD+CQyi
 nmdbe+72wnDzNUHrR4/f/BUPjTFWyGKoAiBd6gTDbxL7i5U4oOHbNo7AbD58kByWgcHC
 FtkUKtf9q4yimhuy7r1RAwMLsrTzV85nGVIu+bGoHDLnhhp/zECizV/oM72UUMTR7bHu
 7cBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=JYySXSGBzvnYQydgCEKyuRrWuQWLku8R683GWpWrstQ=;
 b=qbNk0JOyYRbJ/RURpliCnfn6yhObUWJU/O2C8Na8bcP8x5h+2BOLJd5WPhWuCEmu6K
 hQog4mcTTE+HaIAqgnud4B4n3OW1Oczv4TRlrSyKIQJNuzS0hRCTgTSdp4+x+rke02v/
 xI56SVxtrPKgyNHyl+Cx6NwO9vtxcSDWWUDSgX3AwdZQE53Y+1SAk1ko5FMN6McX1eW1
 6ZzPGmCfG8zQx/VBhpwGZlZ6LRvsE5tddVW2j3L0gRjkJ6s7m2ggoy01lLpGajZU6o1l
 fVvYM3UOGSmx6PUPoXArBoLh94y5X/8UYiOzRy+fXXi9kWGfSygqWvU+Dw3cN9R0cDHi
 kz2w==
X-Gm-Message-State: AOAM531SlfqNnmOs0XNTUZSsZmrMRuvyf5vU+05CprBX3b4//rBqB5Rt
 22N5AwTrjU3gN1mMLAUirBDZhQ==
X-Google-Smtp-Source: ABdhPJwkQtau0sj7WLhIu091Bto5KGXOBHI/yDtT6x/mZEZSJii1SHGYHEOqWbmWkPDuKUY8PevsjQ==
X-Received: by 2002:a17:906:7256:: with SMTP id
 n22mr4411730ejk.31.1589989823618; 
 Wed, 20 May 2020 08:50:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j12sm2124250edv.47.2020.05.20.08.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 08:50:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 658261FF7E;
 Wed, 20 May 2020 16:50:21 +0100 (BST)
References: <20200519025355.4420-1-richard.henderson@linaro.org>
 <20200519025355.4420-10-richard.henderson@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RISU v2 09/17] Unify i/o functions and use RisuResult
In-reply-to: <20200519025355.4420-10-richard.henderson@linaro.org>
Date: Wed, 20 May 2020 16:50:21 +0100
Message-ID: <87a722hagy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

> Push the trace check down from the function calling the reginfo
> function down into the i/o function.  This means we don't have
> to pass a function pointer.
>
> Return a RisuResult from the i/o functions.  This fixes a minor bug
> in send_register_info (even before the conversion to RisuResult),
> which returned the write_fn result directly.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

