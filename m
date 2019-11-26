Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FFAC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 16:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0792073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 16:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WuTARiGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0792073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZe55-0003Xy-Vc
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 11:52:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iZe18-0008Ty-Vr
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:48:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iZe17-0007mv-Kz
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:48:46 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:45877)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iZe17-0007mY-Fl
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:48:45 -0500
Received: by mail-oi1-x22d.google.com with SMTP id 14so17212741oir.12
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 08:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oCmRSdgXAqAKl6pvy9RZQ6VlZ6cBuTC+vcSUCm3TIjY=;
 b=WuTARiGllWMpBcMfADyRDR+JdbtHkHWShexTutQXuxw2eSVtNygHiYB8WL/RD6wj8+
 oViYCwM9f3Tt7lH8YUd0Kv5/oeLHpydOycZhcZNzEY2dTx4n30/f9Htu/DsRku8tcksa
 gw8rKIgHCfHCZW979t9AQhzJkkBguObJNJk7BDjCW3MtmZgslgjg4ubX88RxNCjjefwn
 cxgo2b48c0C1vWnae7fX2xOmr1pVRC06tI5akzF4JmV/3TfUDG7aN1wchNYJ/4St69xA
 /R49+d1GK9dVjxWD6oWl8g7SNOWvIjKAl6zl10z3VQQjeQ9LFUSozWQYubP7fYgSAtwu
 Z/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oCmRSdgXAqAKl6pvy9RZQ6VlZ6cBuTC+vcSUCm3TIjY=;
 b=A0MH8nrIJRUTi2Ai7Twn8EPkA8arkWVIGH1p80yIxWPOuC2vsvX/gDrAiYxFPcfp7+
 EWAWnchZsN5x0DqSrISkyGb4H76vS0bygSf5QZ/f6LC82q0DTT7DeKOBgCSCdHV6mDzY
 +TOBc3OLWACJ8bp50hXZdXhux1iB2Rec8v8Az7yx/e1DWORsG6mpRfrSv0FmASk9oecD
 jsEzIa464cZOoJ/zcoJDRmRcekbC4N0AL3k9AL/J+XMCfevGcFm+RzewVgBW4q2sb/aW
 ZEZ2f+du7Xt0pT12EPFk3Nwm2HXnyQ4xw0/k07oIw65Y3+4LB+8ElhbmEaKSN9lwDtmo
 hcuw==
X-Gm-Message-State: APjAAAV2Iz9u811MCOTaQDoAvOdOdnv3RoTL6akuxmyYSfGikEDPTGDH
 w4sfFTnvfa8SU5iYFbXZIxACfYRxCf/6j1l1GXCjdg==
X-Google-Smtp-Source: APXvYqwTUlHYIAwvfS0aPEoJn9JO4kVEn6q25qwdO2hd5QmkXllkuxg/QWhWdk+LwHi6HOzqY4UU59Tis3uUMQc9M+k=
X-Received: by 2002:aca:5ac1:: with SMTP id o184mr4468054oib.170.1574786924471; 
 Tue, 26 Nov 2019 08:48:44 -0800 (PST)
MIME-Version: 1.0
References: <20191125225333.322163-1-ehabkost@redhat.com>
In-Reply-To: <20191125225333.322163-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2019 16:48:33 +0000
Message-ID: <CAFEAcA8_6JSJAjCez=AHR1bTAhLujv3NHi9GtVtpbEg3Lj6=EQ@mail.gmail.com>
Subject: Re: [PULL 0/1] vmstate-static-checker fix for 4.2
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
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
Cc: Juan Quintela <quintela@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 25 Nov 2019 at 22:53, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 65e05c82bdc6d348155e301c9d87dba7a08a5701:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-11-25 15:47:44 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to e8d0ac5801edda91412e52fb82f291eed5171c2c:
>
>   vmstate-static-checker: Fix for current python (2019-11-25 19:49:50 -0300)
>
> ----------------------------------------------------------------
> vmstate-static-checker fix for 4.2
>
> ----------------------------------------------------------------
>
> Dr. David Alan Gilbert (1):
>   vmstate-static-checker: Fix for current python
>
>  scripts/vmstate-static-checker.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

