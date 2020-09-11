Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6676C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DD4208FE
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZZMSVXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DD4208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGe6d-0007xc-Kd
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 04:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kGe5v-0007WT-0M
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 04:07:43 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632]:42668)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kGe5t-0006f3-1Z
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 04:07:42 -0400
Received: by mail-ej1-x632.google.com with SMTP id q13so12551792ejo.9
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 01:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8y48C6fQMG08qrarN2X9n+BZlUUoCLwucFT8V32XPIg=;
 b=dZZMSVXvw09GN02BW4YB/KtYKRv7VSgwlXFhYWGdCJzTTNf4Zwmv8kWWefFuadnrwe
 0fo+abxv0xtb4a7kUxHAiTFBK7xhYCRYvnKV1y6MfIzREoKYTSs8C3XRTj//rVyf+/bw
 r9o/JJXtuq6t2wCCUsYeP6LCHSAzjWE4OOHmVwTFg8R8ZYYgTTGXZCTqth2FzKtzs87i
 7jsj5dfHYtnHM4W41ZYWHhhyyhEsrbEaOBCihbECBC9MNysi+ckODqz9Fo9xsJjCTXOM
 5O7oER7xeGhdKm6Mmjk+y+yeI3tczR1KCb9KlcJ9BTrIXDuNHWOqzW3qWYbHnVW4AdAL
 W+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8y48C6fQMG08qrarN2X9n+BZlUUoCLwucFT8V32XPIg=;
 b=gytudtattwXpfjfoRHrciDI3BQX6iSQUyzRjZ+bNC7hg8BrVptw04B3gOrF6Sj9wUY
 U1za7rCES4o6XjTb4bJRkmVR+B0GVrQXp30j6fwUbVqIYMlsm17SJSfsZLUjRQquroIg
 VapqB43smDY8pTmQ95c2PYtKJkU7VBtP+gv3Fb7VHGjVm8UtLTXZIXry3++MhWtlk2MY
 saP6sZb2ADRr9iStjLEAM7o1lFshJPiCuH1SpcMSp7L7tOY+odngjM2ilY73pUcNbJSh
 iNNIuC5LfMLAPNZzj0ESsuV126v7+nVKlokVRyaHNrTeGAYBSDUOuKfvcnuOlfCA6CVT
 YpuQ==
X-Gm-Message-State: AOAM5319OPG6XZGHHLb3BxbQUM+EYjhW6TUExnMgdKIpHFVb0zaqONQ3
 nekWese7sP1EetWqynE7voE1MGyhwNts+zQnjPI=
X-Google-Smtp-Source: ABdhPJzPjJtUPZ6Ux6S4Juy4tnw465GGJbMzxO6JNpSmFRXtJ2r1uAN3MtZzPZzJ5KaTzzvT+VhAoCHxgR4ZCDyoydw=
X-Received: by 2002:a17:906:4a51:: with SMTP id
 a17mr853078ejv.381.1599811659186; 
 Fri, 11 Sep 2020 01:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200910194903.4104696-1-ehabkost@redhat.com>
In-Reply-To: <20200910194903.4104696-1-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 11 Sep 2020 12:07:27 +0400
Message-ID: <CAJ+F1CLLKesMvZo4DJcC=f387d_fN8g--qX8YEQGu8Thf1qotA@mail.gmail.com>
Subject: Re: [PATCH 00/18] chardev: QOM cleanups
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a7458705af052db3"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x632.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a7458705af052db3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Sep 10, 2020 at 11:50 PM Eduardo Habkost <ehabkost@redhat.com>
wrote:

> Some chardev QOM cleanup patches had to be dropped from my queue
> due to build erros introduced by code movements across ifdef
> boundaries at char-parallel.c.  This series redo the changes from
> those patches, but the macro renames are now a little different:
>
> In this version I have decided to rename the type checking macros
> from *_CHARDEV to CHARDEV_* instead of renaming tye
> TYPE_CHARDEV_* constants to TYPE_*_CHARDEV, to make the
> identifiers actually match the QOM type name strings
> ("chardev-*").
>

Sounds reasonable to me, but it loses the matching with the
structure/object type name though.

- MuxChardev *d =3D MUX_CHARDEV(s);
+ MuxChardev *d =3D CHARDEV_MUX(s);

