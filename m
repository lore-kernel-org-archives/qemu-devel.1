Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E03CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 21:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 188F721721
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 21:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="keSD7L6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188F721721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPYlM-0003a4-7m
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 17:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iPYjQ-0002YS-62
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 17:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iPYjL-0000J1-7N
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 17:08:47 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:40785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iPYjF-0000De-TD
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 17:08:38 -0400
Received: by mail-ot1-x336.google.com with SMTP id d8so184582otc.7
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 14:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mbJdKWUZ6gZLvM1BddtEDcq19cerbF6LlVUJfqKESMc=;
 b=keSD7L6VbiSYCHcfWcu8JmCx5a3ftWJlKHWsCgodzY19mjvFw3WQkJS3/Lxi2+aYdQ
 ddK0s8jtlkIGvjO8OTlCGAEUvnT0vYuAQMsGD2rZ+LkHxhn3OQDYkxf078cG259wAftl
 K1E2poYV10/IVLJCaezVrhNfTh2g0pfcoyxjW8VIefPPNCGFYUFN34aH9bKZT41lPJhA
 16I3/gaAm73QxSaB6ek8WEGNGlSbvTKmkFrNLI3BSO3vtZRykXrpBb8krS1US2R4V6O6
 nab9XqREp+QwLiJN+HelCpyFjip5czqhOKskrmbLKpDVX8d8NQTjCVfuIIICArGv1ySg
 wQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mbJdKWUZ6gZLvM1BddtEDcq19cerbF6LlVUJfqKESMc=;
 b=XOszZy63oyQl4WC92YXslm3OpkXzXrnwfJLlBIe4JSYCKZJ9pm3aTahCJUzDf8X+UY
 tTkfU388UfzOf+HQpUVCGaTJ+qTCxvjHIX3e5JPoeSpBrmkZZY+MUWqZ4s9mEBZVzL+R
 lCS6QhQdKCSvipsJ2m4QrSgSI6/PvcqgvRoHMce/WE3j7Qt4jgx3rGWae6ziA1aa4L6A
 I6bbHuRuaFNJ7/FF9RP3+xGkbYOvMsn4Y2ff6unOPxr0iNWP3ZMFCCJtZToFQumMc7D0
 3Tetx2U8RgYm+mwuUh9cudpm5+2A/St6sAC45ioxBHW3JEnkxx/tYPRWkJY54XOyFr8D
 H9NQ==
X-Gm-Message-State: APjAAAVnbg3SnFEu3RkacNg3CpYvqtheyr+rx3OvihvvKN7GZdGEQGqi
 FVINfZsm9SL0BF5F6dn1F8lcRnMoyQyb0zMf5fRE7g==
X-Google-Smtp-Source: APXvYqxETKqm2TTDny3Lnc2M/eNB8yYkB1fZO9I5voO4wojGII5gk6du9+sr4tdwhNilkcNvvGD7EeN0BhY+48q89S0=
X-Received: by 2002:a9d:7cd4:: with SMTP id r20mr2884319otn.91.1572383313537; 
 Tue, 29 Oct 2019 14:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191029102228.20740-1-armbru@redhat.com>
In-Reply-To: <20191029102228.20740-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Oct 2019 21:08:35 +0000
Message-ID: <CAFEAcA9G2o+xJtyvRfEKf5aX0L__V48qTXUv=CMMOdaRFj6_Uw@mail.gmail.com>
Subject: Re: [PULL 00/19] QAPI patches for 2019-10-29
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
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

On Tue, 29 Oct 2019 at 10:24, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit aaffb853359829a37daaf883c773e8320b55c723:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-10-28' into staging (2019-10-28 14:40:01 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2019-10-29
>
> for you to fetch changes up to e151941d1b691402f7914750e025209b7839a1c0:
>
>   qapi: Check feature documentation against the schema (2019-10-29 07:35:16 +0100)
>
> ----------------------------------------------------------------
> QAPI patches for 2019-10-29
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

