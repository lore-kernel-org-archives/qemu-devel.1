Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF07C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 292BF20754
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUaRFXSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292BF20754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFGe4-0007pd-7A
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 08:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dnbrdsky@gmail.com>) id 1jFGdK-0007G2-9G
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dnbrdsky@gmail.com>) id 1jFGdJ-000622-0Y
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:20:14 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:55586)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dnbrdsky@gmail.com>)
 id 1jFGdF-0005u8-Fg; Fri, 20 Mar 2020 08:20:10 -0400
Received: by mail-pj1-x1042.google.com with SMTP id mj6so2388804pjb.5;
 Fri, 20 Mar 2020 05:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ebZnZeU9jgWhVKfqRtvZQMyb3oXy5xZTyHV3/+fAH84=;
 b=AUaRFXSvdMhizbe4oKX0GGYj1utSGZmZ9XR/TbtJEAd616ilzi0z6NpBaHV9cHzgQc
 MzMYUeCmwvYu7WjD4Do5oNqPO2veKGSCyyN+8nCpl8oDfSSI9Qq2DQEm5jmJC03373Vy
 ADmPzogAIpVjAQ6+a9p1m7fOt+Yv4lQzmJ0kGgQG+L57G4hxXd7JKiPswsn0aQYA7HrM
 UIqdKldNISTP6gtNuJNRQqca7EYIxjvsFN0tc7m5enmO3sl6U/6HnmK960enw3wlut0h
 h/GYxf6QDFCFisc7nyLynipQG/718Pd3pAg/nB65D61chpo9YJcml1MxkGxBMKC3SwDc
 FgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ebZnZeU9jgWhVKfqRtvZQMyb3oXy5xZTyHV3/+fAH84=;
 b=fH7w1gOrMygtdKAxCqwuaPue3GyfBaRMbfoGuSXIhW0zDozlOBLbynN+15U/FTt2CE
 GpocauRDVGMHFRs5ixLMfrzwBM5hS5hvWG0IJ0rDgBbN149ukuWuQSgUg2xorU+HgFYX
 Ga5VWX17h3bKw5MwzpNDY+jel1XA82yh0LRowQEu4G/3rN4UkXXaeuA4ji3G+07nNnMy
 +4ZsCEZS8GI1WK29qMNG/BwqC1L7J8J+9U6KfeTgUwueU+QcrBZcSm0qTfUDtU2Z4+Y8
 dOfdRqRxOjQCfrA0H6tSv1seLPqB9Vi0+FpY0tbcVLmy7/bRuCeF0WdgJiKQC5XasYDW
 qgSQ==
X-Gm-Message-State: ANhLgQ0+aSyUDR4hEqA0Ed+4Uic0N9eE6THhFXTnEN5G10iVFWH/VO/A
 5cjUgk0IL/O+9KLJoQbkk2Ej6ixH31EPbHwn5zs=
X-Google-Smtp-Source: ADFU+vvwsF7JDFg9Eubpof6A6YR7SJQoyLb4EAYBI/ktprh2ovp2oTUUDj+jEIlDKfS98IB7j5zdYaD6fKlH6BL4p2Y=
X-Received: by 2002:a17:90b:94a:: with SMTP id
 dw10mr9211632pjb.105.1584706808344; 
 Fri, 20 Mar 2020 05:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200319233454.1856568-1-dnbrdsky@gmail.com>
 <20200319233454.1856568-3-dnbrdsky@gmail.com>
 <7f5383d0-7bba-607e-93ae-f79e5c959d0e@redhat.com>
In-Reply-To: <7f5383d0-7bba-607e-93ae-f79e5c959d0e@redhat.com>
From: Daniel Brodsky <dnbrdsky@gmail.com>
Date: Fri, 20 Mar 2020 05:19:57 -0700
Message-ID: <CA+ZmoZWnntqawF89XyAV3mkVubPbeVh1FucyQoZxrETYRK0aeA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lockable: replaced locks with lock guard macros
 where appropriate
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:iSCSI" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 20, 2020 at 5:06 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 20/03/20 00:34, dnbrdsky@gmail.com wrote:
> > index 682abd8e09..89f8a656a4 100644
> > --- a/block/iscsi.c
> > +++ b/block/iscsi.c
> > @@ -1086,7 +1086,7 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
> >      acb->task->expxferlen = acb->ioh->dxfer_len;
> >
> >      data.size = 0;
> > -    qemu_mutex_lock(&iscsilun->mutex);
> > +    QEMU_LOCK_GUARD(&iscsilun->mutex);
> >      if (acb->task->xfer_dir == SCSI_XFER_WRITE) {
> >          if (acb->ioh->iovec_count == 0) {
> >              data.data = acb->ioh->dxferp;
> > @@ -1102,7 +1102,6 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
> >                                   iscsi_aio_ioctl_cb,
> >                                   (data.size > 0) ? &data : NULL,
> >                                   acb) != 0) {
> > -        qemu_mutex_unlock(&iscsilun->mutex);
> >          scsi_free_scsi_task(acb->task);
> >          qemu_aio_unref(acb);
> >          return NULL;
>
> Not exactly the same, should be okay but it also should be noted in the
> changelog.

Going to drop this change in the next version, I don't want this patch
to include cases
with possible side effects as I skipped other ones like this already.

> >  void cpu_list_remove(CPUState *cpu)
> >  {
> > -    qemu_mutex_lock(&qemu_cpu_list_lock);
> > +    QEMU_LOCK_GUARD(&qemu_cpu_list_lock);
> >      if (!QTAILQ_IN_USE(cpu, node)) {
> >          /* there is nothing to undo since cpu_exec_init() hasn't been called */
> >          qemu_mutex_unlock(&qemu_cpu_list_lock);
>
>
> Missed unlock.
>
> Otherwise looks good.
>
> Paolo
>
Thanks for the review, I'll fix the changes you pointed out in the next version.

Daniel

