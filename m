Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9598EC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 13:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D2FE222BD
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 13:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3zwzbmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2FE222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUsqc-0004t2-Et
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 08:38:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jandryuk@gmail.com>) id 1iUspm-0004QI-6t
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 08:37:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jandryuk@gmail.com>) id 1iUspk-0001L7-OP
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 08:37:22 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:41840)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1iUspk-0001KT-Gn
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 08:37:20 -0500
Received: by mail-lf1-x143.google.com with SMTP id j14so1970632lfb.8
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 05:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TLDZjbsPgN/xppR+flaQKJvQCV1Yht1tzIlscYLxuSY=;
 b=u3zwzbmLoLvVYEweXdo8JwcVKr2BtIexuID/9Qz7SC+xfPg1CmZX+lf8gItKD5ePXY
 F0TZhWVVVmPTifE71n2qe5GMbqmAQuGZLIVXTQ5jZpPB+7+k2zjAy4msANljyRdTEJKr
 naf7NPEvt+Juo1Fkkv8sL00m5Z7HJKfFg+TxHf0dnltqedunsKjJVIVwiZgNeu/1IRtn
 5/fGtmzjsm3g4cZuOxnKq1oB/No7u8WOGS9pwZjX7ssvn5t/Rib+7pwOO+44LchKXMpe
 g1TJJaGJqXFmTKBmT99lEE9VeMIAxL/DoPjFdJAEGcb8zRlTrTYPzLgIaLC7rkibkclh
 +Bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TLDZjbsPgN/xppR+flaQKJvQCV1Yht1tzIlscYLxuSY=;
 b=VEk+pg1+5paXWntxExihcFQCdtlMjWi5hB/aCwIA73hUcazNecUDTBFRQWvTlxZhuQ
 GYkjRZMLSxpTy+tjQR5OFNRLBOpU9cWvUMAVyoBn7am8CHwg//DlCJ6ROg81NnkLqmYn
 vGyDgSPO58/mqsnC2jNGk2uATssn6hyDs4t3sz3G2gF8cAHu23Yoq8zd7tdbZzWxy9GY
 jK8be23a4ubkobaG0gjRy/KSqyeLw9L9JGfCSVxCV5yAQaUlZj5rkdg5+wc6XzVgPgXT
 XniJtBYhmQOrYZAFKUhIT52LRNmMqroYkzYINCa6WWh9CQZ2BFQ1S5oXO3Y4JyNg3/Da
 X7IQ==
X-Gm-Message-State: APjAAAX82k2sWn+ONy1Pt8BDYmDzs/q4yfe+j52PnQkM601YhI035PDz
 qW1kwRjlMOarbOnNXnfHBrEL1Tx3LFXEQSGGw/E=
X-Google-Smtp-Source: APXvYqw597x5h0A76zz10vGWFTu6RhffwU8slVE2Z51B3Z3p+vh52PLvSOdeQOwe04rybisTBA4Mp3sjMfGpyFJN4d0=
X-Received: by 2002:a19:6503:: with SMTP id z3mr2721875lfb.192.1573652238476; 
 Wed, 13 Nov 2019 05:37:18 -0800 (PST)
MIME-Version: 1.0
References: <20191106130309.6737-1-jandryuk@gmail.com>
 <878sok2ble.fsf@dusky.pond.sub.org>
 <CAJ+F1C+cnvqg7P93Fhxn7xreivQFW9eOYDbPa9j83mz7ZR_Wvg@mail.gmail.com>
