Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E096C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:58:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 999B92227F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tfylfUBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999B92227F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZaLw-00065g-Ay
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 08:58:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZaL6-0005Fw-7H
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:57:40 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c]:40726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZaL4-0005HH-2a
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:57:39 -0500
Received: by mail-ed1-x52c.google.com with SMTP id p93so14418663edd.7
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 05:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7bjbF0umzUt3cOs92/wgTgV11b7gcFLJAdreC9IFDTA=;
 b=tfylfUBzrI4UK59XEMcaiJXPw37sfBfS7m6owOhJc5ryux4Gh7AxNoWexEkwgZ5qFo
 DRXCEEroLuWBCRGxXjnrgLD4IKAbJNkbT8ejgZOH+081WnTNIyJWfQK9AsznBfxoI2Uy
 BKKwW595kVkqR+7mzk39b9KFGTfqBnsnEUUHdOPRwS79pwfR/xX6DQq30bZsIiMXqCk/
 TQ+93+MjvCw9qD0VAmVCi8vqw5vT/tOJlVZ/S9S+Luvl9wRHqMdBfjmoA9bCllmQABU9
 /3+WuPR23AaWGAPCI52xGCUySA8F3dMFuKCzbXazWKCXIOczKiF5hm11L/eA+DhYHyDS
 0nYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7bjbF0umzUt3cOs92/wgTgV11b7gcFLJAdreC9IFDTA=;
 b=XveR3ar7yXt6iUb6ORiCHybhmPXQa4h3ca3ueI0OIr1tOpk0TtOQkvNlGrvhYIr3YY
 11+MkfZBJHJp5kojMZVqFreZlNPW/y8EygqXkM7K3GSv7mJ/XM5+o3yvOliDn/Y0gzJs
 rwj1NkG8Ve/ndcCc04bCNqZJWq6n10BzgUKe+yDzAXsJL47H3nyPDSy8couQ0HMyRbz3
 WoIXfRwX7XgBSM/geHI8pjX4PXSnB47lLTHT17zinm5sq7wIVv9ZDEy7i6JcoGuf0/xO
 hmLClqT7CMQF+TRFY9T84A/cQkFkUnuTBd82POgvS6rPv3O6yblLScgeeYkNgHeYvTHR
 ljSA==
X-Gm-Message-State: AOAM532XtXzp3B5WGY6B82DaW4oZxEXqdWNqbjkLABjnqfn1oVBofln8
 xCzY27uIzuOOJTxZPkh7nDkM0yQBz4ZQ9is3RJsZAQ==
X-Google-Smtp-Source: ABdhPJy3R35MhViCTSwAb0sHWSsuShJ8d0Hazs/okOCHJOOmdvAcAxBMl9G6Yaof38c9G4uBF8tsIYJIExuh5cVpTws=
X-Received: by 2002:a05:6402:b35:: with SMTP id
 bo21mr17250959edb.52.1604325456188; 
 Mon, 02 Nov 2020 05:57:36 -0800 (PST)
MIME-Version: 1.0
References: <20201027165114.71508-1-richard.henderson@linaro.org>
In-Reply-To: <20201027165114.71508-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 13:57:24 +0000
Message-ID: <CAFEAcA8GOB1ivDj=JyjJb8Y5gfwSJePrrV1eci823H8FX_74aQ@mail.gmail.com>
Subject: Re: [PULL 0/3] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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
Cc: qemu@igor2.repo.hu, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Oct 2020 at 16:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
> ----------------------------------------------------------------
> Optimize across branches.
> Add logging for cpu_io_recompile.

Igor2 reported on IRC that this seems to cause a crash when
using an hppa guest. This is apparently happening on a proprietary
disk image, so no reproducible test case, but the logging of
the tail end of -d in_asm,op is at:
 http://igor2.repo.hu/tmp/in_asm_op.log

QEMU asserts with
../tcg/tcg.c:3346: tcg fatal error

The TB in question involves several conditional branches; the
generated TCG ops look OK to me, and reverting the two commits
b4cb76e6208cf6b5b and cd0372c515c4732d8b fixes the crash.
(We didn't test reverting only one of the two commits separately.)

thanks
-- PMM

