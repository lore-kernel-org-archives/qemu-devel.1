Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF16C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 14:04:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973652158C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 14:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXtHSmhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973652158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZDxn-0002jF-D1
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 09:04:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZDw4-0001kb-H7
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 09:02:20 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530]:40291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZDw2-0005ZF-Jr
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 09:02:19 -0500
Received: by mail-ed1-x530.google.com with SMTP id p93so11447272edd.7
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2020 06:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B1vfD/Upk/o86+TNLq24gmTbYD7GApKeoSWcCqy7BFA=;
 b=UXtHSmhYQZ54iaJcd6CJ4kjbCCI/SY2Ti3SeD26mTzENHswW1ekeWWFoEqf/OmEwR/
 44mN/LKAemVRlSwVaEqcajpL6NleEgqZa0VJZJpdzwW+E4B9Nj4y2MONzK/V3fixR4rD
 kQLZSXwaah1XTTuJPNs2eZEIQxpAyLUci498gfDWgJ3q4Y0cH8xjuWuj59K3FkoWna+U
 uNrLjy3cGb46HMQ6zFhTOTjM5EvJDHvaLQDLVti82VBF5zS5tXKmbaqhkwaa5kSUWRsN
 DPCp3/n8oVHJq++INQaReKbNx3jJS082i8iM0e8ctpQ+sVZIajU+MvYenvcAnYkUPOPN
 yfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B1vfD/Upk/o86+TNLq24gmTbYD7GApKeoSWcCqy7BFA=;
 b=PSkYAuRn+rmIlzv/pimyM1kEaLCoovjy5qfTQBDxblTgkOELfhiv7bFID/pA5Iwtr2
 qPmO3jfm02ml6qFUtu4kQ1zuGHQ3FNHLXrfVLKi+UppEGi0Njbab8eRh4ehnKjmelF4J
 LRtAlJq7NTsab2xkPIWRoNGRzN3wRcde1UG2Mdqj3mT3di4bXlHP0/hrf8k59VvkmRWQ
 bWXmHyt5mV7H1jHKft1aYi8AhgwNjE9Jzh81w39rwrZ8ztL+qCXVyHCe16y4lZ6NIkG3
 0tUTBxGJnsfW9Weu3r6DyNaFQK2oZYvULENIDrJcLQYAIFEfBAVRO+FD6hFQgic8dvkM
 eD8w==
X-Gm-Message-State: AOAM532HXbF8/lMIe1K2FPGkOBRX5rbkMOInMya8MwYUOyK+AngkWZZv
 RXMouJ72P5RLCdl2QApb3HLwhMo4C/Vy5rKIkK6+xA==
X-Google-Smtp-Source: ABdhPJzBw4y1zakEqZ8YPhzftoygcDzuHQv/4+MDtKTWTAb8+snlUcUqlGT0UtUYpfKtYPYSv9C3RZRK3lwgviNDN7Y=
X-Received: by 2002:a50:fc87:: with SMTP id f7mr523802edq.36.1604239337182;
 Sun, 01 Nov 2020 06:02:17 -0800 (PST)
MIME-Version: 1.0
References: <20201029141358.3102636-1-alistair.francis@wdc.com>
In-Reply-To: <20201029141358.3102636-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 1 Nov 2020 14:02:05 +0000
Message-ID: <CAFEAcA9cTDhKjcvOL_QaeeDjWKUPaLxh22iueE0s4i7+WtMtiw@mail.gmail.com>
Subject: Re: [PULL 00/18] riscv-to-apply queue
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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
Cc: Alistair Francis <alistair23@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Oct 2020 at 14:25, Alistair Francis <alistair.francis@wdc.com> wrote:
>
> The following changes since commit c0444009147aa935d52d5acfc6b70094bb42b0dd:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qmp-2020-10-27' into staging (2020-10-29 10:03:32 +0000)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20201029
>
> for you to fetch changes up to e041badcd4ac644a67f02f8765095a5ff7a24d47:
>
>   hw/riscv: microchip_pfsoc: Hook the I2C1 controller (2020-10-29 07:11:14 -0700)
>
> ----------------------------------------------------------------
> This series adds support for migration to RISC-V QEMU and expands the
> Microchip PFSoC to allow unmodified HSS and Linux boots.
>
> ----------------------------------------------------------------

Hi; this fails 'make check' on 32-bit hosts:

qemu-system-riscv64: at most 2047 MB RAM can be simulated
Broken pipe
../../tests/qtest/libqtest.c:167: kill_qemu() tried to terminate QEMU
process but encountered exit status 1 (expected 0)
ERROR qtest-riscv64/qom-test - too few tests run (expected 6, got 3)

and

qemu-system-riscv64: at most 2047 MB RAM can be simulated
Broken pipe
../../tests/qtest/libqtest.c:167: kill_qemu() tried to terminate QEMU
process but encountered exit status 1 (expected 0)
ERROR qtest-riscv64/test-hmp - too few tests run (expected 7, got 3)

thanks
-- PMM

