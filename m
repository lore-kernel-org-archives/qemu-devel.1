Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EC2C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6AAA20838
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyE7Cqji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6AAA20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j95FA-0004TU-Tc
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1j95Dz-00032O-Jx
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:56:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1j95Dy-0006nB-50
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:56:31 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43909)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1j95Dx-0006n3-Ua
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:56:30 -0500
Received: by mail-wr1-x442.google.com with SMTP id h9so2774659wrr.10
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 02:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5SxTrWxDOJUKYSjsaw3blq6cbUO/ielJdeQnAH8903A=;
 b=hyE7CqjiZXJeHaeYPPEqELaT4+TVFSfH6kzz50TU7lSdhrmwHr+2nRDROdJPazAxDb
 go+R+uHtD218984TVHGSSIE2CjrbvQrJahcXuC5fdqnkQpKlhoOUlZZ65Y7zJ+y0FBF2
 5yEx/kHReeqgNjGllwG2m6pVteeLD69ZwQXRE1t5i7PCziCqLDHY765vywkJ+iKsGojj
 TJ3VotixRTCPzC9XbMFQ9gKfUB14qDFd6eNXkmrTnuV4MdF1nCSvhMmIzANhoZXmtRZh
 f01nth0D/qBFFLoDdNO5HUzTt0QN/rQCxPv/yilAqtPPb4VCb2WM3yinTd2OPKL3eleg
 qxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5SxTrWxDOJUKYSjsaw3blq6cbUO/ielJdeQnAH8903A=;
 b=Ap/tXJERYO2nRuDqt8mqGdTi7/7rCT3jm0rkwDw5jv2PVzeA5tOi0i0wTSstkLQ3DW
 4kBSzvaKBfdDSd+SjJuwkT3KmuIvl/oMTHtjC+5ElkKtzMlwWukATfSObQAL1QaGnjAx
 cbFgYmNzONG+7ora9k6faltNsdFS60VORmf45A7lbVKu0veAFMdCfbxYyxTltc5jWSJ0
 dVTt/2YOMCyBECwvRt2m/nPZs6XVizC/lRI8FvXRX4xIjRXmLV5RGueN7KCWg8LW3vXz
 diqx6voR9+D2bM+Z9HW3XeJW2En6imudN6hfP1rW7qJnX7D6TbpXAikoPij3XLh8CCqF
 e49Q==
X-Gm-Message-State: ANhLgQ2FfkAYu7NrOFVzbdqBLIfn6EZIxPktgPTFKNGirfIaKnVTToGF
 RiGEuY6DPnKXQFfX6JKMs4SRLARx5gtj5AM8JjC8e2BG
X-Google-Smtp-Source: ADFU+vvIea2XNaCR9Lpi3eJn5cM4VXfR1WOUHt5A2GCEzrxLhVyaaNMLms+OPXq37zcW17MxYikOPjzECcaJNg/cpr8=
X-Received: by 2002:adf:cc85:: with SMTP id p5mr4854472wrj.196.1583232988670; 
 Tue, 03 Mar 2020 02:56:28 -0800 (PST)
MIME-Version: 1.0
References: <20200113144848.2168018-1-marcandre.lureau@redhat.com>
 <87a75dn1gd.fsf@dusky.pond.sub.org>
 <CAJ+F1C+M3yPreBLOHXkt16b5aghesT7qYkEPbS_3Dm7vGTaMKA@mail.gmail.com>
 <87blptckoi.fsf@dusky.pond.sub.org> <20200221100700.GA5254@linux.fritz.box>
 <87pne751g9.fsf@dusky.pond.sub.org>
 <CAJ+F1CKbZiVk0DCQxMojxu8FyEskg5Cw32B08Vi9emaEMw79fQ@mail.gmail.com>
 <87imjm96qy.fsf@dusky.pond.sub.org> <20200302153626.GD4965@linux.fritz.box>
 <875zflevh1.fsf@dusky.pond.sub.org>
