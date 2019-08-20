Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E60C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 10:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A15522070B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 10:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EvLGbP0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15522070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i01V5-0000wB-N9
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 06:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i01UM-0000W7-Eo
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 06:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i01UL-0005Ei-41
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 06:35:42 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:33668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i01UK-0005EH-UZ
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 06:35:41 -0400
Received: by mail-io1-xd43.google.com with SMTP id z3so11135182iog.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 03:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E1nsCHiOTFXqRw8V3tz3HK0ndA+NiKw+twh6mpGuzuE=;
 b=EvLGbP0oz36kyG6TUN3mF1Mmvw6DUIa7iWJA+2ADaxd/EOKV8+TgCuT26r2LTjmq0+
 lLsQTsixVW0RYYK4BBEN3SzLKB3Fa0QqZvlOOKzaYRWbmrOdlFRqfkZIWwja0JlKaDlC
 X1vCIYXrQgfQA+/WGcOPnFQRwjdkR2f7TEpscRppN9Rikkz3xCKICOcO766shpt5Qct+
 drYujL06kD/rM0K4rx80NevLvTu1huLvvOn0G+QzRsbXcjAcJliawGcTz6dB2OcokMV+
 17l/PMfVVv7U9XgDSW8jiIo6N2tjvTr4rgTS7lNLOTXfZ7XOokl5wx/r5x+Kl/yaG2LM
 oYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E1nsCHiOTFXqRw8V3tz3HK0ndA+NiKw+twh6mpGuzuE=;
 b=HyJum9Lv/CmpMg8d9UhhDx7kg27cLJy5PAPLJahFr4K1Fk+cYgqOxYYjhHClQ4No9p
 vgRF3RquPeJ0JMYLMni0vWswuAQQu+arHalCWhaIDJ6a7FOmPPC3SxC3DrHcuDGn358z
 6KPhStQPS1+vQycvQdu5tom5dXNYJeiFccQ4+0qI5nxUPbJXFvA/qB2DkdxEac/6LxEb
 YueRnWW8ClwmPhWoXuMF5G3me9+hs7NYIMrWhH12wECdLtrb9i1UDJYWjy9FyUuXpK6Y
 7zweVchiDYa9hsyTNs9gfvL6mVYrxaPggR/ZrnwdBhVHDyatN3TS9Pzkq/B23eNuDG7l
 PZyw==
X-Gm-Message-State: APjAAAWFC2UIB0QcmJdS1DeVfvUvDNHWHdHXl+I+lAVLN67eFRByse3T
 q8UqsJkEuHWMyf5BO3m3kdJWRFr8N5gYuWPfmIA39/bo
X-Google-Smtp-Source: APXvYqwEyhZkzn39LsqNWGTzbh66av4eMhsOTO6Nsf33CC79MSIPiKJkBjVsrZIpiBRj36Qm4iKCXeQQqjCXP5PQb8E=
X-Received: by 2002:a6b:cac2:: with SMTP id
 a185mr30959078iog.142.1566297340136; 
 Tue, 20 Aug 2019 03:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <1565983669-6886-1-git-send-email-pc@us.ibm.com>
 <CAL1e-=jy6vggskJ26rTc8dnaqtqCB0SdfpV9p-NvKdjoBk+Vkw@mail.gmail.com>
 <0cfddc22-92ef-3067-9275-8f4f22ca9805@linaro.org>
 <CAL1e-=h=Hzfm8KZ4ebwaBsS6U=KVcReXpOPT2-vy4OeBktjWkQ@mail.gmail.com>
 <20190819062817.GA24503@umbus.fritz.box>
 <CAL1e-=j0w=OasHidP4W4ND-R3p6Ui7MS0iaj7Wk+c1tVyR09+A@mail.gmail.com>
 <1b486ed4-512f-e5b3-bcd7-9385b689b1cb@us.ibm.com>
 <20190820073114.GC20890@umbus>
In-Reply-To: <20190820073114.GC20890@umbus>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Aug 2019 11:35:29 +0100
Message-ID: <CAFEAcA-qCRH-a7oGj3K_gvBVTq_JR8LjsorZuOKOP+w4pk4G6A@mail.gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc: Three floating point fixes
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, Paul Clarke <pc@us.ibm.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Aug 2019 at 08:36, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Mon, Aug 19, 2019 at 12:13:34PM -0500, Paul Clarke wrote:
> > These issues were found while running Glibc's test suite for "math",
> > and there are still a *LOT* of QEMU-only FAILs, so I may be back
> > again with suggested fixes or questions.  :-)
>
> That doesn't greatly surprise me, TCG's ppc target stuff is only so-so
> tested, TBH.

You might also consider using/extending the risu test cases for
ppc64 -- individual checks of each insn against a known-good
implementation can be easier to track down bugs than trying
to figure out why a higher-level test suite like the glibc one
has reported a failure, IME. (There are already risu patterns
for XSCVDPSP and XSCVDPSPN, so I think that bug at least ought
to be found by risu if you run it against the right h/w as
known-good reference...)

thanks
-- PMM

