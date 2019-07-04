Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B755DC06513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 09:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82686218A0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 09:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GWMrjGWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82686218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiy6u-0005UK-R3
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 05:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35937)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiy4c-0004PX-R1
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiy4b-0001wD-HS
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:30:38 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:38097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiy4b-0001uE-3Y
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:30:37 -0400
Received: by mail-oi1-x22e.google.com with SMTP id v186so4464718oie.5
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 02:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PLU41fjeeau1htQG/XoezZhx9188QQyLIRDjopiHOsg=;
 b=GWMrjGWqYF6jU21/5CGvZhLkXBhACzwxdeGzphRmpaO+a/Nixz2GZ5VZs/gynthjUw
 aANLW3XB+9Xz/eyOBXSZ1CQdFmGiEqZF6vgjUweWa/Oi2c+Q+QqD+24qgphKyT3bHcMx
 HO9nDexycYGw3M83MJn+32nSAlS/DhDUa2HlJ4DLLE/ARrgZk40kAhMVp3mTn6W+Palu
 ymrsb4c5LMy+/6ts07uKlGLddeDuu2ktoWjnwouSvHx7SiV33viuoZ4xZM0oJjwfPPJL
 fpPRkmAGYobfFT1FJtYiCjlDmM1ZGPTXyV2Jj6MIV7sSHWof+V8p8nnzzLVjCNy+F4hA
 +N9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PLU41fjeeau1htQG/XoezZhx9188QQyLIRDjopiHOsg=;
 b=VsAYbued+0c5+U1hebEayCx7ru2b0UPFqob99unsVaZiK7NI5O9qcXEQ2kdeiPgBzX
 E8sjCs3N6COXqiO6tGptDXKSVoTo/G01e+dJT85uD3Zo+Uo+rgtP4xaVmTmqhZiJiiot
 G4fyZjbjprxCsv/0UW5TB38vq4g0LkFwxB0X/ce+QUmQiXM4OReagqtdK0WUqCjFKc9d
 x0n+3Tsrnwb4qOC+V0QccZZX3Nv5RNE7qizRHHcvLO0Y3zai/olZxUiUwBFsP5Zd4hj6
 TWOmU+P7bj/UHGJmn9+i0BptHL0iDi2ul5fG90/h0qhP3NlKIB9ilXGGkrsylyXvdgRe
 N3wA==
X-Gm-Message-State: APjAAAVneHtspkNdovAObCfpyK7z3TQ9KJt8hdGQITXqiaPFZFS3Z5oA
 g/xeKbmV7qmcuf2jFhefIu7zgRkOj/j+8tyPbI3r9w==
X-Google-Smtp-Source: APXvYqzfjlgqflFev6C06q534MR4RXFtSNQtRbDbgY/k2Km149D4LB7nsQwvmRV2Sf/IcCkkssyCoC2B4x+LuaAfl3w=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr1367404oic.170.1562232635642; 
 Thu, 04 Jul 2019 02:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <156220045355.21218.10996548601675268562@c4a48874b076>
 <nycvar.YSQ.7.76.1907041145470.6795@xnncv>
In-Reply-To: <nycvar.YSQ.7.76.1907041145470.6795@xnncv>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2019 10:30:24 +0100
Message-ID: <CAFEAcA8hdnUykMtXqd9FBtD3-JziOZjYWeAcmcvJVKf+SEgUqQ@mail.gmail.com>
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
Subject: Re: [Qemu-devel] [PATCH] hw/ssi/xilinx_spips: add lqspi_write
 routine
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
Cc: slei.casper@gmail.com, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 4 Jul 2019 at 07:18, P J P <ppandit@redhat.com> wrote:
>
> +-- On Wed, 3 Jul 2019, no-reply@patchew.org wrote --+
> | Patchew URL: https://patchew.org/QEMU/20190703190615.31436-1-ppandit@redhat.com/
> |
> | This series failed the asan build test. Please find the testing commands and
> | their output below. If you have Docker installed, you can probably reproduce it
> | locally.
> |
> | === TEST SCRIPT BEGIN ===
> | #!/bin/bash
> | make docker-image-fedora V=1 NETWORK=1
> | time make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu J=14 NETWORK=1
> | === TEST SCRIPT END ===
>
> This patch does not build for x86_64 target. Not sure what's causing the test
> failure.

It's an issue currently in master, which means patchew is complaining
about every patch sent to the list.

thanks
-- PMM

