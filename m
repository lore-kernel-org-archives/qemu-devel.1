Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB96C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D2F20772
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t0OtP0X1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D2F20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfjBa-0002ib-BL
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 08:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfjAo-0002CH-9m
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:04:10 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:40849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfjAm-0004oA-Mb
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:04:10 -0400
Received: by mail-oi1-x230.google.com with SMTP id t25so757535oij.7
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 05:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AXs9RDvYZOb6XSpask3boPtXtH6HO/N7WLt9rl/CamI=;
 b=t0OtP0X1UQe1exueUEcox5bx7nUhQnMzQ5sYM35h/z8zTeihC5klvO6IF6aykFUMXJ
 rlfk17vc8einJAm9RThSh49JPU3JxL1URj7X7b50RQ8+Ncz6LEsbvjLeLlcb3nSR6luK
 NZMJHRlLfIl3yGzfe1+pOaoWEJPR2hazKJrCpwx/InBEkTlp1uHcm9BcOMfwrCV34e+l
 e+QDvmAzGeC7xgcr3yuoZCPSbLmXZTDMkeaZF+W9ly8mn7/VCLNZtp84lGRzoWO2IjVX
 Jo2mZ+jZ5uHaN/MX8Ca//d5Kc9MUz1PT9fXVnIoxarlOBmyZzYwhlqIMG2oq2QLzbYPA
 eFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AXs9RDvYZOb6XSpask3boPtXtH6HO/N7WLt9rl/CamI=;
 b=DT5X9PqvXIBc3ISaiedVNE+P1As4PytLp61HulIjUC7WqzGfZo0I8V4IHRhMPGh1+K
 vcRBWBljYhagGGzHgnSaR4dq3k6NP/NxV3r3fFD1LB4tHHdO4/jQD2B7IDwy/Xnwocg/
 v/xd6PS42dg3Pl+lHDAmb/1RsuBe1dhvVdfJe1BLv6yYp3TcrK6n/7Z1ea2MbxDAe3JK
 i64R+yUvFwrp5Bv3cWYHhU/TTfZKiFtOJ3H8ftNhg5nlvDRr0b7EOBL8hOhadh6QgZfo
 dRpzqaX+Mkx2UeXUnko4s10fD8uchXhyVg6yXw57eiACQCvGD38pPRymqXu3d19x+yP/
 oonw==
X-Gm-Message-State: AOAM533o9AwBF5KI6uuxHXSpO1kKb6kmVMA40tsiB/lFTRUU8YKRBrP6
 Q/D0GD0oI0pEPiUJ8IU4Crvc9ka2g20vmcUV/y7gCg==
X-Google-Smtp-Source: ABdhPJxQP/k6yo6IIg3zSMu4UaKpgWz3nSyfk4MtDnFQ/2y+KbUX0KOofjQ6iBSwBVA4lnaAjzeYK7K9ZFPA69Qc164=
X-Received: by 2002:aca:5152:: with SMTP id f79mr3595258oib.146.1591013046956; 
 Mon, 01 Jun 2020 05:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200531163846.25363-1-philmd@redhat.com>
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jun 2020 13:03:55 +0100
Message-ID: <CAFEAcA88=x_mecmN98LdQ_3Gag_QRNqj_y2K0KQheAK=NMVMow@mail.gmail.com>
Subject: Re: [PULL 00/25] python-next patches for 2020-05-31
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x230.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Qemu-block <qemu-block@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 31 May 2020 at 17:40, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> The following changes since commit c86274bc2e34295764fb44c2aef3cf29623f9b=
4b:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-tcg-plu=
gins=3D
> -270520-1' into staging (2020-05-29 17:41:45 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/python-next-20200531
>
> for you to fetch changes up to 1c80c87c8c2489e4318c93c844aa29bc1d014146:
>
>   tests/acceptance: refactor boot_linux to allow code reuse (2020-05-31 1=
8:25=3D
> :31 +0200)
>
> ----------------------------------------------------------------
> Python queue:
>
> * migration acceptance test fix
> * introduce pylintrc & flake8 config
> * various cleanups (Python3, style)
> * vm-test can set QEMU_LOCAL=3D3D1 to use locally built binaries
> * refactored BootLinuxBase & LinuxKernelTest acceptance classes
>
> https://gitlab.com/philmd/qemu/pipelines/151323210
> https://travis-ci.org/github/philmd/qemu/builds/693157969
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

