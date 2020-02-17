Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E7BC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030E12064C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tplBBtkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030E12064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3il5-0003v9-8Y
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 10:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3ijz-0002UG-Sp
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:55:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3ijy-00089r-NG
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:55:23 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:45471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3ijy-00089b-Gu
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:55:22 -0500
Received: by mail-ot1-x32e.google.com with SMTP id 59so16502883otp.12
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 07:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8kBDhxVVM/Gq1wwnz0BXDQtaLqVE7Wb7I+vJhj5biCE=;
 b=tplBBtkpJM3KaRJ5XxZW0s+jwwaiw3QXLJuJiBdCwrPcP0Z2VdiUqcDvuJtR6gjFwR
 fZbpxYnrZUBou9yKVizfOoGJDCJpTit+u4qWvIcVirIGbQ8my9Pg/JlVYP0soKrZPo+b
 iiZA7hpXcB70c71h6s7TqHV+uNQwnN9O1r0nwObMyod9Ppg5IqAsyr15c/09Ri+DOyd8
 nkOzGVr6KbjFDAB9OeIdtvXTzUpicTRSqYQpAgePWDgC8lj1kziY5zBf0LqE5GbW+nKc
 009Ox7xi/Nd0kzeuvJP/fumQ1VqLL1HOWag7Nu6xgxT9zBatjeS4JaMIKnCEd9vp9H2x
 9pLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8kBDhxVVM/Gq1wwnz0BXDQtaLqVE7Wb7I+vJhj5biCE=;
 b=aszesgHlEIsjVtz0t9Do8a+9bBh1IIUOoXxvXfqZDcuoFOPIT89/s/l0UImdc4O5fg
 ScEx8Vf4Ok4epypPNpk2wJs2xhuzhXkb83ZfO3d9n5KEbgxucMQXIVLSn/ih6Jvm0qVO
 2USNbI1VdpJWZ9YBphk1MrrRFz3YZBKH8e+3/nvAmbyYQsDIlz3Sw9eJb04xxt/TF5pH
 SLQRXrq+q3n4g2TIPjf19L4UjmWcSkMkyWADxtqkTx3MAAHW07K7CC2Z8MiTS9KdI1W9
 m6IpeYCHqxm0PY6Fnmzfi/5Rr08TUK9bsDa1QilqY0Gikn9B1g0oLE5Wq3CDPxi4gdin
 5c7g==
X-Gm-Message-State: APjAAAV7Orp+kpK9+6BE1+782hez81ZnF2NawTZ2tftNxNMmYNxZB8pa
 jagrCS02oVu7ZlPFsSHc/A+yxqm0pD4fCIz9XBBErw==
X-Google-Smtp-Source: APXvYqwg0eQgX7SXymOmnT4FwgBtMNMJ0ifa3g8Go2uNWYEDodvIAG1IV2lfv6OTaQ17I48BolMbVuLspaj/uheg+Bg=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr448036oto.135.1581954921324; 
 Mon, 17 Feb 2020 07:55:21 -0800 (PST)
MIME-Version: 1.0
References: <20200217132814.9018-1-armbru@redhat.com>
In-Reply-To: <20200217132814.9018-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2020 15:55:10 +0000
Message-ID: <CAFEAcA_PxO9kPLB8vZnBzZ+0Skyeisr3wGJ0XU+j2ChT45PR2w@mail.gmail.com>
Subject: Re: [PULL v2 0/5] Monitor patches for 2020-02-15
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
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

On Mon, 17 Feb 2020 at 13:31, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 9ced5c7c20cb16dff0c2fa3242c3ee96b68cec2a:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-02-15' into staging (2020-02-16 21:15:26 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2020-02-15-v2
>
> for you to fetch changes up to ec95fcc8bae624e87c7601d2d4baf7c519c3814e:
>
>   qemu-doc: Clarify extent of build platform support (2020-02-17 13:53:47 +0100)
>
> ----------------------------------------------------------------
> Monitor patches for 2020-02-15
>
> * Refactoring in preparation for qemu-storage-daemon
>
> * A doc clarification that's admittedly not about the monitor
> ----------------------------------------------------------------
> Kevin Wolf (4):
>       monitor: Move monitor option parsing to monitor/monitor.c
>       qapi: Split control.json off misc.json
>       monitor: Collect "control" command handlers in qmp-cmds.control.c
>       monitor: Move qmp_query_qmp_schema to qmp-cmds-control.c
>
> Markus Armbruster (1):
>       qemu-doc: Clarify extent of build platform support


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

