Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1A7C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 12:04:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 501A52073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 12:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DR+xSv5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501A52073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j96IC-0002kj-Jy
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 07:04:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j96HH-0002IZ-Th
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 07:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j96HG-0000i7-On
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 07:03:59 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:39088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j96HG-0000gF-K5
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 07:03:58 -0500
Received: by mail-ot1-x333.google.com with SMTP id x97so2704416ota.6
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 04:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hI8VYRVvJjS6RCyTR07Kv04tLyKyaz6W7Y7xBI99xXA=;
 b=DR+xSv5Dh6nr99V0tcn0ogB3E33X6FnKjmq2VtyPgrVGbVVDe8VPgMsrIQss7eIZ0h
 i6VnqwCswEXeyqMRQel0y7+Jwngr9DYNatLHWRIlqiCjhKdTx8JHacDUeL338DyEvUS6
 K9FApMkLfQ5Fhj9fg4bvm6eLOc+UubnmN7lSxiwaZXFOEJeWEiy+zhFz8ujXHaB/nqsp
 wk03OrHQRjvTv3188WexTy6z0rKiG3UK3vpwhMJ3NRuszkm0WCFQpeHsjb0rObpBQo2c
 iicJmpT1x9GdvjGsjK5BYETyiNA6CHJbqipKB8mSXmssPcybLcn9kxVGXHAQ6oJdivvR
 pGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hI8VYRVvJjS6RCyTR07Kv04tLyKyaz6W7Y7xBI99xXA=;
 b=Qu6XFAVMC0W4L/omAazLG3/GLpI1/KXgOwsIkKKcmnDx7dykyGefSmyI+sIj+AaDHN
 oa7jW6ycAxlrj6foTO3WsyqClshv0Z+P4/yDoBHJfcEfaSfE1Ro/16FCm0uXdgMuOMKK
 WIL5ivrBUvWwOGALPlON1m64vOvlpH182JPejsGcD7X1OEbCiEZBoAI3Q5ZyzEr/a3bU
 ZoX46zvXNqYMwffJIWC6uy5XHtDnFYsn/sTXDsv99F23j7+fM8X3Qyx8Ix3mwPs6FgfA
 e0EtK8JfxeqC8WtBgM0sYrjMXMMt6C4VNGfuJ9fcaHdSwfc9rp3NFGIyx3F1TecmDpOt
 XtBA==
X-Gm-Message-State: ANhLgQ3sA79n4dgYF+0ZViR4ycDWUbafielq1q47HdpEv40y4dQKj1km
 L8itaC92XbrWkqxH2LtOkp0WaFJySKeqfEiwZR5lHg==
X-Google-Smtp-Source: ADFU+vuONQ4q6faTVNgMXOkUZrfFdtUKgxl+vUP1sCGIK/7hrsdL/5ZDtkSkni8CH/PLDDxooW38OJGXeUME4/OCgtc=
X-Received: by 2002:a05:6830:1406:: with SMTP id
 v6mr3141652otp.232.1583237037383; 
 Tue, 03 Mar 2020 04:03:57 -0800 (PST)
MIME-Version: 1.0
References: <20200303004848.136788-1-palmerdabbelt@google.com>
In-Reply-To: <20200303004848.136788-1-palmerdabbelt@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2020 12:03:46 +0000
Message-ID: <CAFEAcA-TrzErHFjHiSYmXZVG4=8d5u8vDjX-YtzAdwd0XHBSUA@mail.gmail.com>
Subject: Re: [PULL] RISC-V Patches for the 5.0 Soft Freeze, Part 3
To: Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
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

On Tue, 3 Mar 2020 at 00:48, Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> The following changes since commit 8b6b68e05b43f976714ca1d2afe01a64e1d82cba:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-02-27 19:15:15 +0000)
>
> are available in the Git repository at:
>
>   git@github.com:palmer-dabbelt/qemu.git tags/riscv-for-master-5.0-sf3
>
> for you to fetch changes up to 5f3616ccceb5d5c49f99838c78498e581fb42fc5:
>
>   hw/riscv: Provide rdtime callback for TCG in CLINT emulation (2020-02-27 13:46:37 -0800)
>
> ----------------------------------------------------------------
> RISC-V Patches for the 5.0 Soft Freeze, Part 3
>
> This pull request is almost entirely an implementation of the draft hypervisor
> extension.  This extension is still in draft and is expected to have
> incompatible changes before being frozen, but we've had good luck managing
> other RISC-V draft extensions in QEMU so far.
>
> Additionally, there's a fix to PCI addressing and some improvements to the
> M-mode timer.
>
> This boots linux and passes make check for me.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

