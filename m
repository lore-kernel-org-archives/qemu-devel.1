Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC69C2D0BF
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 09:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97BD62464D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 09:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nee7Zrr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BD62464D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icngo-0007kC-0K
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 04:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chanmickyyun@gmail.com>) id 1icnfV-0006tW-AW
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 04:43:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chanmickyyun@gmail.com>) id 1icnfQ-0004at-PE
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 04:43:27 -0500
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:44443)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chanmickyyun@gmail.com>)
 id 1icnfQ-0004XI-BX
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 04:43:24 -0500
Received: by mail-ed1-x542.google.com with SMTP id cm12so2034420edb.11
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 01:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K0zxWYQKUtjfIO0WBRIWr4EH8CkelKvwfG9/UjT23TI=;
 b=Nee7Zrr0WzGpLhMLynQcY0qgFKaLXExK60pJor7aJFUpNg7TN9EGyWG4wLU56CoCSk
 WjlLf+rJToQHzWKvZJ8a8oKK/fr9let/c1BAdqbX9y0MVz9UMGX9cUOrc5mzYKcSsO3V
 1ihd+afEZULEXIozURsaW0G9MTWnTwclCOIhH9J6exWemPfsDTKE8Hy22w5bAFYnHyXD
 jVuT1KJ3v7shGERzgHfK5kKQlicvEzSGoG3iKzRJcaap1iXRhhKs73iYrdKAu4Es66r2
 jqUkklX3FPGLas5YKT15d9Rb86by7WTP6bTQk88YNWa01RYxH3DoUkcslgFlD0sW0nbj
 lPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K0zxWYQKUtjfIO0WBRIWr4EH8CkelKvwfG9/UjT23TI=;
 b=YDHSxRPUbFA6OHm4Y4hZRiU7poUFjdf64rlRtpW7HesbQpKax4VRWtHeQPNv8KDtug
 DU/mWmRgGjBzECRTHp2CHv9frrFgzEaK60b9oN5UNbwBm75zI5XGDFHtRU+6C8f1MSpW
 q8QSKesEh74Y98JFCxPK6SOu7qGSRHBD+DQMJWmLSQgz0o24bn21inoUlRup9h2KNwUp
 Iva8j6TnFkDSbsVLj1oX+PlpgQfdrdq5jFEKe80HrL0/RlpaARyG17toUdMpldVhBGA0
 jIwGUWkG8BPnAneVJ6jCoMuPn64AS23IL1gGN1y+pIaYYnpzxLBXTfi6dBgSsv54FtYy
 hzBQ==
X-Gm-Message-State: APjAAAU7XP5IBPGRXxwNKVt2SFsa1v8TqbMEaXDGRCoOk1sEWLSkM8RZ
 axuyJjL6D4SzM5bCBgytlhe2jHdfrxQtYaLiJHdY7RCtH4A=
X-Google-Smtp-Source: APXvYqxtpdckvbAb5Su6fO/EatLaPaSRvI0VeJrxVSoHpVadycYrKV08LhSWdcK0WVnb9DrQ9MehhrVmEjPcJlLlccM=
X-Received: by 2002:a17:906:b253:: with SMTP id
 ce19mr8243447ejb.61.1575539002346; 
 Thu, 05 Dec 2019 01:43:22 -0800 (PST)
MIME-Version: 1.0
References: <20191125051722.15523-1-chanmickyyun@gmail.com>
 <CAPojyfO0DQhptkUix5j1hzcV4y4pwQ0ZRDQYsrrPBCvpEWL2NQ@mail.gmail.com>
In-Reply-To: <CAPojyfO0DQhptkUix5j1hzcV4y4pwQ0ZRDQYsrrPBCvpEWL2NQ@mail.gmail.com>
From: Micky C <chanmickyyun@gmail.com>
Date: Thu, 5 Dec 2019 17:43:10 +0800
Message-ID: <CAPojyfM+M+eftqT_Vvgpf1yYYL3MG=v6LhVSvg1vUkUYr17RBg@mail.gmail.com>
Subject: Re: [PATCH v7] Implement backend program convention command for
 vhost-user-blk
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000908ff30598f1c2c9"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
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
Cc: stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000908ff30598f1c2c9
Content-Type: text/plain; charset="UTF-8"

