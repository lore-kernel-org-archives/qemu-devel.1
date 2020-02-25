Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCB2C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66FD02072D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZRb/Nusr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66FD02072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6cch-0003JY-H3
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6cbZ-00029E-EY
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:58:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6cbY-0000mq-DZ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:58:41 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43549)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6cbY-0000lA-8J
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:58:40 -0500
Received: by mail-ot1-x343.google.com with SMTP id p8so12462211oth.10
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tNHwY1eHJJ3qs8vO8aynlhw0l903XZzzrhTFAJUhL7g=;
 b=ZRb/Nusr0/qbO+5w4hg8CuAU6mWf1pOAdvXQUYT6knm6A3l5LlEo5GlZMCj+SLcJWJ
 vNCFERdTXHmHFbMPtsCyLQLqy2opJEXRVmzAL9VHgR29zBxvtgxteg+AYy2aB1PpgomP
 3j7lG4Sqey/AITcr1DK8wRNmG1QoI3mXUOznghIRxpVhPb6l7RyVjlUOqBI33y9mHnHp
 JIpB36zGLiEp5l99Rq+YXDNeMDRLvL7MLHaxya0LARhOxSLnsbui8RlfPqckJjjGbeRJ
 Bt00vaqCjkGUUTS/1Atgt42nY9ZEV8HGwEycT4lTHDj3f4v/0qC0xfOts809rarmn0oy
 Jllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tNHwY1eHJJ3qs8vO8aynlhw0l903XZzzrhTFAJUhL7g=;
 b=Ry1TppaMNR5tACpu62O4DM0QPl/QoALJYryPF4IEC+YaVr9F2X3RHQNv+EHSNbeRRx
 63+1jX5PPiAcgFGvrZQjxd3mgFsoX6rS9G1Xeo7eDnqPN3zNtDj7RrR3oPtnAgEX7rTt
 CjnM42pMql+PMtSvRW21F6Jb9aQdM/Fp6Z2AFuROI65cJBQ0S2T9UoVaDdfxoaJhk2L1
 OcJegvroFeHZhrOs5X2SiiSGAXMIkjAkFvYZO51MXbpIrLONZR02O8WNXv62mhYZr27+
 gTBcBVlyYCc/Okr5j4YutMZI+v3k17w8roZa7fH5Kxxaf5fCYLi7lVrT4beeEd4f578n
 gpuQ==
X-Gm-Message-State: APjAAAU6sGEil64a+lmek6VbmcCSyeu0OpRtZxCmCcK4eNu1f29GMLCO
 aGm7SFGgdvymlGibyo6VdjCASiOfqFSxt6+wcc9Q9g==
X-Google-Smtp-Source: APXvYqznOUiBo5e0WJJcTU/CwQbiHSTQtkO+AsSbStuR9FnAjvDAKolUPKRW+msgnSTUyYaAJ462TzQeldbM1hLsq34=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr33255846oto.135.1582646319169; 
 Tue, 25 Feb 2020 07:58:39 -0800 (PST)
MIME-Version: 1.0
References: <20200224222232.13807-1-richard.henderson@linaro.org>
 <20200224222232.13807-6-richard.henderson@linaro.org>
 <CAFEAcA9WZbZj_hPemTGr+Rkh--VmZt1eis189+ExuPVNipgo_A@mail.gmail.com>
 <49741058-7dbf-d20f-95ce-5bf9b5e5bdb2@linaro.org>
In-Reply-To: <49741058-7dbf-d20f-95ce-5bf9b5e5bdb2@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 15:58:28 +0000
Message-ID: <CAFEAcA9nZx0eCnQtjCdG2OZRK=pF-Afb9jtvGZ=dJTAbaVAL1Q@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] target/arm: Improve ID_AA64PFR0 FP/SIMD
 validation
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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

On Tue, 25 Feb 2020 at 15:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/25/20 5:24 AM, Peter Maydell wrote:
> > This check is supposed to be "did the user accidentally specify
> > some incompatible settings on their '-cpu,+this,-that' option?".
> > By making it check the actual ID register values, you're turning
> > it into also a check on "does the implementation specify sane
> > ID register values", which (a) is useful for TCG but ought to
> > be an assert and (b) we shouldn't be checking for KVM in case
> > the h/w is giving us dubious ID values.
>
> Hmm.  Because kvm64 unconditionally set VFP and NEON, you're right.  It was
> only kvm32 that was examining id registers.
>
> The only consequence of kvm giving us dubious id values that I can see is if
> ADVSIMD is on, but FP is off, we won't migrate the register set.
>
> Do you want me to add a tcg_enabled check, or shall we just drop the patch?
> The existing test is good enough for just checking the command-line.

If it isn't a requirement for the rest of the series, let's just
drop the patch.

thanks
-- PMM

