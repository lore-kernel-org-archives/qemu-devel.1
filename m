Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B60EC352AA
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 10:30:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55384206BB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 10:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQ1Dwi6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55384206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHQHk-0002ip-H2
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 06:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHQGO-0001Z3-CU
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHQGI-00007N-Pz
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:29:11 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:43732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHQGI-00005j-HQ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:29:06 -0400
Received: by mail-oi1-x22d.google.com with SMTP id t84so11152000oih.10
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 03:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YZqvcXka5J6bNuWYHdFF/Mtpjn6AovRwgKo7kaLDPHE=;
 b=aQ1Dwi6s8dRpQjwdV27Gyk2EdlCNvSmAJ1ltipJwDz1nBB14QiNDAuvgmWMsf9efHf
 6pTb7CNHdtKLUBrkMu9vl7OgOADQ+Y3dGyA7UT5yjfPhX3GT7TTiPpEfMoSRoQm5A/Yu
 b3ICWYqr5FaxHpidHUN/sYRTDepoMoAyz4W8sHV9vUJbE9HrF0UYwnhQ4N6mgSQUSKlb
 2tCxsSkX7wvtn/GMJqb3FTg7mWVgLECbbcl3sYSKB8vlv91oDSBs9Fb8luI/t6jDUY+5
 WlelQrlbIXRXHOYAjl2x9RMwfmHc2DR80nGIAPJsqCzkdQtyUoBtjFeAz8cBDr2pTL8h
 HRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YZqvcXka5J6bNuWYHdFF/Mtpjn6AovRwgKo7kaLDPHE=;
 b=N02UE9nLqTNqrmE8YKd4TN0DK9lmBmTh0XTtLyxStzOKs6YBEB3/C2fd9eIhOUSzzL
 bPK9ARssxiQnXdNjaAYhSJXJ/BPcIvzOv6q6khRDPA5Yj7shIL0JGblAoKeOI3p7EtZ2
 AHLR3mRqymVMDJbsyNJiVJiEgE0snEQNNh2S4N2O0AuvB3Bvh6vBYmPfv8YtUBRzpJhA
 6mbLjNeJp8xtsNoQcFwz0i1WRb5JyM/a3N89gGcpLA17PcgwKYI9i7ypp2S29FmE65XW
 URrySP/he+qcSH2t4JfxzJhgYKhWIEIo3cSv3Ug27NUkxCX7r3qYQn9zHP7bMXZ+NGMI
 ZD8A==
X-Gm-Message-State: APjAAAU8ZiUtaIEFVyNmAlK8xEcR6Av3Y6Yl2YOrDrujjCT6+dTuVgtg
 aPVxkDzhVY53LWtSxaXBd/cFIJflBjK8G7ztYK9TNA==
X-Google-Smtp-Source: APXvYqwR9kFOTvY7CM3o+rv0aSXyRWx/ClG1PK/VbC65iUCP6gaRc7rWiBJTnKDiLGZLX3oHu7Kw/q75K1lVPAlPyJE=
X-Received: by 2002:aca:b48a:: with SMTP id d132mr18076747oif.98.1570444145600; 
 Mon, 07 Oct 2019 03:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <1570208363-11948-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1570208363-11948-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Oct 2019 11:28:54 +0100
Message-ID: <CAFEAcA8CjjXnTU5yc08KNKOY0=S8ok+O+X9gyNG=J+C0jiO5jA@mail.gmail.com>
Subject: Re: [PULL v3 00/29] Misc patches for 2019-10-02
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
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

On Fri, 4 Oct 2019 at 18:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 7f21573c822805a8e6be379d9bcf3ad9effef3=
dc:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-201=
9-10-01' into staging (2019-10-01 13:13:38 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to a1834d975f7d329b128965dd69bc3aaa7195f5a2:
>
>   target/i386/kvm: Silence warning from Valgrind about uninitialized byte=
s (2019-10-04 18:49:20 +0200)
>
> ----------------------------------------------------------------
> * Compilation fix for KVM (Alex)
> * SMM fix (Dmitry)
> * VFIO error reporting (Eric)
> * win32 fixes and workarounds (Marc-Andr=C3=A9)
> * qemu-pr-helper crash bugfix (Maxim)
> * Memory leak fixes (myself)
> * VMX features (myself)
> * Record-replay deadlock (Pavel)
> * i386 CPUID bits (Sebastian)
> * kconfig tweak (Thomas)
> * Valgrind fix (Thomas)
> * Autoconverge test (Yury)
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

