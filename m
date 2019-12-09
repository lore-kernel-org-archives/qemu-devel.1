Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A82FC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 01:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 121E9206F4
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 01:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4Z+phSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121E9206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie8Fy-0002Hl-8H
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 20:54:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chanmickyyun@gmail.com>) id 1ie8Er-0001lA-1f
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 20:53:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chanmickyyun@gmail.com>) id 1ie8Eo-0001bA-Mr
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 20:53:28 -0500
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:38436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chanmickyyun@gmail.com>)
 id 1ie8Eo-0001aC-9L
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 20:53:26 -0500
Received: by mail-ed1-x541.google.com with SMTP id i6so10151257edr.5
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2019 17:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vhY7iu1hEKVuv8cmv2ZMOqi5t5YP2iuammgb6T1dB0c=;
 b=n4Z+phSYL919Ks3KfZ0rvcyv1sPtx2xZ5wde4Ss4XJHnkUiLPq0nejYynYiAKCqblF
 dCgzm9ZVYQUBtL35Ct6yCP6t5NTzMD5ypohYnIsMXYWAztWo2f8S+q/pYcGbNz3qngKM
 m0IzTkFfshVkssZh2xEEsp1Jdli5BIHefdDtoGJ3/2/A9+FP0SPQV5yW02mjwq7lT3pg
 UrEgaOq2H7/esGaDKY0uJjCA1t6BdbIxI60OhvbTFhz2Szvh/KZ4CrapcEA8gMqOkces
 Y/bApc5UJV9yFUpoApj7FpN30sNdXK6tAn7F9HrEO4v8XvN7uVibK6KrnZteupSpevyp
 ZW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vhY7iu1hEKVuv8cmv2ZMOqi5t5YP2iuammgb6T1dB0c=;
 b=UirkN7vC9v1vCF1XEy6eVNUUwNnc1qOS1TFPF2/V8GfaBcC3tzUStUFX6UOOI6iCHQ
 BTshhor2SKu47yQW7zo5ncyQR80F+KpC31lrXJgUUs0miXwFBN4Nl0Z3JB/8S6BSPr0u
 03YOesedBw/RolW3au4cb5SAStB+09fRDeiENQ3SCQzO3lz3pDA9ckVMyXiGflzYatR9
 iSS+jnGXVcGnRTnFtOfjiURI8iShQ4TFRMPwHsbDoJnslNtCk1j/4s9Jfk2Ry+NJL+9k
 QGxj93MS3DSO0UDXRVjqYZhLQgRJK8QWDsTE/uOAvS6Wpc0cyPlEFK+Rt4nx9AFrhyxm
 bmiA==
X-Gm-Message-State: APjAAAXiqo3oGFZ3+ghLk+QOkBe4TlBrdGAPEe3grRFM7LCoBt32eRdq
 qaNd3IH0lvs7a8kZHUqCqckRZTQrPusweY9JQIQ=
X-Google-Smtp-Source: APXvYqwD/XhqpomXWUPID/q+/KvEsJcq0qKkPXB1Jy+RLZEeRdalVR9Q2ZePcWR4Bt7wT/Sy1a73pb17TmnblqT+w2M=
X-Received: by 2002:aa7:cfcd:: with SMTP id r13mr29665913edy.121.1575856404308; 
 Sun, 08 Dec 2019 17:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20191125051722.15523-1-chanmickyyun@gmail.com>
 <CAJ+F1CL-h3KrObUyKzGBjVra9EZPZFyK-WbW7=Co1Pn9YbypWA@mail.gmail.com>
In-Reply-To: <CAJ+F1CL-h3KrObUyKzGBjVra9EZPZFyK-WbW7=Co1Pn9YbypWA@mail.gmail.com>
From: Micky C <chanmickyyun@gmail.com>
Date: Mon, 9 Dec 2019 09:53:12 +0800
Message-ID: <CAPojyfPdTDjrCT1MJNPJsL=2gLjH514P3-k9PS7r3_8LNqNu2g@mail.gmail.com>
Subject: Re: [PATCH v7] Implement backend program convention command for
 vhost-user-blk
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000032272405993ba9a9"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
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
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000032272405993ba9a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I agree, I just sent the updated version.

