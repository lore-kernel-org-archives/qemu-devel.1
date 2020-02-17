Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7EEC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88783206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MKYAvIax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88783206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3dE6-0001wG-OZ
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 05:02:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3dD1-0000op-86
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3dD0-0006q1-5R
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:00:59 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:36414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3dCz-0006pE-WA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:00:58 -0500
Received: by mail-ot1-x334.google.com with SMTP id j20so15542607otq.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 02:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9QJxx1j7c5NPaOZNw3Ib9wYNiueOrJ0NNrXjyoiApWc=;
 b=MKYAvIaxgu/qD2SrjVKH4s93WBv7wvOPhXVgQHtVyFZ9SrgVv+GzIH0Zwru8i+EtIC
 oaxPiTJUj2FxSYfyggXQaVz6drih48ovsbzOLJw0NOD70QWd84ssklzlcIluq56X/5z6
 lNd2mpejB8M5HidMMRo0B39TaWIgVh0HaVTYu6Bk0GEhyNBVzWuiH23qe/VSju0HnWk2
 +gNsnyCVVLPVdPbZJJb6OK2ZY9gPMupM2J1fjDucLTKeLVfNjP1AxThtgjfmkz+yj3/v
 Kp2qYW94aS/Ye/0vRnVBdp8pNuMTLcifrfLqT+8ZFt2plgWU8796obNPrMeyZlBr/H+o
 cHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9QJxx1j7c5NPaOZNw3Ib9wYNiueOrJ0NNrXjyoiApWc=;
 b=cGS/JJCdPKZWBxCJ0JUe1CAPQDajzpFdLDLUJFm/Hrk3DgjzrQ9KKI5b4JM6wiFb46
 aMb2qpOJx3iTVpO47EICUaHcSVqJDdKSFZq/H9/wlthFVNmGelNVjYD6oPFM1kZ7o9zn
 R8S3zXQi2hkVC9U0Cgg2r3CMKi9oEbezZ3PjqyIJ1S6Qpgir35Icu4Avhg0KSJh5zprD
 OduOunTYlzx35byTLi3aRjifda18awytc5+2g3KsFfKiTpSgeAN/1UT6B5q+iIeCLsaw
 vZDRtP1T/+pbXb8KXm9FKJvtkr10XLrCK1oJbESXsbnYAAlVEPUxWmbo1vNoPDvIknHn
 3Wvw==
X-Gm-Message-State: APjAAAX965W2FPO/yzSDvomZKSuhfSxYukVpYo87NOlMwPM9b5DGwTpK
 kvnda1ueWGNQeDDl2SpB9xa4JWerpJz0OdHzfrINlfoh
X-Google-Smtp-Source: APXvYqzXmXV8qywFVNF2uq3Gb7KaHmjnAPKEtveQQZ+A8HNgSjbTKcrZj5BHtj5/bktf0T1xz7APood+/EUPWYDrZnQ=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr11556839otq.135.1581933656702; 
 Mon, 17 Feb 2020 02:00:56 -0800 (PST)
MIME-Version: 1.0
References: <20200215130527.28861-1-armbru@redhat.com>
In-Reply-To: <20200215130527.28861-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2020 10:00:45 +0000
Message-ID: <CAFEAcA8Lj4a5Qsw7rJzHSm=UbdtSKqUT88Ss=K9DOeYq0S06Vw@mail.gmail.com>
Subject: Re: [PULL 0/5] Monitor patches for 2020-02-15
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
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

On Sat, 15 Feb 2020 at 13:08, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit b29c3e23f64938784c42ef9fca896829e3c19120:
>
>   Merge remote-tracking branch 'remotes/juanquintela/tags/pull-migration-pull-request' into staging (2020-02-14 17:57:15 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2020-02-15
>
> for you to fetch changes up to 6fce5a08f89d4ebf197fca838d60239482db957f:
>
>   qemu-doc: Clarify extent of build platform support (2020-02-15 12:44:28 +0100)
>
> ----------------------------------------------------------------
> Monitor patches for 2020-02-15
>
> * Refactoring in preparation for qemu-storage-daemon
>
> * A doc clarification that's admittedly not about the monitor
>
> ----------------------------------------------------------------
> Kevin Wolf (4):
>       monitor: Move monitor option parsing to monitor/monitor.c
>       qapi: Split control.json off misc.json
>       monitor: Collect "control" command handlers in qmp-cmds.control.c
>       monitor: Move qmp_query_qmp_schema to qmp-cmds-control.c
>
> Markus Armbruster (1):
>       qemu-doc: Clarify extent of build platform support

Hi; I'm afraid this has merge conflicts with your other
qapi pullreq. Could you respin, please?

thanks
-- PMM

