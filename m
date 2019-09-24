Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D7FC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC7E21655
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC7E21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCmMu-0007JH-LX
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 11:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1iClBs-0002ds-I0
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1iClBq-0002UV-96
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:49:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44732)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1iClBp-0002SI-Of
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:49:13 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D75E9C049E36
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 13:49:11 +0000 (UTC)
Received: by mail-ot1-f69.google.com with SMTP id y24so1186034otk.15
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 06:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Yd3R6KSv5z7jZ1WUYszFA0z9StOa+OrPRSmgLR2t9PU=;
 b=hctG46UeJUajcDCNmWwJKgJylnj2cjvrVONrZysqo4+uEzgwtLCNuM7uhE7EICobuj
 VZ4nxNodnJRW8OvHabluTdFc02G3PCZymraylS7P/Jkubv2SttS4gZIZV2G7MTzgINFE
 Yjz7YdWFbWbgESZgcc0NC+jgsF42eIfgNlrptiaT4M2l0K3SmaTa0WVbQ6+jN++gMXiP
 gxPB8t81vNGu49kpCvWJCwFjsVdJThBKTLCGp53E1ppX4GGjftufGPnavf2dNNKLnj2t
 xJZm93n8UlMkHNkovdpfjPSzPNsgTsR2CX91HVIQYkonD2mPi7XDtCbXzMfc0G9317YH
 HnXA==
X-Gm-Message-State: APjAAAXsw4meq4jXGFatNfSjW2BQK7RROqZY7b55qhULr+QhFFpFsB4T
 UbSu93/M2CR49M8zHo6QWi1+3WlZlh+8AwcH+yufAdRjVg9sLOOkYeh70sj0IzJY8Hu8pGrLr5I
 uxMXjwo8Ny0x6k3RPnVgHOkitN6yEK8s=
X-Received: by 2002:aca:f456:: with SMTP id s83mr106686oih.156.1569332951330; 
 Tue, 24 Sep 2019 06:49:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqylG/KuhqyuxsKHVEQ+dO8HDpKvfugm7aGA5aU3lDU0EAbAg7V4NUAE36y4HiyHrkyfrn6jJoUOS218pVOcf5s=
X-Received: by 2002:aca:f456:: with SMTP id s83mr106664oih.156.1569332951026; 
 Tue, 24 Sep 2019 06:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190924123933.10607-1-eblake@redhat.com>
 <20190924123933.10607-5-eblake@redhat.com>
In-Reply-To: <20190924123933.10607-5-eblake@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Tue, 24 Sep 2019 16:49:00 +0300
Message-ID: <CAMRbyyuwaRPgO0G5Jj8_tFO+rGbMi_F0V3JuQR-0qU3BAEoEJQ@mail.gmail.com>
Subject: Re: [PULL 4/4] tests: Use iothreads during iotest 223
To: Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000014ac9a05934ccdf2"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000014ac9a05934ccdf2
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 24, 2019 at 4:18 PM Eric Blake <eblake@redhat.com> wrote:

> Doing so catches the bugs we just fixed with NBD not properly using
> correct contexts.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Message-Id: <20190920220729.31801-1-eblake@redhat.com>
> ---
>  tests/qemu-iotests/223     | 6 ++++--
>  tests/qemu-iotests/223.out | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
> index cc48e78ea7dc..2ba3d8124b4f 100755
> --- a/tests/qemu-iotests/223
> +++ b/tests/qemu-iotests/223
> @@ -2,7 +2,7 @@
>  #
>  # Test reading dirty bitmap over NBD
>  #
> -# Copyright (C) 2018 Red Hat, Inc.
> +# Copyright (C) 2018-2019 Red Hat, Inc.
>  #
>  # This program is free software; you can redistribute it and/or modify
>  # it under the terms of the GNU General Public License as published by
> @@ -109,7 +109,7 @@ echo
>  echo "=== End dirty bitmaps, and start serving image over NBD ==="
>  echo
>
> -_launch_qemu 2> >(_filter_nbd)
> +_launch_qemu -object iothread,id=io0 2> >(_filter_nbd)
>

But now we will not catch bugs in flows that do not use iothreads.

I think it will be better to run this test twice, one with iothreads, one
without.

 # Intentionally provoke some errors as well, to check error handling
>  silent=
> @@ -117,6 +117,8 @@ _send_qemu_cmd $QEMU_HANDLE
> '{"execute":"qmp_capabilities"}' "return"
>  _send_qemu_cmd $QEMU_HANDLE '{"execute":"blockdev-add",
>    "arguments":{"driver":"qcow2", "node-name":"n",
>      "file":{"driver":"file", "filename":"'"$TEST_IMG"'"}}}' "return"
> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-blockdev-set-iothread",
> +  "arguments":{"node-name":"n", "iothread":"io0"}}' "return"
>  _send_qemu_cmd $QEMU_HANDLE '{"execute":"block-dirty-bitmap-disable",
>    "arguments":{"node":"n", "name":"b"}}' "return"
>  _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
> diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
> index 5d00398c11cb..23b34fcd202e 100644
> --- a/tests/qemu-iotests/223.out
> +++ b/tests/qemu-iotests/223.out
> @@ -27,6 +27,7 @@ wrote 2097152/2097152 bytes at offset 2097152
>  {"return": {}}
>  {"return": {}}
>  {"return": {}}
> +{"return": {}}
>  {"error": {"class": "GenericError", "desc": "NBD server not running"}}
>  {"return": {}}
>  {"error": {"class": "GenericError", "desc": "NBD server already running"}}
> --
> 2.21.0
>
>
>