On Thu, Dec 5, 2019 at 9:39 PM Marc-Andr=C3=A9 Lureau <marcandre.lureau@gma=
il.com>
wrote:

> Hi
>
> On Mon, Nov 25, 2019 at 9:17 AM Micky Yun Chan(michiboo)
> <chanmickyyun@gmail.com> wrote:
> >
> > From: Micky Yun Chan <chanmickyyun@gmail.com>
> >
> > This patch is to add standard commands defined in
> docs/interop/vhost-user.rst
> > For vhost-user-* program
> >
> > Signed-off-by: Micky Yun Chan (michiboo) <chanmickyyun@gmail.com>
> > ---
> >  contrib/vhost-user-blk/vhost-user-blk.c | 108 ++++++++++++++----------
> >  docs/interop/vhost-user.json            |  31 +++++++
> >  docs/interop/vhost-user.rst             |  15 ++++
> >  3 files changed, 110 insertions(+), 44 deletions(-)
> >
> > diff --git a/contrib/vhost-user-blk/vhost-user-blk.c
> b/contrib/vhost-user-blk/vhost-user-blk.c
> > index ae61034656..6fd91c7e99 100644
> > --- a/contrib/vhost-user-blk/vhost-user-blk.c
> > +++ b/contrib/vhost-user-blk/vhost-user-blk.c
> > @@ -576,70 +576,90 @@ vub_new(char *blk_file)
> >      return vdev_blk;
> >  }
> >
> > +static int opt_fdnum =3D -1;
> > +static char *opt_socket_path;
> > +static char *opt_blk_file;
> > +static gboolean opt_print_caps;
> > +static gboolean opt_read_only;
> > +
> > +static GOptionEntry entries[] =3D {
> > +    { "print-capabilities", 'c', 0, G_OPTION_ARG_NONE, &opt_print_caps=
,
> > +      "Print capabilities", NULL },
> > +    { "fd", 'f', 0, G_OPTION_ARG_INT, &opt_fdnum,
> > +      "Use inherited fd socket", "FDNUM" },
> > +    { "socket-path", 's', 0, G_OPTION_ARG_FILENAME, &opt_socket_path,
> > +      "Use UNIX socket path", "PATH" },
> > +    {"blk-file", 'b', 0, G_OPTION_ARG_FILENAME, &opt_blk_file,
> > +     "block device or file path", "PATH"},
> > +    { "read-only", 'r', 0, G_OPTION_ARG_NONE, &opt_read_only,
> > +      "Enable read-only", NULL }
> > +};
> > +
> >  int main(int argc, char **argv)
> >  {
> > -    int opt;
> > -    char *unix_socket =3D NULL;
> > -    char *blk_file =3D NULL;
> > -    bool enable_ro =3D false;
> >      int lsock =3D -1, csock =3D -1;
> >      VubDev *vdev_blk =3D NULL;
> > +    GError *error =3D NULL;
> > +    GOptionContext *context;
> >
> > -    while ((opt =3D getopt(argc, argv, "b:rs:h")) !=3D -1) {
> > -        switch (opt) {
> > -        case 'b':
> > -            blk_file =3D g_strdup(optarg);
> > -            break;
> > -        case 's':
> > -            unix_socket =3D g_strdup(optarg);
> > -            break;
> > -        case 'r':
> > -            enable_ro =3D true;
> > -            break;
> > -        case 'h':
> > -        default:
> > -            printf("Usage: %s [ -b block device or file, -s UNIX domai=
n
> socket"
> > -                   " | -r Enable read-only ] | [ -h ]\n", argv[0]);
> > -            return 0;
> > +    context =3D g_option_context_new(NULL);
> > +    g_option_context_add_main_entries(context, entries, NULL);
> > +    if (!g_option_context_parse(context, &argc, &argv, &error)) {
> > +        g_printerr("Option parsing failed: %s\n", error->message);
> > +        exit(EXIT_FAILURE);
> > +    }
> > +    if (opt_print_caps) {
> > +        g_print("{\n");
> > +        g_print("  \"type\": \"block\",\n");
> > +        g_print("  \"features\": [\n");
> > +        g_print("    \"read-only\",\n");
> > +        g_print("    \"blk-file\"\n");
> > +        g_print("  ]\n");
> > +        g_print("}\n");
> > +        exit(EXIT_SUCCESS);
> > +    }
> > +
> > +    if (!opt_blk_file) {
> > +        g_print("%s\n", g_option_context_get_help(context, true, NULL)=
);
> > +        exit(EXIT_FAILURE);
> > +    }
> > +
> > +    if (opt_socket_path) {
> > +        lsock =3D unix_sock_new(opt_socket_path);
> > +        if (lsock < 0) {
> > +            exit(EXIT_FAILURE);
> >          }
> > +    } else if (opt_fdnum < 0) {
> > +        g_print("%s\n", g_option_context_get_help(context, true, NULL)=
);
> > +        exit(EXIT_FAILURE);
> > +    } else {
> > +        lsock =3D opt_fdnum;
> >      }
> >
> > -    if (!unix_socket || !blk_file) {
> > -        printf("Usage: %s [ -b block device or file, -s UNIX domain
> socket"
> > -               " | -r Enable read-only ] | [ -h ]\n", argv[0]);
> > -        return -1;
> > -    }
> > -
> > -    lsock =3D unix_sock_new(unix_socket);
> > -    if (lsock < 0) {
> > -        goto err;
> > -    }
> > -
> > -    csock =3D accept(lsock, (void *)0, (void *)0);
> > +    csock =3D accept(lsock, NULL, NULL);
> >      if (csock < 0) {
> > -        fprintf(stderr, "Accept error %s\n", strerror(errno));
> > -        goto err;
> > +        g_printerr("Accept error %s\n", strerror(errno));
> > +        exit(EXIT_FAILURE);
> >      }
> >
> > -    vdev_blk =3D vub_new(blk_file);
> > +    vdev_blk =3D vub_new(opt_blk_file);
> >      if (!vdev_blk) {
> > -        goto err;
> > +        exit(EXIT_FAILURE);
> >      }
> > -    if (enable_ro) {
> > +    if (opt_read_only) {
> >          vdev_blk->enable_ro =3D true;
> >      }
> >
> >      if (!vug_init(&vdev_blk->parent, VHOST_USER_BLK_MAX_QUEUES, csock,
> >                    vub_panic_cb, &vub_iface)) {
> > -        fprintf(stderr, "Failed to initialized libvhost-user-glib\n");
> > -        goto err;
> > +        g_printerr("Failed to initialize libvhost-user-glib\n");
> > +        exit(EXIT_FAILURE);
> >      }
> >
> >      g_main_loop_run(vdev_blk->loop);
> > -
> > +    g_main_loop_unref(vdev_blk->loop);
> > +    g_option_context_free(context);
> >      vug_deinit(&vdev_blk->parent);
> > -
> > -err:
> >      vub_free(vdev_blk);
> >      if (csock >=3D 0) {
> >          close(csock);
> > @@ -647,8 +667,8 @@ err:
> >      if (lsock >=3D 0) {
> >          close(lsock);
> >      }
> > -    g_free(unix_socket);
> > -    g_free(blk_file);
> > +    g_free(opt_socket_path);
> > +    g_free(opt_blk_file);
> >
> >      return 0;
> >  }
> > diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.jso=
n
> > index da6aaf51c8..ce0ef74db5 100644
> > --- a/docs/interop/vhost-user.json
> > +++ b/docs/interop/vhost-user.json
> > @@ -54,6 +54,37 @@
> >    ]
> >  }
> >
> > +##
> > +# @VHostUserBackendBlockFeature:
> > +#
> > +# List of vhost user "block" features.
> > +#
> > +# @read-only: The --read-only command line option is supported.
> > +# @blk-file: The --blk-file command line option is supported.
> > +#
> > +# Since: 5.0
> > +##
> > +{
> > +  'enum': 'VHostUserBackendBlockFeature',
> > +  'data': [ 'read-only', 'blk-file' ]
> > +}
> > +
> > +##
> > +# @VHostUserBackendCapabilitiesBlock:
> > +#
> > +# Capabilities reported by vhost user "block" backends
> > +#
> > +# @features: list of supported features.
> > +#
> > +# Since: 5.0
> > +##
> > +{
> > +  'struct': 'VHostUserBackendCapabilitiesBlock',
> > +  'data': {
> > +    'features': [ 'VHostUserBackendBlockFeature' ]
> > +  }
> > +}
> > +
> >  ##
> >  # @VHostUserBackendInputFeature:
> >  #
> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > index 7827b710aa..2f0910d515 100644
> > --- a/docs/interop/vhost-user.rst
> > +++ b/docs/interop/vhost-user.rst
> > @@ -1376,3 +1376,18 @@ Command line options:
> >    Enable virgl rendering support.
> >
> >    (optional)
> > +
> > +vhost-user-blk
> > +--------------
> > +
> > +Command line options:
> > +
> > +--blk-file=3DPATH
> > +
> > +  Specify block device or file path.
>
> Would it make sense to make it optional? Since you have a
> corresponding "blk-file" feature already, there is not much to change
> but the doc.
>
> > +
> > +--read-only
> > +
> > +  Enable read-only.
> > +
> > +  (optional)
> > --
> > 2.21.0
> >
> >
>
> Looks good to me otherwise
>
> --
> Marc-Andr=C3=A9 Lureau
>

--00000000000032272405993ba9a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I agree, I just sent the updated version.<br></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 5=
, 2019 at 9:39 PM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lu=
reau@gmail.com">marcandre.lureau@gmail.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">Hi<br>
<br>
On Mon, Nov 25, 2019 at 9:17 AM Micky Yun Chan(michiboo)<br>
&lt;<a href=3D"mailto:chanmickyyun@gmail.com" target=3D"_blank">chanmickyyu=
n@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Micky Yun Chan &lt;<a href=3D"mailto:chanmickyyun@gmail.com" tar=
get=3D"_blank">chanmickyyun@gmail.com</a>&gt;<br>
&gt;<br>
&gt; This patch is to add standard commands defined in docs/interop/vhost-u=
ser.rst<br>
&gt; For vhost-user-* program<br>
&gt;<br>
&gt; Signed-off-by: Micky Yun Chan (michiboo) &lt;<a href=3D"mailto:chanmic=
kyyun@gmail.com" target=3D"_blank">chanmickyyun@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 contrib/vhost-user-blk/vhost-user-blk.c | 108 ++++++++++++++----=
------<br>
&gt;=C2=A0 docs/interop/vhost-user.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 31 +++++++<br>
&gt;=C2=A0 docs/interop/vhost-user.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 15 ++++<br>
&gt;=C2=A0 3 files changed, 110 insertions(+), 44 deletions(-)<br>
&gt;<br>
&gt; diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-u=
ser-blk/vhost-user-blk.c<br>
&gt; index ae61034656..6fd91c7e99 100644<br>
&gt; --- a/contrib/vhost-user-blk/vhost-user-blk.c<br>
&gt; +++ b/contrib/vhost-user-blk/vhost-user-blk.c<br>
&gt; @@ -576,70 +576,90 @@ vub_new(char *blk_file)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return vdev_blk;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +static int opt_fdnum =3D -1;<br>
&gt; +static char *opt_socket_path;<br>
&gt; +static char *opt_blk_file;<br>
&gt; +static gboolean opt_print_caps;<br>
&gt; +static gboolean opt_read_only;<br>
&gt; +<br>
&gt; +static GOptionEntry entries[] =3D {<br>
&gt; +=C2=A0 =C2=A0 { &quot;print-capabilities&quot;, &#39;c&#39;, 0, G_OPT=
ION_ARG_NONE, &amp;opt_print_caps,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &quot;Print capabilities&quot;, NULL },<br>
&gt; +=C2=A0 =C2=A0 { &quot;fd&quot;, &#39;f&#39;, 0, G_OPTION_ARG_INT, &am=
p;opt_fdnum,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &quot;Use inherited fd socket&quot;, &quot;FDNUM=
&quot; },<br>
&gt; +=C2=A0 =C2=A0 { &quot;socket-path&quot;, &#39;s&#39;, 0, G_OPTION_ARG=
_FILENAME, &amp;opt_socket_path,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &quot;Use UNIX socket path&quot;, &quot;PATH&quo=
t; },<br>
&gt; +=C2=A0 =C2=A0 {&quot;blk-file&quot;, &#39;b&#39;, 0, G_OPTION_ARG_FIL=
ENAME, &amp;opt_blk_file,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;block device or file path&quot;, &quot;PATH=
&quot;},<br>
&gt; +=C2=A0 =C2=A0 { &quot;read-only&quot;, &#39;r&#39;, 0, G_OPTION_ARG_N=
ONE, &amp;opt_read_only,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &quot;Enable read-only&quot;, NULL }<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 int main(int argc, char **argv)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 int opt;<br>
&gt; -=C2=A0 =C2=A0 char *unix_socket =3D NULL;<br>
&gt; -=C2=A0 =C2=A0 char *blk_file =3D NULL;<br>
&gt; -=C2=A0 =C2=A0 bool enable_ro =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int lsock =3D -1, csock =3D -1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VubDev *vdev_blk =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 GError *error =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 GOptionContext *context;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 while ((opt =3D getopt(argc, argv, &quot;b:rs:h&quot;))=
 !=3D -1) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (opt) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;b&#39;:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blk_file =3D g_strdup(optar=
g);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;s&#39;:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unix_socket =3D g_strdup(op=
targ);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;r&#39;:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable_ro =3D true;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;h&#39;:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;Usage: %s [ -b=
 block device or file, -s UNIX domain socket&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&quot; | -r Enable read-only ] | [ -h ]\n&quot;, argv[0]);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 context =3D g_option_context_new(NULL);<br>
