Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281B3C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 22:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43932076E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 22:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE+JXKPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43932076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF3PJ-0005qb-R0
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 18:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dnbrdsky@gmail.com>) id 1jF3OS-0005Ly-M1
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 18:12:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dnbrdsky@gmail.com>) id 1jF3OR-0001z3-72
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 18:12:00 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:35154)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dnbrdsky@gmail.com>)
 id 1jF3ON-0001uo-KQ; Thu, 19 Mar 2020 18:11:55 -0400
Received: by mail-io1-xd42.google.com with SMTP id h8so4052855iob.2;
 Thu, 19 Mar 2020 15:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/tfjzR/CaG2cZcoGhB+I2RN3BpOoglQ/9/LJ3SWYEm4=;
 b=JE+JXKPPZqJ4fB5EUlJYeCY5UV4i9eiBSxzelCcaPHkkBODG/WCBzOV0ckpNNXRJci
 L8HKDVc0k3VB3tcSG510S+EB8ILVLieMfyEk8JgRa20GwZSFrXdbKtmGdS0AEj/7JPJi
 6NTLxt/wuUn8r4/TmuT1YHqKFfr3Z6sHSnR8xJXZCLTJY/Yx+5JGi1mYZ03C+LXSKq9Z
 M8TEB0ledchtE2sda8y7SWArvQxSEp89Slf4xmLdeXKhg+ucgQ/zhwxR5foa8oomvQWP
 FJEHxI39e6yujWXSKaAN4t7tpICvODNZIN0gKDjVUJFK85YZh9Emr+s9D1aACAWREZL3
 oEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/tfjzR/CaG2cZcoGhB+I2RN3BpOoglQ/9/LJ3SWYEm4=;
 b=MC5HN6wMgKMfBgmegry9QHdDiID2A6bp5q8fYmqayMq//gwFSAyVeSnsWQLigVwiqk
 ZchfliVooo6T2nP4J/0PZHFCV/V9/IEz60VzN3DvGLvifEEbcvYxcZD8kfLUhq8N+/AX
 nP5461FLzgd+RiVRRf6edoK/lPgOcRSz3mzP67PaXQFOYBiSe1P8XCIETJbC9I/vuJpF
 TF9VSxWEqXxcyT3FQJmg0UxsLTMW0fsn615kldPfMLz0QmIp7Ov65Vaap22/L2knY8Cm
 IBFGvV1G9uhGnD+1CJcGnoGasxzSaIkS40aCVVd/oPMPXpkXb8GJl98kRwldO52DJ7dN
 57DQ==
X-Gm-Message-State: ANhLgQ22DEkeBGCnsSj8ezubJV71cYXZ1mdGbA/DicVTAdAZUrsglsm0
 fOkvkuEPlnOgTA8e3mJ13ph5KmCr0P8lqJhGbCo=
X-Google-Smtp-Source: ADFU+vu8B3Lwxs990EVJ53LMBmhJ5bLypNSRZr39hIr7rnFR3w1uTAWGuKCtwbuQXJcQnE3V6NEh0ukURMlSRCPVnP4=
X-Received: by 2002:a6b:3a87:: with SMTP id h129mr4656585ioa.135.1584655914726; 
 Thu, 19 Mar 2020 15:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200319161925.1818377-1-dnbrdsky@gmail.com>
 <20200319161925.1818377-2-dnbrdsky@gmail.com>
 <8a44d121-81fe-fb52-29db-edb0ad4d48be@redhat.com>
In-Reply-To: <8a44d121-81fe-fb52-29db-edb0ad4d48be@redhat.com>
From: Daniel Brodsky <dnbrdsky@gmail.com>
Date: Thu, 19 Mar 2020 15:11:44 -0700
Message-ID: <CA+ZmoZXoTD91mzMqOJf6W0ocPOFSNL=AK1yYybfPxiHC9gWuAA@mail.gmail.com>
Subject: Re: [PATCH] lockable: replaced locks with lock guard macros where
 appropriate
