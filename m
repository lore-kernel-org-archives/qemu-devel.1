Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC27C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:59:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EED9821739
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u/fYuSYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED9821739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwTHD-0001kE-5L
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 10:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iwTGM-0000Tw-Bn
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iwTGK-00016o-UF
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:58:50 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41875)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iwTGK-00016J-Nw
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:58:48 -0500
Received: by mail-oi1-x243.google.com with SMTP id i1so10764627oie.8
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 07:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SF7XNMAU5USmJuCqSubWEzfB2WJu1T7VRr35gzS8eB8=;
 b=u/fYuSYad76CfVGg7XucOSDuiNl+6sjdlPJYzcrMVvRdb6t9DAk4sh45EzIVAgAAoG
 0e3yrzbAEoA5+bEPgDIUGANtty8FiNvboQT5tvcHdsQsGpI9TUCDwgHbrxDpG6ZpUKTc
 ixmD4ztuKyATqCYd5TpZrn1pgWcSoIl7boWN0/PdlLEHhrtoNdrSC645Jth6Y7EIkFj8
 wbaxXeLNhkw4GeVmVQbA2E0+q4MbTjHWkVuWXPh2tyLJ4hgPp5NQ8Jo+oXwT7f0ciO+9
 Wk+T/Hh6uOKtVn+6TosZ24dQGTkTsSA3fNv1w37k5XXoF6nRBlM7Cwn2vSYBJf+fH0FN
 xyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SF7XNMAU5USmJuCqSubWEzfB2WJu1T7VRr35gzS8eB8=;
 b=Cqjblo7IAE8iDbIjPicY/DpxTxkbawIKRt1CbbkVZDllzyrE6oeejn4jI6Q9JfI4ir
 +zHTeojYGwI7dPr/lRtEotGn6/3aEPEWCYEdiJeN0ajPiIQvG33qGcI4BoNVm9K4TJIn
 85K9dQz6uVfh10db+EtIADWwhqrApNlbUfDUyh3qZcOLuA8O0RGxVzfigZFfCb9fFWWm
 SFtf66/3ATXyJWh0RnGTVSrOwnVxAAV31KYKZf8AiG9D7xUx+RK97su+3NrJu3GL31Wx
 NYficX+Oc+pmyuU9mPuSuTXIHjv7WN/IeFTI5wFZyXykxZtLv6dtZlLXSmSU4rfPmpl9
 SEbA==
X-Gm-Message-State: APjAAAX43n//lHBdvMPP65B7JysCsEd6dyYxfPza2jEUfd6bOLZWVrWf
 NXX3Br9iOj5Mu7XtoHRCEtS1L62cDUUayR+fx7c4jA==
X-Google-Smtp-Source: APXvYqww2LzuT+BqEJYSZwuc94aKxwZHcuLaWjFhPj+RdlQLogJksQ3NlOogKSl/TdRLbQ3WWXCnxABiXO65kgYmoqM=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr3122200oie.146.1580227127918; 
 Tue, 28 Jan 2020 07:58:47 -0800 (PST)
MIME-Version: 1.0
References: <20200127190144.1456-1-richard.henderson@linaro.org>
In-Reply-To: <20200127190144.1456-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jan 2020 15:58:37 +0000
Message-ID: <CAFEAcA9wKR_pHxMAR0MqCoeHh6A89Q56rHqyHNp-aAx4Mmmrxw@mail.gmail.com>
Subject: Re: [PATCH 00/11] target/hppa patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jan 2020 at 19:01, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Version 4 fixes trivial conflicts with
>
> commit 4f67d30b5e74e060b8dbe10528829b47345cd6e8
> Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Date:   Fri Jan 10 19:30:32 2020 +0400
>
>     qdev: set properties with device_class_set_props()
>
>
> r~
>
>
> The following changes since commit 105b07f1ba462ec48b27e5cb74ddf81c6a7936=
4c:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200127' into =
staging (2020-01-27 13:02:36 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-pa-20200127
>
> for you to fetch changes up to b1af755c33bf0d690553a5ccd93689dfd15a98e8:
>
>   target/hppa: Allow, but diagnose, LDCW aligned only mod 4 (2020-01-27 1=
0:49:51 -0800)
>
> ----------------------------------------------------------------
> Improve LASI emulation
> Add Artist graphics
> Fix main memory allocation
> Improve LDCW emulation wrt real hw
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

