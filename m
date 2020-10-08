Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AFFC4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 11:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58FE820B1F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 11:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRxXHwNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FE820B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQUS9-0000Uo-9d
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 07:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kQURR-0008Qp-Fp
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 07:50:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41423)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kQURN-0007zf-Bw
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 07:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602157831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MMFfFrmzQ0jxj+83olHwkGlUT9eJyGfxrIQV+dctoUI=;
 b=SRxXHwNnIMM9jk9Doz8d03H7JzZsbrOUkUjAoxXCE+FNE/DgSVcKHahB20b1iFr3k8R9fb
 Pcfc0NGFX1sED1eOqzTNM/JAtYs/1KwzzRus2HgjY+hXdl0pQLJpIoL1J+UudZUWKjw88t
 aI1LxsHthX8yneFunrM6/rDfr+CDRy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-B6raCMDINkSAF9UpdWhU_g-1; Thu, 08 Oct 2020 07:50:29 -0400
X-MC-Unique: B6raCMDINkSAF9UpdWhU_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2703C1091074;
 Thu,  8 Oct 2020 11:50:28 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-68.ams2.redhat.com [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E6027664D;
 Thu,  8 Oct 2020 11:50:20 +0000 (UTC)
Date: Thu, 8 Oct 2020 13:50:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: acceptance-system-fedora failures
Message-ID: <20201008115018.GD4672@linux.fritz.box>
References: <4e191372-c332-8f69-85e2-1ff6ead0f40d@redhat.com>
 <59d2a787-bcd4-7283-693b-09ea04c16dc6@redhat.com>
 <6068346f-b034-9321-0eea-29233c23a300@redhat.com>
 <78ce9ac1-d2a1-9dc0-bf38-f9ac34b2f203@ispras.ru>
 <14ee7cc6-42ca-fd86-241b-ed85e26693f7@redhat.com>
 <878sci1dt0.fsf@linaro.org>
 <d86c9425-dcb2-7fa7-1f6f-bd7b8dab53c1@ispras.ru>
 <c5e6f7ea-93c4-a46a-dfee-7699c08c1060@redhat.com>
 <4f4eee5e-e8cd-0595-cccc-8b648773c9ba@ispras.ru>
 <43eac2fb-7325-9e9f-ce13-d0774638753f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <43eac2fb-7325-9e9f-ce13-d0774638753f@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 08.10.2020 um 12:26 hat Philippe Mathieu-Daudé geschrieben:
> On 10/7/20 3:11 PM, Pavel Dovgalyuk wrote:
> > On 07.10.2020 15:49, Philippe Mathieu-Daudé wrote:
> >> On 10/7/20 2:20 PM, Pavel Dovgalyuk wrote:
> >>> On 07.10.2020 14:22, Alex Bennée wrote:
> >>>>
> >>>> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> >>>>
> >>>>> On 10/7/20 10:51 AM, Pavel Dovgalyuk wrote:
> >>>>>> On 07.10.2020 11:23, Thomas Huth wrote:
> >>>>>>> On 07/10/2020 09.13, Philippe Mathieu-Daudé wrote:
> >>>>>>> Thanks, that was helpful. ... and the winner is:
> >>>>>>>
> >>>>>>>        commit   55adb3c45620c31f29978f209e2a44a08d34e2da
> >>>>>>>        Author:  John Snow <jsnow@redhat.com>
> >>>>>>>        Date:    Fri Jul 24 01:23:00 2020 -0400
> >>>>>>>        Subject: ide: cancel pending callbacks on SRST
> >>>>>>>
> >>>>>>> ... starting with this commit, the tests starts failing. John, any
> >>>>>>> idea what
> >>>>>>> might be causing this?
> >>>>>>
> >>>>>> This patch includes the following lines:
> >>>>>>
> >>>>>> +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> >>>>>> +                                ide_bus_perform_srst, bus);
> >>>>>>
> >>>>>> replay_bh_schedule_oneshot_event should be used instead of this
> >>>>>> function, because it synchronizes non-deterministic BHs.
> >>>>>
> >>>>> Why do we have 2 different functions? BH are already complex
> >>>>> enough, and we need to also think about the replay API...
> >>>>>
> >>>>> What about the other cases such vhost-user (blk/net), virtio-blk?
> >>>>
> >>>> This does seem like something that should be wrapped up inside
> >>>> aio_bh_schedule_oneshot itself or maybe we need a
> >>>> aio_bh_schedule_transaction_oneshot to distinguish it from the other
> >>>> uses the function has.
> >>>>
> >>>
> >>> Maybe there should be two functions:
> >>> - one for the guest modification
> >>
> >> aio_bh_schedule_oneshot_deterministic()?
> >>
> >>> - one for internal qemu things
> >>
> >> Not sure why there is a difference, BH are used to
> >> avoid delaying the guest, so there always something
> >> related to "guest modification".
> > 
> > Not exactly. At least there is one non-related-to-guest case
> > in monitor_init_qmp:
> >         /*
> >          * We can't call qemu_chr_fe_set_handlers() directly here
> >          * since chardev might be running in the monitor I/O
> >          * thread.  Schedule a bottom half.
> >          */
> >         aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
> >                                 monitor_qmp_setup_handlers_bh, mon);
> 
> I don't understand the documentation in docs/devel/replay.txt:
> 
> ---
> Bottom halves
> =============
> 
> Bottom half callbacks, that affect the guest state, should be invoked
> through
> replay_bh_schedule_event or replay_bh_schedule_oneshot_event functions.
> Their invocations are saved in record mode and synchronized with the
> existing
> log in replay mode.
> ---
> 
> But then it is only used in block drivers, which are not
> related to guest state:

