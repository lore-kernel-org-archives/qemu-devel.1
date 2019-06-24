Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E266BC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9197520674
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQGvgh6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9197520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50020 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfN8l-0007Qc-BB
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 07:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60524)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@gmail.com>) id 1hfN6f-0006Oj-AH
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1hfN6Y-0006sU-Ec
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:25:49 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45164)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hfN6W-0006ZS-9L
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:25:44 -0400
Received: by mail-oi1-x241.google.com with SMTP id m206so9440089oib.12
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 04:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5ST2PF5q4Z6x+/Jg3bOgoDlbdjI3m8HcoOI/bl+t7Ro=;
 b=bQGvgh6Ynl718K2KboiBBylaQBoPBnYSYySKsNNVs+mNGnjm2IFhnBQmn0iPeeYRrH
 EHgQjS8LJh9r7DkFregoqWP6VwfHxiexc3R9zWW1i2n9QO6H1hp9OqbfzT2lfeGjC/ZZ
 ttyWXpIGd4tYPVj8l7iLSPd4QzrXY+UzrSPx7Z3oMvr7g9TtJVMupR8qnx2CFhQtoCeA
 2z6sg2c5/pD7f+G7sUNM2ogSyvpFahQdrzOAhu/hmDs7IVZ+RFm1N+pNpkGhWkvw88xN
 EtdB5bvCcUl5VluFPJwjYfHNM64r9tCgexUNZuFx13xSUsTY1IV7IweeO9/DkX07DoyX
 kmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5ST2PF5q4Z6x+/Jg3bOgoDlbdjI3m8HcoOI/bl+t7Ro=;
 b=Dw3k1/HKohClKFSwH18Zy2OsxSt30rZc6RgzThNl/HfT0dTLuQYeeM11lVHUwkVWSW
 ecZWg2+49mYagmBKYuO+dTwa2WfxTEA24NEH+nTcXaVybFxPGJuejGzutMaIIper9/G9
 ydosD3p1yQXGdQniBWFFmRnyNXg7bYB198B2uq60BXLK02UL1IlObOPzS4ZhiWpqLTW1
 wDkif3NUIeX/H9zDPXly/OFNNdUMAG6WpTnJmmiI+KGtFHLk7/aHzh8Cnbzmw9mKIdwe
 NUWnRx+o8sWJrHpTEWay8Q6D5gVhg/FgkvNrKF1/qgiQWzKSX5XbEGOHBAF2uDND5r6C
 OtoQ==
X-Gm-Message-State: APjAAAUgL465gz0ggI5I4LtCNHRh7eIu1h5CAMaOSAT+95WK38EKr5So
 4lvPiKyZ+/RbHqS2j5aSOfx7qG+DtQ1mlLMBePA=
X-Google-Smtp-Source: APXvYqxfGq2vdXUi8TnVkiYIzyhpqRRaAufCN2jNVzxM/FgUII7js/mL05oie7Q0bH+JHxn5fnsPeyf1VDb3CFI+VlQ=
X-Received: by 2002:a54:468c:: with SMTP id k12mr11158865oic.56.1561375533623; 
 Mon, 24 Jun 2019 04:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190622002119.126834-1-liq3ea@163.com>
 <20190624094216.GI6279@xz-x1>
 <CAKXe6S+5Ad-WHYpX9E8EFv61ASxSQYL+RQoqnG6NVbysgtv4FQ@mail.gmail.com>
 <20190624112056.GM6279@xz-x1>
In-Reply-To: <20190624112056.GM6279@xz-x1>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 24 Jun 2019 19:24:57 +0800
Message-ID: <CAKXe6SJ2eV=nOQgmT3OAaWTFv6unr4p0zS3tTrjHwCadPB43JQ@mail.gmail.com>
To: Peter Xu <peterx@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2] ioapic: use irq number instead of
 vector in ioapic_eoi_broadcast
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Li Qiang <liq3ea@163.com>,
 Qemu Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Xu <peterx@redhat.com> =E4=BA=8E2019=E5=B9=B46=E6=9C=8824=E6=97=A5=E5=
=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=887:21=E5=86=99=E9=81=93=EF=BC=9A

> On Mon, Jun 24, 2019 at 07:08:30PM +0800, Li Qiang wrote:
> > Do you mean the redirect table entry of ioapic update?
>
> Yes.
>
> > I think this is reasonable, I will prepare a separate patch with this o=
ne
> > as a patchset later.
>
> IMHO you can post that as separate patch.  After all these are
> different issues and this one looks good already, so no need to
> repost.
>
>

OK, got.

For the maintainer please remember to add the Fixes tag Peter adds in the
review
and also merge the v2 version.


Thanks,
Li Qiang



> Regards,
>
> --
> Peter Xu
>