In-Reply-To: <CAJ+F1C+cnvqg7P93Fhxn7xreivQFW9eOYDbPa9j83mz7ZR_Wvg@mail.gmail.com>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Wed, 13 Nov 2019 08:37:07 -0500
Message-ID: <CAKf6xpsK+OU_rud9peWfatS4j5xLpxEVbEfozuwmW=Gz7b6A_w@mail.gmail.com>
Subject: Re: [PATCH] qmp: Reset mon->commands on CHR_EVENT_CLOSED
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
Cc: Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 13, 2019 at 8:18 AM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Wed, Nov 13, 2019 at 4:41 PM Markus Armbruster <armbru@redhat.com> wro=
te:
> >
> > Jason Andryuk <jandryuk@gmail.com> writes:
> >
> > > Currently, mon->commands is uninitialized until CHR_EVENT_OPENED wher=
e
> > > it is set to &qmp_cap_negotiation_commands.  After capability
> > > negotiation, it is set to &qmp_commands.  If the chardev is closed,
> > > CHR_EVENT_CLOSED, mon->commands remains as &qmp_commands.  Only once =
the
> > > chardev is re-opened with CHR_EVENT_OPENED, is it reset to
> > > &qmp_cap_negotiation_commands.
> > >
> > > monitor_qapi_event_emit compares mon->commands to
> > > &qmp_cap_negotiation_commands, and skips sending events when they are
> > > equal.
> >
> > The check's purpose is to ensure we don't send events in capabilities
> > negotiation mode, i.e. between connect and a successful qmp_capabilitie=
s
> > command.
> >
> > >         In the case of a closed chardev, QMP events are still sent do=
wn
> > > to the closed chardev which needs to drop them.
> >
> > True, but I wonder how this can happen.  Can you explain?

I was working on QMP over Xen's argo inter-vm communication for the
OpenXT project.  We had a lock up because we weren't properly dropping
QMP events in the chardev, even though we called CHR_EVENT_CLOSED.  We
fixed the argo chardev to drop messages like other chardevs, but my
investigation found QMP was still sending events even through it was
closed.

Xen's libxl opens a UNIX domain QMP socket for the duration of issuing
a command and then closes it.  OpenXT does the same over Argo.  In the
case of connecting and disconnecting, QMP events continue to be
generated after the first connection, even though there is nothing
connected for an unbounded length of time.  I was just trying to
optimize that scenario by skipping QMP events when disconnected.

> > > Set mon->commands to &qmp_cap_negotiation_commands for CHR_EVENT_CLOS=
ED
> > > to stop sending events.  Setting for the CHR_EVENT_OPENED case remain=
s
> > > since that is how mon->commands is set for a newly opened connections=
.
> > >
> > > Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> > > ---
> > >  monitor/qmp.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/monitor/qmp.c b/monitor/qmp.c
> > > index 9d9e5d8b27..5e2073c5eb 100644
> > > --- a/monitor/qmp.c
> > > +++ b/monitor/qmp.c
> > > @@ -333,6 +333,7 @@ static void monitor_qmp_event(void *opaque, int e=
vent)
> >        case CHR_EVENT_CLOSED:
> >            /*
> >             * Note: this is only useful when the output of the chardev
> >             * backend is still open.  For example, when the backend is
> >             * stdio, it's possible that stdout is still open when stdin
> > >           * is closed.
> > >           */
> > >          monitor_qmp_cleanup_queues(mon);
> > > +        mon->commands =3D &qmp_cap_negotiation_commands;
> > >          json_message_parser_destroy(&mon->parser);
> > >          json_message_parser_init(&mon->parser, handle_qmp_command,
> > >                                   mon, NULL);
> >
> > Patchew reports this loses SHUTDOWN events.  Local testing confirms it
> > does.  Simplified reproducer:
> >
> >     $ for ((i=3D0; i<100; i++)); do printf '{"execute": "qmp_capabiliti=
es"}\n{"execute": "quit"}' | upstream-qemu -S -display none -qmp stdio; don=
e | grep -c SHUTDOWN
> >     84
> >
> > In this test, the SHUTDOWN event was lost 16 out of 100 times.
> >
> > Its emission obviously races with the assignment you add.
> >
> > The comment preceding it provides a clue: after CHR_EVENT_CLOSED, we
> > know the input direction is gone, and we duly clean up that part of the
> > monitor.  But the output direction may or may not be gone, so we don't
> > touch it.  Your assignment touches it.  This is not the correct spot.
> > I can't tell you offhand where the correct spot is.  Perhaps Marc-Andr=
=C3=A9
> > can.
>
> The same "closed" event is used to signal read-disconnected,
> write-disconnected and hup.
>
> To implement half-closed signaling, we would need more events/state
> (probably change the chardev API to use input and output streams).
> Tbh, I am not sure it's really worth at this point, unless we have a
> "visible" bug to fix.

Yes, I agree.

Thanks for your time looking at this.

Regards,
Jason