Ping again

On Mon, Dec 2, 2019 at 9:53 AM Micky C <chanmickyyun@gmail.com> wrote:

> Ping
>
> On Mon, Nov 25, 2019 at 1:17 PM Micky Yun Chan(michiboo) <
> chanmickyyun@gmail.com> wrote:
>
>> From: Micky Yun Chan <chanmickyyun@gmail.com>
>>
>> This patch is to add standard commands defined in
>> docs/interop/vhost-user.rst
>> For vhost-user-* program
>>
>> Signed-off-by: Micky Yun Chan (michiboo) <chanmickyyun@gmail.com>
>> ---
>>  contrib/vhost-user-blk/vhost-user-blk.c | 108 ++++++++++++++----------
>>  docs/interop/vhost-user.json            |  31 +++++++
>>  docs/interop/vhost-user.rst             |  15 ++++
>>  3 files changed, 110 insertions(+), 44 deletions(-)
>>
>> diff --git a/contrib/vhost-user-blk/vhost-user-blk.c
>> b/contrib/vhost-user-blk/vhost-user-blk.c
>> index ae61034656..6fd91c7e99 100644
>> --- a/contrib/vhost-user-blk/vhost-user-blk.c
>> +++ b/contrib/vhost-user-blk/vhost-user-blk.c
>> @@ -576,70 +576,90 @@ vub_new(char *blk_file)
>>      return vdev_blk;
>>  }
>>
>> +static int opt_fdnum = -1;
>> +static char *opt_socket_path;
>> +static char *opt_blk_file;
>> +static gboolean opt_print_caps;
>> +static gboolean opt_read_only;
>> +
>> +static GOptionEntry entries[] = {
>> +    { "print-capabilities", 'c', 0, G_OPTION_ARG_NONE, &opt_print_caps,
>> +      "Print capabilities", NULL },
>> +    { "fd", 'f', 0, G_OPTION_ARG_INT, &opt_fdnum,
>> +      "Use inherited fd socket", "FDNUM" },
>> +    { "socket-path", 's', 0, G_OPTION_ARG_FILENAME, &opt_socket_path,
>> +      "Use UNIX socket path", "PATH" },
>> +    {"blk-file", 'b', 0, G_OPTION_ARG_FILENAME, &opt_blk_file,
>> +     "block device or file path", "PATH"},
>> +    { "read-only", 'r', 0, G_OPTION_ARG_NONE, &opt_read_only,
>> +      "Enable read-only", NULL }
>> +};
>> +
>>  int main(int argc, char **argv)
>>  {
>> -    int opt;
>> -    char *unix_socket = NULL;
>> -    char *blk_file = NULL;
>> -    bool enable_ro = false;
>>      int lsock = -1, csock = -1;
>>      VubDev *vdev_blk = NULL;
>> +    GError *error = NULL;
>> +    GOptionContext *context;
>>
>> -    while ((opt = getopt(argc, argv, "b:rs:h")) != -1) {
>> -        switch (opt) {
>> -        case 'b':
>> -            blk_file = g_strdup(optarg);
>> -            break;
>> -        case 's':
>> -            unix_socket = g_strdup(optarg);
>> -            break;
>> -        case 'r':
>> -            enable_ro = true;
>> -            break;
>> -        case 'h':
>> -        default:
>> -            printf("Usage: %s [ -b block device or file, -s UNIX domain
>> socket"
>> -                   " | -r Enable read-only ] | [ -h ]\n", argv[0]);
>> -            return 0;
>> +    context = g_option_context_new(NULL);
>> +    g_option_context_add_main_entries(context, entries, NULL);
>> +    if (!g_option_context_parse(context, &argc, &argv, &error)) {
>> +        g_printerr("Option parsing failed: %s\n", error->message);
>> +        exit(EXIT_FAILURE);
>> +    }
>> +    if (opt_print_caps) {
>> +        g_print("{\n");
>> +        g_print("  \"type\": \"block\",\n");
>> +        g_print("  \"features\": [\n");
>> +        g_print("    \"read-only\",\n");
>> +        g_print("    \"blk-file\"\n");
>> +        g_print("  ]\n");
>> +        g_print("}\n");
>> +        exit(EXIT_SUCCESS);
>> +    }
>> +
>> +    if (!opt_blk_file) {
>> +        g_print("%s\n", g_option_context_get_help(context, true, NULL));
>> +        exit(EXIT_FAILURE);
>> +    }
>> +
>> +    if (opt_socket_path) {
>> +        lsock = unix_sock_new(opt_socket_path);
>> +        if (lsock < 0) {
>> +            exit(EXIT_FAILURE);
>>          }
>> +    } else if (opt_fdnum < 0) {
>> +        g_print("%s\n", g_option_context_get_help(context, true, NULL));
>> +        exit(EXIT_FAILURE);
>> +    } else {
>> +        lsock = opt_fdnum;
>>      }
>>
>> -    if (!unix_socket || !blk_file) {
>> -        printf("Usage: %s [ -b block device or file, -s UNIX domain
>> socket"
>> -               " | -r Enable read-only ] | [ -h ]\n", argv[0]);
>> -        return -1;
>> -    }
>> -
>> -    lsock = unix_sock_new(unix_socket);
>> -    if (lsock < 0) {
>> -        goto err;
>> -    }
>> -
>> -    csock = accept(lsock, (void *)0, (void *)0);
>> +    csock = accept(lsock, NULL, NULL);
>>      if (csock < 0) {
>> -        fprintf(stderr, "Accept error %s\n", strerror(errno));
>> -        goto err;
>> +        g_printerr("Accept error %s\n", strerror(errno));
>> +        exit(EXIT_FAILURE);
>>      }
>>
>> -    vdev_blk = vub_new(blk_file);
>> +    vdev_blk = vub_new(opt_blk_file);
>>      if (!vdev_blk) {
>> -        goto err;
>> +        exit(EXIT_FAILURE);
>>      }
>> -    if (enable_ro) {
>> +    if (opt_read_only) {
>>          vdev_blk->enable_ro = true;
>>      }
>>
>>      if (!vug_init(&vdev_blk->parent, VHOST_USER_BLK_MAX_QUEUES, csock,
>>                    vub_panic_cb, &vub_iface)) {
>> -        fprintf(stderr, "Failed to initialized libvhost-user-glib\n");
>> -        goto err;
>> +        g_printerr("Failed to initialize libvhost-user-glib\n");
>> +        exit(EXIT_FAILURE);
>>      }
>>
>>      g_main_loop_run(vdev_blk->loop);
>> -
>> +    g_main_loop_unref(vdev_blk->loop);
>> +    g_option_context_free(context);
>>      vug_deinit(&vdev_blk->parent);
>> -
>> -err:
>>      vub_free(vdev_blk);
>>      if (csock >= 0) {
>>          close(csock);
>> @@ -647,8 +667,8 @@ err:
>>      if (lsock >= 0) {
>>          close(lsock);
>>      }
>> -    g_free(unix_socket);
>> -    g_free(blk_file);
>> +    g_free(opt_socket_path);
>> +    g_free(opt_blk_file);
>>
>>      return 0;
>>  }
>> diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.json
>> index da6aaf51c8..ce0ef74db5 100644
>> --- a/docs/interop/vhost-user.json
>> +++ b/docs/interop/vhost-user.json
>> @@ -54,6 +54,37 @@
>>    ]
>>  }
>>
>> +##
>> +# @VHostUserBackendBlockFeature:
>> +#
>> +# List of vhost user "block" features.
>> +#
>> +# @read-only: The --read-only command line option is supported.
>> +# @blk-file: The --blk-file command line option is supported.
>> +#
>> +# Since: 5.0
>> +##
>> +{
>> +  'enum': 'VHostUserBackendBlockFeature',
>> +  'data': [ 'read-only', 'blk-file' ]
>> +}
>> +
>> +##
>> +# @VHostUserBackendCapabilitiesBlock:
>> +#
>> +# Capabilities reported by vhost user "block" backends
>> +#
>> +# @features: list of supported features.
>> +#
>> +# Since: 5.0
>> +##
>> +{
>> +  'struct': 'VHostUserBackendCapabilitiesBlock',
>> +  'data': {
>> +    'features': [ 'VHostUserBackendBlockFeature' ]
>> +  }
>> +}
>> +
>>  ##
>>  # @VHostUserBackendInputFeature:
>>  #
>> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> index 7827b710aa..2f0910d515 100644
>> --- a/docs/interop/vhost-user.rst
>> +++ b/docs/interop/vhost-user.rst
>> @@ -1376,3 +1376,18 @@ Command line options:
>>    Enable virgl rendering support.
>>
>>    (optional)
>> +
>> +vhost-user-blk
>> +--------------
>> +
>> +Command line options:
>> +
>> +--blk-file=PATH
>> +
>> +  Specify block device or file path.
>> +
>> +--read-only
>> +
>> +  Enable read-only.
>> +
>> +  (optional)
>> --
>> 2.21.0
>>
>>

--000000000000908ff30598f1c2c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ping again<br></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Mon, Dec 2, 2019 at 9:53 AM Micky C &lt;<=
a href=3D"mailto:chanmickyyun@gmail.com">chanmickyyun@gmail.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"=
ltr"><div dir=3D"ltr">Ping<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Nov 25, 2019 at 1:17 PM Micky Yun Cha=
n(michiboo) &lt;<a href=3D"mailto:chanmickyyun@gmail.com" target=3D"_blank"=
>chanmickyyun@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">From: Micky Yun Chan &lt;<a href=3D"mailto:chanmicky=
yun@gmail.com" target=3D"_blank">chanmickyyun@gmail.com</a>&gt;<br>
<br>
This patch is to add standard commands defined in docs/interop/vhost-user.r=
st<br>
For vhost-user-* program<br>
<br>
Signed-off-by: Micky Yun Chan (michiboo) &lt;<a href=3D"mailto:chanmickyyun=
@gmail.com" target=3D"_blank">chanmickyyun@gmail.com</a>&gt;<br>
---<br>
=C2=A0contrib/vhost-user-blk/vhost-user-blk.c | 108 ++++++++++++++---------=
-<br>
=C2=A0docs/interop/vhost-user.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 31 +++++++<br>
=C2=A0docs/interop/vhost-user.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 15 ++++<br>
=C2=A03 files changed, 110 insertions(+), 44 deletions(-)<br>
<br>
diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-b=
lk/vhost-user-blk.c<br>
index ae61034656..6fd91c7e99 100644<br>
--- a/contrib/vhost-user-blk/vhost-user-blk.c<br>
+++ b/contrib/vhost-user-blk/vhost-user-blk.c<br>
@@ -576,70 +576,90 @@ vub_new(char *blk_file)<br>
=C2=A0 =C2=A0 =C2=A0return vdev_blk;<br>
=C2=A0}<br>
<br>
+static int opt_fdnum =3D -1;<br>
+static char *opt_socket_path;<br>
+static char *opt_blk_file;<br>
+static gboolean opt_print_caps;<br>
+static gboolean opt_read_only;<br>
+<br>
+static GOptionEntry entries[] =3D {<br>
+=C2=A0 =C2=A0 { &quot;print-capabilities&quot;, &#39;c&#39;, 0, G_OPTION_A=
RG_NONE, &amp;opt_print_caps,<br>
+=C2=A0 =C2=A0 =C2=A0 &quot;Print capabilities&quot;, NULL },<br>
+=C2=A0 =C2=A0 { &quot;fd&quot;, &#39;f&#39;, 0, G_OPTION_ARG_INT, &amp;opt=
_fdnum,<br>
+=C2=A0 =C2=A0 =C2=A0 &quot;Use inherited fd socket&quot;, &quot;FDNUM&quot=
; },<br>
+=C2=A0 =C2=A0 { &quot;socket-path&quot;, &#39;s&#39;, 0, G_OPTION_ARG_FILE=
NAME, &amp;opt_socket_path,<br>
+=C2=A0 =C2=A0 =C2=A0 &quot;Use UNIX socket path&quot;, &quot;PATH&quot; },=
<br>
+=C2=A0 =C2=A0 {&quot;blk-file&quot;, &#39;b&#39;, 0, G_OPTION_ARG_FILENAME=
, &amp;opt_blk_file,<br>
+=C2=A0 =C2=A0 =C2=A0&quot;block device or file path&quot;, &quot;PATH&quot=
;},<br>
+=C2=A0 =C2=A0 { &quot;read-only&quot;, &#39;r&#39;, 0, G_OPTION_ARG_NONE, =
&amp;opt_read_only,<br>
+=C2=A0 =C2=A0 =C2=A0 &quot;Enable read-only&quot;, NULL }<br>
+};<br>
+<br>
=C2=A0int main(int argc, char **argv)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 int opt;<br>
-=C2=A0 =C2=A0 char *unix_socket =3D NULL;<br>
-=C2=A0 =C2=A0 char *blk_file =3D NULL;<br>
-=C2=A0 =C2=A0 bool enable_ro =3D false;<br>
=C2=A0 =C2=A0 =C2=A0int lsock =3D -1, csock =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0VubDev *vdev_blk =3D NULL;<br>
+=C2=A0 =C2=A0 GError *error =3D NULL;<br>
+=C2=A0 =C2=A0 GOptionContext *context;<br>
<br>
-=C2=A0 =C2=A0 while ((opt =3D getopt(argc, argv, &quot;b:rs:h&quot;)) !=3D=
 -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (opt) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;b&#39;:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blk_file =3D g_strdup(optarg);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;s&#39;:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unix_socket =3D g_strdup(optarg)=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;r&#39;:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable_ro =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;h&#39;:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;Usage: %s [ -b bloc=
k device or file, -s UNIX domain socket&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
; | -r Enable read-only ] | [ -h ]\n&quot;, argv[0]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 context =3D g_option_context_new(NULL);<br>
+=C2=A0 =C2=A0 g_option_context_add_main_entries(context, entries, NULL);<b=
r>
+=C2=A0 =C2=A0 if (!g_option_context_parse(context, &amp;argc, &amp;argv, &=
amp;error)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_printerr(&quot;Option parsing failed: %s\n&q=
uot;, error-&gt;message);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (opt_print_caps) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_print(&quot;{\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_print(&quot;=C2=A0 \&quot;type\&quot;: \&quo=
t;block\&quot;,\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_print(&quot;=C2=A0 \&quot;features\&quot;: [=
\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_print(&quot;=C2=A0 =C2=A0 \&quot;read-only\&=
quot;,\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_print(&quot;=C2=A0 =C2=A0 \&quot;blk-file\&q=
uot;\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_print(&quot;=C2=A0 ]\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_print(&quot;}\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_SUCCESS);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!opt_blk_file) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_print(&quot;%s\n&quot;, g_option_context_get=
_help(context, true, NULL));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (opt_socket_path) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 lsock =3D unix_sock_new(opt_socket_path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (lsock &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 } else if (opt_fdnum &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_print(&quot;%s\n&quot;, g_option_context_get=
_help(context, true, NULL));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 lsock =3D opt_fdnum;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (!unix_socket || !blk_file) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;Usage: %s [ -b block device or fi=
le, -s UNIX domain socket&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; | -r Enable =
read-only ] | [ -h ]\n&quot;, argv[0]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 lsock =3D unix_sock_new(unix_socket);<br>
-=C2=A0 =C2=A0 if (lsock &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 csock =3D accept(lsock, (void *)0, (void *)0);<br>
+=C2=A0 =C2=A0 csock =3D accept(lsock, NULL, NULL);<br>
=C2=A0 =C2=A0 =C2=A0if (csock &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Accept error %s\n&quot;,=
 strerror(errno));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_printerr(&quot;Accept error %s\n&quot;, stre=
rror(errno));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 vdev_blk =3D vub_new(blk_file);<br>
+=C2=A0 =C2=A0 vdev_blk =3D vub_new(opt_blk_file);<br>
=C2=A0 =C2=A0 =C2=A0if (!vdev_blk) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 if (enable_ro) {<br>
+=C2=A0 =C2=A0 if (opt_read_only) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vdev_blk-&gt;enable_ro =3D true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!vug_init(&amp;vdev_blk-&gt;parent, VHOST_USER_BLK_=
MAX_QUEUES, csock,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vub_pa=
nic_cb, &amp;vub_iface)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Failed to initialized li=
bvhost-user-glib\n&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_printerr(&quot;Failed to initialize libvhost=
-user-glib\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_main_loop_run(vdev_blk-&gt;loop);<br>
-<br>
+=C2=A0 =C2=A0 g_main_loop_unref(vdev_blk-&gt;loop);<br>
+=C2=A0 =C2=A0 g_option_context_free(context);<br>
=C2=A0 =C2=A0 =C2=A0vug_deinit(&amp;vdev_blk-&gt;parent);<br>
-<br>
-err:<br>
=C2=A0 =C2=A0 =C2=A0vub_free(vdev_blk);<br>
=C2=A0 =C2=A0 =C2=A0if (csock &gt;=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(csock);<br>
@@ -647,8 +667,8 @@ err:<br>
=C2=A0 =C2=A0 =C2=A0if (lsock &gt;=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(lsock);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 g_free(unix_socket);<br>
-=C2=A0 =C2=A0 g_free(blk_file);<br>
+=C2=A0 =C2=A0 g_free(opt_socket_path);<br>
+=C2=A0 =C2=A0 g_free(opt_blk_file);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.json<br=
>
index da6aaf51c8..ce0ef74db5 100644<br>
--- a/docs/interop/vhost-user.json<br>
+++ b/docs/interop/vhost-user.json<br>
@@ -54,6 +54,37 @@<br>
=C2=A0 =C2=A0]<br>
=C2=A0}<br>
<br>
+##<br>
+# @VHostUserBackendBlockFeature:<br>
+#<br>
+# List of vhost user &quot;block&quot; features.<br>
+#<br>
+# @read-only: The --read-only command line option is supported.<br>
+# @blk-file: The --blk-file command line option is supported.<br>
+#<br>
+# Since: 5.0<br>
+##<br>
+{<br>
+=C2=A0 &#39;enum&#39;: &#39;VHostUserBackendBlockFeature&#39;,<br>
+=C2=A0 &#39;data&#39;: [ &#39;read-only&#39;, &#39;blk-file&#39; ]<br>
+}<br>
+<br>
+##<br>
+# @VHostUserBackendCapabilitiesBlock:<br>
+#<br>
+# Capabilities reported by vhost user &quot;block&quot; backends<br>
+#<br>
+# @features: list of supported features.<br>
+#<br>
+# Since: 5.0<br>
+##<br>
+{<br>
+=C2=A0 &#39;struct&#39;: &#39;VHostUserBackendCapabilitiesBlock&#39;,<br>
+=C2=A0 &#39;data&#39;: {<br>
+=C2=A0 =C2=A0 &#39;features&#39;: [ &#39;VHostUserBackendBlockFeature&#39;=
 ]<br>
+=C2=A0 }<br>
+}<br>
+<br>
=C2=A0##<br>
=C2=A0# @VHostUserBackendInputFeature:<br>
=C2=A0#<br>
diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst<br>
index 7827b710aa..2f0910d515 100644<br>
--- a/docs/interop/vhost-user.rst<br>
+++ b/docs/interop/vhost-user.rst<br>
@@ -1376,3 +1376,18 @@ Command line options:<br>
=C2=A0 =C2=A0Enable virgl rendering support.<br>
<br>
=C2=A0 =C2=A0(optional)<br>
+<br>
+vhost-user-blk<br>
+--------------<br>
+<br>
+Command line options:<br>
+<br>
+--blk-file=3DPATH<br>
+<br>
+=C2=A0 Specify block device or file path.<br>
+<br>
+--read-only<br>
+<br>
+=C2=A0 Enable read-only.<br>
+<br>
+=C2=A0 (optional)<br>
-- <br>
2.21.0<br>
<br>
</blockquote></div></div>
</blockquote></div>

--000000000000908ff30598f1c2c9--

