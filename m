Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B49FC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 12:45:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2414C2075C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 12:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CL2/6XX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2414C2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZDkF-0002MK-7U
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 07:45:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iZDj7-0001tO-Nf
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:44:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iZDj6-0005tD-D3
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:44:25 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:45569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iZDj6-0005sY-5y
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:44:24 -0500
Received: by mail-il1-x144.google.com with SMTP id o18so14002671ils.12
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 04:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=15fQz/ukKmnrXq2A3zCq0s4LrSaWEj4oxlRAK43YEg0=;
 b=CL2/6XX0H/nMkW7nejajP8RINQTvR4Z9lon6nm//ooPJWVkbVTGgGlply0Kj07yr6d
 KXTAwV0ZcIovT4/rUJRC42oX/Uq2wvx28lp/GaKCUYn0sPOGhtQFDKAYK6jgdLzT8RZE
 RHnJeC+gbvUUe6GQKyUkOKq4+qzfSvkY3mkqqigW9bwLlC2MlyNrIOXPcj4S1ev7RuQm
 2W9SfbR4JXYoo32NzjsPjVbE3muMFm9OIJ+sMwhEAw/2Kx8X3NFpvKkgE7jQpzLHYeGo
 jdOjwZs92CVQJF6cwoLWJOUUkaoBuGflqKdk/oRZinLHpGws74SGs8GeLXyHtGbWFELF
 iTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=15fQz/ukKmnrXq2A3zCq0s4LrSaWEj4oxlRAK43YEg0=;
 b=DRj1nEmoDPGrpMuiIEGl9bGVedzg27H/zcSSnJJpwle3pf+5c4pIIroop+F/oNkXQ5
 /4F3qp/wftekvH/WxPsGj14+ppU6nObcPptuajcaopYWqcnJkKNRGPbiXL6Vt4tjdUKI
 gRFDdQXcy7NSJSwKl70LXq7lWgM9UpK7IBYK/yTNYgXOzq3Vyimh8vSqW2K+Zls7xLe0
 UnwkhISp/E/xV6J6pDLaixgWy8kQep/SG6dkoxmRA9wce00IPAVZegZEWp60mHpMRSB9
 53HZQokXi67n1QsEJnCoSLyLV4de1RrX4Ws3xwK7ojuWifySRtYEK0x/0kz+Y+jN1RRt
 hmFw==
X-Gm-Message-State: APjAAAUz/hEDfr7ONNXGMdnpdC0T8FwCAPkBL+ln5adKcdDtnJlyORIV
 T27PUkWXgQYkzKZPDp/8wOq0Xn5AG1vAgcauYDdrzA==
X-Google-Smtp-Source: APXvYqwSowqLEL6CHnQnvGXMUZLmixfsWZEcw1+I2oMpCnew6lsqOjEJN8dKTGEEdGwXKG2l5NyBgyJRcjXQkQ2Uq8M=
X-Received: by 2002:a92:c887:: with SMTP id w7mr32281304ilo.143.1574685863200; 
 Mon, 25 Nov 2019 04:44:23 -0800 (PST)
MIME-Version: 1.0
References: <20191015103900.313928-1-its@irrelevant.dk>
 <20191015103900.313928-10-its@irrelevant.dk>
 <CADSWDzuzDPZdXUi-3e-TbwDy8GcGZPM78cA0fUU84nOj+y3NCA@mail.gmail.com>
 <20191119195110.GA1022320@apples.localdomain>
In-Reply-To: <20191119195110.GA1022320@apples.localdomain>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Mon, 25 Nov 2019 12:44:11 +0000
Message-ID: <CADSWDzsAf9cF1tpyvaqb_ZU7RW1mXVv3MN+QFZ5VJj6t2C+ChA@mail.gmail.com>
Subject: Re: [PATCH v2 09/20] nvme: add support for the asynchronous event
 request command
To: Klaus Birkelund <its@irrelevant.dk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paul Durrant <Paul.Durrant@citrix.com>,
 Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 Nov 2019 at 19:51, Klaus Birkelund <its@irrelevant.dk> wrote:
>
> On Tue, Nov 12, 2019 at 03:04:59PM +0000, Beata Michalska wrote:
> > Hi Klaus,
> >
> > On Tue, 15 Oct 2019 at 11:49, Klaus Jensen <its@irrelevant.dk> wrote:
> > > @@ -1188,6 +1326,9 @@ static int nvme_start_ctrl(NvmeCtrl *n)
> > >
> > >      nvme_set_timestamp(n, 0ULL);
> > >
> > > +    n->aer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_process_aers, n);
> > > +    QTAILQ_INIT(&n->aer_queue);
> > > +
> >
> > Is the timer really needed here ? The CEQ can be posted either when requested
> > by host through AER, if there are any pending events, or once the
> > event is triggered
> > and there are active AER's.
> >
>
> I guess you are right. I mostly cribbed this from Keith's tree, but I
> see no reason to keep the timer.
>
> Keith, do you have any comments on this?
>
> > > @@ -1380,6 +1521,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
> > >                             "completion queue doorbell write"
> > >                             " for nonexistent queue,"
> > >                             " sqid=%"PRIu32", ignoring", qid);
> > > +
> > > +            if (n->outstanding_aers) {
> > > +                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
> > > +                    NVME_AER_INFO_ERR_INVALID_DB_REGISTER,
> > > +                    NVME_LOG_ERROR_INFO);
> > > +            }
> > > +
> > This one (as well as cases below) might not be entirely right
> > according to the spec. If given event is enabled for asynchronous
> > reporting the controller should retain that even. In this case, the event
> > will be ignored as there is no pending request.
> >
>
> I understand these notifications to be special cases (i.e. they cannot
> be enabled/disabled through the Asynchronous Event Configuration
> feature). See Section 4.1 of NVM Express 1.2.1. The spec specifically
> says that "... and an Asynchronous Event Request command is outstanding,
> ...).
>

 OK, I have missed that one.
Thanks for the reference.

BR
Beata
> > > @@ -1591,6 +1759,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
> > >      id->ver = cpu_to_le32(0x00010201);
> > >      id->oacs = cpu_to_le16(0);
> > >      id->acl = 3;
> > > +    id->aerl = n->params.aerl;
> >
> > What about the configuration for the asynchronous events ?
> >
>
> It will default to an AEC vector of 0 (everything disabled).
>
>
> K