Pavel can tell you the details, but I think the idea was that you need
to use this function not when the code calling it modifies guest state,
but when the BH implementation can do so.

In the case of generic callbacks like provided by the blk_aio_*()
functions, we don't know whether this is the case, but it's generally
device emulation code, so chances are relatively high that they do.

I seem to remember that when reviewing the code that introduced
replay_bh_schedule_event(), I was relatively sure that we didn't catch
all necessary instances, but since it worked for Pavel and I didn't feel
like getting too involved with replay code, we just merged it anyway.

As I said, the details are a question for Pavel.

Kevin

> $ git grep replay_bh_schedule_oneshot_event
> block/block-backend.c:1385:
> replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
> block/block-backend.c:1450:
> replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
> block/io.c:371:
> replay_bh_schedule_oneshot_event(bdrv_get_aio_context(bs),
> block/iscsi.c:286:
> replay_bh_schedule_oneshot_event(iTask->iscsilun->aio_context,
> block/nfs.c:262:
> replay_bh_schedule_oneshot_event(task->client->aio_context,
> block/null.c:183:
> replay_bh_schedule_oneshot_event(bdrv_get_aio_context(bs),
> block/nvme.c:323:        replay_bh_schedule_oneshot_event(q->aio_context,
> block/nvme.c:1075:    replay_bh_schedule_oneshot_event(data->ctx,
> nvme_rw_cb_bh, data);
> block/rbd.c:865:
> replay_bh_schedule_oneshot_event(bdrv_get_aio_context(acb->common.bs),
> docs/devel/replay.txt:25:replay_bh_schedule_event or
> replay_bh_schedule_oneshot_event functions.
> include/sysemu/replay.h:178:void
> replay_bh_schedule_oneshot_event(AioContext *ctx,
> replay/replay-events.c:141:void
> replay_bh_schedule_oneshot_event(AioContext *ctx,
> stubs/replay-user.c:5:void replay_bh_schedule_oneshot_event(AioContext *ctx,
> 
> Is replay_bh_schedule_oneshot_event ever used by replay?
> Maybe we can remove it and use aio_bh_schedule_oneshot()
> in place?
> 
> Else the documentation need to be clarified please.
> 
> > 
> > 
> >>
> >>>
> >>> The first one may be implemented though the rr+second one.
> >>> Maybe replay_ prefix is confusing and the whole BH interface should look
> >>> like that?
> >>
> >> Yes, but it would be safer/clearer if we don't need to use
> >> a replay_ API.
> >>
> >> Can we embed these functions?
> >>
> >> - replay_bh_schedule_event
> >> - replay_bh_schedule_oneshot_event
> >>
> >> If compiled without rr, events_enabled=false and
> >> compiler can optimize:
> >>
> >> -- >8 --
> >> diff --git a/util/async.c b/util/async.c
> >> index f758354c6a..376b6d4e27 100644
> >> --- a/util/async.c
> >> +++ b/util/async.c
> >> @@ -109,14 +109,19 @@ static QEMUBH *aio_bh_dequeue(BHList *head,
> >> unsigned *flags)
> >>
> >>   void aio_bh_schedule_oneshot(AioContext *ctx, QEMUBHFunc *cb, void
> >> *opaque)
> >>   {
> >> -    QEMUBH *bh;
> >> -    bh = g_new(QEMUBH, 1);
> >> -    *bh = (QEMUBH){
> >> -        .ctx = ctx,
> >> -        .cb = cb,
> >> -        .opaque = opaque,
> >> -    };
> >> -    aio_bh_enqueue(bh, BH_SCHEDULED | BH_ONESHOT);
> >> +    if (events_enabled) {
> >> +        replay_add_event(REPLAY_ASYNC_EVENT_BH_ONESHOT, cb,
> >> +                         opaque, replay_get_current_icount());
> >> +    } else {
> >> +        QEMUBH *bh;
> >> +        bh = g_new(QEMUBH, 1);
> >> +        *bh = (QEMUBH){
> >> +            .ctx = ctx,
> >> +            .cb = cb,
> >> +            .opaque = opaque,
> >> +        };
> >> +        aio_bh_enqueue(bh, BH_SCHEDULED | BH_ONESHOT);
> >> +    }
> >>   }
> >>
> >>   QEMUBH *aio_bh_new(AioContext *ctx, QEMUBHFunc *cb, void *opaque)
> >> @@ -178,7 +183,12 @@ void qemu_bh_schedule_idle(QEMUBH *bh)
> >>
> >>   void qemu_bh_schedule(QEMUBH *bh)
> > 
> > qemu_bh_schedule is even worse.
> > Many modules use it (e.g., loadvm_postcopy_handle_run), and there is no
> > need to use replay version there. In such cases QEMU will halt if trying
> > to call replay_bh_schedule_event.
> > 
> >>   {
> >> -    aio_bh_enqueue(bh, BH_SCHEDULED);
> >> +    if (events_enabled) {
> >> +        replay_add_event(REPLAY_ASYNC_EVENT_BH, bh, NULL,
> >> +                         replay_get_current_icount());
> >> +    } else {
> >> +        aio_bh_enqueue(bh, BH_SCHEDULED);
> >> +    }
> >>   }
> >>
> > 
> 
> 


