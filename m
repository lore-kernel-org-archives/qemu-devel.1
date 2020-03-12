Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56C4C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BD83206CD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYTSeOee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD83206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCVv8-0001i5-Nr
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 18:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCVsu-00085n-Vr
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCVst-00069i-A7
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:00:56 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:35855)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCVst-00068a-4h
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:00:55 -0400
Received: by mail-oi1-x234.google.com with SMTP id k18so7227020oib.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zBEgTSkue8n3N3haF1UqERuVBSPxxEbviL0PkP9K0zY=;
 b=ZYTSeOeeYuCVOBGQ6oqzUWhMEXmHKuK6M7cyHceajl0LRUqticlltOKMFfCEA4sv4X
 5pb8GDMeNPfjj05L3Hg5u6EdQsSr/omvBfmWmDx7a6Yagwy58A33gn7fF2riLAU3IXl/
 m3hUwHcwhpVS2v2epMna7vQwPk86pT7vM8WVp3d27Nv9pXjLUyob/F31Ka4A9+KOurrq
 Bvr3f0XrSuIsfXLws2kf6u1N7d8zulbe6Spj/onsyvQKyt7Bhj6xbRAao4ttK3IOLO1t
 PSqr97AOwsaAKd2+usoz38TaWnBDkv74yB/kb8p7s14UtwqzlkWhgCG7dew56fZVTXe4
 x2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zBEgTSkue8n3N3haF1UqERuVBSPxxEbviL0PkP9K0zY=;
 b=s0igXgHNO5PzrxadfF+TWDs4H4QHl+FfIHvYlk5oCEUEQwBF6G7yOeAqyaL4KT+rkv
 ocFTwUpQFh6CSG3t9DrerLsGCnu5Gl6NLBHDEAJkS5Claj+2E85DxxV3RHWm2G8xuZNX
 ZUNLbusjAykvdARn+cdhsGaUK2QFTmTi0doxXIcxgHqwbWkKPJr5iDRpsqWbMK2sOA8Q
 JTThym1LS8RUeS4z+ZtzWbwWjKUt7eiiYPa7LF4oVb/uygCVeLHXKtj66gA1bxl80E0R
 Hgb4PHGYpiiXadpqb6aULF0Pa6eLxsnj/Hyj72n6j+rlY5triBQSeSFSoAAIXHapA2OH
 4+kQ==
X-Gm-Message-State: ANhLgQ1TiGhcgvm1eSXgC1hvIrPrS5uod4euvFgCZrt15Ik71zdETWqV
 hOvW+DYUcxamHYUvU3cjX/y4ewbyMUYkabdukIAEiA==
X-Google-Smtp-Source: ADFU+vuvFBSiL3uADk8C4Ay9xj3hi+w+qbQpCY99PbqwQvzYuIjXbRkJNtX4KMxc0aHo8wi/fWkzgXM+CGyxptngu4M=
X-Received: by 2002:aca:c695:: with SMTP id w143mr4537727oif.98.1584050453858; 
 Thu, 12 Mar 2020 15:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200312193616.438922-1-crosa@redhat.com>
In-Reply-To: <20200312193616.438922-1-crosa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 22:00:42 +0000
Message-ID: <CAFEAcA_PiX7LffcT9+1Bdn764fsqsSzUZib-yp=Og0Vpa3oOrw@mail.gmail.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Wainer Moschetta <wmoschet@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Mar 2020 at 19:36, Cleber Rosa <crosa@redhat.com> wrote:
>
> The idea about a public facing Gating CI for QEMU was lastly
> summarized in an RFC[1].  Since then, it was decided that a
> simpler version should be attempted first.

OK, so my question here is:
 * what are the instructions that I have to follow to be
able to say "ok, here's my branch, run it through these tests,
please" ?

thanks
-- PMM

