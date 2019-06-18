Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB2AC31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 10:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D752070B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 10:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pyrkAWmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D752070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55546 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdBl1-0007ii-26
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 06:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38355)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hdBk4-0007Ij-4W
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 06:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hdBk3-0007JC-20
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 06:53:32 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:34680)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hdBk2-0007IE-R1
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 06:53:30 -0400
Received: by mail-ot1-x333.google.com with SMTP id n5so13811295otk.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 03:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6T2xewx2U27mxuSKQ7pFHqjKIDfJdYRz2Ip1vfnma04=;
 b=pyrkAWmR9v9ZLlrmtA1+XgYoFipiZGToEAXbcbXdSzAT0Aze1Gy+84cTmUYlKAfEzo
 ottTggDUkosyXq19qRGn77N91MyqVuqdeJPIlhimAzZjnysM1oKFICKgw0TDFFIMKoyY
 sUFfDnRMRH7/3xccBCnZmFMZPYvQDtU0L2SmFQ/LM4nSfeBt63bWCNVA/VOebafPVf00
 5bjmqgeJjaEtru1YHCryyD9DMERY+HYk67Nq8CpUYW8zh0HNkMkX9SNFP2ajgz3vu6fR
 bbtYzfTigAxMlF4oxK1Bnh/d35qJRMxcg4mbkXtuG4CWB6o2yB9k/XF546aXjc0HS9KK
 hBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6T2xewx2U27mxuSKQ7pFHqjKIDfJdYRz2Ip1vfnma04=;
 b=o/qvv9Q07E9zWck6yMlzv4l7M5feGfneZnoN5oZoURw7HMLpR/a5RkcWAeFyQ0VWGP
 wQhGrV7GPko6UItjXX/We+Q9A0zFXLuiYo3RypEzAIzqiT1JyfWkreHJE1MIhP7Ytz+t
 ByeVv95oI0e2ym++Z8lSIaZdCuqfb3AjJkL7EuiYN4/3eIG6eVoiYuZClCbqeUtQ58Ie
 8TRY5u0xf1VgeG/t0WpVJSLgNV/DD9iNRz0F3xq5/bVtXBi1sWMhTkvGpAYYqD6PeyK0
 SoTR0A7i4DTsOkF20LusdeZ5rPwTPSf4aoEnQRynT4HDFDirAYCWYjnD3gv37YGkSfaq
 v/nw==
X-Gm-Message-State: APjAAAWuszW/iKm3TFqL/7G6EtJYI3o7Ltw4VyPtaThjtZILvE8Lxnwf
 l6aUlSkRYFqKAtRqk/K3wqnD94uC7h6i7VjyBhRO6w==
X-Google-Smtp-Source: APXvYqz6Qfy4+9b6ya2GDFH31hQokZG933TA+pK2B4nzpp/C4i80KT2XdysYRbUthe2XaVs+mZDpOxKgJK32Y+F0Jlw=
X-Received: by 2002:a05:6830:210f:: with SMTP id
 i15mr5675076otc.250.1560855210105; 
 Tue, 18 Jun 2019 03:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190618062641.32214-1-armbru@redhat.com>
In-Reply-To: <20190618062641.32214-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jun 2019 11:53:19 +0100
Message-ID: <CAFEAcA9tcksaA8cvT9QbQzwbef746TtDnzqk7m6eG7zJ2LEYeQ@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
Subject: Re: [Qemu-devel] [PULL v2 00/16] Monitor patches for 2019-06-17
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

On Tue, 18 Jun 2019 at 07:29, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 076243ffe6c1b687e9e6d98348c3bf3398df78f3:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-docs-20190617' into staging (2019-06-17 16:41:25 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2019-06-17-v2
>
> for you to fetch changes up to 3c45f62570aeacadf4a05bfa1afaa12bea05ae86:
>
>   vl: Deprecate -mon pretty=... for HMP monitors (2019-06-18 08:14:17 +0200)
>
> ----------------------------------------------------------------
> Monitor patches for 2019-06-17
>
> ----------------------------------------------------------------
> Kevin Wolf (15):
>       monitor: Remove unused password prompting fields
>       monitor: Split monitor_init in HMP and QMP function
>       monitor: Make MonitorQMP a child class of Monitor
>       monitor: Create MonitorHMP with readline state
>       monitor: Remove Monitor.cmd_table indirection
>       monitor: Rename HMP command type and tables
>       Move monitor.c to monitor/misc.c
>       monitor: Move {hmp, qmp}.c to monitor/{hmp, qmp}-cmds.c
>       monitor: Create monitor-internal.h with common definitions
>       monitor: Split out monitor/qmp.c
>       monitor: Split out monitor/hmp.c
>       monitor: Split out monitor/monitor.c
>       monitor: Split Monitor.flags into separate bools
>       monitor: Replace monitor_init() with monitor_init_{hmp, qmp}()
>       vl: Deprecate -mon pretty=... for HMP monitors
>
> Yury Kotov (1):
>       monitor: Fix return type of monitor_fdset_dup_fd_find


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

