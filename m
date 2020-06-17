Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6726EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2E620C09
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws57gUhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2E620C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlTJy-0002ER-Cj
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 04:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jlTJD-0001Uj-AC
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:20:35 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:42818)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jlTJA-0003MM-AB
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:20:35 -0400
Received: by mail-wr1-x431.google.com with SMTP id p5so1304585wrw.9
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 01:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TzkjuuPflHv9jDOWGAm/RYPX5agguPtT5dSHD0MYV/s=;
 b=Ws57gUhSiPkBcHl8pye2QWG7BbWrVooP5xLbDh0E0uRz4nDdB2L56weUkCncsnbKpp
 SZSHiLWVM1mj0XFBedGUXvl4nky2ZIv61Ik5071poLM1reiGK4eX+djzJl5AF/ptWv6l
 sI/9w3c2u7PhYiPe3G1+2Mz+NzJc2E6gdmuQH5Em+LPYBDkbOyxfrQIymp1ZQBZNSqqr
 hoK4ndCcb+lDbicwK3sxbBNS5Sg80UKLLwbybbKd3JpcQjVuxhaoCbHYzt9p6Q+F0HLR
 blLhlHTb+iJq/HMyeJdlJZutHTSf9KK0jBrpsyuWQ9XNf28svVdq9FMkO+LVkFCDD1B6
 lM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TzkjuuPflHv9jDOWGAm/RYPX5agguPtT5dSHD0MYV/s=;
 b=kWA1994OBnqXKUSR0gwW75ttv+FFd/6XaijqGuwVCy2M97Q3vO8iI/HVE3eVf+GIPB
 BH/wh0B+cRcCH9z7EKKBt+3kNeipOQI5AzNI/kvBgwNmVgVqRpX+e3nz/82r+LMN/VHX
 1SDEYpaNeQ3C05bcObLh4CQLXOVvMNrBQnmI+bRulzj3BsO22SbwuuWisBKGURfnoVlE
 umxjW3cY7MHpDAYr0QuDlildqe0t6X4A8jYb5S98BuVz/DysYGkASdvOjo+wBeTv2fa6
 v4k0xayFeadGMgWT0yeMhLDYvqq/rSPjgxqNi8/AYiIQvuFpxHBP/4nvhGDgF//ymXeC
 s6gQ==
X-Gm-Message-State: AOAM532BI3uxLfD1Mw9bLQ2yopv7XqtZ7WLTZtB7ktk0ZFV8QjznYO3H
 FqWaHtuJuIsroFUrFeQ48EVyma7lglNpgOBNuf0=
X-Google-Smtp-Source: ABdhPJwTghI1CElGTorAq2s6oMQ103qanI7TfRnwbqrJSwmq5++hek/Ji112Lk9rhYTkntyFgakNsE+viMtMMbSXhnY=
X-Received: by 2002:adf:fec8:: with SMTP id q8mr7460716wrs.2.1592382030563;
 Wed, 17 Jun 2020 01:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200428085122.1621-1-fengli@smarx.com>
 <20200522025554.41063-1-fengli@smartx.com>
 <20200615084341.GA25038@dimastep-nix>
 <CAHckoCyj9JteH0_v08mCU36P3Tz47VsWfjWbUP_NL8d7pzMGwA@mail.gmail.com>
In-Reply-To: <CAHckoCyj9JteH0_v08mCU36P3Tz47VsWfjWbUP_NL8d7pzMGwA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 17 Jun 2020 12:20:17 +0400
Message-ID: <CAJ+F1CJS_Zarbx-4FSAODcZKKtD1qLffuwhJX_4CYYTLb6LyCQ@mail.gmail.com>
Subject: Re: [PATCH v5] char-socket: initialize reconnect timer only when the
 timer doesn't start
To: Li Feng <fengli@smartx.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000474d6805a84355f5"
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Dima Stepanov <dimastep@yandex-team.ru>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000474d6805a84355f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jun 17, 2020 at 12:09 PM Li Feng <fengli@smartx.com> wrote:

> Hi Lureau,
>
> When will this patch be merged?
>
>
Paolo, can you queue it?
thanks

