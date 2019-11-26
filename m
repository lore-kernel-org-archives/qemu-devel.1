Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E78C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF552073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGW46ShQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF552073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZaiD-00077s-VS
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 08:17:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iZahC-0006ad-QX
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 08:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iZahA-0004qb-BG
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 08:15:58 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43700)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iZah6-0004lP-QZ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 08:15:54 -0500
Received: by mail-oi1-x242.google.com with SMTP id l20so16561818oie.10
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 05:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IfL3XGbQuAfxS2cezRmM4LbUmbLFpg8qrPknCE+eYeU=;
 b=iGW46ShQUkE4zeKW6aewJfebLMkOnC5yPBegQ36tbeSxSmvDux3I4LAunGSAfmdNtm
 ZYPs1NT6q6BiCnDzmNOzypXlXMJbFru9Gc4iqfU2Hn+wKJJgt6/Vr1syJtJ7Iyt2fxsZ
 UhTQC6wKFlbmBgRNcv0Sq/bja62ERjnCLQ6xDtVukI2sXEjWPj9r82LHRO4amI96oWap
 nKrau0ODphfmmSOrAwX0bVUQkwz8rqOcdJjCBKWO1DR/De/UN2c+ZCJJ7JO+tUhCB4jw
 usrcPM/UW7rPQhGlOf+HoWKbx8PtgCVekLeNGjXJ/W3q4KlfKXjWbRBPrhDBjavNa7uQ
 j27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IfL3XGbQuAfxS2cezRmM4LbUmbLFpg8qrPknCE+eYeU=;
 b=NK+QfwxhDK5DPnQPhttuh+x6Pc0E1rOrNeoBAU9p3w4j8NR6yrf13YcYqxXOK+aRlB
 NIyJ3ALhnjbAVcKePD5aNGNexGdpZy4bFNEg1ChjnDac6Lv5uCwglkMFFhp0nj49qbig
 114Co9PQN190huLfkRHzIkDyn70pqJMSQIL2HP6KH2czkcY8fCgicd6finKh6dAIyrOI
 qiQA1htY7FTO0bMz/dccSnxLTt6mEhdsiYfZbNTBMeRIVb7igyZRIoAmUwWH+M6omrKf
 WqVep29gwpmOtvaJKmAT0pzXH0nHQr+G5lYl62mfV5gtFF+WmB15wfDcwWBPPSwrMVb9
 SB8A==
X-Gm-Message-State: APjAAAUq0PyOPXtCvxvVE2TIjw3PSRJd8tnDeVDJiu3hgI/LVIr2ZxNp
 R/28XOUryUNxJBGETGjvyOSbZ12F1JZuZlWQAZ6Kgg==
X-Google-Smtp-Source: APXvYqzlDyvlltSvSUpg1/LRWk/ehLl7uEq33VNEoyWT8QbR2m35JeM77UzTJijmCr5H1JURqzsfIotO4aTQjmiQzu4=
X-Received: by 2002:aca:cf12:: with SMTP id f18mr3399560oig.48.1574774150488; 
 Tue, 26 Nov 2019 05:15:50 -0800 (PST)
MIME-Version: 1.0
References: <20191125205854.226672-1-palmerdabbelt@google.com>
In-Reply-To: <20191125205854.226672-1-palmerdabbelt@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2019 13:15:39 +0000
Message-ID: <CAFEAcA8+DYpZCcVNegwji2FYUsNOi=2j0GGK8jpCiSps9y=BTg@mail.gmail.com>
Subject: Re: [PULL] RISC-V Patches for 4.2-rc3
To: Palmer Dabbelt <palmerdabbelt@google.com>
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 25 Nov 2019 at 20:59, Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> The following changes since commit 65e05c82bdc6d348155e301c9d87dba7a08a5701:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-11-25 15:47:44 +0000)
>
> are available in the Git repository at:
>
>   git@github.com:palmer-dabbelt/qemu.git tags/riscv-for-master-4.2-rc3
>
> for you to fetch changes up to 6478dd745dca49d63250500cd1aeca1c41cd6f89:
>
>   hw/riscv: Add optional symbol callback ptr to riscv_load_kernel() (2019-11-25 12:34:52 -0800)
>
> ----------------------------------------------------------------
> RISC-V Patches for 4.2-rc3
>
> This tag contains two patches that I'd like to target for 4.2-rc3:
>
> * A fix to the DT entry for the SiFive test finisher.
> * A fix to the spike board's HTIF interface.
>
> This passes "make check" and boots OE for me.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

