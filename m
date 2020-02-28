Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D6EC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:02:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 562CC20732
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="imxbZGIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562CC20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7i5z-0001IX-IR
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7i52-0000eW-Qq
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:01:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7i51-00089M-Lu
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:01:36 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:36626)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7i51-00088s-GU
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:01:35 -0500
Received: by mail-oi1-x235.google.com with SMTP id c16so3323844oic.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yAoJfoCDQa8NFSywO6cKFZoPqF92BWDMzqB4VD2DmeE=;
 b=imxbZGIhoQAR+hf0fNwmRTEdXx3XbEJ5CdXYLEhFP2rySXBCP2YE6haoT6eyNyQHQ7
 f6umD+0PMHFFDGZoN80Jlw4EF5LNqmBtsgwq324xwJFhw5wcdAsMd3dDPdwK2LoWuxU8
 2y7F9nKj/twRwdCusgDQ2+MQUCtF9WMZadyyQ++nhA769BURuNBX+JAnbuNts6v9E+n9
 n5yKM69Q+0+vJESFZyiZTJrQvGAIhXux2u6kLYGRyixl+48gAaj6O+z8a1+z8bB4ef4C
 hDDkBHSlqLJkoEVQb0BUKcjgw7tbuEuFdIXgWKcD6OoWJmMwpVBal0bT491zL1n9eVN+
 AvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yAoJfoCDQa8NFSywO6cKFZoPqF92BWDMzqB4VD2DmeE=;
 b=RJliaTQelCoK53wupFALOx7ZvUw/Uicv1EaKNuyY4Um7gWFk/tExmyc2rU6FdOEtMU
 D8PL9XLWhEQQY2je7GXYHY7ocBCVDitoiqQuEmR+CgocH9T4DW9iykDLhgpedOXCpo6i
 y5RC1INdO+fBSE51C4BIfr/EV+M0bGh/LGQMWcxt0nZGV3kvPLEOYqmBJj8evusExf1x
 Vn6EU2+2Ntftvlscs8U4mbnNjaVYNqE558hDtrWBgXHkN6XJFiORP2ngNFD2HgOHE/PS
 6eHAEZQ+KcpRDQuEvsjt62ZZb3axDdhrHyngAGsvRJlP7VsYisZAGUxKbZT9S3L05tWS
 5eZg==
X-Gm-Message-State: APjAAAXzX++NIjChAaCN6K8I8giSVhr3fHI8HZcUMGDzi6yKU7RkW2KA
 N63WDiVA2VrdlH5SewlTpBQ93G9QWHVgxjfYn217rA==
X-Google-Smtp-Source: APXvYqyyKOFGVlkv1OZReh2oHUpYS3MyREOMoO8xwL3fA8Jlx9oPVMyavmJUGQLdIBe9qQqubzi1/dLOQVuDkab5KUI=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr3765487oiy.170.1582905694435; 
 Fri, 28 Feb 2020 08:01:34 -0800 (PST)
MIME-Version: 1.0
References: <20200228092420.103757-1-quintela@redhat.com>
In-Reply-To: <20200228092420.103757-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Feb 2020 16:01:23 +0000
Message-ID: <CAFEAcA9iRTmYkE=v9hWxSjLbqQuMNschXPX-rrna2RhezjNJXw@mail.gmail.com>
Subject: Re: [PULL 00/15] Pull migration patches
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Feb 2020 at 09:25, Juan Quintela <quintela@redhat.com> wrote:
>
> The following changes since commit 8b6b68e05b43f976714ca1d2afe01a64e1d82cba:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-02-27 19:15:15 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/juanquintela/qemu.git tags/pull-migration-pull-request
>
> for you to fetch changes up to f51d0b4178738bba87d796eba7444f6cdb3aa0fd:
>
>   savevm: Don't call colo_init_ram_cache twice (2020-02-28 10:13:54 +0100)
>
> ----------------------------------------------------------------
> Migration pull request
>
> - cleanup redundant initilazation (chen)
> - fix memleak in test_load_qlist (chen)
> - several colo fixes (hailiang)
> - multifd compression (juan)
> - release list after use (pan)
> - rename BLOCK_SIZE (stefan)
>
> Please apply.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

