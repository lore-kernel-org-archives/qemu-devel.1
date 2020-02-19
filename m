Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E821C18DFF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 19:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3C320801
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 19:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFxEfRZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3C320801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Ufr-0007eD-Hh
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 14:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j4Uf9-00077F-7C
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 14:05:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j4Uf6-0007dA-GJ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 14:05:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28646
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j4Uf6-0007c3-AJ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 14:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582139131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q5ZriIRfiLK4aihpfPxKfQPtDlnsoYq8x1WthG2MQi4=;
 b=DFxEfRZ/TFVUclc6eTXy0KHVbMZQm7HJPwvmHvltHe/i+nICcb9ma9IY/TDtt/JaQzfc+H
 sHSNQp7gZVwmL6h3SjEtHZB5OHXUIKJZhmwrw+VrUgOB7akZfvlh7V6sJh3JPpTEuC2elm
 Y13lZspyKcYBP59sNe26hV+pya5qQQk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-Ug_alfr3Nb6pmJx17XxtsA-1; Wed, 19 Feb 2020 14:05:26 -0500
Received: by mail-ed1-f69.google.com with SMTP id c24so854471edy.9
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 11:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bRmVodz40b39BO/Xx2gmkdCxbytY6j+bypLCcnVdsfg=;
 b=EItDoJMUz3+kkB3NtYzGNgv6NdP1TD/pbTLjKir+xdTs1iQuNIyWoTwZMgJwt1SxcR
 KVilceKX8huvwpXZOQTv6bng0tbKvVLkoCTmIGFBEmwBkkvqF30kj50q0iDQou0eDTAL
 RrYkSml1ERC0NejptReMUn+FyTGi2wPylEl+g45EHQbFntVWm+I8apH7b5g9JxaHY81a
 KqClNvOKqhfu4qQfHOD8qpD2eKeBj0z4QKESvcEwDgvDi1Qi+uDpx7DtJphMo5pRaR6N
 4lEciL71y0Ixd8vvkPYZM3Wx6Q8ESYjD+CK6IfO+qxVhEvBeU5q1LN7deKx3Ed1luKS7
 DTzQ==
X-Gm-Message-State: APjAAAVb1Zfqn/d0NrLIDIm6iDLyd4JLXki4frIpUTEaQNFPPZ/QOgvn
 6RA3nzAGnALRDxKElJogAQmgMHL0j2NN975D9jijWGVUwCaWYiy5eQM07tL4Efj2aKkzUCH7jZX
 vXF0PG4y7e6pRDusU/e1KdgSNKjuBCrg=
X-Received: by 2002:a17:906:72de:: with SMTP id
 m30mr300623ejl.247.1582139125370; 
 Wed, 19 Feb 2020 11:05:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqz9g52Gj1/j+eZEuSBeuLeQD1+3lCbJ83Rz0R1HuGKO9G2WUJoz/RThYMg+VlukHFfL55Ec2UqYhxSVqhXM64k=
X-Received: by 2002:a17:906:72de:: with SMTP id
 m30mr300599ejl.247.1582139124974; 
 Wed, 19 Feb 2020 11:05:24 -0800 (PST)
MIME-Version: 1.0
References: <20200219100045.1074381-1-stefanha@redhat.com>
 <ad80faf5-7e77-739e-36d7-8d88101b9d59@redhat.com>
 <20200219165425.GB1089598@stefanha-x1.localdomain>
In-Reply-To: <20200219165425.GB1089598@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Feb 2020 20:05:12 +0100
Message-ID: <CABgObfYY+tr3xuoBFF3Q3zn2khrZCSfGK-P63NYJ_phS1vCp5w@mail.gmail.com>
Subject: Re: [PATCH] util/async: make bh_aio_poll() O(1)
To: Stefan Hajnoczi <stefanha@redhat.com>
X-MC-Unique: Ug_alfr3Nb6pmJx17XxtsA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000879a2c059ef27806"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000879a2c059ef27806
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 19 feb 2020, 18:58 Stefan Hajnoczi <stefanha@redhat.com> ha scritto:

> On Wed, Feb 19, 2020 at 12:09:48PM +0100, Paolo Bonzini wrote:
> > Really a great idea, though I have some remarks on the implementation
> below.
> >
> > On 19/02/20 11:00, Stefan Hajnoczi wrote:
> > > + * Each aio_bh_poll() call carves off a slice of the BH list.  This
> way newly
> > > + * scheduled BHs are not processed until the next aio_bh_poll()
> call.  This
> > > + * concept extends to nested aio_bh_poll() calls because slices are
> chained
> > > + * together.
> >
> > This is the tricky part so I would expand a bit on why it's needed:
> >
> > /*
> >  * Each aio_bh_poll() call carves off a slice of the BH list, so that
> >  * newly scheduled BHs are not processed until the next aio_bh_poll()
> >  * call.  All active aio_bh_poll() calls chained their slices together
> >  * in a list, so that nested aio_bh_poll() calls process all scheduled
> >  * bottom halves.
> >  */
>
> Thanks, will fix in v2.
>
> > > +struct BHListSlice {
> > > +    QEMUBH *first_bh;
> > > +    BHListSlice *next;
> > > +};
> > > +
> >
> > Using QLIST and QSLIST removes the need to create your own lists, since
> > you can use QSLIST_MOVE_ATOMIC and QSLIST_INSERT_HEAD_ATOMIC.  For
> example:
> >
> > struct BHListSlice {
> >     QSLIST_HEAD(, QEMUBH) first_bh;
> >     QLIST_ENTRY(BHListSlice) next;
> > };
> >
> > ...
> >
> >     QSLIST_HEAD(, QEMUBH) active_bh;
> >     QLIST_HEAD(, BHListSlice) bh_list;
>
> I thought about this but chose the explicit tail pointer approach
> because it lets aio_compute_timeout() and aio_ctx_check() iterate over
> both the active BH list and slices in a single for loop :).  But
> thinking about it more, maybe it can still be done by replacing
> active_bh with a permanently present first BHListSlice element.
>

Probably not so easy since the idea was to empty the slices list entirely
via the FIFO order.

But since you are rewriting everything anyway, can you add a flag for
whether there are any non-idle bottom halves anywhere in the list? It need
not be computed perfectly, because any non-idle bh will cause the idle
bottom halves to be triggered as well; you can just set in qemu_bh_schedule
and clear it at the end of aio_bh_poll.

Then if there is any active bh or slice you consult the flag and use it to
return the timeout, which will be either 0 or 10ms depending on the flag.
That's truly O(1). (More precisely, this patch goes from O(#created-bh) to
O(#scheduled-bh), which of course is optimal for aio_bh_poll but not for
aio_compute_timeout; making timeout computation O(1) can lower latency a
bit by decreasing the constant factor).

Paolo


> >
> > Related to this, in the aio_bh_poll() loop:
> >
> >     for (s =3D ctx->bh_list.next; s; s =3D s->next) {
> >     }
> >
> > You can actually do the removal inside the loop.  This is slightly more
> > efficient since you can remove slices early from the nested
> > aio_bh_poll().  Not that it's relevant for performance, but I think the
> > FIFO order for slices is also more intuitive than LIFO.
> >
> > Putting this idea together with the QLIST one, you would get:
> >
> >     /*
> >      * If a bottom half causes a recursive call, this slice will be
> >      * removed by the nested aio_bh_poll().
> >      */
> >     QSLIST_MOVE_ATOMIC(&slice.first_bh, ctx->active_bh);
> >     QLIST_INSERT_TAIL(&ctx->bh_list, slice);
> >     while ((s =3D QLIST_FIRST(&ctx->bh_list)) {
> >         while ((bh =3D aio_bh_dequeue(&s, &flags))) {
> >         }
> >         QLIST_REMOVE_HEAD(s, next);
> >     }
>
> Cool, reusing "queue.h" is nice.
>
> >
> > >  /* Multiple occurrences of aio_bh_poll cannot be called concurrently=
.
> > >   * The count in ctx->list_lock is incremented before the call, and i=
s
> > >   * not affected by the call.
> >
> > The second sentence is now stale.
>
> Thanks, will fix in v2.
>
> Stefan
>

--000000000000879a2c059ef27806
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 19 feb 2020, 18:58 Stefan Hajnoczi &lt;<a href=
=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</a>&gt; ha scritto:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">On Wed, Feb 19, 2020 at 12:09:48PM +01=
00, Paolo Bonzini wrote:<br>
&gt; Really a great idea, though I have some remarks on the implementation =
below.<br>
&gt; <br>
&gt; On 19/02/20 11:00, Stefan Hajnoczi wrote:<br>
&gt; &gt; + * Each aio_bh_poll() call carves off a slice of the BH list.=C2=
=A0 This way newly<br>
&gt; &gt; + * scheduled BHs are not processed until the next aio_bh_poll() =
call.=C2=A0 This<br>
&gt; &gt; + * concept extends to nested aio_bh_poll() calls because slices =
are chained<br>
&gt; &gt; + * together.<br>
&gt; <br>
&gt; This is the tricky part so I would expand a bit on why it&#39;s needed=
:<br>
&gt; <br>
&gt; /*<br>
&gt;=C2=A0 * Each aio_bh_poll() call carves off a slice of the BH list, so =
that<br>
&gt;=C2=A0 * newly scheduled BHs are not processed until the next aio_bh_po=
ll()<br>
&gt;=C2=A0 * call.=C2=A0 All active aio_bh_poll() calls chained their slice=
s together<br>
&gt;=C2=A0 * in a list, so that nested aio_bh_poll() calls process all sche=
duled<br>
&gt;=C2=A0 * bottom halves.<br>
&gt;=C2=A0 */<br>
<br>
Thanks, will fix in v2.<br>
<br>
&gt; &gt; +struct BHListSlice {<br>
&gt; &gt; +=C2=A0 =C2=A0 QEMUBH *first_bh;<br>
&gt; &gt; +=C2=A0 =C2=A0 BHListSlice *next;<br>
&gt; &gt; +};<br>
&gt; &gt; +<br>
&gt; <br>
&gt; Using QLIST and QSLIST removes the need to create your own lists, sinc=
e<br>
&gt; you can use QSLIST_MOVE_ATOMIC and QSLIST_INSERT_HEAD_ATOMIC.=C2=A0 Fo=
r example:<br>
&gt; <br>
&gt; struct BHListSlice {<br>
&gt;=C2=A0 =C2=A0 =C2=A0QSLIST_HEAD(, QEMUBH) first_bh;<br>
&gt;=C2=A0 =C2=A0 =C2=A0QLIST_ENTRY(BHListSlice) next;<br>
&gt; };<br>
&gt; <br>
&gt; ...<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0QSLIST_HEAD(, QEMUBH) active_bh;<br>
&gt;=C2=A0 =C2=A0 =C2=A0QLIST_HEAD(, BHListSlice) bh_list;<br>
<br>
I thought about this but chose the explicit tail pointer approach<br>
because it lets aio_compute_timeout() and aio_ctx_check() iterate over<br>
both the active BH list and slices in a single for loop :).=C2=A0 But<br>
thinking about it more, maybe it can still be done by replacing<br>
active_bh with a permanently present first BHListSlice element.<br></blockq=
uote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Probably not=
 so easy since the idea was to empty the slices list entirely via the FIFO =
