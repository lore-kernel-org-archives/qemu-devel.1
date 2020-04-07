Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D8CC2BA80
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 16:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C602072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 16:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="juwtMfnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C602072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLrFx-0001yR-1R
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 12:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLrF5-0001XS-6A
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 12:38:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLrF3-0004A8-Sq
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 12:38:26 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:43970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLrF3-00049T-NB
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 12:38:25 -0400
Received: by mail-oi1-x22c.google.com with SMTP id k5so2044700oiw.10
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 09:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g2K6/kivdpb/gy0FkXHfjWtw8hqxceT1RbziT4cqcfk=;
 b=juwtMfnEBGuBnS8U9fHm02rArXiocT0m5wVIjKOvq2KyJ6Cu+Z0x1I57TszzIOuHR6
 lp/R1mp2QBpKXNcpsJNh3uFduQZVfuFV8zsbj4wudx8HR9j73s9MQEfOGo+F4vusA/EJ
 MrW55lNBlEWyMSFLS5Tl4Ciw/ko5FZbp9cEAw//QtyOI0V38VBUJznfuOdTlZr2WIphm
 nRZZYbyQ/pmvawBTW9TLhCir9JYxZ5nTpDdpqBKhqebK5Zj7YyK9865gXxrIqyipiMpR
 J8arQJuPWnEequGz6QImVwS0OJXnfbL7uwuD7d3XJihcqg1JMy1gK/ub1fJxX3hh7qm+
 1wWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g2K6/kivdpb/gy0FkXHfjWtw8hqxceT1RbziT4cqcfk=;
 b=sk2ZWSOTWwBuM1hi+lHAvewx8yZvynBLJM3jeh3JNZXOQccXqEScsBYJgip9SsuC6n
 juppTRNMRKZmeIsfMOlnq6Y+YW7PvbHcxSCEowtgB54RmJk3W9wsArxhXAwbaIFrBxN2
 EppcwBujlJK5jjqS51q01RnVSasKiDsf6fyhyAQjAiRgBPAac1WygH1mukOsLykm3qRn
 7xY93EEO/blC9lZE67o8rE9DobE8s15Qk/bcKJY+72E80rearrXlmIf66OqdqG5WtwlP
 RYTj7GM4XARyc1elldiWfmK+34G5pVpwh672dm50Yg1/c/+lB/mrhmUNFqnPwEEtunSX
 bOlg==
X-Gm-Message-State: AGi0PuZQaMufc00/nVv+iEqPr8jluwNbrhoLCB8LJYvkf98PObPjwum8
 jQr3SfXk7xAjxEF4BkEULR61HvfeO2bG0fimbjxaRQ==
X-Google-Smtp-Source: APiQypLPIjuHWdLMeP1Fs2lKMQHM7FgV169a19dKc+gFCfCPgDfowW9cwv0roNin+a12b0bxCGk++BMTIksyu83qOD4=
X-Received: by 2002:aca:c608:: with SMTP id w8mr97958oif.163.1586277504802;
 Tue, 07 Apr 2020 09:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200407114523.27583-1-armbru@redhat.com>
In-Reply-To: <20200407114523.27583-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Apr 2020 17:38:13 +0100
Message-ID: <CAFEAcA9N49kG++QtbJ6vsWeBf=xbyGSCwQnONeepG4gw-6AJBQ@mail.gmail.com>
Subject: Re: [PULL 0/1] QAPI patches for 2020-04-07
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
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

On Tue, 7 Apr 2020 at 12:46, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 53ef8a92eb04ee19640f5aad3bff36cd4a36c250:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200406' into staging (2020-04-06 12:36:45 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-04-07
>
> for you to fetch changes up to 1394dc0690e7a1514bd6594322d5a2105e881769:
>
>   json: Fix check for unbalanced right curly brace (2020-04-07 13:10:11 +0200)
>
> ----------------------------------------------------------------
> QAPI patches for 2020-04-07
>
> ----------------------------------------------------------------
> Simran Singhal (1):
>       json: Fix check for unbalanced right curly brace
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

