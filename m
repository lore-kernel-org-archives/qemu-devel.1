Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_KAM_HTML_FONT_INVALID autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054EEC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:32:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B05206D9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIM3DWe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B05206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPZX2-00068W-SP
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 18:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leoluan@gmail.com>) id 1jPZW4-0005ig-UJ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <leoluan@gmail.com>) id 1jPZW2-0000k0-Q5
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:31:20 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f]:35187)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <leoluan@gmail.com>)
 id 1jPZW2-0000iJ-IC; Fri, 17 Apr 2020 18:31:18 -0400
Received: by mail-io1-xd2f.google.com with SMTP id w20so4139183iob.2;
 Fri, 17 Apr 2020 15:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=us88UQFyqK65CCki2iEuIy+I+3THwFkJtAE6WzuC2fE=;
 b=rIM3DWe933vCYKXKllWOphiVsg+tYv/+Z6vURidroPlvHXL075z3x9GVE1hd1mFU8u
 6D38Bv2AFbZdRVBDW+DNUAQXaMXl8P+LDWW9S43mCAPlEkEAFi7Q4cuDSyKly3GK7buT
 LMxB3bw9L7nE2q1Lirl0mVTKEg0lxQXIV7Sjlc1fsW285baHvfzSbLzRPIBCIr/E71u3
 KP1ILu2nD4uIzO1bdXD/EMeU/m/ZhUtIgtoAjCRO31f1M8y8e/JxU5qC9Kzj68wcei00
 uLT02deEv38+R6+nZ8PywApX8bJ0qLtRZ8Obj/+tjtrJjSjbrfdgWPpkXHz3cfjgfPNM
 m5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=us88UQFyqK65CCki2iEuIy+I+3THwFkJtAE6WzuC2fE=;
 b=uO3oSf10xlPriHHAk++jxoKWch+a1ru5W7n++tKk0adsgaCGoglDEQJUHjGEeY0GgF
 ORi6hL9HPnaOyiPUEYRdaLypiN/qNSTjXEWv9YJ63DJv/s+BPuZP8E20Exp3V8LABejy
 +JkhWfzIagD3Kpm040Ohsc2l7ofZTfafETEc3ZSdC/W1fv+EIlKqewgxmiVFLwXwqp+7
 2i/oQAHhHfHqNCbwtAuf+/hUSzsxaTG5bYI5cChA+rD0ZWEJZFhe1Xoo2LW4C1FZ3Vtl
 l4Yo+2eIRtX++XS65i6AZhfsmrXHpagrcB/jtkZkl6cyNWP6WdUCUhntIfkx+SR10JFA
 TWkA==
X-Gm-Message-State: AGi0PuZ9pVaPwnCpmygrvvE4CumKJOfuPw10kxtBU2Yf9tdGmTO+MsBM
 PZhvg256rp+QAkA7tZYqGVOM9TIEHT2NRBeBtfk=
X-Google-Smtp-Source: APiQypIAuO50THxGjoQKdpUbh473kukUNw5LDNIu49rYTdJbAGHPKvD1MKwIEmJ2LjOEmMShj713mLmYGOioYC2Lby0=
X-Received: by 2002:a5d:9c46:: with SMTP id 6mr5377897iof.146.1587162677587;
 Fri, 17 Apr 2020 15:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAD_3s9Jnd9BzkZAe6SEKz7unuxJHY502pNdUgxrC3MOQAFj9Hw@mail.gmail.com>
 <ba8ff0c2-2e56-c8d7-a13a-4af48372f172@redhat.com>
In-Reply-To: <ba8ff0c2-2e56-c8d7-a13a-4af48372f172@redhat.com>
From: Leo Luan <leoluan@gmail.com>
Date: Fri, 17 Apr 2020 15:31:06 -0700
Message-ID: <CAD_3s9LdScjB8ySrGGn9i-2PiDpby4YZo558PXZV4TaMip6pvQ@mail.gmail.com>
Subject: Re: Avoid copying unallocated clusters during full backup
To: John Snow <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000099364a05a3841bb2"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d2f
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000099364a05a3841bb2
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 17, 2020 at 1:11 PM John Snow <jsnow@redhat.com> wrote:

>
>
> On 4/17/20 2:33 PM, Leo Luan wrote:
> > When doing a full backup from a single layer qcow2 disk file to a new
> > qcow2 file, the backup_run function does not unset unallocated parts in
> > the copy bit map.  The subsequent backup_loop call goes through these
> > unallocated clusters unnecessarily.  In the case when the target and
> > source reside in different file systems, an EXDEV error would cause
> > zeroes to be actually copied into the target and that causes a target
> > file size explosion to the full virtual disk size.
> >
>
> I think the idea, generally, is to leave the detection of unallocated
> portions to the format (qcow2) and the protocol (posix file) respectively.
>
> As far as I know, it is incorrect to assume that unallocated data
> can/will/should always be read as zeroes; so it may not be the case that
> it is "safe" to skip this data, because the target may or may not need
> explicit zeroing.
>

Thanks for pointing this out.  Would it be safe to skip unallocated
clusters if both source and target's bdrv_unallocated_blocks_are_zero()
returns true?

> This patch aims to unset the unallocated parts in the copy bitmap when
> > it is safe to do so, thereby avoid dealing with unallocated clusters in
> > the backup loop to prevent significant performance or storage efficiency
> > impacts when running full backup jobs.
> >
> > Any insights or corrections?
> >
> > diff --git a/block/backup.c b/block/backup.c
> > index cf62b1a38c..609d551b1e 100644
> > --- a/block/backup.c
> > +++ b/block/backup.c
> > @@ -139,6 +139,29 @@ static void backup_clean(Job *job)
> >      bdrv_backup_top_drop(s->backup_top);
> >  }
> >
> > +static bool backup_ok_to_skip_unallocated(BackupBlockJob *s)
> > +{
> > +    /* Checks whether this backup job can avoid copying or dealing with
> > +       unallocated clusters in the backup loop and their associated
> > +       performance and storage effciency impacts. Check for the
> condition
> > +       when it's safe to skip copying unallocated clusters that allows
> the
> > +       corresponding bits in the copy bitmap to be unset.  The
> assumption
> > +       here is that it is ok to do so when we are doing a full backup,
> > +       the target file is a qcow2, and the source is single layer.
> > +       Do we need to add additional checks (so that it does not break
> > +       something) or add addtional conditions to optimize additional use
> > +       cases?
> > +     */
> > +
> > +    if (s->sync_mode == MIRROR_SYNC_MODE_FULL &&
> > +       s->bcs->target->bs->drv != NULL &&
> > +       strncmp(s->bcs->target->bs->drv->format_name, "qcow2", 5) == 0 &&
> > +       s->bcs->source->bs->backing_file[0] == '\0')
>
> This isn't going to suffice upstream; the backup job can't be performing
> format introspection to determine behavior on the fly.
>
> I think what you're really after is something like
> bdrv_unallocated_blocks_are_zero().
>

Thanks for this pointer.


>
> > +       return true;
> > +    else
> > +        return false;
> > +}
> > +
> >  void backup_do_checkpoint(BlockJob *job, Error **errp)
> >  {
> >      BackupBlockJob *backup_job = container_of(job, BackupBlockJob,
> common);
> > @@ -248,7 +271,7 @@ static int coroutine_fn backup_run(Job *job, Error
> > **errp)
> >
> >      backup_init_copy_bitmap(s);
> >
> > -    if (s->sync_mode == MIRROR_SYNC_MODE_TOP) {
> > +    if (s->sync_mode == MIRROR_SYNC_MODE_TOP ||
>
> So the basic premise is that if you are copying a qcow2 file and the
> unallocated portions as defined by the qcow2 metadata are zero, it's
> safe to skip those, so you can treat it like SYNC_MODE_TOP.
>

In the MIRROR_SYNC_MODE_TOP case, the check for unallocated clusters does
not go all the way to the base level.  So it would be incorrect to treat
the MIRROR_SYNC_MODE_FULL the same as MIRROR_SYNC_MODE_TOP unless the
source does not have a backing and the base itself.  That's why I added a
check for the backing_file field of the source.  I guess the code can be
potentially extended with a new flag to do the block status check all the
way into the base level for the case of the FULL mode?

I think you *also* have to know if the *source* needs those regions
> explicitly zeroed, and it's not always safe to just skip them at the
> manifest level.
>

Do you mean some operation changing the target into non-sparse?

>
> I thought there was code that handled this to some extent already, but I
> don't know. I think Vladimir has worked on it recently and can probably
> let you know where I am mistaken :)
>

Thanks for the reply!


> --js
>
> > backup_ok_to_skip_unallocated(s)) {
> >          int64_t offset = 0;
> >          int64_t count;
> >
>
> John Snow

--00000000000099364a05a3841bb2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span class=3D"gmail-im" style=3D"color:rgb(80,0,80)"><div=
 dir=3D"ltr"><div class=3D"gmail-adn gmail-ads" style=3D"border-left:none;p=
adding:0px;display:flex"><div class=3D"gmail-gs" style=3D"margin:0px;paddin=
g:0px 0px 20px;width:512.017px"><div class=3D"gmail-"><div id=3D"gmail-:a77=
" class=3D"gmail-ii gmail-gt" style=3D"font-size:0.875rem;direction:ltr;mar=
gin:8px 0px 0px;padding:0px"><div id=3D"gmail-:a4t" class=3D"gmail-a3s gmai=
l-aXjCH" style=3D"overflow:hidden;font-variant-numeric:normal;font-variant-=
east-asian:normal;font-stretch:normal;font-size:small;line-height:1.5"><div=
 dir=3D"ltr"><span class=3D"gmail-im"><div dir=3D"ltr">On Fri, Apr 17, 2020=
 at 1:11 PM John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_bl=
ank">jsnow@redhat.com</a>&gt; wrote:<br></div></span><div class=3D"gmail_qu=
ote"><span class=3D"gmail-im"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><br><br>On 4/17/20 2:33 PM, Leo Luan wrote:<br>&gt; When doing a full =
backup from a single layer qcow2 disk file to a new<br>&gt; qcow2 file, the=
 backup_run function does not unset unallocated parts in<br>&gt; the copy b=
it map.=C2=A0 The subsequent backup_loop call goes through these<br>&gt; un=
allocated clusters unnecessarily.=C2=A0 In the case when the target and<br>=
&gt; source reside in different file systems, an EXDEV error would cause<br=
>&gt; zeroes to be actually copied into the target and that causes a target=
<br>&gt; file size explosion to the full virtual disk size.<br>&gt;<br><br>=
I think the idea, generally, is to leave the detection of unallocated<br>po=
rtions to the format (qcow2) and the protocol (posix file) respectively.<br=
><br>As far as I know, it is incorrect to assume that unallocated data<br>c=
an/will/should always be read as zeroes; so it may not be the case that<br>=
it is &quot;safe&quot; to skip this data, because the target may or may not=
 need<br>explicit zeroing.<br></blockquote><div><br></div></span><div>Thank=
s for pointing this out.=C2=A0 Would it be safe to skip unallocated cluster=
s if both source and target&#39;s=C2=A0bdrv_unallocated_blocks_are_zero() r=
eturns true?</div><div><div class=3D"gmail-adm" style=3D"margin:5px 0px"><d=
iv id=3D"gmail-q_1359" class=3D"gmail-ajR gmail-h4" style=3D"background-col=
or:rgb(232,234,237);border:none;clear:both;line-height:6px;outline:none;wid=
th:24px;font-size:11px;border-radius:5.5px"><div class=3D"gmail-ajT" style=
=3D"background:url(&quot;https://www.gstatic.com/images/icons/material/syst=
em/2x/more_horiz_black_20dp.png&quot;) 50% 50%/20px no-repeat;height:11px;o=
pacity:0.54;width:24px"></div></div></div><div class=3D"gmail-im"><div><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; This patch aim=
s to unset the unallocated parts in the copy bitmap when<br>&gt; it is safe=
 to do so, thereby avoid dealing with unallocated clusters in<br>&gt; the b=
ackup loop to prevent significant performance or storage efficiency<br>&gt;=
 impacts when running full backup jobs.<br>&gt;<br>&gt; Any insights or cor=
rections?<br>&gt;<br>&gt; diff --git a/block/backup.c b/block/backup.c<br>&=
gt; index cf62b1a38c..609d551b1e 100644<br>&gt; --- a/block/backup.c<br>&gt=
; +++ b/block/backup.c<br>&gt; @@ -139,6 +139,29 @@ static void backup_clea=
n(Job *job)<br>&gt; =C2=A0 =C2=A0 =C2=A0bdrv_backup_top_drop(s-&gt;backup_t=
op);<br>&gt; =C2=A0}<br>&gt; =C2=A0<br>&gt; +static bool backup_ok_to_skip_=
unallocated(BackupBlockJob *s)<br>&gt; +{<br>&gt; + =C2=A0 =C2=A0/* Checks =
whether this backup job can avoid copying or dealing with<br>&gt; + =C2=A0 =
=C2=A0 =C2=A0 unallocated clusters in the backup loop and their associated<=
br>&gt; + =C2=A0 =C2=A0 =C2=A0 performance and storage effciency impacts. C=
heck for the condition<br>&gt; + =C2=A0 =C2=A0 =C2=A0 when it&#39;s safe to=
 skip copying unallocated clusters that allows the<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0 corresponding bits in the copy bitmap to be unset.=C2=A0 The assumpt=
ion<br>&gt; + =C2=A0 =C2=A0 =C2=A0 here is that it is ok to do so when we a=
re doing a full backup,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 the target file is a=
 qcow2, and the source is single layer.<br>&gt; + =C2=A0 =C2=A0 =C2=A0 Do w=
e need to add additional checks (so that it does not break<br>&gt; + =C2=A0=
 =C2=A0 =C2=A0 something) or add addtional conditions to optimize additiona=
l use<br>&gt; + =C2=A0 =C2=A0 =C2=A0 cases?<br>&gt; + =C2=A0 =C2=A0 */<br>&=
gt; +<br>&gt; + =C2=A0 =C2=A0if (s-&gt;sync_mode =3D=3D MIRROR_SYNC_MODE_FU=
LL &amp;&amp;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 s-&gt;bcs-&gt;target-&gt;bs-&g=
t;drv !=3D NULL &amp;&amp;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 strncmp(s-&gt;bcs=
-&gt;target-&gt;bs-&gt;drv-&gt;format_name, &quot;qcow2&quot;, 5) =3D=3D 0 =
&amp;&amp;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 s-&gt;bcs-&gt;source-&gt;bs-&gt;b=
acking_file[0] =3D=3D &#39;\0&#39;)<br><br>This isn&#39;t going to suffice =
upstream; the backup job can&#39;t be performing<br>format introspection to=
 determine behavior on the fly.<br><br>I think what you&#39;re really after=
 is something like<br>bdrv_unallocated_blocks_are_zero().<br></blockquote><=
div><br></div></div></div><div>Thanks for this pointer.</div><span class=3D=
"gmail-im"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><br>&gt; + =C2=A0 =C2=A0 =C2=A0 return true;<br>&gt; + =C2=A0 =C2=A0else=
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>&gt; +}<br>&gt; +<br=
>&gt; =C2=A0void backup_do_checkpoint(BlockJob *job, Error **errp)<br>&gt; =
=C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0BackupBlockJob *backup_job =3D containe=
r_of(job, BackupBlockJob, common);<br>&gt; @@ -248,7 +271,7 @@ static int c=
oroutine_fn backup_run(Job *job, Error<br>&gt; **errp)<br>&gt; =C2=A0<br>&g=
t; =C2=A0 =C2=A0 =C2=A0backup_init_copy_bitmap(s);<br>&gt; =C2=A0<br>&gt; -=
 =C2=A0 =C2=A0if (s-&gt;sync_mode =3D=3D MIRROR_SYNC_MODE_TOP) {<br>&gt; + =
=C2=A0 =C2=A0if (s-&gt;sync_mode =3D=3D MIRROR_SYNC_MODE_TOP ||<br><br>So t=
he basic premise is that if you are copying a qcow2 file and the<br>unalloc=
ated portions as defined by the qcow2 metadata are zero, it&#39;s<br>safe t=
o skip those, so you can treat it like SYNC_MODE_TOP.<br></blockquote><div>=
<br></div></span><div>In the MIRROR_SYNC_MODE_TOP case, the check for unall=
ocated clusters does not go all the way to the base level.=C2=A0 So it woul=
d be incorrect to treat the MIRROR_SYNC_MODE_FULL the same as MIRROR_SYNC_M=
ODE_TOP unless the source does not have a backing and the base itself.=C2=
=A0 That&#39;s why I added a check for the backing_file field of the source=
.=C2=A0 I guess the code can be potentially extended with a new flag to do =
the block status check all the way into the base level for the case of the =
FULL mode?</div><span class=3D"gmail-im"><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">I think you *also* have to know if the *so=
urce* needs those regions<br>explicitly zeroed, and it&#39;s not always saf=
e to just skip them at the<br>manifest level.<br></blockquote><div><br></di=
v></span><div>Do you mean some operation changing the target into non-spars=
e?</div><span class=3D"gmail-im"><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><br>I thought there was code that handled this to some extent alrea=
dy, but I<br>don&#39;t know. I think Vladimir has worked on it recently and=
 can probably<br>let you know where I am mistaken :)<br></blockquote><div><=
br></div></span><div>Thanks for the reply!=C2=A0</div><div class=3D"gmail-y=
j6qo gmail-ajU" style=3D"outline:none;padding:10px 0px;width:22px;margin:2p=
x 0px 0px"><div id=3D"gmail-:cto" class=3D"gmail-ajR" tabindex=3D"0" style=
=3D"background-color:rgb(232,234,237);border:none;clear:both;line-height:6p=
x;outline:none;width:24px;border-radius:5.5px"><img class=3D"gmail-ajT" src=
=3D"https://ssl.gstatic.com/ui/v1/icons/mail/images/cleardot.gif" style=3D"=
background: url(&quot;https://www.gstatic.com/images/icons/material/system/=
2x/more_horiz_black_20dp.png&quot;) 50% 50% / 20px no-repeat; height: 11px;=
 opacity: 0.54; width: 24px;"></div></div><div class=3D"gmail-adL"><div cla=
ss=3D"gmail-adm" style=3D"margin:5px 0px"></div><div class=3D"gmail-im"><di=
v>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">--js<br=
><br>&gt; backup_ok_to_skip_unallocated(s)) {<br>&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0int64_t offset =3D 0;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int64_t count;<br>&gt; =C2=A0<br><br></blockquote></div></div></div></di=
v><div class=3D"gmail-adL"></div></div></div><div class=3D"gmail-hi" style=
=3D"border-bottom-left-radius:1px;border-bottom-right-radius:1px;padding:0p=
x;width:auto;background:rgb(242,242,242);margin:0px"></div></div></div><div=
 class=3D"gmail-ajx" style=3D"clear:both"></div></div><div class=3D"gmail-g=
A gmail-gt" style=3D"font-size:0.875rem;padding:0px;width:auto;border-botto=
m-left-radius:0px;border-bottom-right-radius:0px;border-top:none;background=
:transparent"><div class=3D"gmail-gB gmail-acO" style=3D"border-top:1px sol=
id transparent;padding:0px"><div class=3D"gmail-ip gmail-adB" style=3D"bord=
er-top:none;margin:0px;border-right:1px solid rgb(207,207,207);border-botto=
m:1px solid rgb(207,207,207);border-left:1px solid rgb(207,207,207);padding=
:16px 0px"><div class=3D"gmail-M9"><div id=3D"gmail-:cpu"></div><div id=3D"=
gmail-:cs3"></div><div id=3D"gmail-:cra" class=3D"gmail-aoI" style=3D"backg=
round-color:transparent;font-size:0.875rem;color:rgb(34,34,34);padding:0px =
8px 0px 16px"><table id=3D"gmail-:crb" class=3D"gmail-aoP gmail-HM" style=
=3D"border-spacing:0px;table-layout:fixed;width:567.273px"><tbody><tr><td c=
lass=3D"gmail-aoY" style=3D"padding:8px 0px;vertical-align:top;width:48px">=
<div id=3D"gmail-:cs0" class=3D"gmail-ajn gmail-aAa" style=3D"height:40px;w=
idth:40px;border-radius:50%"></div><div id=3D"gmail-:cs1" class=3D"gmail-aj=
n" style=3D"width:40px;height:40px;border-radius:50%"><img class=3D"gmail-a=
jn" id=3D"gmail-:15k_95" name=3D":15k" src=3D"https://www.google.com/s2/u/0=
/photos/public/AIbEiAIAAABDCNaAz4W3opjNKyILdmNhcmRfcGhvdG8qKGRkMDNlYjRhYzQ2=
OTc4ZTM3OGQ4YWE3MDMxNmMyMmE0MjYzZGZjMTcwARKsHCy2m1EERBFzv3BdnIySjDJ6?sz=3D8=
0" style=3D"display: block; width: 40px; height: 40px; border-radius: 50%;"=
></div></td><td id=3D"gmail-:ffd" class=3D"gmail-I5" style=3D"padding:0px;b=
order:1px solid rgb(218,220,224);border-radius:8px;box-sizing:border-box"><=
form id=3D"gmail-:ffa" action=3D"https://mail.google.com/mail/u/0/" method=
=3D"POST" enctype=3D"multipart/form-data" class=3D"gmail-bAs"><div id=3D"gm=
ail-:cr7" style=3D"height:0px"></div><div id=3D"gmail-:cr8" style=3D"clip: =
auto;"><table class=3D"gmail-IG" style=3D"border-spacing:0px;table-layout:f=
ixed;width:485.284px;border:none;border-radius:8px 8px 0px 0px;padding:6px =
16px"><tbody><tr><td class=3D"gmail-HQ" style=3D"padding:0px;white-space:no=
wrap;vertical-align:top;border:none;width:48px"><div id=3D"gmail-:crd" clas=
s=3D"gmail-J-JN-M-I gmail-J-J5-Ji gmail-Un gmail-L3" tabindex=3D"1" style=
=3D"display:inline-flex;border-radius:0px;color:rgb(68,68,68);font-size:0.8=
75rem;line-height:27px;list-style:none;min-width:20px;outline:none;padding:=
8px;text-align:center;background:none;border:none;opacity:0.54"><div class=
=3D"gmail-J-J5-Ji gmail-J-JN-M-I-Jm" style=3D"display:inline-flex;vertical-=
align:top"><img class=3D"gmail-mL" id=3D"gmail-:cre" src=3D"https://mail.go=
ogle.com/mail/u/0/images/cleardot.gif" alt=3D"" style=3D"opacity: 1; vertic=
al-align: middle; background: url(&quot;https://www.gstatic.com/images/icon=
s/material/system/2x/reply_black_20dp.png&quot;) 50% 50% / 20px no-repeat; =
height: 20px; width: 20px;"></div></div></td><td class=3D"gmail-Iy" style=
=3D"width:auto;padding:0px"><div id=3D"gmail-:ffe" class=3D"gmail-aoD gmail=
-hl" tabindex=3D"1" style=3D"min-height:auto;padding:8px 0px;display:flex;b=
order:none;line-height:20px"><div id=3D"gmail-:cr4" class=3D"gmail-oL gmail=
-aDm gmail-az9" style=3D"color:rgb(119,119,119);min-height:auto;margin:0px;=
overflow:hidden;text-overflow:ellipsis;white-space:nowrap;display:inline-bl=
ock">John Snow</div><div id=3D"gmail-:ffb" class=3D"gmail-bgW" style=3D"mar=
gin:0px;display:flex;height:20px;min-width:40px"><br class=3D"gmail-Apple-i=
nterchange-newline"></div></div></td></tr></tbody></table></div></form></td=
></tr></tbody></table></div></div></div></div></div></div></span></div>

--00000000000099364a05a3841bb2--

