Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2035C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 15:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9721206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 15:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+2NCD9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9721206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYAdl-0006ba-QR
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 11:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYAby-0004ec-IL
 for qemu-devel@nongnu.org; Mon, 11 May 2020 11:44:58 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:33751)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYAbx-0001Oe-Bf
 for qemu-devel@nongnu.org; Mon, 11 May 2020 11:44:58 -0400
Received: by mail-oi1-x231.google.com with SMTP id o24so15486434oic.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 08:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=9lGiUmEICVC5O/r/QCt9umIePwfJH0Mz+71qavzeW4Y=;
 b=F+2NCD9FR3QJyySkplbB5hUZLEdBiUdurbbln77B5ObyKf9VjdgjkWYF+iA6dkj5IV
 rFU26HbWbDnXfoiTlEivApi3XFnAqJE9enqN8CjkN3qupceubke8+LNU+MlHxmgshNyc
 QAHcWYS6LRMa2Xt4q31Qu1XYtuT6ZsuVMhBlqXV5C3EgWvstpKH+YQDCVSpiS5VbuPJN
 VaAlUeUQh2I7cU1qIPuQR6ECmMbWj7eLzD5fP7/HvoTXMXUdQprTXcb5Ad+UYB8kpNBW
 CMUoa2b1/29S8l4uMU0jdz8Re3r3glCv45WlxHAmAPt9AaZN5QxcbVhHEHNbPSXEKrgp
 mvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=9lGiUmEICVC5O/r/QCt9umIePwfJH0Mz+71qavzeW4Y=;
 b=mxIYbVSUvOSvOfdsjKhm3zm0QhHRP1RiqnUMRuxymJKEa28NaxUhjvsnIxCejbX+vP
 OIlc34/anqdDJNyCxo5dvQgpSD03TIhroCoO8bTqZ3uT9GAYGLEpF4IwerTHbGgCpC+3
 c/gxdJM5UL2+R1LhGE+WKbMTeTLXWbJGrgfEIFiuiN6DUQg+/W2y10mCNvqFMH4Bx7Lh
 jxvqYsRW+LFcB+OzrAnoB8MUlU+K+2WwY9WHyDrcBPFzk63sji0ME8v3tjFoU1cSYU5O
 ygcklYXVvS+O+Nwx6jk3n+ZHMoirCB6Sf7iv/uoWCf8Gd0TN+5wv8Q9Q1TDXaxafel4z
 jAYQ==
X-Gm-Message-State: AGi0PuaQLspbKAdD9Nh0P+2m3SUZ8Idcnz88e3UeDiqd11yaY9//XIcI
 M7LgopWSJNOLKoERD6Y+G86heqYAnKHL7QbF3dAqn2XQ
X-Google-Smtp-Source: APiQypIUJjqNf5Df472L7yJXLh4NMHCfcjBu8sy7DIfb5MRsP9mzh6Fe1aIjpPa2uuhKJPZ4WAe4WO20UcOoDMHsp4A=
X-Received: by 2002:aca:4a45:: with SMTP id x66mr18845037oia.48.1589211895754; 
 Mon, 11 May 2020 08:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200511133405.5275-1-peter.maydell@linaro.org>
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2020 16:44:44 +0100
Message-ID: <CAFEAcA_W6tnxPqwcyi793UDQVjDUNuOf-9K5imO4KmFT-zgomg@mail.gmail.com>
Subject: Re: [PULL 00/34] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x231.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 May 2020 at 14:34, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The following changes since commit c88f1ffc19e38008a1c33ae039482a860aa7418c:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2020-05-08 14:29:18 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200511
>
> for you to fetch changes up to 7e17d50ebd359ee5fa3d65d7fdc0fe0336d60694:
>
>   target/arm: Fix tcg_gen_gvec_dup_imm vs DUP (indexed) (2020-05-11 14:22:54 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  aspeed: Add boot stub for smp booting
>  target/arm: Drop access_el3_aa32ns_aa64any()
>  aspeed: Support AST2600A1 silicon revision
>  aspeed: sdmc: Implement AST2600 locking behaviour
>  nrf51: Tracing cleanups
>  target/arm: Improve handling of SVE loads and stores
>  target/arm: Don't show TCG-only CPUs in KVM-only QEMU builds
>  hw/arm/musicpal: Map the UART devices unconditionally
>  target/arm: Fix tcg_gen_gvec_dup_imm vs DUP (indexed)
>  target/arm: Use tcg_gen_gvec_5_ptr for sve FMLA/FCMLA

Applied, thanks. (I just blew away the broken build trees which
had missing .d files -- it didn't seem worth trying to
investigate why they were missing, and they've been created
properly in the rebuild.)

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

