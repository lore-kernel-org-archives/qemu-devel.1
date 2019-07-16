Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247BCC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 09:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF8A220665
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 09:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8A220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnKD0-0000FI-RS
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 05:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37489)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hnKCo-0008IH-JN
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 05:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hnKCl-0001OI-L1
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 05:57:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24383)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1hnKCl-0001Nb-AM
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 05:57:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9E1B6305D65A;
 Tue, 16 Jul 2019 09:57:02 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD502100164A;
 Tue, 16 Jul 2019 09:56:57 +0000 (UTC)
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1550842915.git.berto@igalia.com>
 <48f7e50413f6f222acb1bf3a9de773e387a2855a.1550842915.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <aa321302-66ae-65ec-c485-43de43eeb1d5@redhat.com>
Date: Tue, 16 Jul 2019 11:56:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <48f7e50413f6f222acb1bf3a9de773e387a2855a.1550842915.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BDUoq6w3BL3Qi2nNGJ4NxJqTVoIqdxgTV"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 16 Jul 2019 09:57:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 3/3] char-socket: Lock
 tcp_chr_disconnect() and socket_reconnect_timeout()
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BDUoq6w3BL3Qi2nNGJ4NxJqTVoIqdxgTV
Content-Type: multipart/mixed; boundary="VPvdOypUyO0ZGEIeW7Y617NlBFo9bUBiA";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Message-ID: <aa321302-66ae-65ec-c485-43de43eeb1d5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] char-socket: Lock
 tcp_chr_disconnect() and socket_reconnect_timeout()
References: <cover.1550842915.git.berto@igalia.com>
 <48f7e50413f6f222acb1bf3a9de773e387a2855a.1550842915.git.berto@igalia.com>
In-Reply-To: <48f7e50413f6f222acb1bf3a9de773e387a2855a.1550842915.git.berto@igalia.com>

--VPvdOypUyO0ZGEIeW7Y617NlBFo9bUBiA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.02.19 14:46, Alberto Garcia wrote:
> There's a race condition in which the tcp_chr_read() ioc handler can
> close a connection that is being written to from another thread.
>=20
> Running iotest 136 in a loop triggers this problem and crashes QEMU.
>=20
>  (gdb) bt
>  #0  0x00005558b842902d in object_get_class (obj=3D0x0) at qom/object.c=
:860
>  #1  0x00005558b84f92db in qio_channel_writev_full (ioc=3D0x0, iov=3D0x=
7ffc355decf0, niov=3D1, fds=3D0x0, nfds=3D0, errp=3D0x0) at io/channel.c:=
76
>  #2  0x00005558b84e0e9e in io_channel_send_full (ioc=3D0x0, buf=3D0x555=
8baf5beb0, len=3D138, fds=3D0x0, nfds=3D0) at chardev/char-io.c:123
>  #3  0x00005558b84e4a69 in tcp_chr_write (chr=3D0x5558ba460380, buf=3D0=
x5558baf5beb0 "...", len=3D138) at chardev/char-socket.c:135
>  #4  0x00005558b84dca55 in qemu_chr_write_buffer (s=3D0x5558ba460380, b=
uf=3D0x5558baf5beb0 "...", len=3D138, offset=3D0x7ffc355dedd0, write_all=3D=
false) at chardev/char.c:112
>  #5  0x00005558b84dcbc2 in qemu_chr_write (s=3D0x5558ba460380, buf=3D0x=
5558baf5beb0 "...", len=3D138, write_all=3Dfalse) at chardev/char.c:147
>  #6  0x00005558b84dfb26 in qemu_chr_fe_write (be=3D0x5558ba476610, buf=3D=
0x5558baf5beb0 "...", len=3D138) at chardev/char-fe.c:42
>  #7  0x00005558b8088c86 in monitor_flush_locked (mon=3D0x5558ba476610) =
at monitor.c:406
>  #8  0x00005558b8088e8c in monitor_puts (mon=3D0x5558ba476610, str=3D0x=
5558ba921e49 "") at monitor.c:449
>  #9  0x00005558b8089178 in qmp_send_response (mon=3D0x5558ba476610, rsp=
=3D0x5558bb161600) at monitor.c:498
>  #10 0x00005558b808920c in monitor_qapi_event_emit (event=3DQAPI_EVENT_=
SHUTDOWN, qdict=3D0x5558bb161600) at monitor.c:526
>  #11 0x00005558b8089307 in monitor_qapi_event_queue_no_reenter (event=3D=
QAPI_EVENT_SHUTDOWN, qdict=3D0x5558bb161600) at monitor.c:551
>  #12 0x00005558b80896c0 in qapi_event_emit (event=3DQAPI_EVENT_SHUTDOWN=
, qdict=3D0x5558bb161600) at monitor.c:626
>  #13 0x00005558b855f23b in qapi_event_send_shutdown (guest=3Dfalse, rea=
son=3DSHUTDOWN_CAUSE_HOST_QMP_QUIT) at qapi/qapi-events-run-state.c:43
>  #14 0x00005558b81911ef in qemu_system_shutdown (cause=3DSHUTDOWN_CAUSE=
_HOST_QMP_QUIT) at vl.c:1837
>  #15 0x00005558b8191308 in main_loop_should_exit () at vl.c:1885
>  #16 0x00005558b819140d in main_loop () at vl.c:1924
>  #17 0x00005558b8198c84 in main (argc=3D18, argv=3D0x7ffc355df3f8, envp=
=3D0x7ffc355df490) at vl.c:4665
>=20
> This patch adds a lock to protect tcp_chr_disconnect() and
> socket_reconnect_timeout()
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  chardev/char-socket.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 4fcdd8aedd..94522777dc 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c

