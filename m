Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531C5C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13AF9208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lH50E6tW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13AF9208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48882 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcuAu-0008Bd-BP
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51880)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcszc-0003Oi-Dc
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsza-0003rM-3h
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:52:20 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcszZ-0003qh-Vb
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:52:18 -0400
Received: by mail-oi1-x243.google.com with SMTP id w196so7195249oie.7
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QJZR1Az/4V69kQygQp+9DMhkA03qEndikj3JJAFD+6U=;
 b=lH50E6tWEvW7O1JnG0iKdOE4POA9mQil+6E4ZeO8VEzo28yuPihqSZaCblVoFNxBq4
 4aWpeLEAY4sqJzinvLAuyyRlpKutcArQca6TNn2EXFhTyBvK0JCwrOU3eu5j4ElXKCfM
 LfCBrEP4zI9VBvUMMPtCTI/kZpRNnWIGu5YsYAiRLjYr00l3wY2P6ZrVhPBvnLcfDpRG
 kpsGdjZuY81a8srfHszh2x78e479+OpWoBukJTlw03JqJ5vrMQjSoLbx/SGFLDKrgPiJ
 JvuR4XXr0x2CztuUEbq1F0hq1kPPH29dcfEWRJLfY5rKGX71ohWn0vqNe0IqDMyZNhL3
 TOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QJZR1Az/4V69kQygQp+9DMhkA03qEndikj3JJAFD+6U=;
 b=Fe21zlxZtT8lzUR0qdT3XkUEabxUKtdNXl6QmwTG/Vp9T+m4Vj+R1jCCMUza5RW+B5
 h39Imm/k0mPcOJm1SEcDXPf6TJ2dgGlYjjbcyrLe160lKFXy3OjP0MyWVGxFj4qI6Cg2
 Z+j46KGecuF0wJO+9zisVtWsa6a/RT3jRJzMQbxgTAN/DaGALvVn89NFF8AT2bNVuHWC
 WaBptk220eTAklUKqX1XwKPBGYU6yWDNeO67KEDDHFbRlVzJjTBI4klw1ElZYhhQD2Vb
 BygkDS4AEcmU3hgWSD2dNnZ1SI9jTs2Gv++If5BGyWGc8YhO/9VhqOEnSPAOVsWDpcJo
 zILg==
X-Gm-Message-State: APjAAAWj5a3LcfCjteweBjtJRVkd+Rp6lpwjQwgBSa+SfanAwkibWzRR
 faMR1m5bib2BHDqeZY3aQbs22lBeLf540OnIoW31dg==
X-Google-Smtp-Source: APXvYqyh4oqRnWa1TDP75Wpicn3TAEw4pvR4VUGNApwJUO6lZGb9WdDek4PWJFuCym4FnH1eLh6/u/6CEoqSlbRnSCY=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr10102300oie.48.1560783136786; 
 Mon, 17 Jun 2019 07:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190615154352.26824-1-philmd@redhat.com>
 <20190615154352.26824-19-philmd@redhat.com>
 <87h88o9svq.fsf@zen.linaroharston>
In-Reply-To: <87h88o9svq.fsf@zen.linaroharston>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jun 2019 15:52:05 +0100
Message-ID: <CAFEAcA8t7EYC6PK24oHcsGsD7PazuqCzGcLuwiMmh2C4dKJF2A@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 18/23] target/arm: Move CPU
 state dumping routines to helper.c
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Robert Bradford <robert.bradford@intel.com>,
 Samuel Ortiz <sameo@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Jun 2019 at 15:41, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Hmm so helper is a mix of non-TCG and TCG bits whereas helper-a64.c is
> basically just TCG helpers. It makes me wonder if we are breaking a
> convention here as helper.c is traditionally only TCG helpers.

The original convention was:
 * op_helper.c has functions which need access to things which
   TCG puts in specific registers and which are accessed from
   C via gcc "register variables" (most notably the CPU env pointer)
 * helper.c has functions which don't need access to the register
   variables (a mishmash of stuff, usually including interrupt/exception
   handling)
 * some targets further split out some parts of the C code into other
   foo-helper.c files
This distinction became entirely moot when we reworked the TCG code
to no longer use register variables (but instead pass in the env
pointer and so on directly as a function argument). You can still
see the comments at the top of target/i386/{op_helper,helper}.c that
claim this is what the files are for, though :-)

So these days there is really no fixed convention, except that
when we've added new things we've sometimes put them in their
own .c file. helper-a64.c in particular is on its own because it's
code that's only compiled into aarch64-softmmu, not arm-softmmu.

> It feels like there should be different file that is unambiguously used
> for both TCG and KVM based workloads where things like the cpu dump code
> can live.

Some sort of split like this seems like a good idea. I don't
know if any of the other target archs have already got a
good convention/naming scheme we could copy?

thanks
-- PMM

