Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F90C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:55:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABBFA2464B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KEOSsRiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBFA2464B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdUI-0006PT-UK
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBdSw-0005Ez-2C
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBdSu-0001cT-Ul
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:54:29 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBdSu-0001aH-P9
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:54:28 -0400
Received: by mail-oi1-x244.google.com with SMTP id p125so13496717oif.10
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 04:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xNSpyHyw9uu9iZuHrpN3jYNpH/YxQIqdv9/m8XBKvZM=;
 b=KEOSsRiRzwrUy6Eempx4S9Z7eNF+8RxFZ6mbXy7Qp4UGOj/c5vxjvj+XT0if80J4Io
 W0yldzGIpM9BMQZaCjB/LbKRQsggXtlnLCKVOXBrOLlkWS3bVFVCpp7Mv6qzJ9AXmB3R
 GKOGhKvAD6VA7YTp0bXrCTNa/kjcuvyNJYm6UwspnQ0DfRbmkM0MgW9DCDHxMZcSOuhg
 iwux4RWQsVYsEt8o3JhYOKQx3R8p1mEXQDgHgAOzrXlV1b4SRtNpWK6zgh1BUfPILDI0
 wrj590R6MhvTUkNRoktLsVlRZZB3GIvA99wa1Sg9duA378ipj1PgfkYxvHwsZ/36jTG2
 /C2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xNSpyHyw9uu9iZuHrpN3jYNpH/YxQIqdv9/m8XBKvZM=;
 b=b1R1qyWNojXdYmdqM4mJ2wUztR8y88E+aeubB4rTjZB1wp0h+9sT9dS1i2sqB9MI6K
 RYl5RWluJzF0+x01XKwjWbV1qmvrm1F0D/rwjETOmoZN0eyhxGNNzU3JqCd3FBdWVYmg
 HZaanw358ZySIXNIo03W8vPRk71IZzhYhdEk5pwUR2WdvGFU5cMx95GIjqIhXGoop8jn
 vMJb0JcVSAmkV6yta+b4uGoBGQ4OZLfDZNJY+3dBoJl61wwjCbLE/fqahrhQvR6B3LNi
 WEtJc7eGmvTF7+U6MkKMQLNJHX80b9Ts46Lu1c8rK0KSh7pvBLAno0O6db3NRFn3keIq
 WUYA==
X-Gm-Message-State: ANhLgQ36OdYdu6I7uWYP4mTOxpGVA1/DlFiwur7xiUpwERlAcBnMON3O
 RT1jqnOTznw2gApfulNgPME7crhf+NBatPZpAkJovQ==
X-Google-Smtp-Source: ADFU+vtzmKlk6X0sq8vAb65jJcxdMlwDV1PphHI8yVk84IB8iGL0/5hrWnbjSHhuq+a4wr6C3o1UkZoz0Hc9E5sTnr8=
X-Received: by 2002:aca:c608:: with SMTP id w8mr819485oif.163.1583841267793;
 Tue, 10 Mar 2020 04:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200308130637.37651-1-ysato@users.sourceforge.jp>
 <e6ccf136-cf93-865d-31bb-4463b65416a9@redhat.com>
 <b075c69c2528772f9f047baba7adc368@users.sourceforge.jp>
 <6d90fc45-6d99-af60-bca0-0a84b91d0408@redhat.com>
In-Reply-To: <6d90fc45-6d99-af60-bca0-0a84b91d0408@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2020 11:54:16 +0000
Message-ID: <CAFEAcA9aOFA7_Tpgvk9Q0yH16B1SLG5zfrU5ZftMsMJ0Zo9YPQ@mail.gmail.com>
Subject: Re: [PATCH] docs: Add RX target.
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Mar 2020 at 11:30, Eric Blake <eblake@redhat.com> wrote:
>
> On 3/9/20 11:28 PM, Yoshinori Sato wrote:
>
> >>> +++ b/docs/system/targets.rst
> >>> @@ -17,3 +17,4 @@ Contents:
> >>>      target-arm
> >>>      target-m68k
> >>>      target-xtensa
> >>> +   target-rx
> >>
> >> Is it worth keeping this list alphabetically sorted?
> >
> > It was not in alphabetical order, it was added at the last. Is it better
> > to arrange in alphabetical order?
>
> The 3 lines of context was alphabetical, but looking at the whole file,
> the overall list is not. So sticking yours last is fine after all.

In an ideal world the correct order would probably be
"alphabetical order of the headline titles in the referenced
files", so that the displayed ToC is alphabetized.

thanks
-- PMM

