Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979EDCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FCAD20869
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VrjTkilR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCAD20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWes-0005GP-7J
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 14:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iLWWB-0004yv-Ga
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iLWWA-0005aF-6u
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:58:27 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35279)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iLWWA-0005Zj-0A
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:58:26 -0400
Received: by mail-wr1-x442.google.com with SMTP id l10so6766149wrb.2
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 10:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=lKt53I7f/6CmozSTncyZXV9A7UBvRK9P650MPucCeC4=;
 b=VrjTkilRff11h+nF8Ta7+TeZ09YtwLrwM07VorzQD/ncWmu54qP9UPy1bS/mj9mFAp
 HEhtNKwOwox+/Qv+9NIo763jBhc4H+2dFBRGppyFMQ5/FtGxXhCHxjLtkH03TbecxmtZ
 Y9b7Q3sMSBUfYq9XZ4XQfyiPzmI8qxbKUGOKCj0T3unyVszx8sCwr4Raq6Uy4Py+GQr8
 coYJKUIImHRLpnumjcgAvl6pkmOglo5FkDvl4q09ojZPO/ZnH6D9Sa8jGsJJ838d78OR
 ZVTrJU/C0erkQNDn+O1UWDKbhvqaijr2DkLfAFRih9qWKLTl5Klq+Dnj+iS0eQcKb+S8
 VOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=lKt53I7f/6CmozSTncyZXV9A7UBvRK9P650MPucCeC4=;
 b=kPdT4N6KHyCDBPw3HsmAONNIvRFYGmCJq/E4vME/oHFuXohlxI6VcmEpo4WRkEikvZ
 7AJDgVAc2N/Caq/7yGC3tmelLCzMSB5tJLyp9conA1naj5bxwM5f7U2dau10yRedAAMk
 PBm3LTWYobRmXyp6k7P1AjzHMtxnEU4YRN+v8hcsYqHGHZP32vUJuPiJ2G1duYteCou9
 HJICx1x0GMSsB+j7Xr7nThOjFqAZGtYAvUKa4LiAJmBTNz2yScd8RmqF/LUf05QSHUCr
 skmpD48o6iXfVXHEY/WL0mEvL+owNfCjhzCe7PLgJfEVDs9T5rINWN3B9rCLjWeZMsB+
 7KJw==
X-Gm-Message-State: APjAAAWvQuArVU/wFSdG10WEbkb8bwYvpuGGAQw7gNMRrAWBFwoYELEJ
 ORqkJ2kyd+7NkC4CD8D8RWuWzg==
X-Google-Smtp-Source: APXvYqxC/6hQ1ihONVT4MwfAtZnbSHG2BSdEJxErkUBrgNbxlaghlnfTOu168SE6HO8LPck42J8nDg==
X-Received: by 2002:adf:e5cc:: with SMTP id a12mr9157997wrn.258.1571421504665; 
 Fri, 18 Oct 2019 10:58:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p68sm3167756wme.0.2019.10.18.10.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 10:58:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 567891FF87;
 Fri, 18 Oct 2019 18:58:23 +0100 (BST)
References: <20191017044232.27601-1-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH 0/4] target/arm vector improvements
In-reply-to: <20191017044232.27601-1-richard.henderson@linaro.org>
Date: Fri, 18 Oct 2019 18:58:23 +0100
Message-ID: <87sgnqndfk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

> The first patch has been seen before.
>
>   https://patchwork.ozlabs.org/patch/1115039/
>
> It had a bug and I didn't fix it right away and then forgot.
> Fixed now; I had mixed up the operand ordering for aarch32.
>
> The next 3 are something that I noticed while doing other stuff.
>
> In particular, pmull is used heavily during https transfers.
> While cloning a repository, the old code peaks at 27% of the
> total runtime, as measured by perf top.  The new code does
> not quite reach 3% repeating the same clone.
>
> In addition, the new helper functions are in the form that
> will be required for the implementation of SVE2.
>
> The comment in patch 2 about ARMv8.4-DIT is perhaps a stretch,
> but re-reading the pmull instruction description in the current
> ARM ARM brought it to mind.
>
> Since TCG is officially not in the security domain, it's
> probably not a bug to just claim to support DIT without
> actually doing anything to ensure the algorithms used are in
> fact timing independent of the data.
>
> On the other hand, I expect the bit distribution of stuff
> going through these sort of hashing algorithms to approach
> 50% 1's and 0's, so I also don't think we gain anything on
> average to terminate the loop early.
>
> Thoughts on DIT specifically?

It would be an interesting academic exercise to see if someone could
exploit the JIT from the guest but as you say not a security domain
so....

>
>
> r~
>
>
> Richard Henderson (4):
>   target/arm: Vectorize USHL and SSHL
>   target/arm: Convert PMUL.8 to gvec
>   target/arm: Convert PMULL.64 to gvec
>   target/arm: Convert PMULL.8 to gvec
>
>  target/arm/helper-sve.h    |   2 +
>  target/arm/helper.h        |  21 ++-
>  target/arm/translate.h     |   6 +
>  target/arm/neon_helper.c   | 117 -------------
>  target/arm/translate-a64.c |  83 ++++-----
>  target/arm/translate.c     | 350 ++++++++++++++++++++++++++++++++-----
>  target/arm/vec_helper.c    | 211 ++++++++++++++++++++++
>  7 files changed, 562 insertions(+), 228 deletions(-)


--
Alex Benn=C3=A9e