To: Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e37a8805a13c7433"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
 Juan Quintela <quintela@redhat.com>, stefanha@gmail.com,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e37a8805a13c7433
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 19, 2020 at 1:48 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 3/19/20 11:19 AM, dnbrdsky@gmail.com wrote:
> > From: danbrodsky <dnbrdsky@gmail.com>
> >
> > - ran regexp "qemu_mutex_lock\(.*\).*\n.*if" to find targets
> > - replaced result with QEMU_LOCK_GUARD if all unlocks at function end
> > - replaced result with WITH_QEMU_LOCK_GUARD if unlock not at end
> >
> > Signed-off-by: danbrodsky <dnbrdsky@gmail.com>
> > ---
> >   block/iscsi.c         | 23 +++++++------------
> >   block/nfs.c           | 53 ++++++++++++++++++++-----------------------
> >   cpus-common.c         | 13 ++++-------
> >   hw/display/qxl.c      | 44 +++++++++++++++++------------------
> >   hw/vfio/platform.c    |  4 +---
> >   migration/migration.c |  3 +--
> >   migration/multifd.c   |  8 +++----
> >   migration/ram.c       |  3 +--
> >   monitor/misc.c        |  4 +---
> >   ui/spice-display.c    | 14 ++++++------
> >   util/log.c            |  4 ++--
> >   util/qemu-timer.c     | 17 +++++++-------
> >   util/rcu.c            |  8 +++----
> >   util/thread-pool.c    |  3 +--
> >   util/vfio-helpers.c   |  4 ++--
> >   15 files changed, 90 insertions(+), 115 deletions(-)
>
> That's a rather big patch touching multiple areas of code at once; I'm
> not sure if it would be easier to review if you were to break it up into
> a series of smaller patches each touching a smaller group of related
> files.  For example, I don't mind reviwing block/, but tend to shy away
> from migration/ code.

