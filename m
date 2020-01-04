Return-Path: <SRS0=YGca=2Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65ECC2D0C2
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 16:08:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69BB522B48
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 16:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihjY2Lun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BB522B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inly3-0005y4-I5
	for qemu-devel@archiver.kernel.org; Sat, 04 Jan 2020 11:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1inlx4-0005X5-6p
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 11:07:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1inlx2-00041J-5p
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 11:06:58 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:45932)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1inlx1-0003qQ-Mv
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 11:06:56 -0500
Received: by mail-lf1-x141.google.com with SMTP id 203so33706209lfa.12
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2020 08:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7juJ6rZsgkjfs81ZCuChXzAC1xQUNM28ZPfu4d9Z0w0=;
 b=ihjY2LunROYUxl3GpSibcvuAMAsUD9TzSlxqaILvZIIpwQvoOeSZB5ln1ZUGVm5UQ+
 H8OatxLnp561Akhn8GylX8WtCvjBvNJjFqeUF7LFZ4t5+/7NL+DJtHF2sfJOgDsevEXr
 a4cNSU8V9eLeG+1fxUTAVEoPJFKDquyzJPSisoD5QQFmrobpX7aQU3W24H6tidK4croF
 GC2go3FxxQF2tGPx13vFbnDSVKdRJK57v7yV9vgXYf6Tgo7B3WOvhYTvjJqaUjfttiYq
 ezlS95X18E/man15VCyiJnCy2m1hPuBLrG5k4hJhyEU8UpU2RLGdlmoZrir9EoXei6+3
 4mSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7juJ6rZsgkjfs81ZCuChXzAC1xQUNM28ZPfu4d9Z0w0=;
 b=PM9ERHRfmoHkzd3p95Cii4h9CwD3fD0S7KxCAuT/QFbL/lSAqIfq8+BQvmamYBhryr
 1VYm6SYiWl3M0259ekiq77j5e+MAYzM3pcl2P7f7gDv7ydsSkGToULK3eGaQKAjK6qoa
 bsazXl0rZaRKt0pdYPqbJXAI3cxqlrW0KYi4L6GPUYoVf2XLlxpDvWhfxHECQ5IdIzPF
 1LKKbGVRWZZGtJbX7j+3FCMNTDRzKmGL5E1dtWGNTzZ9nMLp2gfS7kZGQopOCQ6UUmFr
 2L0lEnSTViVtgZM0OTan5MsvstKDZwVcxYHzxIdti5JPoNvBG+tnK9rrzyqLErAx1qMv
 XQ8Q==
X-Gm-Message-State: APjAAAUMqbSipnps8KygHdqgRPYFcfmbLkdjCk+HJUYxhCIicg5ARLm0
 AdVVKrzejiBfFH5B0GQqzaATi3OZJGi48vLNi1w=
X-Google-Smtp-Source: APXvYqzEDXRQui62dp/tR9B92H5A4vpq3e2IrXy7r0GRCK8dmKjQDFRxZd9hAqganPspdpvTCbQp2m1iG5u4cE3hIUE=
X-Received: by 2002:ac2:4884:: with SMTP id x4mr51165421lfc.92.1578154013815; 
 Sat, 04 Jan 2020 08:06:53 -0800 (PST)
MIME-Version: 1.0
References: <CAJAkqrWm28qXtsFmaENAcsDNQV7gE=sd+YyA5ADmm2Vo9DKrUQ@mail.gmail.com>
 <20191219143141.GF1624084@stefanha-x1.localdomain>
In-Reply-To: <20191219143141.GF1624084@stefanha-x1.localdomain>
From: Coiby Xu <coiby.xu@gmail.com>
Date: Sun, 5 Jan 2020 00:06:17 +0800
Message-ID: <CAJAkqrXKnwPhQMAT6dhvxDgs+7t3o89QSBPPDeP8AxQmwMi2Xw@mail.gmail.com>
Subject: Re: [RFC] Implementing vhost-user-blk device backend
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000064f92a059b529d24"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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
Cc: Kevin Wolf <kwolf@redhat.com>, Bharat Singh <bharatlkmlkvm@gmail.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000064f92a059b529d24
Content-Type: text/plain; charset="UTF-8"

Hi Stefan,

Thank you for reviewing my work! All the improvements have been
applied except for a small issue regarding object_add.