order.</div><div dir=3D"auto"><br></div><div dir=3D"auto">But since you are=
 rewriting everything anyway, can you add a flag for whether there are any =
non-idle bottom halves anywhere in the list?=C2=A0<span style=3D"font-famil=
y:sans-serif">It need not be computed perfectly, because any non-idle bh wi=
ll cause the idle bottom halves to be triggered as well; you can just s</sp=
an><span style=3D"font-family:sans-serif">et in qemu_bh_schedule and clear =
it at the end of aio_bh_poll.</span></div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Then if there is any active bh or slice you consult the flag a=
nd use it to return the timeout, which will be either 0 or 10ms depending o=
n the flag. That&#39;s truly O(1). (More precisely, this patch goes from O(=
#created-bh) to O(#scheduled-bh), which of course is optimal for aio_bh_pol=
l but not for aio_compute_timeout; making timeout computation O(1) can lowe=
r latency a bit by decreasing the constant factor).</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; <br>
&gt; Related to this, in the aio_bh_poll() loop:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0for (s =3D ctx-&gt;bh_list.next; s; s =3D s-&gt;nex=
t) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt; You can actually do the removal inside the loop.=C2=A0 This is slightl=
y more<br>
&gt; efficient since you can remove slices early from the nested<br>
&gt; aio_bh_poll().=C2=A0 Not that it&#39;s relevant for performance, but I=
 think the<br>
&gt; FIFO order for slices is also more intuitive than LIFO.<br>
&gt; <br>
&gt; Putting this idea together with the QLIST one, you would get:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * If a bottom half causes a recursive call, this s=
lice will be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * removed by the nested aio_bh_poll().<br>
&gt;=C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0QSLIST_MOVE_ATOMIC(&amp;slice.first_bh, ctx-&gt;act=
ive_bh);<br>
&gt;=C2=A0 =C2=A0 =C2=A0QLIST_INSERT_TAIL(&amp;ctx-&gt;bh_list, slice);<br>
&gt;=C2=A0 =C2=A0 =C2=A0while ((s =3D QLIST_FIRST(&amp;ctx-&gt;bh_list)) {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while ((bh =3D aio_bh_dequeue(&amp;s,=
 &amp;flags))) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QLIST_REMOVE_HEAD(s, next);<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
<br>
Cool, reusing &quot;queue.h&quot; is nice.<br>
<br>
&gt; <br>
&gt; &gt;=C2=A0 /* Multiple occurrences of aio_bh_poll cannot be called con=
currently.<br>
&gt; &gt;=C2=A0 =C2=A0* The count in ctx-&gt;list_lock is incremented befor=
e the call, and is<br>
&gt; &gt;=C2=A0 =C2=A0* not affected by the call.<br>
&gt; <br>
&gt; The second sentence is now stale.<br>
<br>
Thanks, will fix in v2.<br>
<br>
Stefan<br>
</blockquote></div></div></div>

--000000000000879a2c059ef27806--