In-Reply-To: <875zflevh1.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 3 Mar 2020 11:56:15 +0100
Message-ID: <CAJ+F1CKpJ6dyX2bNvqFmigcG4eePdTg3_Y4UEQ7_PKSV3Naxbg@mail.gmail.com>
Subject: Re: [PATCH] console: make QMP screendump use coroutine
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, David Alan Gilbert <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Mar 3, 2020 at 8:41 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> Kevin Wolf <kwolf@redhat.com> writes:
>
> > Am 02.03.2020 um 15:22 hat Markus Armbruster geschrieben:
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
> >>
> >> > Hi
> >> >
> >> > On Fri, Feb 21, 2020 at 5:50 PM Markus Armbruster <armbru@redhat.com=
> wrote:
> >> >>
> >> >> Kevin Wolf <kwolf@redhat.com> writes:
> >> >>
> >> >> > Am 20.02.2020 um 17:01 hat Markus Armbruster geschrieben:
> >> >> >> >> >  void qmp_screendump(const char *filename, bool has_device,=
 const char *device,
> >> >> >> >> >                      bool has_head, int64_t head, Error **e=
rrp)
> >> >> >> >> >  {
> >> >> >> >> >      QemuConsole *con;
> >> >> >> >> >      DisplaySurface *surface;
> >> >> >> >> > +    g_autoptr(pixman_image_t) image =3D NULL;
> >> >> >> >> >      int fd;
> >> >> >> >> >
> >> >> >> >> >      if (has_device) {
> >> >> >> >> > @@ -365,7 +375,15 @@ void qmp_screendump(const char *filena=
me, bool has_device, const char *device,
> >> >> >> >> >          }
> >> >> >> >> >      }
> >> >> >> >> >
> >> >> >> >> > -    graphic_hw_update(con);
> >> >> >> >> > +    if (qemu_in_coroutine()) {
> >> >> >> >> > +        assert(!con->screendump_co);
> >> >> >> >> > +        con->screendump_co =3D qemu_coroutine_self();
> >> >> >> >> > +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> >> >> >> >> > +                                graphic_hw_update_bh, con)=
;
> >> >> >> >> > +        qemu_coroutine_yield();
> >> >> >> >> > +        con->screendump_co =3D NULL;
> >> >> >> >> > +    }
> >> >> >> >>
> >> >> >> >> What if multiple QMP monitors simultaneously screendump?  Hmm=
, it works
> >> >> >> >> because all execute one after another in the same coroutine
> >> >> >> >> qmp_dispatcher_co.  Implicit mutual exclusion.
> >> >> >> >>
> >> >> >> >> Executing them one after another is bad, because it lets an i=
ll-behaved
> >> >> >> >> QMP command starve *all* QMP monitors.  We do it only out of
> >> >> >> >> (reasonable!) fear of implicit mutual exclusion requirements =
like the
> >> >> >> >> one you add.
> >> >> >> >>
> >> >> >> >> Let's not add more if we can help it.
> >> >> >> >
> >> >> >> > The situation is not worse than the current blocking handling.
> >> >> >>
> >> >> >> Really?
> >> >> >>
> >> >> >> What makes executing multiple qmp_screendump() concurrently (in =
separate
> >> >> >> threads) or interleaved (in separate coroutines in the same thre=
ad)
> >> >> >> unsafe before this patch?
> >> >> >
> >> >> > QMP command handlers are guaranteed to run in the main thread wit=
h the
> >> >> > BQL held, so there is no concurrency. If you want to change this,=
 you