[...]

> @@ -464,11 +464,19 @@ static void update_disconnected_filename(SocketCh=
ardev *s)
>      }
>  }
> =20
> +static gboolean tcp_chr_be_event_closed(gpointer opaque)
> +{
> +    Chardev *chr =3D opaque;
> +    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
> +    return FALSE;
> +}
> +
>  /* NB may be called even if tcp_chr_connect has not been
>   * reached, due to TLS or telnet initialization failure,
>   * so can *not* assume s->state =3D=3D TCP_CHARDEV_STATE_CONNECTED
> + * This must be called with chr->chr_write_lock held.
>   */
> -static void tcp_chr_disconnect(Chardev *chr)
> +static void tcp_chr_disconnect_locked(Chardev *chr)
>  {
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
>      bool emit_close =3D s->state =3D=3D TCP_CHARDEV_STATE_CONNECTED;
> @@ -481,13 +489,20 @@ static void tcp_chr_disconnect(Chardev *chr)
>      }
>      update_disconnected_filename(s);
>      if (emit_close) {
> -        qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
> +        qemu_idle_add(tcp_chr_be_event_closed, chr, chr->gcontext);

How does this guarantee that *chr is still valid when the callback is
invoked?

If I run tests/char-test, it fails.  With a bit of debugging output, it
looks like the the callback is scheduled with this function, then the
chardev is finalized, and only then is the callback invoked, accessing a
dangling pointer.

Or just with valgrind:

> /char/socket/server/mainloop/tcp: =3D=3D2114=3D=3D Invalid write of siz=
e 4
> =3D=3D2114=3D=3D    at 0x139F86: qemu_chr_be_event (char.c:70)
> =3D=3D2114=3D=3D    by 0x13FE3D: tcp_chr_be_event_closed (char-socket.c=
:472)
> =3D=3D2114=3D=3D    by 0x48ED7DA: ??? (in /usr/lib64/libglib-2.0.so.0.6=
000.4)
> =3D=3D2114=3D=3D    by 0x48F0EDC: g_main_context_dispatch (in /usr/lib6=
4/libglib-2.0.so.0.6000.4)
> =3D=3D2114=3D=3D    by 0x158DC7: glib_pollfds_poll (main-loop.c:222)
> =3D=3D2114=3D=3D    by 0x158DC7: os_host_main_loop_wait (main-loop.c:24=
5)
> =3D=3D2114=3D=3D    by 0x158DC7: main_loop_wait (main-loop.c:521)
> =3D=3D2114=3D=3D    by 0x11EA06: char_socket_server_test (test-char.c:8=
08)
> =3D=3D2114=3D=3D    by 0x4918F9D: ??? (in /usr/lib64/libglib-2.0.so.0.6=
000.4)
> =3D=3D2114=3D=3D    by 0x4918D43: ??? (in /usr/lib64/libglib-2.0.so.0.6=
000.4)
> =3D=3D2114=3D=3D    by 0x4918D43: ??? (in /usr/lib64/libglib-2.0.so.0.6=
000.4)
> =3D=3D2114=3D=3D    by 0x4918D43: ??? (in /usr/lib64/libglib-2.0.so.0.6=
000.4)
> =3D=3D2114=3D=3D    by 0x4918D43: ??? (in /usr/lib64/libglib-2.0.so.0.6=
000.4)
> =3D=3D2114=3D=3D    by 0x4919489: g_test_run_suite (in /usr/lib64/libgl=
ib-2.0.so.0.6000.4)
> =3D=3D2114=3D=3D  Address 0x5694434 is 116 bytes inside a block of size=
 312 free'd
> =3D=3D2114=3D=3D    at 0x4839A0C: free (vg_replace_malloc.c:540)
> =3D=3D2114=3D=3D    by 0x48F6D8C: g_free (in /usr/lib64/libglib-2.0.so.=
0.6000.4)
> =3D=3D2114=3D=3D    by 0x1360E9: object_finalize (object.c:620)
> =3D=3D2114=3D=3D    by 0x1360E9: object_unref (object.c:1070)
> =3D=3D2114=3D=3D    by 0x134EC4: object_property_del_child.isra.0 (obje=
ct.c:576)
> =3D=3D2114=3D=3D    by 0x11F1EF: char_websock_test (test-char.c:461)
> =3D=3D2114=3D=3D    by 0x4918F9D: ??? (in /usr/lib64/libglib-2.0.so.0.6=
000.4)
> =3D=3D2114=3D=3D    by 0x4918D43: ??? (in /usr/lib64/libglib-2.0.so.0.6=
000.4)
> =3D=3D2114=3D=3D    by 0x4919489: g_test_run_suite (in /usr/lib64/libgl=
ib-2.0.so.0.6000.4)
> =3D=3D2114=3D=3D    by 0x49194A4: g_test_run (in /usr/lib64/libglib-2.0=
=2Eso.0.6000.4)
> =3D=3D2114=3D=3D    by 0x11A249: main (test-char.c:1459)
> =3D=3D2114=3D=3D  Block was alloc'd at
> =3D=3D2114=3D=3D    at 0x483880B: malloc (vg_replace_malloc.c:309)
> =3D=3D2114=3D=3D    by 0x48F6C98: g_malloc (in /usr/lib64/libglib-2.0.s=
o.0.6000.4)
> =3D=3D2114=3D=3D    by 0x1355D0: object_new_with_type (object.c:631)
> =3D=3D2114=3D=3D    by 0x13AEEA: qemu_chardev_new (char.c:959)
> =3D=3D2114=3D=3D    by 0x13B227: qemu_chr_new_from_opts (char.c:680)
> =3D=3D2114=3D=3D    by 0x13B3B3: qemu_chr_new_noreplay (char.c:726)
> =3D=3D2114=3D=3D    by 0x13B469: qemu_chr_new_permit_mux_mon (char.c:74=
8)
> =3D=3D2114=3D=3D    by 0x11EF17: char_websock_test (test-char.c:415)
> =3D=3D2114=3D=3D    by 0x4918F9D: ??? (in /usr/lib64/libglib-2.0.so.0.6=
000.4)
> =3D=3D2114=3D=3D    by 0x4918D43: ??? (in /usr/lib64/libglib-2.0.so.0.6=
000.4)
> =3D=3D2114=3D=3D    by 0x4919489: g_test_run_suite (in /usr/lib64/libgl=
ib-2.0.so.0.6000.4)
> =3D=3D2114=3D=3D    by 0x49194A4: g_test_run (in /usr/lib64/libglib-2.0=
=2Eso.0.6000.4)

(plus more of the same.)

Now I don=E2=80=99t know whether the test is just wrong and in normal use=
, the
callback would always be invoked before the object is destroyed (i.e.
the test just needs to poll or something).  But in any case, it is fishy
enough that there should be an explanatory comment at least.

Max

>      }
>      if (s->reconnect_time) {
>          qemu_chr_socket_restart_timer(chr);
>      }
>  }
> =20
> +static void tcp_chr_disconnect(Chardev *chr)
> +{
> +    qemu_mutex_lock(&chr->chr_write_lock);
> +    tcp_chr_disconnect_locked(chr);
> +    qemu_mutex_unlock(&chr->chr_write_lock);
> +}
> +
>  static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void=
 *opaque)
>  {
>      Chardev *chr =3D CHARDEV(opaque);


--VPvdOypUyO0ZGEIeW7Y617NlBFo9bUBiA--

--BDUoq6w3BL3Qi2nNGJ4NxJqTVoIqdxgTV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0tn2cACgkQ9AfbAGHV
z0BX0gf9H7VpfHjx85lbhXJeen6O5T4NPand4CCgzc5la/7CwwEwW5vTnFqi3ACW
0rfy5sh9U690nbCi0r60MwKeiOSMAzR6c+gBfrzL42hXH6M0DZ7rwFtZl0x/Dpa0
mNACvEAkq4ScCVThxU3LmjWLejYMR06bUKAHpZfCdgb6WTH6G2e80qHibu080pEG
+gSRChG2YDonBwBBDdGkfs2b6MGo6B+RBMq6h5wYlK6tiZhDXRSX5IFHvznTEv73
27w42DVbNzduzem2ILPpF5QbaNiCXrofyperRlgmvh2n6u/vF4qvF0qr0z6op0jm
ydKxFY0JgMnxBMkCJ8/YPhwARo4uzA==
=8xwV
-----END PGP SIGNATURE-----

--BDUoq6w3BL3Qi2nNGJ4NxJqTVoIqdxgTV--

