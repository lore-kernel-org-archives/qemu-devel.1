Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE53C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 20:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42CA1206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 20:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JHKsFvlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42CA1206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvRUA-0007Ur-Gu
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 16:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvRQw-0004mD-QB
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 16:21:46 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:36557)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvRQu-0006Xa-S1
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 16:21:46 -0400
Received: by mail-oi1-x22c.google.com with SMTP id h17so6118oie.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 13:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v/JxJn/f5c+VU0jMhChoGMEE3awzEh5qpKUL03d6ABc=;
 b=JHKsFvlSOD+Q0wiqFXTbEzWijlXvN5Hwj8AxIk3pvQj16QJTA8YSZAlh8HZDvGED5G
 dtTWQpzb9NBJl6x5+rZO7QVeBU341Ohxp/zVUHx0xxHheBvoP+1muDDfBc2l25fVErru
 HQYTmeTS3UhihRrhOlN5wQFRKIlImdcnvTZePTAMQp/wpe+UTvJ2H2Bzj+K/xZ0eZSWa
 OTPh30hFwfOl76CvnWZn479DeGg1jznFHerhmYLNWButWPYqbZylgak3iru4je3vdtrD
 rc73Kgwj2IR5sOzRN+yQiIQ8UNr7d20qpuHs/1nwRvkjZ4+9dcBJ/TDPpLtYYA6Qq90P
 Qxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v/JxJn/f5c+VU0jMhChoGMEE3awzEh5qpKUL03d6ABc=;
 b=BFhExdwfUleS+dCEI/NmV4BhfeTQ7AYbrOkARpw7QlQQZEwpMno/baYgmpOsZUcaeT
 Syb+FZMxxk0HCRxEwAtAOHmBojP7SZX9JJQVhQOFaMKxjPrxw5i/5LhWYEVC6Z9PpREc
 Fictv8tPqbLc3BdYQ7jRx+l4JIk43RGdfRORhOf5yrsXyn56OUw7RQrxiMpcMQi+imvA
 dZaYbhQSknWGTOaPNGXfCdUEVP764bPf7vPnJJAkoy+6KxVX15NNmC0VkLkOCv0SABeI
 /ZTrzezaIYMtEMajiFChBcaiQh27IBj2mr7uj1fSEHe+rayPJKBIWdYNdkqh/LkJnh/T
 +Z3g==
X-Gm-Message-State: AOAM533TVkxG+5+GODp6QHJHZwD/Z9usYdhFFwQ6bTh/EFHSZgXm4RxJ
 TnHYe9qccwdKXOKN3TUGNupQHQ9zHlziG+RjimSc6LrG
X-Google-Smtp-Source: ABdhPJzSQq4WbHtTaWkTAsYz0+vpF1PqHfbLHCU8bmaNe6J4YzwuCn8Kmlnubip3s4mYyhh0yu34nM+HW0xjkRh8U+o=
X-Received: by 2002:aca:2819:: with SMTP id 25mr4854447oix.48.1594758103289;
 Tue, 14 Jul 2020 13:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200714073259.1464675-1-laurent@vivier.eu>
In-Reply-To: <20200714073259.1464675-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jul 2020 21:21:32 +0100
Message-ID: <CAFEAcA_73OwotpmtEOeqwf2_B9CGvjeJoroBbxiZvb6Aker4tA@mail.gmail.com>
Subject: Re: [PULL 0/7] Linux user for 5.1 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jul 2020 at 08:34, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 5c65b1f135ff09d24827fa3a17e56a4f8a032cd5:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200713' into staging (2020-07-13 15:14:48 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.1-pull-request
>
> for you to fetch changes up to 42b16184d016d48d167229a1ddb89b3671c77440:
>
>   linux-user: fix print_syscall_err() when syscall returned value is negative (2020-07-14 09:29:14 +0200)
>
> ----------------------------------------------------------------
> linux-user branch 20200714
>
> Fix strace errno management
> Fix Coverity erros in ioctl straces
> Fix some netlinks errors
> Fix semtimedop
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