Thanks, Feng Li.
>
> ---------- Forwarded message ---------
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A Dima Stepanov <dimastep@yandex-team.=
ru>
> Date: 2020=E5=B9=B46=E6=9C=8815=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=
=8D=884:43
> Subject: Re: [PATCH v5] char-socket: initialize reconnect timer only
> when the timer doesn't start
> To: Li Feng <fengli@smartx.com>
>
>
> Hi,
>
> I don't see this change merged to upstream. Any updates on it?
>
> Thanks, Dima.
>
>
> On Fri, May 22, 2020 at 10:55:54AM +0800, Li Feng wrote:
> > When the disconnect event is triggered in the connecting stage,
> > the tcp_chr_disconnect_locked may be called twice.
> >
> > The first call:
> >     #0  qemu_chr_socket_restart_timer (chr=3D0x55555582ee90) at
> chardev/char-socket.c:120
> >     #1  0x000055555558e38c in tcp_chr_disconnect_locked (chr=3D<optimiz=
ed
> out>) at chardev/char-socket.c:490
> >     #2  0x000055555558e3cd in tcp_chr_disconnect (chr=3D0x55555582ee90)=
 at
> chardev/char-socket.c:497
> >     #3  0x000055555558ea32 in tcp_chr_new_client (chr=3Dchr@entry=3D0x5=
5555582ee90,
> sioc=3Dsioc@entry=3D0x55555582f0b0) at chardev/char-socket.c:892
> >     #4  0x000055555558eeb8 in qemu_chr_socket_connected
> (task=3D0x55555582f300, opaque=3D<optimized out>) at chardev/char-socket.=
c:1090
> >     #5  0x0000555555574352 in qio_task_complete (task=3Dtask@entry=3D0x=
55555582f300)
> at io/task.c:196
> >     #6  0x00005555555745f4 in qio_task_thread_result
> (opaque=3D0x55555582f300) at io/task.c:111
> >     #7  qio_task_wait_thread (task=3D0x55555582f300) at io/task.c:190
> >     #8  0x000055555558f17e in tcp_chr_wait_connected
> (chr=3D0x55555582ee90, errp=3D0x555555802a08 <error_abort>) at
> chardev/char-socket.c:1013
> >     #9  0x0000555555567cbd in char_socket_client_reconnect_test
> (opaque=3D0x5555557fe020 <client8unix>) at tests/test-char.c:1152
> > The second call:
> >     #0  0x00007ffff5ac3277 in raise () from /lib64/libc.so.6
> >     #1  0x00007ffff5ac4968 in abort () from /lib64/libc.so.6
> >     #2  0x00007ffff5abc096 in __assert_fail_base () from /lib64/libc.so=
.6
> >     #3  0x00007ffff5abc142 in __assert_fail () from /lib64/libc.so.6
> >     #4  0x000055555558d10a in qemu_chr_socket_restart_timer
> (chr=3D0x55555582ee90) at chardev/char-socket.c:125
> >     #5  0x000055555558df0c in tcp_chr_disconnect_locked (chr=3D<optimiz=
ed
> out>) at chardev/char-socket.c:490
> >     #6  0x000055555558df4d in tcp_chr_disconnect (chr=3D0x55555582ee90)=
 at
