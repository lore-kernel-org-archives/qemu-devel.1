Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2237C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 14:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78106206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 14:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nko/WoK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78106206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJeh8-000546-Fm
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 10:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <singhalsimran0@gmail.com>) id 1jJegH-0004Bh-UL
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <singhalsimran0@gmail.com>) id 1jJegF-0004kq-OF
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:49:25 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:38989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <singhalsimran0@gmail.com>)
 id 1jJeg6-0004P2-JY; Wed, 01 Apr 2020 10:49:14 -0400
Received: by mail-lj1-x241.google.com with SMTP id i20so26045291ljn.6;
 Wed, 01 Apr 2020 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ypeunQvjxpeP6zSj94eQzrzkgz1qBwNgKrY0BPplNMc=;
 b=nko/WoK9tbmoBFuJt83CN5gLOrpL8V9dReRj5Q3yYaMLTRsDSjA0EESwbVf8xV7hOa
 fAKWl8NZbdxTvgb2US7NUNnLHnse8fgFbOShEmXd1+QBXa3+8NVQu0gU22+rgojiq0lj
 rB39eHMlnLutLA5kwIrB/5UtdygJUkAX1oEno5oHU5mCdDxd7tyN0oe/1SwUAPJxL3dA
 B2Tj7CGwCtWrLmOVo/JcsSsCFsYAOiMYFHfcREAubVJZ1xEvCpDQy6IpPw+1Rr/vl+FC
 Okolgwh2FjtvN52UIky8yUTEqHsu5dfNeNuR/GMpcCt+OS9MlbceG0EZ/C5Ed/GRv4pY
 GRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ypeunQvjxpeP6zSj94eQzrzkgz1qBwNgKrY0BPplNMc=;
 b=ICMWsQVS9KNkHM/FbBwHidX/YYk1vP6TwFPBAiER8OZSATzIIgoBI9YyaFUfOJ4LB0
 BQ86oPkQghwTApXLKUZqW83Oj0S9nXs+swMkAZHEEEUc5nRhE78kAKbMO6hvL4ZAcoEg
 McmYiZpGiuz0pHqLYVWs4SuPubSnj5sa533MW5ZlBjv45N6aqe6H7ecO6R6ZRgAkWG3A
 sPjN4dL7AIhOWhQ1cigu+WltPW3xbc9AdDHC7+qw/3YtdOQi6ry4V8m2EM+KV5afTB06
 09Rko3Q7V9lq+9vL0Hyqw8LIzwZduw5Twp7hyQHvo+mlCl41vsOGURMVjTZ8rBjJFXTS
 QSgQ==
X-Gm-Message-State: AGi0PuYFzUFhEOxbvP5elZbfSahzRtw0TChVhF9c4QE1u0ThBkztnhle
 1WiM+zGB49lumyB7YnaJHHV8Ymb0JXv3Fo4q8YE=
X-Google-Smtp-Source: APiQypIFxPzwsLegh3B9wlN9NKkzEKuRZyCwfvXxtlYxytyYtgJdnezXq+5PqBuoZa18b3b9smxJ1CXsCTm/rN2dTRo=
X-Received: by 2002:a2e:7004:: with SMTP id l4mr12637702ljc.55.1585752552987; 
 Wed, 01 Apr 2020 07:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200401121101.GA26994@simran-Inspiron-5558>
 <d93af7ef-59d3-ceda-6847-1f5c92eaea2b@redhat.com>
In-Reply-To: <d93af7ef-59d3-ceda-6847-1f5c92eaea2b@redhat.com>
From: Simran Singhal <singhalsimran0@gmail.com>
Date: Wed, 1 Apr 2020 20:19:01 +0530
Message-ID: <CALrZqyNpvKeH6E2KCLQoCt1H1qphktWuX8i-cwoMOH6_g0Qu4g@mail.gmail.com>
Subject: Re: [PATCH] Compress lines for immediate return
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009f614a05a23bc94e"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009f614a05a23bc94e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Philippe

On Wed, Apr 1, 2020 at 7:26 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>
wrote:

> Hi Simran,
>
> On 4/1/20 2:11 PM, Simran Singhal wrote:
> > Compress two lines into a single line if immediate return statement is
> found.
>
> How did you find these changes? Manual audit, some tool?
>

I wrote coccinelle script to do these changes.


> >
> > It also remove variables progress, val, data, ret and sock
> > as they are no longer needed.
> >
> > Remove space between function "mixer_load" and '(' to fix the
> > checkpatch.pl error:-
> > ERROR: space prohibited between function name and open parenthesis '('
> >
> > Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
> > ---
> >   block/file-posix.c      | 3 +--
> >   block/nfs.c             | 3 +--
> >   block/nvme.c            | 4 +---
> >   block/vhdx.c            | 3 +--
> >   hw/audio/ac97.c         | 4 +---
> >   hw/audio/adlib.c        | 5 +----
> >   hw/display/cirrus_vga.c | 4 +---
> >   migration/ram.c         | 4 +---
> >   ui/gtk.c                | 3 +--
> >   util/qemu-sockets.c     | 5 +----
> >   10 files changed, 10 insertions(+), 28 deletions(-)
> >
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index 7e19bbff5f..dc01f0d4d3 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -1627,8 +1627,7 @@ static int handle_aiocb_write_zeroes_unmap(void
> *opaque)
> >
> >       /* If we couldn't manage to unmap while guaranteed that the area
> reads as
> >        * all-zero afterwards, just write zeroes without unmapping */
> > -    ret =3D handle_aiocb_write_zeroes(aiocb);
> > -    return ret;
> > +    return handle_aiocb_write_zeroes(aiocb);
> >   }
> >
> >   #ifndef HAVE_COPY_FILE_RANGE
> > diff --git a/block/nfs.c b/block/nfs.c
> > index cc2413d5ab..100f15bd1f 100644
> > --- a/block/nfs.c
> > +++ b/block/nfs.c
> > @@ -623,8 +623,7 @@ static int nfs_file_open(BlockDriverState *bs, QDic=
t
> *options, int flags,
> >       }
> >
> >       bs->total_sectors =3D ret;
> > -    ret =3D 0;
> > -    return ret;
> > +    return 0;
> >   }
> >
> >   static QemuOptsList nfs_create_opts =3D {
> > diff --git a/block/nvme.c b/block/nvme.c
> > index 7b7c0cc5d6..eb2f54dd9d 100644
> > --- a/block/nvme.c
> > +++ b/block/nvme.c
> > @@ -575,11 +575,9 @@ static bool nvme_poll_cb(void *opaque)
> >   {
> >       EventNotifier *e =3D opaque;
> >       BDRVNVMeState *s =3D container_of(e, BDRVNVMeState, irq_notifier)=
;
> > -    bool progress =3D false;
> >
> >       trace_nvme_poll_cb(s);
> > -    progress =3D nvme_poll_queues(s);
> > -    return progress;
> > +    return nvme_poll_queues(s);
> >   }
> >
> >   static int nvme_init(BlockDriverState *bs, const char *device, int
> namespace,
> > diff --git a/block/vhdx.c b/block/vhdx.c
> > index 33e57cd656..2c0e7ee44d 100644
> > --- a/block/vhdx.c
> > +++ b/block/vhdx.c
> > @@ -411,8 +411,7 @@ int vhdx_update_headers(BlockDriverState *bs,
> BDRVVHDXState *s,
> >       if (ret < 0) {
> >           return ret;
> >       }
> > -    ret =3D vhdx_update_header(bs, s, generate_data_write_guid, log_gu=
id);
> > -    return ret;
> > +    return vhdx_update_header(bs, s, generate_data_write_guid,
> log_guid);
> >   }
> >
> >   /* opens the specified header block from the VHDX file header section
> */
> > diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
> > index 1ec87feec0..8a9b9924c4 100644
> > --- a/hw/audio/ac97.c
> > +++ b/hw/audio/ac97.c
> > @@ -573,11 +573,9 @@ static uint32_t nam_readb (void *opaque, uint32_t
> addr)
> >   static uint32_t nam_readw (void *opaque, uint32_t addr)
> >   {
> >       AC97LinkState *s =3D opaque;
> > -    uint32_t val =3D ~0U;
> >       uint32_t index =3D addr;
>
> Why remove 'val' and keep 'index'?
>

I focused on doing one type of change in this patch. I removed 'val'
because that variable was no longer useful with these changes.


> >       s->cas =3D 0;
> > -    val =3D mixer_load (s, index);
> > -    return val;
> > +    return mixer_load(s, index);
> >   }
> >
> >   static uint32_t nam_readl (void *opaque, uint32_t addr)
> > diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
> > index d6c1fb0586..7c3b67dcfb 100644
> > --- a/hw/audio/adlib.c
> > +++ b/hw/audio/adlib.c
> > @@ -120,13 +120,10 @@ static void adlib_write(void *opaque, uint32_t
> nport, uint32_t val)
> >   static uint32_t adlib_read(void *opaque, uint32_t nport)
> >   {
> >       AdlibState *s =3D opaque;
> > -    uint8_t data;
> >       int a =3D nport & 3;
>
> Why remove 'data' and keep 'a'?
>

I focused on doing one type of change in this patch. I removed 'data'
because that variable was no longer useful with these changes.

>
> >
> >       adlib_kill_timers (s);
> > -    data =3D OPLRead (s->opl, a);
> > -
> > -    return data;
> > +    return OPLRead (s->opl, a);
> >   }
> >
> >   static void timer_handler (void *opaque, int c, double interval_Sec)
> > diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> > index 0d391e1300..1f29731ffe 100644
> > --- a/hw/display/cirrus_vga.c
> > +++ b/hw/display/cirrus_vga.c
> > @@ -2411,12 +2411,10 @@ static uint64_t cirrus_linear_bitblt_read(void
> *opaque,
> >                                             unsigned size)
> >   {
> >       CirrusVGAState *s =3D opaque;
> > -    uint32_t ret;
>
> Why remove 'ret' and keep 's'?
>

I focused on doing one type of change in this patch. I removed 'ret'
because that variable was no longer useful with these changes.


>
> >
> >       /* XXX handle bitblt */
> >       (void)s;
> > -    ret =3D 0xff;
> > -    return ret;
> > +    return 0xff;
> >   }
> >
> >   static void cirrus_linear_bitblt_write(void *opaque,
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 04f13feb2e..06cba88632 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -2135,9 +2135,7 @@ int
> ram_postcopy_send_discard_bitmap(MigrationState *ms)
> >       }
> >       trace_ram_postcopy_send_discard_bitmap();
> >
> > -    ret =3D postcopy_each_ram_send_discard(ms);
> > -
> > -    return ret;
> > +    return postcopy_each_ram_send_discard(ms);
> >   }
> >
> >   /**
> > diff --git a/ui/gtk.c b/ui/gtk.c
> > index 030b251c61..83f2f5d49b 100644
> > --- a/ui/gtk.c
> > +++ b/ui/gtk.c
> > @@ -1650,8 +1650,7 @@ static GSList *gd_vc_menu_init(GtkDisplayState *s=
,
> VirtualConsole *vc,
> >                        G_CALLBACK(gd_menu_switch_vc), s);
> >       gtk_menu_shell_append(GTK_MENU_SHELL(view_menu), vc->menu_item);
> >
> > -    group =3D
> gtk_radio_menu_item_get_group(GTK_RADIO_MENU_ITEM(vc->menu_item));
> > -    return group;
> > +    return
> gtk_radio_menu_item_get_group(GTK_RADIO_MENU_ITEM(vc->menu_item));
> >   }
> >
> >   #if defined(CONFIG_VTE)
> > diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> > index bcc06d0e01..86c48b9fa5 100644
> > --- a/util/qemu-sockets.c
> > +++ b/util/qemu-sockets.c
> > @@ -765,15 +765,12 @@ static int vsock_connect_addr(const struct
> sockaddr_vm *svm, Error **errp)
> >   static int vsock_connect_saddr(VsockSocketAddress *vaddr, Error **err=
p)
> >   {
> >       struct sockaddr_vm svm;
> > -    int sock =3D -1;
> >
> >       if (!vsock_parse_vaddr_to_sockaddr(vaddr, &svm, errp)) {
> >           return -1;
> >       }
> >
> > -    sock =3D vsock_connect_addr(&svm, errp);
> > -
> > -    return sock;
> > +    return vsock_connect_addr(&svm, errp);
> >   }
> >
> >   static int vsock_listen_saddr(VsockSocketAddress *vaddr,
> >
>
>

--0000000000009f614a05a23bc94e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Philippe<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 1, 2020 at 7:26 PM Phil=
ippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"=
_blank">philmd@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Hi Simran,<br>
<br>
On 4/1/20 2:11 PM, Simran Singhal wrote:<br>
&gt; Compress two lines into a single line if immediate return statement is=
 found.<br>
<br>
How did you find these changes? Manual audit, some tool?<br></blockquote><d=
iv><br></div><div>I wrote coccinelle script to do these changes.</div><div>=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; It also remove variables progress, val, data, ret and sock<br>
&gt; as they are no longer needed.<br>
&gt; <br>
&gt; Remove space between function &quot;mixer_load&quot; and &#39;(&#39; t=
o fix the<br>
&gt; <a href=3D"http://checkpatch.pl" rel=3D"noreferrer" target=3D"_blank">=
checkpatch.pl</a> error:-<br>
&gt; ERROR: space prohibited between function name and open parenthesis &#3=
9;(&#39;<br>
&gt; <br>
&gt; Signed-off-by: Simran Singhal &lt;<a href=3D"mailto:singhalsimran0@gma=
il.com" target=3D"_blank">singhalsimran0@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0block/file-posix.c=C2=A0 =C2=A0 =C2=A0 | 3 +--<br>
&gt;=C2=A0 =C2=A0block/nfs.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 3 +--<br>
&gt;=C2=A0 =C2=A0block/nvme.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4 =
+---<br>
&gt;=C2=A0 =C2=A0block/vhdx.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 3 =
+--<br>
&gt;=C2=A0 =C2=A0hw/audio/ac97.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 +---<=
br>
&gt;=C2=A0 =C2=A0hw/audio/adlib.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 5 +----<br>
&gt;=C2=A0 =C2=A0hw/display/cirrus_vga.c | 4 +---<br>
&gt;=C2=A0 =C2=A0migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 +---<=
br>
&gt;=C2=A0 =C2=A0ui/gtk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 3 +--<br>
&gt;=C2=A0 =C2=A0util/qemu-sockets.c=C2=A0 =C2=A0 =C2=A0| 5 +----<br>
&gt;=C2=A0 =C2=A010 files changed, 10 insertions(+), 28 deletions(-)<br>
&gt; <br>
&gt; diff --git a/block/file-posix.c b/block/file-posix.c<br>
&gt; index 7e19bbff5f..dc01f0d4d3 100644<br>
&gt; --- a/block/file-posix.c<br>
&gt; +++ b/block/file-posix.c<br>
&gt; @@ -1627,8 +1627,7 @@ static int handle_aiocb_write_zeroes_unmap(void =
*opaque)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* If we couldn&#39;t manage to unmap while =
guaranteed that the area reads as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * all-zero afterwards, just write zeroes wi=
thout unmapping */<br>
&gt; -=C2=A0 =C2=A0 ret =3D handle_aiocb_write_zeroes(aiocb);<br>
&gt; -=C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 return handle_aiocb_write_zeroes(aiocb);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#ifndef HAVE_COPY_FILE_RANGE<br>
&gt; diff --git a/block/nfs.c b/block/nfs.c<br>
&gt; index cc2413d5ab..100f15bd1f 100644<br>
&gt; --- a/block/nfs.c<br>
&gt; +++ b/block/nfs.c<br>
&gt; @@ -623,8 +623,7 @@ static int nfs_file_open(BlockDriverState *bs, QDi=
ct *options, int flags,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bs-&gt;total_sectors =3D ret;<br>
&gt; -=C2=A0 =C2=A0 ret =3D 0;<br>
&gt; -=C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static QemuOptsList nfs_create_opts =3D {<br>
&gt; diff --git a/block/nvme.c b/block/nvme.c<br>
&gt; index 7b7c0cc5d6..eb2f54dd9d 100644<br>
&gt; --- a/block/nvme.c<br>
&gt; +++ b/block/nvme.c<br>
&gt; @@ -575,11 +575,9 @@ static bool nvme_poll_cb(void *opaque)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0EventNotifier *e =3D opaque;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0BDRVNVMeState *s =3D container_of(e, BDRVNVM=
eState, irq_notifier);<br>
&gt; -=C2=A0 =C2=A0 bool progress =3D false;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_nvme_poll_cb(s);<br>
&gt; -=C2=A0 =C2=A0 progress =3D nvme_poll_queues(s);<br>
&gt; -=C2=A0 =C2=A0 return progress;<br>
&gt; +=C2=A0 =C2=A0 return nvme_poll_queues(s);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static int nvme_init(BlockDriverState *bs, const char *dev=
ice, int namespace,<br>
&gt; diff --git a/block/vhdx.c b/block/vhdx.c<br>
&gt; index 33e57cd656..2c0e7ee44d 100644<br>
&gt; --- a/block/vhdx.c<br>
&gt; +++ b/block/vhdx.c<br>
&gt; @@ -411,8 +411,7 @@ int vhdx_update_headers(BlockDriverState *bs, BDRV=
VHDXState *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 ret =3D vhdx_update_header(bs, s, generate_data_write_g=
uid, log_guid);<br>
&gt; -=C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 return vhdx_update_header(bs, s, generate_data_write_gu=
id, log_guid);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/* opens the specified header block from the VHDX file hea=
der section */<br>
&gt; diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c<br>
&gt; index 1ec87feec0..8a9b9924c4 100644<br>
&gt; --- a/hw/audio/ac97.c<br>
&gt; +++ b/hw/audio/ac97.c<br>
&gt; @@ -573,11 +573,9 @@ static uint32_t nam_readb (void *opaque, uint32_t=
 addr)<br>
&gt;=C2=A0 =C2=A0static uint32_t nam_readw (void *opaque, uint32_t addr)<br=
>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AC97LinkState *s =3D opaque;<br>
&gt; -=C2=A0 =C2=A0 uint32_t val =3D ~0U;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t index =3D addr;<br>
<br>
Why remove &#39;val&#39; and keep &#39;index&#39;?<br></blockquote><div><br=
></div><div>I focused on doing one type of change in this patch. I removed =
&#39;val&#39; because that variable was no longer useful with these changes=
.<br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;cas =3D 0;<br>
&gt; -=C2=A0 =C2=A0 val =3D mixer_load (s, index);<br>
&gt; -=C2=A0 =C2=A0 return val;<br>
&gt; +=C2=A0 =C2=A0 return mixer_load(s, index);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static uint32_t nam_readl (void *opaque, uint32_t addr)<br=
>
&gt; diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c<br>
&gt; index d6c1fb0586..7c3b67dcfb 100644<br>
&gt; --- a/hw/audio/adlib.c<br>
&gt; +++ b/hw/audio/adlib.c<br>
&gt; @@ -120,13 +120,10 @@ static void adlib_write(void *opaque, uint32_t n=
port, uint32_t val)<br>
&gt;=C2=A0 =C2=A0static uint32_t adlib_read(void *opaque, uint32_t nport)<b=
r>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AdlibState *s =3D opaque;<br>
&gt; -=C2=A0 =C2=A0 uint8_t data;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int a =3D nport &amp; 3;<br>
<br>
Why remove &#39;data&#39; and keep &#39;a&#39;?<br></blockquote><div>=C2=A0=
</div><div>I focused on doing one type of change in this patch. I removed &=
#39;data&#39; because that variable was no longer useful with these changes=
. <br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0adlib_kill_timers (s);<br>
&gt; -=C2=A0 =C2=A0 data =3D OPLRead (s-&gt;opl, a);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 return data;<br>
&gt; +=C2=A0 =C2=A0 return OPLRead (s-&gt;opl, a);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void timer_handler (void *opaque, int c, double int=
erval_Sec)<br>
&gt; diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c<br>
&gt; index 0d391e1300..1f29731ffe 100644<br>
&gt; --- a/hw/display/cirrus_vga.c<br>
&gt; +++ b/hw/display/cirrus_vga.c<br>
&gt; @@ -2411,12 +2411,10 @@ static uint64_t cirrus_linear_bitblt_read(void=
 *opaque,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0unsigned size)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CirrusVGAState *s =3D opaque;<br>
&gt; -=C2=A0 =C2=A0 uint32_t ret;<br>
<br>
Why remove &#39;ret&#39; and keep &#39;s&#39;?<br></blockquote><div><br></d=
iv><div>I focused on doing one type of change in this patch. I removed &#39=
;ret&#39; because that variable was no longer useful with these changes.</d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* XXX handle bitblt */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(void)s;<br>
&gt; -=C2=A0 =C2=A0 ret =3D 0xff;<br>
&gt; -=C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 return 0xff;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void cirrus_linear_bitblt_write(void *opaque,<br>
&gt; diff --git a/migration/ram.c b/migration/ram.c<br>
&gt; index 04f13feb2e..06cba88632 100644<br>
&gt; --- a/migration/ram.c<br>
&gt; +++ b/migration/ram.c<br>
&gt; @@ -2135,9 +2135,7 @@ int ram_postcopy_send_discard_bitmap(MigrationSt=
ate *ms)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_ram_postcopy_send_discard_bitmap();<br=
>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 ret =3D postcopy_each_ram_send_discard(ms);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 return postcopy_each_ram_send_discard(ms);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/**<br>
&gt; diff --git a/ui/gtk.c b/ui/gtk.c<br>
&gt; index 030b251c61..83f2f5d49b 100644<br>
&gt; --- a/ui/gtk.c<br>
&gt; +++ b/ui/gtk.c<br>
&gt; @@ -1650,8 +1650,7 @@ static GSList *gd_vc_menu_init(GtkDisplayState *=
s, VirtualConsole *vc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 G_CALLBACK(gd_menu_switch_vc), s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0gtk_menu_shell_append(GTK_MENU_SHELL(view_me=
nu), vc-&gt;menu_item);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 group =3D gtk_radio_menu_item_get_group(GTK_RADIO_MENU_=
ITEM(vc-&gt;menu_item));<br>
&gt; -=C2=A0 =C2=A0 return group;<br>
&gt; +=C2=A0 =C2=A0 return gtk_radio_menu_item_get_group(GTK_RADIO_MENU_ITE=
M(vc-&gt;menu_item));<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#if defined(CONFIG_VTE)<br>
&gt; diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c<br>
&gt; index bcc06d0e01..86c48b9fa5 100644<br>
&gt; --- a/util/qemu-sockets.c<br>
&gt; +++ b/util/qemu-sockets.c<br>
&gt; @@ -765,15 +765,12 @@ static int vsock_connect_addr(const struct socka=
ddr_vm *svm, Error **errp)<br>
&gt;=C2=A0 =C2=A0static int vsock_connect_saddr(VsockSocketAddress *vaddr, =
Error **errp)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sockaddr_vm svm;<br>
&gt; -=C2=A0 =C2=A0 int sock =3D -1;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vsock_parse_vaddr_to_sockaddr(vaddr, &a=
mp;svm, errp)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 sock =3D vsock_connect_addr(&amp;svm, errp);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 return sock;<br>
&gt; +=C2=A0 =C2=A0 return vsock_connect_addr(&amp;svm, errp);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static int vsock_listen_saddr(VsockSocketAddress *vaddr,<b=
r>
&gt; <br>
<br>
</blockquote></div></div>

--0000000000009f614a05a23bc94e--

