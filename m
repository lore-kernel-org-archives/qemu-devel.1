Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA112C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 10:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823FC206BB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 10:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xVcj7VYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823FC206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEtGi-0003an-Hn
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 06:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iEtEt-0002cw-Tl
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iEtEr-0001Td-Ts
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:49:11 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:37858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iEtEq-0001S0-MC
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:49:09 -0400
Received: by mail-ot1-x335.google.com with SMTP id k32so7862670otc.4
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 03:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s0B1LojPhIMWMLJNus0el0jsNpPTVPXwv343VIUMhxQ=;
 b=xVcj7VYj4zKsqfOr1lkC3K1vszXt68mVnWnxorg/aTX9SKPxebyV0e35Ja7A3buYpA
 KMPbPX9ndt5fiMntdzpmdlsnPYYEpaLKRfIXTBRPjK75vWYBHaeRN7eZrP0sDMfpLznp
 mw3M4x8FgkW2WOwMOfmYYCH99qJPxp6AYXh/n7mew6QeEjdgISwB3oj5IEB6XZ6iJkpd
 tEfewOpkZemBy033KjwdF1RqIRBx54UOxnvocxf915FpiUl3qkFDXEx3iSy/65EPFub8
 OfLN3uNsMP+nEh08DjnzfpE71mz6NbpTI1HZRxWgxdQ5o0HolmRnZekzTEEGJmK+zMRr
 YiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s0B1LojPhIMWMLJNus0el0jsNpPTVPXwv343VIUMhxQ=;
 b=EdbQQ+s90QgEvKCG6PtAyH6hJ9PYh22DVqCuZ6Jk5fZQ+3vINT1ug9o58xz2BFORSN
 W2RuJjE218MOYK2AuJ/Hi7vbpnkS8dCNWYsEc22Uj0uKkclt5Xy30Q136aDeF/rFT/f2
 xgnRrxQ6ACFCIac0403K/oWYXLVuDIWukk0BvoecSZ4vWYclz2GArEgQdqfQkeEBLb/3
 sJQihHejHVd+MidUlFFPmmqZn9jSWu8iUtRMyfd/3KVItuHy6C2mXsnvxL5QqPFldXPZ
 tSN1vrwk9pORX7Bx+Ts+qpS8L442qzs12dfZbcEyJvYHVq/rooKFMQL2QVqRfh7zKxUd
 8u5A==
X-Gm-Message-State: APjAAAWKeADH+Jt4UqRbjfbBdH4Py6FxD0oldH1msfkq7Dav9E9QhJv3
 Rw1fxRWUdSY9j+9aPFfMWfwMqmiOjUpabDMHxheUjg==
X-Google-Smtp-Source: APXvYqyLIIRxy2y0v7LwhTTVSevIIIxSAgA856Ar7Uk29ZVPyHNcGYemTT7hqMws+akHMFc6oyvu8ujHmHk/sLFMtss=
X-Received: by 2002:a9d:73ce:: with SMTP id m14mr8552899otk.135.1569840545411; 
 Mon, 30 Sep 2019 03:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190928183934.12459-1-armbru@redhat.com>
In-Reply-To: <20190928183934.12459-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Sep 2019 11:48:54 +0100
Message-ID: <CAFEAcA8tQde=o0FaezJuRb+fw_gt-7sq5pQSr_3RNjqc9jenaQ@mail.gmail.com>
Subject: Re: [PULL 00/27] QAPI patches for 2019-09-28
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
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

On Sat, 28 Sep 2019 at 19:45, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit c6f5012ba5fa834cbd5274b1b8369e2c5d2f5933:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-260919-1' into staging (2019-09-27 15:43:41 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2019-09-28
>
> for you to fetch changes up to c615550df306a7b16e75d21f65ee38898c756bac:
>
>   qapi: Improve source file read error handling (2019-09-28 17:17:48 +0200)
>
> ----------------------------------------------------------------
> QAPI patches for 2019-09-28
>

Just a note that repo.or.cz seems to be down currently;
I'll retry this pullreq later in the week.

thanks
-- PMM

