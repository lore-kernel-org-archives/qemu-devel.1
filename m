Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D95CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:31:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E557205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZV6DI2kX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E557205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMvBp-0007sA-Ts
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 10:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMv9k-0006LN-Fv
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 10:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMv9j-0004qN-6f
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 10:29:04 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:35998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMv9i-0004pb-T8
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 10:29:03 -0400
Received: by mail-ot1-x32e.google.com with SMTP id c7so3569480otm.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 07:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=21QePouUgHt/oRxem3nbzuQBIZQnjGNbRt6axQbekyg=;
 b=ZV6DI2kX8hRYyJFdKMJK4j7oYVcF9+ExSN6Lrihp8YGyfUrufrn7zeGUDyACCKQGcr
 aukVPQKv43ZjB1hOncwBwssrRK8jQpQIGtMYFwz9IfWDTLVfxDKhWNzjYnXrplLW3tFN
 3kV4il9zWWRbTrJMtEWZ9tdYwhnJw5VyudEPq/h9JdMqEVKmjTFNfmBWAWC9LNEw2CFE
 bQ41I1bD32yMgGRm1nmXqxU/ITK9kcF/gfb9wEclU+g8A8JMKSFBSuRQqBkIgZiHG3IS
 M97+V+m6XLCG29HCwriV8zY62C1Mk99zl9c/7gjEzZYdkv5XC/sD0GAXm9iwawTx6CYm
 s73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=21QePouUgHt/oRxem3nbzuQBIZQnjGNbRt6axQbekyg=;
 b=DEoJKFVr1651tYCraKCXHDAY/5X3DqVblWahaPw8ty/PGOJkNBAXTBGiacdoq6JQed
 OeAbDPz6OXrGlpqM9iTmyC7vvtHYEjtZZl2oMIKb/nsx59GYH4y3yaJzPGtwKNiEJ+1p
 IK9ZrubpSP1bKCEB4DnUTuogzuWNaXxqao6ewk/+SP6v+/Eo4xvZ/DUBOWj6uUnnU3GY
 Ao0S3kRJYrCtaos2+etWAfBSmzV3F5zUtd4RQy0q8BRh/Fv/cuqzbyWXwZ/p5a7MDsgo
 IEyAXtEe4w1sj+Pcwi82RJTdq4eoeY/3ot+tQKYInvKz+UP7kWNJzjgmOyHeg8HrE+Vo
 4VZQ==
X-Gm-Message-State: APjAAAVPdHY+sdoUw/nYMLHOfUz9IwqHcRfPt9uaefuja1nCcECy8gVz
 +wNaaFfL5RbrUH/epw11Qm1gFFRr98OMLwtxmrQZKg==
X-Google-Smtp-Source: APXvYqznb9r20ockMqyjq1cV+iipowxz6f7jJfK/X3z81jRpyoN8BIi/PEspMLAMvp8RCcPcO7oKdjmsHPdHSoBVCvw=
X-Received: by 2002:a9d:398a:: with SMTP id y10mr2814807otb.97.1571754541944; 
 Tue, 22 Oct 2019 07:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191022122145.27792-1-armbru@redhat.com>
In-Reply-To: <20191022122145.27792-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2019 15:28:50 +0100
Message-ID: <CAFEAcA-nZW+RkkRKrfZQ9_nFi7y=wCjciqgFqV5c+8PWeG3Ztg@mail.gmail.com>
Subject: Re: [PULL v2 00/12] QAPI patches for 2019-10-22
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

On Tue, 22 Oct 2019 at 13:25, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit e9d42461920f6f40f4d847a5ba18e90d095ed0b9:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20191018-pull-request' into staging (2019-10-18 14:13:11 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2019-10-22
>
> for you to fetch changes up to 0582bce69e8688fd7dd5501d352695e5c675b89b:
>
>   qapi: Allow introspecting fix for savevm's cooperation with blockdev (2019-10-22 09:28:11 +0200)
>
> ----------------------------------------------------------------
> QAPI patches for 2019-10-22
>
> v2:
> * PATCH 6: Add "# -*- coding: utf-8 -*-" lines
>

Still fails, same way. Both your pullreq emails have the same
"changes up to 0582bce69e8688fd7d" line -- did you forget
to push the changed patches or something ?

thanks
-- PMM

