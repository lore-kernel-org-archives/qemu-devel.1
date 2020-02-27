Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2862FC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2DF2469B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nVoL/7G0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2DF2469B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Mio-0002Hr-6e
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 12:13:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7Mi2-0001Nm-N2
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:12:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7Mi1-0002y1-Ir
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:12:26 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34298)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7Mi1-0002xs-DJ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:12:25 -0500
Received: by mail-ot1-x342.google.com with SMTP id j16so3656349otl.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 09:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=paOPNp7PPm85fKRnyBsW+8qjplOXKxvoCxrHDVKgPnU=;
 b=nVoL/7G0lyfBMxicR+St45RkKlIMI1aF/wF2hKEJCI9K8ZyW6+hWfbx+l6fCbmOjvc
 v4CgUsffmstPWdjbi6IiPswka/qk6TXXu3ITa5/HWrkpIaNd81zImEkobBDY9YFj+Kap
 xQA6xcdrUXyPTpgGu/l64cLwARgf/wYX32BlytaNY15yu1KfYrZNUY2V/S7SQdgZjAOp
 gtcOJvCNvKM7cLW5qbSscmWlRnmPCaSa8VuHDOl1CvAkvyO9SD+HkohYaH40J28UpgmN
 KeSdq36ltuFNlgDycvR5PROilhbSHRU43Uf0l6t7e5agqKnj9HgzFN/DBBrrTrNeieRE
 skkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=paOPNp7PPm85fKRnyBsW+8qjplOXKxvoCxrHDVKgPnU=;
 b=PVDuh7BZJCt73Mf5TzRefFj/YRNtJEvkViGyVl2fpo3KKY+4nge1Lpncb15GwPtC5p
 ffd8JvCG1DTYS/8fODJTYi4WBVWwOfQVjDo+Hz4gMBnT0aZoUd/9PhawG2PR5PUWmOOg
 /WfY9gRVkt7sA0q6KbJMM/FH4zw10dQb/8gzsGilO8tKssRkSN/JhU4eiMnRTrkbxxtF
 HBfdsHlVEwcyKlH7ngryLO9rlV+VsoY89UcYdHd6fzZ68EKRZ4tNYpadb3aQJyNR+iWC
 yxMtm71cgKoKonKhu7MWbDadIf6KIPFxQbJbRUlOBMC9YaRC/S1xlY79mczu3mATJ8I2
 TH+w==
X-Gm-Message-State: APjAAAV9nNmN+ujDp7yZWV3axhikiesOLhfRQG4VqJjKlbN37h7yclx2
 jB+3rREwnuyyoATyp+TISH6ETntvSwUYDkZluEsKEg==
X-Google-Smtp-Source: APXvYqzxzdUHEqulWpO/PUIZ+MN8PDGOmCozr0wjnwSw0cYP4p0fmYjAl5f5jRwCCkMPNsxp/kh4aQrwDrLobkmS7Mk=
X-Received: by 2002:a05:6830:4a4:: with SMTP id l4mr610883otd.91.1582823543962; 
 Thu, 27 Feb 2020 09:12:23 -0800 (PST)
MIME-Version: 1.0
References: <20200227161454.32368-1-imammedo@redhat.com>
In-Reply-To: <20200227161454.32368-1-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2020 17:12:12 +0000
Message-ID: <CAFEAcA_uShJjZ1iwS5XrP7LDX5Y6JwYNtpF7fJpnzGyS6=urSw@mail.gmail.com>
Subject: Re: [PATCH v2] softmmu/vl.c: fix too slow TCG regression
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020 at 16:15, Igor Mammedov <imammedo@redhat.com> wrote:
>
> Commit a1b18df9a4 moved -m option parsing after configure_accelerators()
> that broke TCG accelerator initialization which accesses global ram_size
> from size_code_gen_buffer() which is equal to 0 at that moment.
>
> Partially revert a1b18df9a4, by returning set_memory_options() to its
> original location and only keep 32-bit host VA check and 'memory-backend'
> size check introduced by fe64d06afc at current place.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>   * check if user used -m SZ before comparing ram_size with backend's size.
>     Fixes case where qemu exits with error when backend's size doesn't match
>     dafault ram_size (i.e. user haven't used -m option  at all)
>     (Peter Maydell <peter.maydell@linaro.org>)
>   * keep order addr space size check for 32-bit host after
>     backend size check. So it would be affected by backend's size as well.

Applied to master as a fix for the tcg perf regression, thanks.

-- PMM

