Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178FCC282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 06:16:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4AD620880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 06:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPLCS2LI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AD620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48083 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDNaO-0007PM-So
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 02:16:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hDNZT-00074j-Hb
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 02:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hDNZR-0000Gj-GW
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 02:15:55 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
	id 1hDNZN-0000EY-Hd
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 02:15:51 -0400
Received: by mail-ot1-x344.google.com with SMTP id m10so10954081otp.2
	for <qemu-devel@nongnu.org>; Sun, 07 Apr 2019 23:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=/FjdsiQusyyKzzcbPXhDOtJ7hWuVRpouEhvBLFTgAg0=;
	b=DPLCS2LINdUPJJanD0APwPArXlb4ECuOhLh9uP+PAdkElJtiVm6NZnjiQthguCJrC2
	OIFTK9qNDFE+PuTf/4S3UCL3wIFNSXUxeVe72aYmi4kWFkOvi9RVQxcBnhzt4F5VbJ3W
	1iU8z8xRaUcsW9tNYraheyCwJhkWMeApzzjCm7v6xrnzNvHcjOjex3pP9wo08xbR444U
	/W053CGmSlCGqPZQwgxfYz913Adca01cZx5liUSMz1Axr5T4DkEbScrthFvE14GzggYX
	fY0zqMg18sSiTDQG9vadJzoaiCWFqBOm9o3jgKoRV0gcz3rEe4q+QUskUMUDGGOFIWxI
	sd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=/FjdsiQusyyKzzcbPXhDOtJ7hWuVRpouEhvBLFTgAg0=;
	b=LRs9yflIioy+k2D7xPzUkPamz3gN0zjI9Cj4bL+odhFV7PerPMVfAQe0OPLcempjSO
	noSf1LYkXMrtS3Hqk2FqLAvtidbHZUkli8eoyjMZJ5ee71lowEzAKpv1p5qcvJb9XSVC
	9n6f3JjZTi4fIOj0Xq57yGuinG60XK8Uptg7dpyOGi72ck2w3/59Uxuns/ESZYFdEeKJ
	I1sFE2nvOMnBCwRHhNt5CFc7hzT1CURtTZMnITg86lmkhbd+YrWpkhYJzYKF/8sT2Qjt
	1yURnUMcukMlQQyT2bn5H2VmQHEOdmXoNGg8KPq91ByiECOAOYeeoFxRcGs5r69KF8NX
	YS5w==
X-Gm-Message-State: APjAAAVBOZXD55pqQJDiazBTeYGbHVVO6Vhyb+SKpjCgL2Oilxy7/zWj
	Y62ILsI5Y87KBU8BpFAArUYbCJjjk6ZXddL8x9g=
X-Google-Smtp-Source: APXvYqx+BXEJIlV2Z0D6UG0QNGMrt7Sv5uNlaeLCdcugdeoaszkNCp9NUDJPRqox6BBerPHxpywGlKmWpSkMzlCUs3E=
X-Received: by 2002:a05:6830:51:: with SMTP id
	d17mr17377865otp.178.1554704147330; 
	Sun, 07 Apr 2019 23:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <1554689945-18619-1-git-send-email-catherine.hecx@gmail.com>
	<20190408032543.GE23212@xz-x1>
In-Reply-To: <20190408032543.GE23212@xz-x1>
From: Catherine Ho <catherine.hecx@gmail.com>
Date: Mon, 8 Apr 2019 14:15:36 +0800
Message-ID:
 <CAEn6zmE3tjtZrusqZptkgqi2CFaNndsVHekr9=uxS=YptcbQzQ@mail.gmail.com>
To: Peter Xu <peterx@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] hostmem-file: warn when
 memory-backend-file, share=on and in incoming migration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408061536.oRIHtXoHwP_yHgQ5ATsUUiH9ht1Bq_2kEHaBdOn3m_s@z>

Hi Peter Xu

On Mon, 8 Apr 2019 at 11:25, Peter Xu <peterx@redhat.com> wrote:

> On Sun, Apr 07, 2019 at 10:19:05PM -0400, Catherine Ho wrote:
> > Currently it is not forbidden to use "-object
> memory-backend-file,share=on"
> > and together with "-incoming". But after incoming migration is finished,
> > the memory-backend-file will be definitely written if share=on. So the
> > memory-backend-file can only be used once, but failed in the 2nd time
> > incoming.
> >
> > Thus it gives a warning and the users can run the qemu if they really
> > want to do it.
> >
> > Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
> > ---
> >  backends/hostmem-file.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> > index 37ac6445d2..59429ee0b4 100644
> > --- a/backends/hostmem-file.c
> > +++ b/backends/hostmem-file.c
> > @@ -16,6 +16,7 @@
> >  #include "sysemu/hostmem.h"
> >  #include "sysemu/sysemu.h"
> >  #include "qom/object_interfaces.h"
> > +#include "migration/migration.h"
> >
> >  /* hostmem-file.c */
> >  /**
> > @@ -79,6 +80,16 @@ file_backend_memory_alloc(HostMemoryBackend *backend,
> Error **errp)
> >          }
> >      }
> >
> > +    /*
> > +     * In ignore shared case, if share=on for host memory backend file,
> > +     * the ram might be written after incoming process is finished. Thus
> > +     * the memory backend can't be reused for 2nd/3rd... incoming
> > +     */
> > +    if (backend->share && migrate_ignore_shared()
> > +                       && runstate_check(RUN_STATE_INMIGRATE))
> > +        warn_report("share=on for memory backend file might be "
> > +                        "conflicted with incoming in ignore shared
> case");
>
> I feel like this message wasn't really clear to me...  you want to
> warn people these data might not match with each other, right?  How
> about simply state it:
>
>   NOTE: Please make sure the data on the shared memory backend file
>   and the data from the incoming migration stream contains matching
>   contents, otherwise...
>

Sorry for my vague expression.
The background is [1]
I happened to use "-object memory-backend-file,share=on" and together with
"-incoming".
It worked fine in 1st incoming migration but failed in 2nd, 3rd incoming
migration.
Because qemu uses qemu_ram_mmap(..., MAP_SHARED,...) when share=on, the
memory-backend-file will be written after 1st incoming migration.
Finally I realized that this was caused by "share=on" flag, and after I
removed it,
the memory-backend-file will not be changed any more.

So do you think it will be better that qemu gives the user a clear warning
that
incoming migration will change the data in  memory-backend-file  with
"share=on" ?

[1] http://lists.nongnu.org/archive/html/qemu-devel/2019-04/msg00350.html


> Regards,
>
> --
> Peter Xu
>