&gt; +=C2=A0 =C2=A0 g_option_context_add_main_entries(context, entries, NUL=
L);<br>
&gt; +=C2=A0 =C2=A0 if (!g_option_context_parse(context, &amp;argc, &amp;ar=
gv, &amp;error)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_printerr(&quot;Option parsing failed: %=
s\n&quot;, error-&gt;message);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (opt_print_caps) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_print(&quot;{\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_print(&quot;=C2=A0 \&quot;type\&quot;: =
\&quot;block\&quot;,\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_print(&quot;=C2=A0 \&quot;features\&quo=
t;: [\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_print(&quot;=C2=A0 =C2=A0 \&quot;read-o=
nly\&quot;,\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_print(&quot;=C2=A0 =C2=A0 \&quot;blk-fi=
le\&quot;\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_print(&quot;=C2=A0 ]\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_print(&quot;}\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_SUCCESS);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!opt_blk_file) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_print(&quot;%s\n&quot;, g_option_contex=
t_get_help(context, true, NULL));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (opt_socket_path) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 lsock =3D unix_sock_new(opt_socket_path);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (lsock &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else if (opt_fdnum &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_print(&quot;%s\n&quot;, g_option_contex=
t_get_help(context, true, NULL));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 lsock =3D opt_fdnum;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 if (!unix_socket || !blk_file) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;Usage: %s [ -b block device =
or file, -s UNIX domain socket&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; | -r En=
able read-only ] | [ -h ]\n&quot;, argv[0]);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 lsock =3D unix_sock_new(unix_socket);<br>
&gt; -=C2=A0 =C2=A0 if (lsock &lt; 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 csock =3D accept(lsock, (void *)0, (void *)0);<br>
&gt; +=C2=A0 =C2=A0 csock =3D accept(lsock, NULL, NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (csock &lt; 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Accept error %s\n&q=
uot;, strerror(errno));<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_printerr(&quot;Accept error %s\n&quot;,=
 strerror(errno));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 vdev_blk =3D vub_new(blk_file);<br>
&gt; +=C2=A0 =C2=A0 vdev_blk =3D vub_new(opt_blk_file);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!vdev_blk) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 if (enable_ro) {<br>
&gt; +=C2=A0 =C2=A0 if (opt_read_only) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdev_blk-&gt;enable_ro =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!vug_init(&amp;vdev_blk-&gt;parent, VHOST_USER=
_BLK_MAX_QUEUES, csock,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
ub_panic_cb, &amp;vub_iface)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Failed to initializ=
ed libvhost-user-glib\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_printerr(&quot;Failed to initialize lib=
vhost-user-glib\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_main_loop_run(vdev_blk-&gt;loop);<br>
&gt; -<br>
&gt; +=C2=A0 =C2=A0 g_main_loop_unref(vdev_blk-&gt;loop);<br>
&gt; +=C2=A0 =C2=A0 g_option_context_free(context);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 vug_deinit(&amp;vdev_blk-&gt;parent);<br>
&gt; -<br>
&gt; -err:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 vub_free(vdev_blk);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (csock &gt;=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close(csock);<br>
&gt; @@ -647,8 +667,8 @@ err:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (lsock &gt;=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close(lsock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 g_free(unix_socket);<br>
&gt; -=C2=A0 =C2=A0 g_free(blk_file);<br>
&gt; +=C2=A0 =C2=A0 g_free(opt_socket_path);<br>
&gt; +=C2=A0 =C2=A0 g_free(opt_blk_file);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.js=
on<br>
&gt; index da6aaf51c8..ce0ef74db5 100644<br>
&gt; --- a/docs/interop/vhost-user.json<br>
&gt; +++ b/docs/interop/vhost-user.json<br>
&gt; @@ -54,6 +54,37 @@<br>
&gt;=C2=A0 =C2=A0 ]<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +##<br>
&gt; +# @VHostUserBackendBlockFeature:<br>
&gt; +#<br>
&gt; +# List of vhost user &quot;block&quot; features.<br>
&gt; +#<br>
&gt; +# @read-only: The --read-only command line option is supported.<br>
&gt; +# @blk-file: The --blk-file command line option is supported.<br>
&gt; +#<br>
&gt; +# Since: 5.0<br>
&gt; +##<br>
&gt; +{<br>
&gt; +=C2=A0 &#39;enum&#39;: &#39;VHostUserBackendBlockFeature&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: [ &#39;read-only&#39;, &#39;blk-file&#39; ]<br=
>
&gt; +}<br>
&gt; +<br>
&gt; +##<br>
&gt; +# @VHostUserBackendCapabilitiesBlock:<br>
&gt; +#<br>
&gt; +# Capabilities reported by vhost user &quot;block&quot; backends<br>
&gt; +#<br>
&gt; +# @features: list of supported features.<br>
&gt; +#<br>
&gt; +# Since: 5.0<br>
&gt; +##<br>
&gt; +{<br>
&gt; +=C2=A0 &#39;struct&#39;: &#39;VHostUserBackendCapabilitiesBlock&#39;,=
<br>
&gt; +=C2=A0 &#39;data&#39;: {<br>
&gt; +=C2=A0 =C2=A0 &#39;features&#39;: [ &#39;VHostUserBackendBlockFeature=
&#39; ]<br>
&gt; +=C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @VHostUserBackendInputFeature:<br>
&gt;=C2=A0 #<br>
&gt; diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst=
<br>
&gt; index 7827b710aa..2f0910d515 100644<br>
&gt; --- a/docs/interop/vhost-user.rst<br>
&gt; +++ b/docs/interop/vhost-user.rst<br>
&gt; @@ -1376,3 +1376,18 @@ Command line options:<br>
&gt;=C2=A0 =C2=A0 Enable virgl rendering support.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 (optional)<br>
&gt; +<br>
&gt; +vhost-user-blk<br>
&gt; +--------------<br>
&gt; +<br>
&gt; +Command line options:<br>
&gt; +<br>
&gt; +--blk-file=3DPATH<br>
&gt; +<br>
&gt; +=C2=A0 Specify block device or file path.<br>
<br>
Would it make sense to make it optional? Since you have a<br>
corresponding &quot;blk-file&quot; feature already, there is not much to ch=
ange<br>
but the doc.<br>
<br>
&gt; +<br>
&gt; +--read-only<br>
&gt; +<br>
&gt; +=C2=A0 Enable read-only.<br>
&gt; +<br>
&gt; +=C2=A0 (optional)<br>
&gt; --<br>
&gt; 2.21.0<br>
&gt;<br>
&gt;<br>
<br>
Looks good to me otherwise<br>
<br>
-- <br>
Marc-Andr=C3=A9 Lureau<br>
</blockquote></div>

--00000000000032272405993ba9a9--

