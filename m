Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AFFC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:16:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74D4F20650
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oqu6xgto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D4F20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9n7O-0005GW-Kd
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 05:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i9n6D-0004fZ-Bs
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i9n6B-0003Fm-GF
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:15:08 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:45694)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i9n6B-0003FJ-9Y
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:15:07 -0400
Received: by mail-ot1-x329.google.com with SMTP id 41so31112510oti.12
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 02:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l6KzhEcjwBlXrcCnR76IeoZ1/7isuXIbL5WSLx50VfM=;
 b=Oqu6xgtoaKhKqtEJh0utHw9yF2BdGCJczqEXqeJRgQUOHdOPmTFOvOi12QCwHjP9/o
 5mME1exZJpJ6ah3KofmH6kJpmUguLr4mOhXyktmmpO69E8x+ra+WDE4RdkRvU4mpinnF
 4QLuz4PlRpye7F+54W8T65bAgpxMW0QM5ZhnR+x1Re/aV66t9eqA70BEhW4D+Acn98xj
 VJv5RJug+iPN90qyOg18mnYJvIkilfr0am3vcf3OjU2j15/ilfidokCQsPIPMsJug7T1
 LlYr94pcA36XWqW9HA6F3G7YF0rA5KlM4c6M5wOpXzKc69KVp9xgXWi7IZJbB9o6yzpm
 +rZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l6KzhEcjwBlXrcCnR76IeoZ1/7isuXIbL5WSLx50VfM=;
 b=lIY+nbuYshv8V63hO+5QH/S9WtVPlI9dgiv7ovVxJS6XHVuBtc1zTYBLrJVdDb4OHm
 7L1o351ulFfnNQuxAMGMrOdEP4rWJ2cbl4/2lgZzlo3okqzZdJBREkEZXyFKtnkscicr
 GATs7TIlS72NU9V7BUb8/VHrN+/Nb2l8RwDLkCnBPPBirsPiAb9UWqpEv6rQRQ5MuiPe
 IkwfCbA6US9bXk2EGW5tKNMNsKIM2D0BZddqh6vQpRzlY5NnaD6u22C3XNia2Cb8L2R9
 Hi6sg3d1MCrbqUJWBWcsztaGOMZbWT7n4pP/s93+bZRItJlOnkkKeO1VJKH0h/NM9SmP
 7CfA==
X-Gm-Message-State: APjAAAWOlUjVXquXphHGqZjhDNu4aapNS5ytKPjrHA5JB/yayGjd6rGE
 PXyWlgcBkJsbGqNPQDBot1IDgul8Bw12bWqI3C2MNgDm9lM=
X-Google-Smtp-Source: APXvYqwpPMZhljXfjywHZdSaMx/lVGsqL5dIf5SnYHmxSE5hiW3RXRkzaKAxNfakIrqNzlqvHa6gDYPOkgsRn6yEbwA=
X-Received: by 2002:a9d:6a8a:: with SMTP id l10mr44942170otq.97.1568625305594; 
 Mon, 16 Sep 2019 02:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <1568305840-12550-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1568305840-12550-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Sep 2019 10:14:54 +0100
Message-ID: <CAFEAcA8iTUBm-E+7iNqpF9XRJBW-rinJ9pqJ1pKryiVBkYaE0w@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
Subject: Re: [Qemu-devel] [PULL 0/4] MIPS queue for September 12th, 2019
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
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Sep 2019 at 17:30, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 6d2fdde42c3344099262431df6a3f429c509291d:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-100919-2' into staging (2019-09-10 14:52:09 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-sep-12-2019
>
> for you to fetch changes up to d1cc1533509012916dceeb7f23accda8a9fee85c:
>
>   target/mips: gdbstub: Revert commit 8e0b373 (2019-09-12 18:25:34 +0200)
>
> ----------------------------------------------------------------
>
> MIPS queue for September 12th, 2019
>
> Highlights:
>
>   - switch to using do_transaction_failed() hook for MIPS' Jazz boards
>   - revert a commit that caused problems with gdb's packet 'g' for MIPS


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

