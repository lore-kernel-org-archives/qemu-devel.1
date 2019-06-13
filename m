Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE0FC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 19:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC7620B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 19:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UiZQWZdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC7620B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44254 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbV3g-0001HP-LX
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 15:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46965)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbTy3-00066o-Bs
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 13:56:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbTy1-00045N-Uc
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 13:56:55 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:36185)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbTxz-0003z4-Lv
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 13:56:53 -0400
Received: by mail-ot1-x331.google.com with SMTP id r6so36085oti.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 10:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kXRzzvf/Kr8HgFa4YX5oTVBBGu3qPyGIdY6iNYAU5Ls=;
 b=UiZQWZdrEnDPVU17NJu7OV3F7WQvv83wNrSMfha7+FluaK2jeL7Fm0HXaWdbkXajdH
 UheqyVcBohjiV085tl9hqPBGaCVEVxSEs9hJILm6n2dAExhKD42nvQZrBPuTdOO689io
 B6HeCHIaAlevZ5a24miTFYlDsXjxzOFv+bP9cSL8Da4w9omlM2d+YSXYSJXzabbVlvV6
 y3/WcM3lvijrdR2j3t9bhkShavMhCpX0C4XGobNtcOfMo6s517rQbGPo5ByCFrdtYB/9
 LcLKn8OYEudHELGE+vGddQelxpMBxbEN8Fkd7YVFcHvV+0T8NMlZz1GBXFBYmXKlIXs0
 8ivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kXRzzvf/Kr8HgFa4YX5oTVBBGu3qPyGIdY6iNYAU5Ls=;
 b=LapBt66ohqvaybNrAnrteoGJMdFrvAyXjJhtMrgUE0Bw5wPiiBdxkUts0mF4tqaZRS
 b7amziWMLB+FbW364f//ln1a5z1OBFd4IjamX77do46j2RDdIUWqFUiOcBfqonaUk4kN
 UbPwuRvxxzyOZuHuc23W8Hhdd55Fuzy8ybqmXYZokP09XT78Y6SYmADXF0jwnkSeE5mJ
 kix/Z2CuewJXj2c96AEhH202uk8TQerbuIw0j9XDQ/IFsvCvGGWCfHescP58SHQNVwnD
 iBK/7k/QRcf6qgZwzvaUEfC4eafPekVFEhxMHMHBCRjYyienkL9MKpKrFw6FaLjbA8pb
 E1WA==
X-Gm-Message-State: APjAAAWAYkTn2TCXoOomKU7XCmkPlrWl8hNykFQxYv8Yet3BX6SGv5mI
 x9UA3fXvOqc5zITuY8n/YG+c/gbuOA39BD2GVFYSqA==
X-Google-Smtp-Source: APXvYqwlXsJNDBr8BkCBjz2xoDrEtJ3qwqO8ru9uDXkDdyZJGn66+p50/AXDNPSBRcN7/dElV3QvFqOGDusQlNYnhcM=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr2618612otn.135.1560448609719; 
 Thu, 13 Jun 2019 10:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190613154837.21734-1-eblake@redhat.com>
In-Reply-To: <20190613154837.21734-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jun 2019 18:56:38 +0100
Message-ID: <CAFEAcA-OLU+k=hFnz1enXZWK4m3Vy7T7iQ3QNJbrCwecmHHqpg@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::331
Subject: Re: [Qemu-devel] [PULL 0/9] NBD patches through 2019-06-13
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

On Thu, 13 Jun 2019 at 18:13, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 785a602eae7ad97076b9794ebaba072ad4a9f74f:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20190613-pull-request' into staging (2019-06-13 13:25:25 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-06-13
>
> for you to fetch changes up to 611ae1d71647c58b23dc2c116a946884ce30abf8:
>
>   block/nbd: merge NBDClientSession struct back to BDRVNBDState (2019-06-13 10:00:42 -0500)
>
> ----------------------------------------------------------------
> nbd patches for 2019-06-13
>
> - add 'qemu-nbd --pid-file'
> - NBD-related iotest improvements
> - NBD code refactoring in preparation for reconnect
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