--00000000000014ac9a05934ccdf2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small;color:#000000"><span style=3D"color:rgb(34,34,34)">On Tue, Sep=
 24, 2019 at 4:18 PM Eric Blake &lt;<a href=3D"mailto:eblake@redhat.com">eb=
lake@redhat.com</a>&gt; wrote:</span><br></div></div><div class=3D"gmail_qu=
ote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">Doing so catches the=
 bugs we just fixed with NBD not properly using<br>
correct contexts.<br>
<br>
Signed-off-by: Eric Blake &lt;<a href=3D"mailto:eblake@redhat.com" target=
=3D"_blank">eblake@redhat.com</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20190920220729.31801-1-eblake@redhat.com"=
 target=3D"_blank">20190920220729.31801-1-eblake@redhat.com</a>&gt;<br>
---<br>
=C2=A0tests/qemu-iotests/223=C2=A0 =C2=A0 =C2=A0| 6 ++++--<br>
=C2=A0tests/qemu-iotests/223.out | 1 +<br>
=C2=A02 files changed, 5 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223<br>
index cc48e78ea7dc..2ba3d8124b4f 100755<br>
--- a/tests/qemu-iotests/223<br>
+++ b/tests/qemu-iotests/223<br>
@@ -2,7 +2,7 @@<br>
=C2=A0#<br>
=C2=A0# Test reading dirty bitmap over NBD<br>
=C2=A0#<br>
-# Copyright (C) 2018 Red Hat, Inc.<br>
+# Copyright (C) 2018-2019 Red Hat, Inc.<br>
=C2=A0#<br>
=C2=A0# This program is free software; you can redistribute it and/or modif=
y<br>
=C2=A0# it under the terms of the GNU General Public License as published b=
y<br>
@@ -109,7 +109,7 @@ echo<br>
=C2=A0echo &quot;=3D=3D=3D End dirty bitmaps, and start serving image over =
NBD =3D=3D=3D&quot;<br>
=C2=A0echo<br>
<br>
-_launch_qemu 2&gt; &gt;(_filter_nbd)<br>
+_launch_qemu -object iothread,id=3Dio0 2&gt; &gt;(_filter_nbd)<br></blockq=
uote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:sm=
all;color:rgb(0,0,0)">But now we will not catch bugs in flows that do not u=
se iothreads.</div><div class=3D"gmail_default" style=3D"font-size:small;co=
lor:rgb(0,0,0)"><br></div><div class=3D"gmail_default" style=3D"font-size:s=
mall;color:rgb(0,0,0)">I think it will be better to run this test twice, on=
e with iothreads, one without.</div></div><div class=3D"gmail_default" styl=
e=3D"font-size:small;color:rgb(0,0,0)"><br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
=C2=A0# Intentionally provoke some errors as well, to check error handling<=
br>
=C2=A0silent=3D<br>
@@ -117,6 +117,8 @@ _send_qemu_cmd $QEMU_HANDLE &#39;{&quot;execute&quot;:&=
quot;qmp_capabilities&quot;}&#39; &quot;return&quot;<br>
=C2=A0_send_qemu_cmd $QEMU_HANDLE &#39;{&quot;execute&quot;:&quot;blockdev-=
add&quot;,<br>
=C2=A0 =C2=A0&quot;arguments&quot;:{&quot;driver&quot;:&quot;qcow2&quot;, &=
quot;node-name&quot;:&quot;n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0&quot;file&quot;:{&quot;driver&quot;:&quot;file&quot;, =
&quot;filename&quot;:&quot;&#39;&quot;$TEST_IMG&quot;&#39;&quot;}}}&#39; &q=
uot;return&quot;<br>
+_send_qemu_cmd $QEMU_HANDLE &#39;{&quot;execute&quot;:&quot;x-blockdev-set=
-iothread&quot;,<br>
+=C2=A0 &quot;arguments&quot;:{&quot;node-name&quot;:&quot;n&quot;, &quot;i=
othread&quot;:&quot;io0&quot;}}&#39; &quot;return&quot;<br>
=C2=A0_send_qemu_cmd $QEMU_HANDLE &#39;{&quot;execute&quot;:&quot;block-dir=
ty-bitmap-disable&quot;,<br>
=C2=A0 =C2=A0&quot;arguments&quot;:{&quot;node&quot;:&quot;n&quot;, &quot;n=
ame&quot;:&quot;b&quot;}}&#39; &quot;return&quot;<br>
=C2=A0_send_qemu_cmd $QEMU_HANDLE &#39;{&quot;execute&quot;:&quot;nbd-serve=
r-add&quot;,<br>
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out<br>
index 5d00398c11cb..23b34fcd202e 100644<br>
--- a/tests/qemu-iotests/223.out<br>
+++ b/tests/qemu-iotests/223.out<br>
@@ -27,6 +27,7 @@ wrote 2097152/2097152 bytes at offset 2097152<br>
=C2=A0{&quot;return&quot;: {}}<br>
=C2=A0{&quot;return&quot;: {}}<br>
=C2=A0{&quot;return&quot;: {}}<br>
+{&quot;return&quot;: {}}<br>
=C2=A0{&quot;error&quot;: {&quot;class&quot;: &quot;GenericError&quot;, &qu=
ot;desc&quot;: &quot;NBD server not running&quot;}}<br>
=C2=A0{&quot;return&quot;: {}}<br>
=C2=A0{&quot;error&quot;: {&quot;class&quot;: &quot;GenericError&quot;, &qu=
ot;desc&quot;: &quot;NBD server already running&quot;}}<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote></div></div>

--00000000000014ac9a05934ccdf2--