> >> >> > would have much more complicated problems to solve than in this h=
andler.
> >> >> > I'm not sure it's fair to require thread-safety from one handler =
when
> >> >> > no other handler is thread safe (except accidentally) and nobody =
seems
> >> >> > to plan actually calling them from multiple threads.
> >> >>
> >> >> "Let's not [...] if we can help it." is hardly a "change this or el=
se no
> >> >> merge" demand.  It is a challenge to find a more elegant solution.
> >> >>
> >> >> >> >> Your screendump_co is per QemuConsole instead of per QMP moni=
tor only
> >> >> >> >> because you need to find the coroutine in graphic_hw_update_d=
one().  Can
> >> >> >> >> we somehow pass it via function arguments?
> >> >> >> >
> >> >> >> > I think it could be done later, so I suggest a TODO.
> >> >> >>
> >> >> >> We should avoid making our dependence on implicit mutual exclusi=
on
> >> >> >> worse.  When we do it anyway, a big, fat, ugly comment is defini=
tely
> >> >> >> called for.
> >> >> >
> >> >> > Anyway, what I really wanted to add:
> >> >> >
> >> >> > This should be easy to solve by having a CoQueue instead of a sin=
gle
> >> >>
> >> >> Ah, challenge accepted!  Exactly the outcome I was hoping for :)
> >> >>
> >> >> > Coroutine pointer. The coroutine would just call qemu_co_queue_wa=
it(),
> >> >> > which adds itself to the queue before it yields and the update
> >> >> > completion would wake up all coroutines that are currently queued=
 with
> >> >> > qemu_co_queue_restart_all().
> >> >> >
> >> >> > qemu_co_queue_wait() takes a lock as its second parameter. You do=
n't
> >> >> > need it in this context and can just pass NULL. (This is a lock t=
hat
> >> >> > would be dropped while the coroutine is sleeping and automaticall=
y
> >> >> > reacquired afterwards.)
> >> >> >
> >> >> >> >> In case avoiding the mutual exclusion is impractical: please =
explain it
> >> >> >> >> in a comment to make it somewhat less implicit.
> >> >> >>
> >> >> >> It is anything but: see appended patch.
> >> >> >
> >> >> > This works, too, but it requires an additional struct. I think th=
e queue
> >> >> > is easier. (Note there is a difference in the mechanism: Your pat=
ch
> >> >> > waits for the specific update it triggered, while the CoQueue wou=
ld wait
> >> >> > for _any_ update to complete. I assume effectively the result is =
the
> >> >> > same.)
> >> >>
> >> >> Your idea sounds much nicer to me.  Thanks!
> >> >
> >> > Similar to the NULL check you asked to remove,
> >> > having a CoQueue there would lead to think that several concurrently
> >> > running screendump are possible.
> >> >
> >> > Is this a direction we are willing to take?
> >>
> >> Let's take a step back.
> >>
> >> The actual problem is to find the coroutine in graphic_hw_update_done(=
),
> >> so you can wake it.
> >>
> >> Your solution stores the coroutine in the QemuConsole, because that's
> >> readily available in graphic_hw_update_done().
> >>
> >> However, it really, really doesn't belong there, it belongs to the
> >> monitor.  Works anyway only because QMP commands execute one after the
> >> other.
> >>
> >> Kevin suggested using a CoQueue to avoid this unspoken dependency.  Yo=
u
> >> object, because it could make readers assume multiple screendump
> >> commands could run concurrently, which is not the case.
> >>
> >> Alright, let's KISS: since there's just one main loop, there's just on=
e
> >> coroutine: @qmp_dispatcher_co.  Let's use that, so the dependency on
> >> "one command after the other" is explicit and obvious.
> >
> > Ugh... If you choose that this is the way to go, please add an assertio=
n
> > at least that we are indeed in qmp_dispatcher_co before yielding.
>
> No objection.
>
> To apply the QMP coroutine infrastructure for 5.0, I need a user.  We
> have two: block_resize from Kevin, and screendump from Marc-Andr=C3=A9.
> Neither is quite ready, yet.  I'll wait for a respin of either one.
>

Kevin series has conflicts, I will wait for his respin.

--=20
Marc-Andr=C3=A9 Lureau