>  (qemu) object_add vhost-user-server,id=ID,chardev=CHARDEV,writable=on|off

Currently I implement object_add feature in the following syntax which use
unix_socket directly instead of chardev,

  (qemu) object_add
vhost-user-server,id=id=disk,unix_socket=/tmp/vhost-user-blk_vhost.socket,name=disk,writable=off

I know in QEMU we can create a socket server using chardev-add,
  (qemu) chardev-add socket,id=char1,path=/tmp/vhost-user-blk_vhost.socket

But it seems it's a bit cumbersome to utilize chardev. Take QMP over socket
as an example,

  $ x86_64-softmmu/qemu-system-x86_64 -drive
file=dpdk.img,format=raw,if=none,id=disk -device
ide-hd,drive=disk,bootindex=0 -m 128 -enable-kvm -chardev
socket,id=mon1,path=/tmp/mon.sock,server,nowait -mon
chardev=mon1,mode=control,pretty=on

It doesn't support multiple concurrent client connections because of the
limitation of chardev/char-socket.c.

On Thu, Dec 19, 2019 at 10:31 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Mon, Nov 18, 2019 at 10:27:28PM +0800, Coiby Xu wrote:
> > Hi all,
> >
> > This is an implementation of vhost-user-blk device backend by
> > following
> https://wiki.qemu.org/Google_Summer_of_Code_2019#vhost-user-blk_device_backend
> .
> > raw/qcow2 disk images can now be shared via vhost user protocol. In
> > this way, it could provide better performance than QEMU's existing NBD
> > support.
>
> Thank you for working on this feature!
>
> > +static size_t vub_iov_to_buf(const struct iovec *iov,
> > +                             const unsigned int iov_cnt, void *buf)
>
> Please take a look at utils/iov.c.  iov_to_buf_full() can be used
> instead of defining this function.
>
> > +{
> > +    size_t len;
> > +    unsigned int i;
> > +
> > +    len = 0;
> > +    for (i = 0; i < iov_cnt; i++) {
> > +        memcpy(buf + len,  iov[i].iov_base, iov[i].iov_len);
> > +        len += iov[i].iov_len;
> > +    }
> > +    return len;
> > +}
> > +
> > +static  VubDev *vub_device;
>
> If you switch to -object (see below) then this global pointer will go
> away so I won't comment on it throughout this patch.
>
> > +static void vub_accept(QIONetListener *listener, QIOChannelSocket *sioc,
> > +                       gpointer opaque)
> > +{
> > +    /* only one connection */
> > +    if (vub_device->sioc) {
> > +        return;
> > +    }
> > +
> > +    vub_device->sioc = sioc;
> > +    vub_device->listener = listener;
> > +    /*
> > +     * increase the object reference, so cioc will not freeed by
> > +     * qio_net_listener_channel_func which will call
> object_unref(OBJECT(sioc))
> > +     */
> > +    object_ref(OBJECT(sioc));
> > +
> > +    qio_channel_set_name(QIO_CHANNEL(sioc), "vhost-server");
> > +    if (!vug_init(&vub_device->parent, VHOST_USER_BLK_MAX_QUEUES,
> sioc->fd,
> > +                  vub_panic_cb, &vub_iface)) {
> > +        fprintf(stderr, "Failed to initialized libvhost-user-glib\n");
> > +    }
>
> vug_init() uses the default GMainContext, which is bad for performance
> when there are many devices because it cannot take advantage of
> multi-core CPUs.  vhost-user-server should support IOThread so that
> devices can be run in dedicated threads.
>
> The nbd/server.c:NBDExport->ctx field serves this purpose in the NBD
> server.  It's a little trickier with libvhost-user-glib because the API
> currently doesn't allow passing in a GMainContext and will need to be
> extended.
>
> > diff --git a/hmp-commands.hx b/hmp-commands.hx
> > index cfcc044ce4..d8de179747 100644
> > --- a/hmp-commands.hx
> > +++ b/hmp-commands.hx
> > @@ -1614,6 +1614,33 @@ STEXI
> >  @findex acl_reset
> >  Remove all matches from the access control list, and set the default
> >  policy back to @code{deny}.
> > +ETEXI
> > +
> > +    {
> > +        .name       = "vhost_user_server_stop",
> > +        .args_type  = "",
> > +        .params     = "vhost_user_server_stop",
> > +        .help       = "stop vhost-user-blk device backend",
> > +        .cmd        = hmp_vhost_user_server_stop,
> > +    },
> > +STEXI
> > +@item vhost_user_server_stop
> > +@findex vhost_user_server_stop
> > +Stop the QEMU embedded vhost-user-blk device backend server.
> > +ETEXI
>
> The NBD server supports multiple client connections and exports
> (drives).  A vhost-user socket only supports one connection and one
> device.  I think it will be necessary to assign a unique identifier to
> every vhost-user server.
>
> By the way, I think the server should be a UserCreatable Object so the
> following syntax works:
>
>   $ qemu -object vhost-user-server,id=ID,chardev=CHARDEV,writable=on|off
>
> And existing HMP/QMP commands can be used:
>
>   (qemu) object_add vhost-user-server,id=ID,chardev=CHARDEV,writable=on|off
>   (qemu) object_del ID
>
> This way we don't need to define new HMP/QMP/command-line syntax for
> vhost-user-server.
>
> If you grep for UserCreatable you'll find examples like "iothread",
> "secret", "throttle-group", etc.
>


-- 
*Best regards,*
*Coiby*

--00000000000064f92a059b529d24
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Stefan,<div><br></div><div>Thank you for reviewing my w=
ork! All the improvements have been applied=C2=A0except for a small issue=
=C2=A0regarding object_add.</div><div><br></div><div>&gt;=C2=A0 (qemu) obje=
ct_add vhost-user-server,id=3DID,chardev=3DCHARDEV,writable=3Don|off<br></d=
iv><div><br></div><div>Currently I implement=C2=A0object_add feature in the=
 following syntax which use unix_socket directly instead of chardev,</div><=
div><br></div><div>=C2=A0 (qemu) object_add vhost-user-server,id=3Did=3Ddis=
k,unix_socket=3D/tmp/vhost-user-blk_vhost.socket,name=3Ddisk,writable=3Doff=
<br></div><div><br></div><div>I know in QEMU we can create a socket server =
using chardev-add,</div><div>=C2=A0 (qemu) chardev-add socket,id=3Dchar1,pa=
th=3D/tmp/vhost-user-blk_vhost.socket</div><div><br></div><div>But it seems=
 it&#39;s a bit cumbersome to utilize chardev. Take QMP over socket as an e=
xample,=C2=A0</div><div><br></div><div>=C2=A0 $=C2=A0x86_64-softmmu/qemu-sy=
stem-x86_64 -drive file=3Ddpdk.img,format=3Draw,if=3Dnone,id=3Ddisk -device=
 ide-hd,drive=3Ddisk,bootindex=3D0 -m 128 -enable-kvm -chardev socket,id=3D=
mon1,path=3D/tmp/mon.sock,server,nowait -mon chardev=3Dmon1,mode=3Dcontrol,=
pretty=3Don</div><div><br></div><div>It doesn&#39;t support multiple concur=
rent client connections because of the limitation of chardev/char-socket.c.=
=C2=A0</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Thu, Dec 19, 2019 at 10:31 PM Stefan Hajnoczi &lt;<a href=3D=
"mailto:stefanha@gmail.com" target=3D"_blank">stefanha@gmail.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Nov=
 18, 2019 at 10:27:28PM +0800, Coiby Xu wrote:<br>
&gt; Hi all,<br>
&gt; <br>
&gt; This is an implementation of vhost-user-blk device backend by<br>
&gt; following <a href=3D"https://wiki.qemu.org/Google_Summer_of_Code_2019#=
vhost-user-blk_device_backend" rel=3D"noreferrer" target=3D"_blank">https:/=
/wiki.qemu.org/Google_Summer_of_Code_2019#vhost-user-blk_device_backend</a>=
.<br>
&gt; raw/qcow2 disk images can now be shared via vhost user protocol. In<br=
>
&gt; this way, it could provide better performance than QEMU&#39;s existing=
 NBD<br>
&gt; support.<br>
<br>
Thank you for working on this feature!<br>
<br>
&gt; +static size_t vub_iov_to_buf(const struct iovec *iov,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const unsigned int iov_cnt, void *buf)<b=
r>
<br>
Please take a look at utils/iov.c.=C2=A0 iov_to_buf_full() can be used<br>
instead of defining this function.<br>
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 size_t len;<br>
&gt; +=C2=A0 =C2=A0 unsigned int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 len =3D 0;<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; iov_cnt; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(buf + len,=C2=A0 iov[i].iov_base, =
iov[i].iov_len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D iov[i].iov_len;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return len;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static=C2=A0 VubDev *vub_device;<br>
<br>
If you switch to -object (see below) then this global pointer will go<br>
away so I won&#39;t comment on it throughout this patch.<br>
<br>
&gt; +static void vub_accept(QIONetListener *listener, QIOChannelSocket *si=
oc,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0gpointer opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* only one connection */<br>
&gt; +=C2=A0 =C2=A0 if (vub_device-&gt;sioc) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vub_device-&gt;sioc =3D sioc;<br>
&gt; +=C2=A0 =C2=A0 vub_device-&gt;listener =3D listener;<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* increase the object reference, so cioc will not=
 freeed by<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* qio_net_listener_channel_func which will call o=
bject_unref(OBJECT(sioc))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 object_ref(OBJECT(sioc));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qio_channel_set_name(QIO_CHANNEL(sioc), &quot;vhost-ser=
ver&quot;);<br>
&gt; +=C2=A0 =C2=A0 if (!vug_init(&amp;vub_device-&gt;parent, VHOST_USER_BL=
K_MAX_QUEUES, sioc-&gt;fd,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vub_pa=
nic_cb, &amp;vub_iface)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Failed to initializ=
ed libvhost-user-glib\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
vug_init() uses the default GMainContext, which is bad for performance<br>
when there are many devices because it cannot take advantage of<br>
multi-core CPUs.=C2=A0 vhost-user-server should support IOThread so that<br=
>
devices can be run in dedicated threads.<br>
<br>
The nbd/server.c:NBDExport-&gt;ctx field serves this purpose in the NBD<br>
server.=C2=A0 It&#39;s a little trickier with libvhost-user-glib because th=
e API<br>
currently doesn&#39;t allow passing in a GMainContext and will need to be<b=
r>
extended.<br>
<br>
&gt; diff --git a/hmp-commands.hx b/hmp-commands.hx<br>
&gt; index cfcc044ce4..d8de179747 100644<br>
&gt; --- a/hmp-commands.hx<br>
&gt; +++ b/hmp-commands.hx<br>
&gt; @@ -1614,6 +1614,33 @@ STEXI<br>
&gt;=C2=A0 @findex acl_reset<br>
&gt;=C2=A0 Remove all matches from the access control list, and set the def=
ault<br>
&gt;=C2=A0 policy back to @code{deny}.<br>
&gt; +ETEXI<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot=
;vhost_user_server_stop&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .args_type=C2=A0 =3D &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .params=C2=A0 =C2=A0 =C2=A0=3D &quot;vhos=
t_user_server_stop&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .help=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot=
;stop vhost-user-blk device backend&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cmd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D hmp_v=
host_user_server_stop,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +STEXI<br>
&gt; +@item vhost_user_server_stop<br>
&gt; +@findex vhost_user_server_stop<br>
&gt; +Stop the QEMU embedded vhost-user-blk device backend server.<br>
&gt; +ETEXI<br>
<br>
The NBD server supports multiple client connections and exports<br>
(drives).=C2=A0 A vhost-user socket only supports one connection and one<br=
>
device.=C2=A0 I think it will be necessary to assign a unique identifier to=
<br>
every vhost-user server.<br>
<br>
By the way, I think the server should be a UserCreatable Object so the<br>
following syntax works:<br>
<br>
=C2=A0 $ qemu -object vhost-user-server,id=3DID,chardev=3DCHARDEV,writable=
=3Don|off<br>
<br>
And existing HMP/QMP commands can be used:<br>
<br>
=C2=A0 (qemu) object_add vhost-user-server,id=3DID,chardev=3DCHARDEV,writab=
le=3Don|off<br>
=C2=A0 (qemu) object_del ID<br>
<br>
This way we don&#39;t need to define new HMP/QMP/command-line syntax for<br=
>
vhost-user-server.<br>
<br>
If you grep for UserCreatable you&#39;ll find examples like &quot;iothread&=
quot;,<br>
&quot;secret&quot;, &quot;throttle-group&quot;, etc.<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div><div dir=3D"ltr"><div><i>Best regards,</i></div><fon=
t color=3D"#00cccc"><i>Coiby</i></font><div><font color=3D"#00cccc"><br></f=
ont></div></div></div></div></div>

--00000000000064f92a059b529d24--

