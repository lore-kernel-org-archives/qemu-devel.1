Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B273C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C2C20720
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bFkaftkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C2C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY4Wl-0003Go-BR
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 05:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY4Vh-0001uu-6H
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:14:05 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:35119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY4Vg-0001bg-0p
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:14:04 -0400
Received: by mail-oi1-x22c.google.com with SMTP id o7so14512964oif.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 02:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EScZQKGcPH3FZkpduQg/uPJtmsj22jK59Rqvp+owkrU=;
 b=bFkaftkKmO+FkXvSL0yzk0nDkWq8Rq7T2NgtlJ6Ld1RlrT7ipxLCBaQZuR4mN4PENe
 IYQ56O8ZDrYN/0YQ2o70kW/ltr0VYyCPjM52LgVD8RXbBMKB2Jj4/uRsS6K2wfzObfp1
 CoN+TQMa0jvhJpBGvdtEmDocncBe06vUtNljTz62r/6F6ewxcTyEPTZqFOswBKqWeENp
 rYNnVC0usRiOInSJEWqzBeh1uqjAA2hK35fVcS7iNmqGOZlj6jSkaYFL2MZcvC0iyeiv
 uitnV1eYs6nwVYfQ++XWiV1Mx76usXhZfTK48GWVQ1DPoSnU+yA5bpP2RaAdsu5lyUzA
 kWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EScZQKGcPH3FZkpduQg/uPJtmsj22jK59Rqvp+owkrU=;
 b=uOBWXrfU99rVzFkIZQxEMiS/NimyEdGMAiGtANIGFAY0VuuC97EGiL23keSmqseeR9
 pvQb9OnOe1wsj8KK53byk2U2RoxC9VYs7zz9nhbEP7kLS+51h6cu6OQ9t4c+nwmOeM0X
 BFSLWqvjx0PqyWKTqFlt5XpIj5QIUU8U1oY2AjAXDz1KjZabE9xmAMdO8lf0TpJON1zs
 KTvA8cZg8yXjMd+nu1VxHiTgdXcO2zI7owGSl3GgNCkTWf7c6aR3beBJIqWc9JXQQAd3
 xMgkzh/g31iyQanmKInHP34QJSlCBijJwZAzbaqSkFUn7h0SDbkzZGN8phmCPpOqt7p3
 oaxA==
X-Gm-Message-State: AGi0PuaVYw5rKx6HahhaIAWSbSHmLeRviUXjqkv9xLsNHKNhMWnCUJBH
 bJ8fTrPDrBDid5zS58ymnejqs3a2itFbUyeAlbgSLg==
X-Google-Smtp-Source: APiQypKiskU0nPLGuHfGQSa8iricqcFoEBu9Trx8cDbzpHm9eFvhyhOjrhD3UcZS1KkKHRNCEXQ6F+kvUBz8DVDapaY=
X-Received: by 2002:aca:4a45:: with SMTP id x66mr17739909oia.48.1589188442721; 
 Mon, 11 May 2020 02:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <41b4d4e6.25f8.171fdd253e0.Coremail.13824125580@163.com>
In-Reply-To: <41b4d4e6.25f8.171fdd253e0.Coremail.13824125580@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2020 10:13:51 +0100
Message-ID: <CAFEAcA-opTbexP9iupVCXrKoeZkd+5HNZZ++Lk5Sa6zKSnF4eg@mail.gmail.com>
Subject: Re: is there any way to make qemu stop at the very first instruction
 of the emulation process and wait for gdb connect?
To: tugouxp <13824125580@163.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 10 May 2020 at 10:18, tugouxp <13824125580@163.com> wrote:
>
> is there any way to make qemu stop at the very first instruction of the emulation process  and wait for gdb connect?

Yes: use the '-S' option (as well as the usual option
to set up a gdbstub connection). See the documentation:
https://www.qemu.org/docs/master/system/gdb.html

thanks
-- PMM