> chardev/char-socket.c:497
> >     #7  0x000055555558e5b2 in tcp_chr_new_client (chr=3Dchr@entry=3D0x5=
5555582ee90,
> sioc=3Dsioc@entry=3D0x55555582f0b0) at chardev/char-socket.c:892
> >     #8  0x000055555558e93a in tcp_chr_connect_client_sync (chr=3Dchr@en=
try=3D0x55555582ee90,
> errp=3Derrp@entry=3D0x7fffffffd178) at chardev/char-socket.c:944
> >     #9  0x000055555558ec78 in tcp_chr_wait_connected
> (chr=3D0x55555582ee90, errp=3D0x555555802a08 <error_abort>) at
> chardev/char-socket.c:1035
> >     #10 0x000055555556804b in char_socket_client_test
> (opaque=3D0x5555557fe020 <client8unix>) at tests/test-char.c:1023
> >
> > Run test/test-char to reproduce this issue.
> >
> > test-char: chardev/char-socket.c:125: qemu_chr_socket_restart_timer:
> Assertion `!s->reconnect_timer' failed.
> >
> > Signed-off-by: Li Feng <fengli@smartx.com>
> > ---
> > v5:
> > - rebase to master
> >
> > v4:
> > - remove the wrong patch
> > - fix the char_socket_ping_pong to support the reconnect exception test
> >
> > v3:
> > - add a patch to fix a crash when recvmsg return 0
> > - make the tests reproduce the two crash
> >
> > v2:
> > - add unit test
> >
> >  chardev/char-socket.c |  2 +-
> >  tests/test-char.c     | 73
> +++++++++++++++++++++++++++++++++++++++------------
> >  2 files changed, 57 insertions(+), 18 deletions(-)
> >
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index e77699db48..8af7fdce88 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -486,7 +486,7 @@ static void tcp_chr_disconnect_locked(Chardev *chr)
> >      if (emit_close) {
> >          qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
> >      }
> > -    if (s->reconnect_time) {
> > +    if (s->reconnect_time && !s->reconnect_timer) {
> >          qemu_chr_socket_restart_timer(chr);
> >      }
> >  }
> > diff --git a/tests/test-char.c b/tests/test-char.c
> > index 3afc9b1b8d..73ba1cf601 100644
> > --- a/tests/test-char.c
> > +++ b/tests/test-char.c
> > @@ -625,12 +625,14 @@ static void char_udp_test(void)
> >  typedef struct {
> >      int event;
> >      bool got_pong;
> > +    CharBackend *be;
> >  } CharSocketTestData;
> >
> >
> >  #define SOCKET_PING "Hello"
> >  #define SOCKET_PONG "World"
> >
> > +typedef void (*char_socket_cb)(void *opaque, QEMUChrEvent event);
> >
> >  static void
> >  char_socket_event(void *opaque, QEMUChrEvent event)
> > @@ -639,6 +641,27 @@ char_socket_event(void *opaque, QEMUChrEvent event=
)
> >      data->event =3D event;
> >  }
> >
> > +static void
> > +char_socket_event_with_error(void *opaque, QEMUChrEvent event)
> > +{
> > +    static bool first_error;
> > +    CharSocketTestData *data =3D opaque;
> > +    CharBackend *be =3D data->be;
> > +    data->event =3D event;
> > +    switch (event) {
> > +    case CHR_EVENT_OPENED:
> > +        if (!first_error) {
> > +            first_error =3D true;
> > +            qemu_chr_fe_disconnect(be);
> > +        }
> > +        return;
> > +    case CHR_EVENT_CLOSED:
> > +        return;
> > +    default:
> > +        return;
> > +    }
> > +}
> > +
> >
> >  static void
> >  char_socket_read(void *opaque, const uint8_t *buf, int size)
> > @@ -699,19 +722,24 @@ char_socket_addr_to_opt_str(SocketAddress *addr,
> bool fd_pass,
> >  }
> >
> >
> > -static void
> > -char_socket_ping_pong(QIOChannel *ioc)
> > +static int
> > +char_socket_ping_pong(QIOChannel *ioc, Error **errp)
> >  {
> >      char greeting[sizeof(SOCKET_PING)];
> >      const char *response =3D SOCKET_PONG;
> >
> > -    qio_channel_read_all(ioc, greeting, sizeof(greeting), &error_abort=
);
> > +    int ret;
> > +    ret =3D qio_channel_read_all(ioc, greeting, sizeof(greeting), errp=
);
> > +    if (ret !=3D 0) {
> > +        object_unref(OBJECT(ioc));
> > +        return -1;
> > +    }
> >
> >      g_assert(memcmp(greeting, SOCKET_PING, sizeof(greeting)) =3D=3D 0)=
;
> >
> > -    qio_channel_write_all(ioc, response, sizeof(SOCKET_PONG),
> &error_abort);
> > -
> > +    qio_channel_write_all(ioc, response, sizeof(SOCKET_PONG), errp);
> >      object_unref(OBJECT(ioc));
> > +    return 0;
> >  }
> >
> >
> > @@ -723,7 +751,7 @@ char_socket_server_client_thread(gpointer data)
> >
> >      qio_channel_socket_connect_sync(ioc, addr, &error_abort);
> >
> > -    char_socket_ping_pong(QIO_CHANNEL(ioc));
> > +    char_socket_ping_pong(QIO_CHANNEL(ioc), &error_abort);
> >
> >      return NULL;
> >  }
> > @@ -783,6 +811,7 @@ static void char_socket_server_test(gconstpointer
> opaque)
> >
> >   reconnect:
> >      data.event =3D -1;
> > +    data.be =3D &be;
> >      qemu_chr_fe_set_handlers(&be, NULL, NULL,
> >                               char_socket_event, NULL,
> >                               &data, NULL, true);
> > @@ -855,10 +884,13 @@ char_socket_client_server_thread(gpointer data)
> >      QIOChannelSocket *ioc =3D data;
> >      QIOChannelSocket *cioc;
> >
> > +retry:
> >      cioc =3D qio_channel_socket_accept(ioc, &error_abort);
> >      g_assert_nonnull(cioc);
> >
> > -    char_socket_ping_pong(QIO_CHANNEL(cioc));
> > +    if (char_socket_ping_pong(QIO_CHANNEL(cioc), NULL) !=3D 0) {
> > +        goto retry;
> > +    }
> >
> >      return NULL;
> >  }
> > @@ -869,12 +901,13 @@ typedef struct {
> >      const char *reconnect;
> >      bool wait_connected;
> >      bool fd_pass;
> > +    char_socket_cb event_cb;
> >  } CharSocketClientTestConfig;
> >
> > -
> >  static void char_socket_client_test(gconstpointer opaque)
> >  {
> >      const CharSocketClientTestConfig *config =3D opaque;
> > +    const char_socket_cb event_cb =3D config->event_cb;
> >      QIOChannelSocket *ioc;
> >      char *optstr;
> >      Chardev *chr;
> > @@ -938,8 +971,9 @@ static void char_socket_client_test(gconstpointer
> opaque)
> >
> >   reconnect:
> >      data.event =3D -1;
> > +    data.be =3D &be;
> >      qemu_chr_fe_set_handlers(&be, NULL, NULL,
> > -                             char_socket_event, NULL,
> > +                             event_cb, NULL,
> >                               &data, NULL, true);
> >      if (config->reconnect) {
> >          g_assert(data.event =3D=3D -1);
> > @@ -977,7 +1011,7 @@ static void char_socket_client_test(gconstpointer
> opaque)
> >      /* Setup a callback to receive the reply to our greeting */
> >      qemu_chr_fe_set_handlers(&be, char_socket_can_read,
> >                               char_socket_read,
> > -                             char_socket_event, NULL,
> > +                             event_cb, NULL,
> >                               &data, NULL, true);
> >      g_assert(data.event =3D=3D CHR_EVENT_OPENED);
> >      data.event =3D -1;
> > @@ -1422,17 +1456,20 @@ int main(int argc, char **argv)
> >
> >  #define SOCKET_CLIENT_TEST(name, addr)
> \
> >      static CharSocketClientTestConfig client1 ## name =3D
>  \
> > -        { addr, NULL, false, false };
>  \
> > +        { addr, NULL, false, false, char_socket_event};
>  \
> >      static CharSocketClientTestConfig client2 ## name =3D
>  \
> > -        { addr, NULL, true, false };
> \
> > +        { addr, NULL, true, false, char_socket_event };
>  \
> >      static CharSocketClientTestConfig client3 ## name =3D
>  \
> > -        { addr, ",reconnect=3D1", false };
> \
> > +        { addr, ",reconnect=3D1", false, false, char_socket_event };
> \
> >      static CharSocketClientTestConfig client4 ## name =3D
>  \
> > -        { addr, ",reconnect=3D1", true };
>  \
> > +        { addr, ",reconnect=3D1", true, false, char_socket_event };
>  \
> >      static CharSocketClientTestConfig client5 ## name =3D
>  \
> > -        { addr, NULL, false, true };
> \
> > +        { addr, NULL, false, true, char_socket_event };
>  \
> >      static CharSocketClientTestConfig client6 ## name =3D
>  \
> > -        { addr, NULL, true, true };
>  \
> > +        { addr, NULL, true, true, char_socket_event };
> \
> > +    static CharSocketClientTestConfig client7 ## name =3D
>  \
> > +        { addr, ",reconnect=3D1", true, false,
> \
> > +            char_socket_event_with_error };
>  \
> >      g_test_add_data_func("/char/socket/client/mainloop/" # name,
> \
> >                           &client1 ##name, char_socket_client_test);
>  \
> >      g_test_add_data_func("/char/socket/client/wait-conn/" # name,
>  \
> > @@ -1444,7 +1481,9 @@ int main(int argc, char **argv)
> >      g_test_add_data_func("/char/socket/client/mainloop-fdpass/" # name=
,
> \
> >                           &client5 ##name, char_socket_client_test);
>  \
> >      g_test_add_data_func("/char/socket/client/wait-conn-fdpass/" #
> name, \
> > -                         &client6 ##name, char_socket_client_test)
> > +                         &client6 ##name, char_socket_client_test);
>  \
> > +    g_test_add_data_func("/char/socket/client/reconnect-error/" # name=
,
> \
> > +                         &client7 ##name, char_socket_client_test)
> >
> >      if (has_ipv4) {
> >          SOCKET_SERVER_TEST(tcp, &tcpaddr);
> > --
> > 2.11.0
> >
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000474d6805a84355f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 17, 2020 at 12:09 PM Li=
 Feng &lt;<a href=3D"mailto:fengli@smartx.com">fengli@smartx.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Lureau,<=
br>
<br>
When will this patch be merged?<br>
<br></blockquote><div><br></div><div>Paolo, can you queue it?</div><div>tha=
nks</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Thanks, Feng Li.<br>
<br>
---------- Forwarded message ---------<br>
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A Dima Stepanov &lt;<a href=3D"mailto:di=
mastep@yandex-team.ru" target=3D"_blank">dimastep@yandex-team.ru</a>&gt;<br=
>
Date: 2020=E5=B9=B46=E6=9C=8815=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=
=884:43<br>
Subject: Re: [PATCH v5] char-socket: initialize reconnect timer only<br>
when the timer doesn&#39;t start<br>
To: Li Feng &lt;<a href=3D"mailto:fengli@smartx.com" target=3D"_blank">feng=
li@smartx.com</a>&gt;<br>
<br>
<br>
Hi,<br>
<br>
I don&#39;t see this change merged to upstream. Any updates on it?<br>
<br>
Thanks, Dima.<br>
<br>
<br>
On Fri, May 22, 2020 at 10:55:54AM +0800, Li Feng wrote:<br>
&gt; When the disconnect event is triggered in the connecting stage,<br>
&gt; the tcp_chr_disconnect_locked may be called twice.<br>
&gt;<br>
&gt; The first call:<br>
&gt;=C2=A0 =C2=A0 =C2=A0#0=C2=A0 qemu_chr_socket_restart_timer (chr=3D0x555=
55582ee90) at chardev/char-socket.c:120<br>
&gt;=C2=A0 =C2=A0 =C2=A0#1=C2=A0 0x000055555558e38c in tcp_chr_disconnect_l=
ocked (chr=3D&lt;optimized out&gt;) at chardev/char-socket.c:490<br>
&gt;=C2=A0 =C2=A0 =C2=A0#2=C2=A0 0x000055555558e3cd in tcp_chr_disconnect (=
chr=3D0x55555582ee90) at chardev/char-socket.c:497<br>
&gt;=C2=A0 =C2=A0 =C2=A0#3=C2=A0 0x000055555558ea32 in tcp_chr_new_client (=
chr=3Dchr@entry=3D0x55555582ee90, sioc=3Dsioc@entry=3D0x55555582f0b0) at ch=
ardev/char-socket.c:892<br>
&gt;=C2=A0 =C2=A0 =C2=A0#4=C2=A0 0x000055555558eeb8 in qemu_chr_socket_conn=
ected (task=3D0x55555582f300, opaque=3D&lt;optimized out&gt;) at chardev/ch=
ar-socket.c:1090<br>
&gt;=C2=A0 =C2=A0 =C2=A0#5=C2=A0 0x0000555555574352 in qio_task_complete (t=
ask=3Dtask@entry=3D0x55555582f300) at io/task.c:196<br>
&gt;=C2=A0 =C2=A0 =C2=A0#6=C2=A0 0x00005555555745f4 in qio_task_thread_resu=
lt (opaque=3D0x55555582f300) at io/task.c:111<br>
&gt;=C2=A0 =C2=A0 =C2=A0#7=C2=A0 qio_task_wait_thread (task=3D0x55555582f30=
0) at io/task.c:190<br>
&gt;=C2=A0 =C2=A0 =C2=A0#8=C2=A0 0x000055555558f17e in tcp_chr_wait_connect=
ed (chr=3D0x55555582ee90, errp=3D0x555555802a08 &lt;error_abort&gt;) at cha=
rdev/char-socket.c:1013<br>
&gt;=C2=A0 =C2=A0 =C2=A0#9=C2=A0 0x0000555555567cbd in char_socket_client_r=
econnect_test (opaque=3D0x5555557fe020 &lt;client8unix&gt;) at tests/test-c=
har.c:1152<br>
&gt; The second call:<br>
&gt;=C2=A0 =C2=A0 =C2=A0#0=C2=A0 0x00007ffff5ac3277 in raise () from /lib64=
/libc.so.6<br>
&gt;=C2=A0 =C2=A0 =C2=A0#1=C2=A0 0x00007ffff5ac4968 in abort () from /lib64=
/libc.so.6<br>
&gt;=C2=A0 =C2=A0 =C2=A0#2=C2=A0 0x00007ffff5abc096 in __assert_fail_base (=
) from /lib64/libc.so.6<br>
&gt;=C2=A0 =C2=A0 =C2=A0#3=C2=A0 0x00007ffff5abc142 in __assert_fail () fro=
m /lib64/libc.so.6<br>
&gt;=C2=A0 =C2=A0 =C2=A0#4=C2=A0 0x000055555558d10a in qemu_chr_socket_rest=
art_timer (chr=3D0x55555582ee90) at chardev/char-socket.c:125<br>
&gt;=C2=A0 =C2=A0 =C2=A0#5=C2=A0 0x000055555558df0c in tcp_chr_disconnect_l=
ocked (chr=3D&lt;optimized out&gt;) at chardev/char-socket.c:490<br>
&gt;=C2=A0 =C2=A0 =C2=A0#6=C2=A0 0x000055555558df4d in tcp_chr_disconnect (=
chr=3D0x55555582ee90) at chardev/char-socket.c:497<br>
&gt;=C2=A0 =C2=A0 =C2=A0#7=C2=A0 0x000055555558e5b2 in tcp_chr_new_client (=
chr=3Dchr@entry=3D0x55555582ee90, sioc=3Dsioc@entry=3D0x55555582f0b0) at ch=
ardev/char-socket.c:892<br>
&gt;=C2=A0 =C2=A0 =C2=A0#8=C2=A0 0x000055555558e93a in tcp_chr_connect_clie=
nt_sync (chr=3Dchr@entry=3D0x55555582ee90, errp=3Derrp@entry=3D0x7fffffffd1=
78) at chardev/char-socket.c:944<br>
&gt;=C2=A0 =C2=A0 =C2=A0#9=C2=A0 0x000055555558ec78 in tcp_chr_wait_connect=
ed (chr=3D0x55555582ee90, errp=3D0x555555802a08 &lt;error_abort&gt;) at cha=
rdev/char-socket.c:1035<br>
&gt;=C2=A0 =C2=A0 =C2=A0#10 0x000055555556804b in char_socket_client_test (=
opaque=3D0x5555557fe020 &lt;client8unix&gt;) at tests/test-char.c:1023<br>
&gt;<br>
&gt; Run test/test-char to reproduce this issue.<br>
&gt;<br>
&gt; test-char: chardev/char-socket.c:125: qemu_chr_socket_restart_timer: A=
ssertion `!s-&gt;reconnect_timer&#39; failed.<br>
&gt;<br>
&gt; Signed-off-by: Li Feng &lt;<a href=3D"mailto:fengli@smartx.com" target=
=3D"_blank">fengli@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt; v5:<br>
&gt; - rebase to master<br>
&gt;<br>
&gt; v4:<br>
&gt; - remove the wrong patch<br>
&gt; - fix the char_socket_ping_pong to support the reconnect exception tes=
t<br>
&gt;<br>
&gt; v3:<br>
&gt; - add a patch to fix a crash when recvmsg return 0<br>
&gt; - make the tests reproduce the two crash<br>
&gt;<br>
&gt; v2:<br>
&gt; - add unit test<br>
&gt;<br>
&gt;=C2=A0 chardev/char-socket.c |=C2=A0 2 +-<br>
&gt;=C2=A0 tests/test-char.c=C2=A0 =C2=A0 =C2=A0| 73 ++++++++++++++++++++++=
+++++++++++++++++------------<br>
&gt;=C2=A0 2 files changed, 57 insertions(+), 18 deletions(-)<br>
&gt;<br>
&gt; diff --git a/chardev/char-socket.c b/chardev/char-socket.c<br>
&gt; index e77699db48..8af7fdce88 100644<br>
&gt; --- a/chardev/char-socket.c<br>
&gt; +++ b/chardev/char-socket.c<br>
&gt; @@ -486,7 +486,7 @@ static void tcp_chr_disconnect_locked(Chardev *chr=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (emit_close) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_be_event(chr, CHR_EVENT_CLO=
SED);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 if (s-&gt;reconnect_time) {<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;reconnect_time &amp;&amp; !s-&gt;reconnect_ti=
mer) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_socket_restart_timer(chr);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/tests/test-char.c b/tests/test-char.c<br>
&gt; index 3afc9b1b8d..73ba1cf601 100644<br>
&gt; --- a/tests/test-char.c<br>
&gt; +++ b/tests/test-char.c<br>
&gt; @@ -625,12 +625,14 @@ static void char_udp_test(void)<br>
&gt;=C2=A0 typedef struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int event;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool got_pong;<br>
&gt; +=C2=A0 =C2=A0 CharBackend *be;<br>
&gt;=C2=A0 } CharSocketTestData;<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 #define SOCKET_PING &quot;Hello&quot;<br>
&gt;=C2=A0 #define SOCKET_PONG &quot;World&quot;<br>
&gt;<br>
&gt; +typedef void (*char_socket_cb)(void *opaque, QEMUChrEvent event);<br>
&gt;<br>
&gt;=C2=A0 static void<br>
&gt;=C2=A0 char_socket_event(void *opaque, QEMUChrEvent event)<br>
&gt; @@ -639,6 +641,27 @@ char_socket_event(void *opaque, QEMUChrEvent even=
t)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 data-&gt;event =3D event;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +static void<br>
&gt; +char_socket_event_with_error(void *opaque, QEMUChrEvent event)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 static bool first_error;<br>
&gt; +=C2=A0 =C2=A0 CharSocketTestData *data =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 CharBackend *be =3D data-&gt;be;<br>
&gt; +=C2=A0 =C2=A0 data-&gt;event =3D event;<br>
&gt; +=C2=A0 =C2=A0 switch (event) {<br>
&gt; +=C2=A0 =C2=A0 case CHR_EVENT_OPENED:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!first_error) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 first_error =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_fe_disconnect(be);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 case CHR_EVENT_CLOSED:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt;<br>
&gt;=C2=A0 static void<br>
&gt;=C2=A0 char_socket_read(void *opaque, const uint8_t *buf, int size)<br>
&gt; @@ -699,19 +722,24 @@ char_socket_addr_to_opt_str(SocketAddress *addr,=
 bool fd_pass,<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;<br>
&gt; -static void<br>
&gt; -char_socket_ping_pong(QIOChannel *ioc)<br>
&gt; +static int<br>
&gt; +char_socket_ping_pong(QIOChannel *ioc, Error **errp)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 char greeting[sizeof(SOCKET_PING)];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 const char *response =3D SOCKET_PONG;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 qio_channel_read_all(ioc, greeting, sizeof(greeting), &=
amp;error_abort);<br>
&gt; +=C2=A0 =C2=A0 int ret;<br>
&gt; +=C2=A0 =C2=A0 ret =3D qio_channel_read_all(ioc, greeting, sizeof(gree=
ting), errp);<br>
&gt; +=C2=A0 =C2=A0 if (ret !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_unref(OBJECT(ioc));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_assert(memcmp(greeting, SOCKET_PING, sizeof(gree=
ting)) =3D=3D 0);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 qio_channel_write_all(ioc, response, sizeof(SOCKET_PONG=
), &amp;error_abort);<br>
&gt; -<br>
&gt; +=C2=A0 =C2=A0 qio_channel_write_all(ioc, response, sizeof(SOCKET_PONG=
), errp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 object_unref(OBJECT(ioc));<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;<br>
&gt; @@ -723,7 +751,7 @@ char_socket_server_client_thread(gpointer data)<br=
>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qio_channel_socket_connect_sync(ioc, addr, &amp;er=
ror_abort);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 char_socket_ping_pong(QIO_CHANNEL(ioc));<br>
&gt; +=C2=A0 =C2=A0 char_socket_ping_pong(QIO_CHANNEL(ioc), &amp;error_abor=
t);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt;=C2=A0 }<br>
&gt; @@ -783,6 +811,7 @@ static void char_socket_server_test(gconstpointer =
opaque)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0reconnect:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 data.event =3D -1;<br>
&gt; +=C2=A0 =C2=A0 <a href=3D"http://data.be" rel=3D"noreferrer" target=3D=
"_blank">data.be</a> =3D &amp;be;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_chr_fe_set_handlers(&amp;be, NULL, NULL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char_socket_event, NULL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;data, NULL, true);<br>
&gt; @@ -855,10 +884,13 @@ char_socket_client_server_thread(gpointer data)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 QIOChannelSocket *ioc =3D data;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QIOChannelSocket *cioc;<br>
&gt;<br>
&gt; +retry:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cioc =3D qio_channel_socket_accept(ioc, &amp;error=
_abort);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_assert_nonnull(cioc);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 char_socket_ping_pong(QIO_CHANNEL(cioc));<br>
&gt; +=C2=A0 =C2=A0 if (char_socket_ping_pong(QIO_CHANNEL(cioc), NULL) !=3D=
 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto retry;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt;=C2=A0 }<br>
&gt; @@ -869,12 +901,13 @@ typedef struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 const char *reconnect;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool wait_connected;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool fd_pass;<br>
&gt; +=C2=A0 =C2=A0 char_socket_cb event_cb;<br>
&gt;=C2=A0 } CharSocketClientTestConfig;<br>
&gt;<br>
&gt; -<br>
&gt;=C2=A0 static void char_socket_client_test(gconstpointer opaque)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 const CharSocketClientTestConfig *config =3D opaqu=
e;<br>
&gt; +=C2=A0 =C2=A0 const char_socket_cb event_cb =3D config-&gt;event_cb;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 QIOChannelSocket *ioc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 char *optstr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Chardev *chr;<br>
&gt; @@ -938,8 +971,9 @@ static void char_socket_client_test(gconstpointer =
opaque)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0reconnect:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 data.event =3D -1;<br>
&gt; +=C2=A0 =C2=A0 <a href=3D"http://data.be" rel=3D"noreferrer" target=3D=
"_blank">data.be</a> =3D &amp;be;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_chr_fe_set_handlers(&amp;be, NULL, NULL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char_socket_event, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0event_cb, NULL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;data, NULL, true);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (config-&gt;reconnect) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(data.event =3D=3D -1);<br>
&gt; @@ -977,7 +1011,7 @@ static void char_socket_client_test(gconstpointer=
 opaque)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Setup a callback to receive the reply to our gr=
eeting */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_chr_fe_set_handlers(&amp;be, char_socket_can_=
read,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char_socket_read,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char_socket_event, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0event_cb, NULL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;data, NULL, true);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_assert(data.event =3D=3D CHR_EVENT_OPENED);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 data.event =3D -1;<br>
&gt; @@ -1422,17 +1456,20 @@ int main(int argc, char **argv)<br>
&gt;<br>
&gt;=C2=A0 #define SOCKET_CLIENT_TEST(name, addr)=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 static CharSocketClientTestConfig client1 ## name =
=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 { addr, NULL, false, false };=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 { addr, NULL, false, false, char_socket_e=
vent};=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 static CharSocketClientTestConfig client2 ## name =
=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 { addr, NULL, true, false };=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 { addr, NULL, true, false, char_socket_ev=
ent };=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 static CharSocketClientTestConfig client3 ## name =
=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 { addr, &quot;,reconnect=3D1&quot;, false=
 };=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 { addr, &quot;,reconnect=3D1&quot;, false=
, false, char_socket_event };=C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 static CharSocketClientTestConfig client4 ## name =
=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 { addr, &quot;,reconnect=3D1&quot;, true =
};=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 { addr, &quot;,reconnect=3D1&quot;, true,=
 false, char_socket_event };=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 static CharSocketClientTestConfig client5 ## name =
=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 { addr, NULL, false, true };=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 { addr, NULL, false, true, char_socket_ev=
ent };=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 static CharSocketClientTestConfig client6 ## name =
=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 { addr, NULL, true, true };=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 { addr, NULL, true, true, char_socket_eve=
nt };=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 static CharSocketClientTestConfig client7 ## name =3D=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 { addr, &quot;,reconnect=3D1&quot;, true,=
 false,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char_socket_event_with_erro=
r };=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_add_data_func(&quot;/char/socket/client/mai=
nloop/&quot; # name,=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;client1 ##name, char_socket_client_test);=
=C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_add_data_func(&quot;/char/socket/client/wai=
t-conn/&quot; # name,=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; @@ -1444,7 +1481,9 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_add_data_func(&quot;/char/socket/client/mai=
nloop-fdpass/&quot; # name, \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;client5 ##name, char_socket_client_test);=
=C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_add_data_func(&quot;/char/socket/client/wai=
t-conn-fdpass/&quot; # name, \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&amp;client6 ##name, char_socket_client_test)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&amp;client6 ##name, char_socket_client_test);=C2=A0 =
=C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 g_test_add_data_func(&quot;/char/socket/client/reconnec=
t-error/&quot; # name, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&amp;client7 ##name, char_socket_client_test)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (has_ipv4) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SOCKET_SERVER_TEST(tcp, &amp;tcpaddr=
);<br>
&gt; --<br>
&gt; 2.11.0<br>
&gt;<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000474d6805a84355f5--

