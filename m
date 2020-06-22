Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A2AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 22:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B222073E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 22:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Veq88ijf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B222073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnV5F-00060j-8r
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 18:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jnV4V-0005Ba-LF
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 18:37:47 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:40527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jnV4T-000528-OS
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 18:37:47 -0400
Received: by mail-io1-xd41.google.com with SMTP id q8so21465482iow.7
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 15:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZUc6PzHoklkAYjHt4GLbLcCSLWqB51SmmJc8uMdR910=;
 b=Veq88ijfb6Lk+hPPmn5WSJyJWplVZ9A55d0//YPBxGfxB+piNco2PDEmXHGx01AX+c
 iFagrH+qzUCp1kcQqvI31WVDj/XIy9vZRhEIGy6l3rGI8QJmjxwQ+GvnSkrlUSuLKn0X
 Y+kHQXQGhmz/Lt/X1mfi4JZy0kxxBOlsZm08qQcYxxBkDWL+qrRQJMns8HiKZV5XHuao
 kXaTBcc2PnfoSsSrVyewKCppbPH6t3ZnIk+1d3rRjaAD+Wr2jQ+3xaIXfwVx1p3Esoge
 vUQILMilarBqkjeJHtq+N7VU/VJwmdvYj9N6x8BwMPTgFbRUdIx/BAM2tE8NYeQt+RJG
 2DFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZUc6PzHoklkAYjHt4GLbLcCSLWqB51SmmJc8uMdR910=;
 b=jTGPoBx6gOtl//5e1pWL7CBHRHHLtNy49zTBLl5scl4t14a74GIJKT95eIH6bQxfWs
 TFSWbkAkShLjxjWOGYRiN4z7QD5W6+gobSnPM2go2LytPe5wBPxn9AZ4+bM8TCegGF4R
 GUNNiHpib/NjH9gbn8Y0Ug025hPMboES7R41dd2M44XHOmwcx+S08T3M/feT8nwMVbZR
 PT6U/4hUsL7EK/dKT4NlplokkNzL+3CrNVlND/4V+yL+bWClxlLEp8gdrCLZ8DsaNk6a
 ppAJdjMEyRHRngSw/y+8gLxam8QB8qhAjtvk4OPTgxAQklLhafzOxbJwJMsPsmKFmB6m
 WUCQ==
X-Gm-Message-State: AOAM533mHWSdrKTQheK6Q0yGnQnUhvWIsp3S6MGX7S+cH/iMEQjvpUsi
 6JOPNGwvVtYwjYyASrFMuX+0cO1rhg5+xWOhO04=
X-Google-Smtp-Source: ABdhPJzT5t2pC3lddUxk7uEUYs20C9nV9SvbCBASt14DMh+Pt8Sx5+8xt4tD0/IEZYfWT/O4CKed0+X8T7xj44lfBrQ=
X-Received: by 2002:a05:6638:cc7:: with SMTP id
 e7mr18302308jak.87.1592865463988; 
 Mon, 22 Jun 2020 15:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200619214912.25598.8400.stgit@localhost.localdomain>
 <20200619215309.25598.7553.stgit@localhost.localdomain>
 <acac152a-8be5-aa5c-ca52-e5ffc90b6ed4@redhat.com>
In-Reply-To: <acac152a-8be5-aa5c-ca52-e5ffc90b6ed4@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 22 Jun 2020 15:37:33 -0700
Message-ID: <CAKgT0UcP6gGK_X80pepwpsC=JFmL9+n61ow-HEJMKbFVZ4Jh8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio-balloon: Prevent guest from starting a report
 when we didn't request one
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alexander.duyck@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 1:10 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 19.06.20 23:53, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > Based on code review it appears possible for the driver to force the device
> > out of a stopped state when hinting by repeating the last ID it was
> > provided.
>
> Indeed, thanks for noticing.
>
> >
> > Prevent this by only allowing a transition to the start state when we are
> > in the requested state. This way the driver is only allowed to send one
> > descriptor that will transition the device into the start state. All others
> > will leave it in the stop state once it has finished.
> >
> > In addition add the necessary locking to provent any potential races
>
> s/provent/prevent/

Thanks for catching that. I will fix the typo.

> > between the accesses of the cmd_id and the status.
> >
> > Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  hw/virtio/virtio-balloon.c |   11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index 10507b2a430a..7f3af266f674 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> > @@ -527,7 +527,8 @@ static bool get_free_page_hints(VirtIOBalloon *dev)
> >              ret = false;
> >              goto out;
> >          }
> > -        if (id == dev->free_page_report_cmd_id) {
> > +        if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED &&
> > +            id == dev->free_page_report_cmd_id) {
> >              dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
> >          } else {
> >              /*
>
> But doesn't that mean that, after the first hint, all further ones will
> be discarded and we'll enter the STOP state in the else case? Or am I
> missing something?
>
> Shouldn't this be something like
>
> if (id == dev->free_page_report_cmd_id) {
>     if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED) {
>         dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
>     }
>     /* Stay in FREE_PAGE_REPORT_S_START as long as the cmd_id match .*/
> } else { ...

There should only be one element containing an outbuf at the start of
the report. Once that is processed we should not see the driver
sending additional outbufs unless it is sending the STOP command ID.

> > @@ -592,14 +593,16 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
> >          return;
> >      }
> >
> > -    if (s->free_page_report_cmd_id == UINT_MAX) {
> > +    qemu_mutex_lock(&s->free_page_lock);
> > +
> > +    if (s->free_page_report_cmd_id++ == UINT_MAX) {
> >          s->free_page_report_cmd_id =
> >                         VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
> > -    } else {
> > -        s->free_page_report_cmd_id++;
> >      }
>
> Somewhat unrelated cleanup.

Agreed. I can drop it if preferred. I just took care of it because I
was adding the lock above and below to prevent us from getting into
any wierd states where the command ID might be updated but the report
status was not.

> >
> >      s->free_page_report_status = FREE_PAGE_REPORT_S_REQUESTED;
> > +    qemu_mutex_unlock(&s->free_page_lock);
> > +
> >      virtio_notify_config(vdev);
> >  }
> >
> >
>
>
> --
> Thanks,
>
> David / dhildenb
>