I have a preference for the first. Unless we rename all the chardev types
too...

Imho, the QOM type name is mostly an internal detail, the C type name is
dominant in the code.



> Eduardo Habkost (18):
>   chardev: Move PARALLEL_CHARDEV macro to common code
>   chardev: Move ParallelChardev typedef to common code
>   chardev: Use DECLARE_INSTANCE_CHECKER macro for PARALLEL_CHARDEV
>   chardev: Rename MOUSE_CHARDEV to CHARDEV_MSMOUSE
>   chardev: Rename BAUM_CHARDEV to CHARDEV_BRAILLE
>   chardev: Rename FD_CHARDEV to CHARDEV_FD
>   chardev: Rename MUX_CHARDEV to CHARDEV_MUX
>   chardev: Rename PARALLEL_CHARDEV to CHARDEV_PARALLEL
>   chardev: Rename PTY_CHARDEV to CHARDEV_PTY
>   chardev: Rename RINGBUF_CHARDEV to CHARDEV_RINGBUF
>   chardev: Rename SOCKET_CHARDEV to CHARDEV_SOCKET
>   chardev: Rename SPICE_CHARDEV to CHARDEV_SPICE
>   chardev: Rename TESTDEV_CHARDEV to CHARDEV_TESTDEV
>   chardev: Rename UDP_CHARDEV to CHARDEV_UDP
>   chardev: Rename VC_CHARDEV to CHARDEV_VC
>   chardev: Rename WCTABLET_CHARDEV to CHARDEV_WCTABLET
>   chardev: Rename WIN_CHARDEV to CHARDEV_WIN
>   chardev: Rename WIN_STDIO_CHARDEV to CHARDEV_WIN_STDIO
>
>  chardev/chardev-internal.h |  2 +-
>  include/chardev/char-fd.h  |  2 +-
>  include/chardev/char-win.h |  2 +-
>  include/chardev/spice.h    |  2 +-
>  chardev/baum.c             | 14 ++++----
>  chardev/char-fd.c          | 14 ++++----
>  chardev/char-fe.c          |  4 +--
>  chardev/char-mux.c         | 22 ++++++------
>  chardev/char-parallel.c    | 28 ++++++++--------
>  chardev/char-pipe.c        |  2 +-
>  chardev/char-pty.c         | 22 ++++++------
>  chardev/char-ringbuf.c     | 12 +++----
>  chardev/char-serial.c      |  2 +-
>  chardev/char-socket.c      | 68 +++++++++++++++++++-------------------
>  chardev/char-udp.c         | 14 ++++----
>  chardev/char-win-stdio.c   | 14 ++++----
>  chardev/char-win.c         | 14 ++++----
>  chardev/char.c             |  2 +-
>  chardev/msmouse.c          | 12 +++----
>  chardev/spice.c            | 16 ++++-----
>  chardev/testdev.c          |  4 +--
>  chardev/wctablet.c         | 12 +++----
>  ui/console.c               | 10 +++---
>  ui/gtk.c                   |  8 ++---
>  ui/spice-app.c             |  2 +-
>  25 files changed, 151 insertions(+), 153 deletions(-)
>
> --
> 2.26.2
>
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000a7458705af052db3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 10, 2020 at 11:50 PM Ed=
uardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Some chardev QOM cleanup patches had to be dropped from my queue<br>
due to build erros introduced by code movements across ifdef<br>
boundaries at char-parallel.c.=C2=A0 This series redo the changes from<br>
those patches, but the macro renames are now a little different:<br>
<br>
In this version I have decided to rename the type checking macros<br>
from *_CHARDEV to CHARDEV_* instead of renaming tye<br>
TYPE_CHARDEV_* constants to TYPE_*_CHARDEV, to make the<br>
identifiers actually match the QOM type name strings<br>
(&quot;chardev-*&quot;).<br></blockquote><div><br></div><div>Sounds reasona=
ble to me, but it loses the matching with the structure/object type name th=
ough.</div><br>- MuxChardev *d =3D MUX_CHARDEV(s);<br>+ MuxChardev *d =3D C=
HARDEV_MUX(s);</div><div class=3D"gmail_quote"><br></div><div class=3D"gmai=
l_quote">I have a preference for the first. Unless we rename all the charde=
v types too...</div><div class=3D"gmail_quote"><br></div><div class=3D"gmai=
l_quote">Imho, the QOM type name is mostly an internal detail, the C type n=
ame is dominant in the code.<br></div><div class=3D"gmail_quote"><br></div>=
<div class=3D"gmail_quote"><br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
Eduardo Habkost (18):<br>
=C2=A0 chardev: Move PARALLEL_CHARDEV macro to common code<br>
=C2=A0 chardev: Move ParallelChardev typedef to common code<br>
=C2=A0 chardev: Use DECLARE_INSTANCE_CHECKER macro for PARALLEL_CHARDEV<br>
=C2=A0 chardev: Rename MOUSE_CHARDEV to CHARDEV_MSMOUSE<br>
=C2=A0 chardev: Rename BAUM_CHARDEV to CHARDEV_BRAILLE<br>
=C2=A0 chardev: Rename FD_CHARDEV to CHARDEV_FD<br>
=C2=A0 chardev: Rename MUX_CHARDEV to CHARDEV_MUX<br>
=C2=A0 chardev: Rename PARALLEL_CHARDEV to CHARDEV_PARALLEL<br>
=C2=A0 chardev: Rename PTY_CHARDEV to CHARDEV_PTY<br>
=C2=A0 chardev: Rename RINGBUF_CHARDEV to CHARDEV_RINGBUF<br>
=C2=A0 chardev: Rename SOCKET_CHARDEV to CHARDEV_SOCKET<br>
=C2=A0 chardev: Rename SPICE_CHARDEV to CHARDEV_SPICE<br>
=C2=A0 chardev: Rename TESTDEV_CHARDEV to CHARDEV_TESTDEV<br>
=C2=A0 chardev: Rename UDP_CHARDEV to CHARDEV_UDP<br>
=C2=A0 chardev: Rename VC_CHARDEV to CHARDEV_VC<br>
=C2=A0 chardev: Rename WCTABLET_CHARDEV to CHARDEV_WCTABLET<br>
=C2=A0 chardev: Rename WIN_CHARDEV to CHARDEV_WIN<br>
=C2=A0 chardev: Rename WIN_STDIO_CHARDEV to CHARDEV_WIN_STDIO<br>
<br>
=C2=A0chardev/chardev-internal.h |=C2=A0 2 +-<br>
=C2=A0include/chardev/char-fd.h=C2=A0 |=C2=A0 2 +-<br>
=C2=A0include/chardev/char-win.h |=C2=A0 2 +-<br>
=C2=A0include/chardev/spice.h=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0chardev/baum.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 14 ++=
++----<br>
=C2=A0chardev/char-fd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 14 ++++----<br>
=C2=A0chardev/char-fe.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +--<br>
=C2=A0chardev/char-mux.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 22 ++++++------=
<br>
=C2=A0chardev/char-parallel.c=C2=A0 =C2=A0 | 28 ++++++++--------<br>
=C2=A0chardev/char-pipe.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0chardev/char-pty.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 22 ++++++------=
<br>
=C2=A0chardev/char-ringbuf.c=C2=A0 =C2=A0 =C2=A0| 12 +++----<br>
=C2=A0chardev/char-serial.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0chardev/char-socket.c=C2=A0 =C2=A0 =C2=A0 | 68 +++++++++++++++++++---=
----------------<br>
=C2=A0chardev/char-udp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 14 ++++----<br>
=C2=A0chardev/char-win-stdio.c=C2=A0 =C2=A0| 14 ++++----<br>
=C2=A0chardev/char-win.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 14 ++++----<br>
=C2=A0chardev/char.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 2 +-<br>
=C2=A0chardev/msmouse.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 12 +++----<br>
=C2=A0chardev/spice.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 16 ++++---=
--<br>
=C2=A0chardev/testdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +--<br>
=C2=A0chardev/wctablet.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 12 +++----<br>
=C2=A0ui/console.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
10 +++---<br>
=C2=A0ui/gtk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 8 ++---<br>
=C2=A0ui/spice-app.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 2 +-<br>
=C2=A025 files changed, 151 insertions(+), 153 deletions(-)<br>
<br>
-- <br>
2.26.2<br>
<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000a7458705af052db3--

