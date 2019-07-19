Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E657AC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 11:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A81A920873
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 11:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YsYUmOPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81A920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoQgR-0006Ae-NV
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 07:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33011)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hoQgF-0005kZ-AX
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hoQgE-0006Vy-4S
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:04:03 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41690)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hoQgD-0006V5-Uo
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:04:02 -0400
Received: by mail-ot1-x344.google.com with SMTP id o101so32322687ota.8
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 04:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JYrtC1sSkkGJUCsJSw98vNNWQqy30ZKlBnj9ldQDtvE=;
 b=YsYUmOPjTbRloqTeYwyO6HietMOeOscuycmD2wkmEJMxlPry3kDa9VHQGgXNNDQyj1
 X0/A4jPDdFQwmMX4XDhZWyDFL7mxa1yg3A5/hBogZcWWYm9JtALkINhfYscANtTjfgUa
 QfbibwaMpyRBsAn8eSRCUURRYeWrxrkuJCsUapqTL3LUuufINy2EaubfdwGEFRnz+M0n
 MkCV0wOOsYgz4sWlTFG1hJ7myR4+e0t+vkENuoHJtMjcEANlONPniOoovGh41PSzgzuV
 /YPHHj6Z6YKCPkgeh4b7OJPJ+ZnCQUQtB/s7/FQvUo9Tz3QAPg2D4T5s5/gp0pNRkVWc
 v4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JYrtC1sSkkGJUCsJSw98vNNWQqy30ZKlBnj9ldQDtvE=;
 b=orAjg0gwL3U7weLmLXy7Mg/tGJebuySJyCEouCSb1iTPadCYiPC1er/5BBod3wZFGs
 b04fdeV1nzZU0fRMnVioGXBjQ9E2DQawK6MjH7lCUZeyGDfvK9+kji4fateN8oRR7k6M
 b3NeLjhmWYEDHXboSHMcvnwx8jlc51Is0zCuJcW44MZClyMbwDC1m8yfwJrbHwRUrjdl
 gAvq6t8ZqI5GcO/fyehTGp3Hu9FadSMnmzAYXMz51DPidvTDcUW/6p9qMd7ZTqzDC8H5
 IVPpMct4cdaCQzS483XW0ujlpIKQBHGztTbzJhZSe24/wlf8E7IUAThu6F/RuBoNJDQr
 HhzQ==
X-Gm-Message-State: APjAAAWwQ16za7fl5WypBrnTiU8eqgXNNaFExk93nW6K3I0+KKO8Gz93
 bj4/Fakb7DTKPFrmhYKwZ/qbOY2ZcLClU+l/jMKEkg==
X-Google-Smtp-Source: APXvYqwhPb9r98y+RxxkxVsLb3W9dnlyHMUTTxyQ/WsylE1BNlDEhjr6XcZKTERctSvrac9le/dgauJrKuErdkF5KH8=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr31506347otr.232.1563534239837; 
 Fri, 19 Jul 2019 04:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190719015811.14776-1-palmer@sifive.com>
In-Reply-To: <20190719015811.14776-1-palmer@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jul 2019 12:03:49 +0100
Message-ID: <CAFEAcA_MGz=EvH67twNoM-SMXZ8_pE6FhO+JuLN=0Z1H6sfRnw@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL] RISC-V Patches for 4.2-rc2
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jul 2019 at 02:58, Palmer Dabbelt <palmer@sifive.com> wrote:
>
> The following changes since commit 0b18cfb8f1828c905139b54c8644b0d8f4aad879:
>
>   Update version for v4.1.0-rc1 release (2019-07-16 18:01:28 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-4.1-rc2
>
> for you to fetch changes up to fdd1bda4b47cfbec61d0e63a516c614feea0b00b:
>
>   hw/riscv: Load OpenSBI as the default firmware (2019-07-18 14:18:45 -0700)
>
> ----------------------------------------------------------------
> RISC-V Patches for 4.2-rc2
>
> This contains a pair of patches that add OpenSBI support to QEMU on
> RISC-V targets.  The patches have been floating around for a bit, but
> everything seems solid now.  These pass my standard test of booting
> OpenEmbedded, and also works when I swap around the various command-line
> arguments to use the new boot method.
>
> ----------------------------------------------------------------
> Alistair Francis (2):
>       roms: Add OpenSBI version 0.4
>       hw/riscv: Load OpenSBI as the default firmware

This passes the 'make check' tests but it prints out a lot
of warnings as it does so:

qemu-system-riscv64: warning: No -bios option specified. Not loading a firmware.
qemu-system-riscv64: warning: This default will change in QEMU 4.3.
Please use the -bios option to aviod breakages when this happens.
qemu-system-riscv64: warning: See QEMU's deprecation documentation for details

(repeated 7 or 8 times during the course of a test run)

Can we make the tests not trigger warnings, please?
(I have a filter where I search through for strings like
"warning" because warnings that shouldn't happen often don't
actually cause the tests to fail.)

Also, I notice that you have a typo: "aviod" should be "avoid".

PS: something in your pull-request creation process seems to
add this junk at the bottom of the pullreq emails, though
since it doesn't appear in the merge commit it's harmless:

> From Palmer Dabbelt <palmer@sifive.com> # This line is ignored.
> From: Palmer Dabbelt <palmer@sifive.com>
> Reply-To:
> Subject:
> In-Reply-To:

thanks
-- PMM

