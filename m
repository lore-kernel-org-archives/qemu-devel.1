Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66E9CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 15:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC6D2054F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 15:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xzUOGSCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC6D2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMwHV-0006x3-05
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 11:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMwEv-00051I-Ky
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMwEu-000541-A9
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:38:29 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:47026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMwEu-00053Z-0y
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:38:28 -0400
Received: by mail-oi1-x242.google.com with SMTP id k25so14523877oiw.13
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 08:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ADF4pNLKPcIQra141jeDBu7JM40/h0QZVL+PkKIQ7Bk=;
 b=xzUOGSCM01+NSKp0nRWfikesFotJPXXijVD9E4n7ljXvfw1d9HYAoaSjXd2nxkPznu
 RT89/uJfGrDnfcGsbPErDrDr+WA30HZ8zyQwCTgO1OFIhkDag4NDVUna58Pemaq8faU2
 Arxx2pPbOPMRLSLfOGJxxY3+y15LbQ5thZp98yKViAyreK4YMuEX8Z/j1TlQCYpWNiUI
 ZCCYBh4XSd5Y3gSZvONnj4UZtVJlfxibPbClM8t9JXRn/4OJcLmk1sdEPW01WVDTr+3E
 jxx9bWE7mYdhvqqWFYR1OnR1h33tnREytQaLn+nQCHHquEb4yNY0AkTEOXqzDzkrFvZJ
 KFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ADF4pNLKPcIQra141jeDBu7JM40/h0QZVL+PkKIQ7Bk=;
 b=NXVtF4ME3tALJ7xiOlPCcXuehq6kSTNX4RAD9+r6pTQZ21uRbIGV9FS/ixz6f0ch86
 TtpbZ0hDDnyaQRdiroQ6w++5X+VvXzMdQTzxsSqf6S9GwGKGfRgaqbFCJy1NhwyxZ2WU
 JfHO6eH5I0p2C3Vr7ueLbD3crx8tcuMk4zJ2YhlfCfpXN9itH36764dWNhfT/9X0cbkj
 obYCm2hTrXsMcHAAWLTt3tDdGlPxwcpYe0kfgkyk0gH5ORUiJFwU27TTzk/CRqXhu9MW
 m783Gd3tHPJqr5QD8JdsQ6lLyAxSN1BuR3L0AWDx6Lnw/ljATvCw0mdo7KNRTEv/OJ/L
 xLWA==
X-Gm-Message-State: APjAAAVVqyQC/db91LT51qiYdKSNh7G3c/yKdprAYvgx9K2MCk7UVb2L
 6ib+apcAWSZguhJaGY7xtjvHQ1RUOwjMyHQpuHbJAfuyXek=
X-Google-Smtp-Source: APXvYqzyY+y9p0jQegKcsUQP9/GE9JlHQyJi+9pzNmqqoJ2g4aiRsUjbtea8Sf1QjlR7yPNJe7MbMCEnkbGI/zHn/jo=
X-Received: by 2002:a05:6808:9:: with SMTP id u9mr3599215oic.98.1571758706887; 
 Tue, 22 Oct 2019 08:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191018174431.1784-1-richard.henderson@linaro.org>
 <CAFEAcA-MyKoA63UF6DYQ6J-dKihYn9iyG09eFCgWT8j4OqsQnw@mail.gmail.com>
In-Reply-To: <CAFEAcA-MyKoA63UF6DYQ6J-dKihYn9iyG09eFCgWT8j4OqsQnw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2019 16:38:15 +0100
Message-ID: <CAFEAcA-Xj-6CdVzgfcVONipApD5b5PZ84nPnvbbOQjQkqQLnqA@mail.gmail.com>
Subject: Re: [PATCH v8 00/22] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 22 Oct 2019 at 13:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 18 Oct 2019 at 18:44, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Changes since v7:
> >   * Rebuild hflags for all successful nvic writes (Peter).
> >   * Rebuild hflags for Xscale sctlr writes (Peter).
> >
> > Changes since v6:
> >   * Regen hflags in two more places for m-profile (patch 19).
> >
> > Changes since v5:
> >   * Fix the debug assertion ifdef in the final patch.
> >   * Add more calls to arm_rebuild_hflags: CPSR and M-profile
> >     These become two new patches, 18 & 19.
> >   * Update some comments per review. (Alex)
> >
> > Changes since v4:
> >   * Split patch 1 into 15 smaller patches.
> >   * Cache the new DEBUG_TARGET_EL field.
> >   * Split out m-profile hflags separately from a-profile 32-bit.
> >   * Move around non-cached tb flags as well, avoiding repetitive
> >     checks for m-profile or other mutually exclusive conditions.
> >
> >   I haven't officially re-run the performance test quoted in the
> >   last patch, but I have eyeballed "perf top", and have dug into
> >   the compiled code a bit, which resulted in a few of the new
> >   cleanup patches (e.g. cs_base, arm_mmu_idx_el, and
> >   arm_cpu_data_is_big_endian).
> > ...
> >
> >
> > r~
>
>
>
> Applied to target-arm.next, thanks.

Turns out this asserts in qemu-armeb :-(

/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/armeb-linux-user/qemu-armeb
-L ./gnemul/qemu-armeb armeb/ls -l dummyfile
qemu-armeb: /home/petmay01/linaro/qemu-for-merges/target/arm/helper.c:11267:
cpu_get_tb_cpu_state: Assertion `flags ==
rebuild_hflags_internal(env)' failed.
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
Segmentation fault (core dumped)

Dropping this series again for the moment.

thanks
-- PMM