Is this necessary for a series of fairly basic changes? Most files are only
modified on 1 or 2 lines.
>
> >
> > diff --git a/block/iscsi.c b/block/iscsi.c
> > index 682abd8e09..df73bde114 100644
> > --- a/block/iscsi.c
> > +++ b/block/iscsi.c
> > @@ -1086,23 +1086,21 @@ static BlockAIOCB
*iscsi_aio_ioctl(BlockDriverState *bs,
> >       acb->task->expxferlen = acb->ioh->dxfer_len;
> >
> >       data.size = 0;
> > -    qemu_mutex_lock(&iscsilun->mutex);
> > +    QEMU_LOCK_GUARD(&iscsilun->mutex);
> >       if (acb->task->xfer_dir == SCSI_XFER_WRITE) {
> >           if (acb->ioh->iovec_count == 0) {
> >               data.data = acb->ioh->dxferp;
> >               data.size = acb->ioh->dxfer_len;
> >           } else {
> >               scsi_task_set_iov_out(acb->task,
> > -                                 (struct scsi_iovec *)
acb->ioh->dxferp,
> > -                                 acb->ioh->iovec_count);
> > +                                  (struct scsi_iovec
*)acb->ioh->dxferp,
> > +                                  acb->ioh->iovec_count);
>
> This looks like a spurious whitespace change.  Why is it part of the
patch?
>

Sorry, it looks like my editor was autoformatting some areas of the text.
I'll remove
those changes in the next version.

> >           }
> >       }
> >
> >       if (iscsi_scsi_command_async(iscsi, iscsilun->lun, acb->task,
> >                                    iscsi_aio_ioctl_cb,
> > -                                 (data.size > 0) ? &data : NULL,
> > -                                 acb) != 0) {
> > -        qemu_mutex_unlock(&iscsilun->mutex);
> > +                                 (data.size > 0) ? &data : NULL, acb)
!= 0) {
> >           scsi_free_scsi_task(acb->task);
>
> Unwrapping the line fit in 80 columns, but again, why are you mixing
> whitespace changes in rather than focusing on the cleanup of mutex
> actions?  Did you create this patch mechanically with a tool like
> Coccinelle, as the source of your reflowing of lines?  If so, what was
> the input to Coccinelle; if it was some other automated tool, can you
> include the formula so that someone else could reproduce your changes
> (whitespace and all)?  If it was not automated, that's also okay, but
> then I would not expect as much whitespace churn.
>

Should I not be including changes that fix warnings in code check? I'll
correct
the mistakes and submit a new version without all the whitespace churn.

--000000000000e37a8805a13c7433
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>On Thu, Mar 19, 2020 at 1:48 PM Eric Blake &lt;<a hre=
f=3D"mailto:eblake@redhat.com">eblake@redhat.com</a>&gt; wrote:<br>&gt;<br>=
&gt; On 3/19/20 11:19 AM, <a href=3D"mailto:dnbrdsky@gmail.com">dnbrdsky@gm=
ail.com</a> wrote:<br>&gt; &gt; From: danbrodsky &lt;<a href=3D"mailto:dnbr=
dsky@gmail.com">dnbrdsky@gmail.com</a>&gt;<br>&gt; &gt;<br>&gt; &gt; - ran =
regexp &quot;qemu_mutex_lock\(.*\).*\n.*if&quot; to find targets<br>&gt; &g=
t; - replaced result with QEMU_LOCK_GUARD if all unlocks at function end<br=
>&gt; &gt; - replaced result with WITH_QEMU_LOCK_GUARD if unlock not at end=
<br>&gt; &gt;<br>&gt; &gt; Signed-off-by: danbrodsky &lt;<a href=3D"mailto:=
dnbrdsky@gmail.com">dnbrdsky@gmail.com</a>&gt;<br>&gt; &gt; ---<br>&gt; &gt=
; =C2=A0 block/iscsi.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 23 +++++++------------=
<br>&gt; &gt; =C2=A0 block/nfs.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 53 ++=
++++++++++++++++++-----------------------<br>&gt; &gt; =C2=A0 cpus-common.c=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 13 ++++-------<br>&gt; &gt; =C2=A0 hw/displa=
y/qxl.c =C2=A0 =C2=A0 =C2=A0| 44 +++++++++++++++++------------------<br>&gt=
; &gt; =C2=A0 hw/vfio/platform.c =C2=A0 =C2=A0| =C2=A04 +---<br>&gt; &gt; =
=C2=A0 migration/migration.c | =C2=A03 +--<br>&gt; &gt; =C2=A0 migration/mu=
ltifd.c =C2=A0 | =C2=A08 +++----<br>&gt; &gt; =C2=A0 migration/ram.c =C2=A0=
 =C2=A0 =C2=A0 | =C2=A03 +--<br>&gt; &gt; =C2=A0 monitor/misc.c =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A04 +---<br>&gt; &gt; =C2=A0 ui/spice-display.c =C2=
=A0 =C2=A0| 14 ++++++------<br>&gt; &gt; =C2=A0 util/log.c =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A04 ++--<br>&gt; &gt; =C2=A0 util/qemu-tim=
er.c =C2=A0 =C2=A0 | 17 +++++++-------<br>&gt; &gt; =C2=A0 util/rcu.c =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A08 +++----<br>&gt; &gt; =C2=A0=
 util/thread-pool.c =C2=A0 =C2=A0| =C2=A03 +--<br>&gt; &gt; =C2=A0 util/vfi=
o-helpers.c =C2=A0 | =C2=A04 ++--<br>&gt; &gt; =C2=A0 15 files changed, 90 =
insertions(+), 115 deletions(-)<br>&gt;<br>&gt; That&#39;s a rather big pat=
ch touching multiple areas of code at once; I&#39;m<br>&gt; not sure if it =
would be easier to review if you were to break it up into<br>&gt; a series =
of smaller patches each touching a smaller group of related<br>&gt; files.=
=C2=A0 For example, I don&#39;t mind reviwing block/, but tend to shy away<=
br>&gt; from migration/ code.<br><br>Is this necessary for a series of fair=
ly basic changes? Most files are only<br>modified on 1 or 2 lines.<br>&gt;<=
br>&gt; &gt;<br>&gt; &gt; diff --git a/block/iscsi.c b/block/iscsi.c<br>&gt=
; &gt; index 682abd8e09..df73bde114 100644<br>&gt; &gt; --- a/block/iscsi.c=
<br>&gt; &gt; +++ b/block/iscsi.c<br>&gt; &gt; @@ -1086,23 +1086,21 @@ stat=
ic BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,<br>&gt; &gt; =C2=A0 =
=C2=A0 =C2=A0 acb-&gt;task-&gt;expxferlen =3D acb-&gt;ioh-&gt;dxfer_len;<br=
>&gt; &gt; =C2=A0<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 data.size =3D 0;<br>&gt=
; &gt; - =C2=A0 =C2=A0qemu_mutex_lock(&amp;iscsilun-&gt;mutex);<br>&gt; &gt=
; + =C2=A0 =C2=A0QEMU_LOCK_GUARD(&amp;iscsilun-&gt;mutex);<br>&gt; &gt; =C2=
=A0 =C2=A0 =C2=A0 if (acb-&gt;task-&gt;xfer_dir =3D=3D SCSI_XFER_WRITE) {<b=
r>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (acb-&gt;ioh-&gt;iovec_co=
unt =3D=3D 0) {<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 data.data =3D acb-&gt;ioh-&gt;dxferp;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data.size =3D acb-&gt;ioh-&gt;dxfer_len;<br>&g=
t; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>&gt; &gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scsi_task_set_iov_out(acb-&gt;task,<=
br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (struct scsi_iovec *) =
acb-&gt;ioh-&gt;dxferp,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 acb-&gt;ioh-&gt;iovec_count);<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0(struct scsi_iovec *)acb-&gt;ioh-&gt;dxferp,<br>&gt; &g=
t; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acb-&gt;ioh-&gt;iovec_count=
);<br>&gt;<br><div>&gt; This looks like a spurious whitespace change.=C2=A0=
 Why is it part of the patch?</div><div>&gt;</div><div><br></div><div>Sorry=
, it looks like my editor was autoformatting some areas of the text. I&#39;=
ll remove<br></div><div>those changes in the next version.<br><br></div>&gt=
; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 }<br>&gt; &gt; =C2=A0<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 if (iscsi_scsi_=
command_async(iscsi, iscsilun-&gt;lun, acb-&gt;task,<br>&gt; &gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iscsi_aio_ioctl_cb,<br>&gt; &g=
t; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (data.size &gt; 0) ? &amp;data : =
NULL,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 acb) !=3D 0) {<=
br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock(&amp;iscsilun-&=
gt;mutex);<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (data.size &=
gt; 0) ? &amp;data : NULL, acb) !=3D 0) {<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 scsi_free_scsi_task(acb-&gt;task);<br>&gt;<br>&gt; Unwrappin=
g the line fit in 80 columns, but again, why are you mixing<br>&gt; whitesp=
ace changes in rather than focusing on the cleanup of mutex<br>&gt; actions=
?=C2=A0 Did you create this patch mechanically with a tool like<br>&gt; Coc=
cinelle, as the source of your reflowing of lines?=C2=A0 If so, what was<br=
>&gt; the input to Coccinelle; if it was some other automated tool, can you=
<br>&gt; include the formula so that someone else could reproduce your chan=
ges<br>&gt; (whitespace and all)?=C2=A0 If it was not automated, that&#39;s=
 also okay, but<br>&gt; then I would not expect as much whitespace churn.<b=
r>&gt;<br><br></div>Should I not be including changes that fix warnings in =
code check? I&#39;ll correct<br>the mistakes and submit a new version witho=
ut all the whitespace churn.<br></div>

--000000000000e37a8805a13c7433--

