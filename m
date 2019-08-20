Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE8BC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 09:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E5B22CF4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 09:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E5B22CF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i00v8-0000W6-KM
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 05:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i00u7-0008UZ-5Y
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 05:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i00u5-0000iB-Dx
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 05:58:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56930)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i00u5-0000gi-5H
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 05:58:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 93507106BB22;
 Tue, 20 Aug 2019 09:58:10 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 381847E39;
 Tue, 20 Aug 2019 09:58:03 +0000 (UTC)
Date: Tue, 20 Aug 2019 10:58:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <20190820095800.GF23352@redhat.com>
References: <1565625509-404969-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1565625509-404969-3-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1565625509-404969-3-git-send-email-andrey.shinkevich@virtuozzo.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Tue, 20 Aug 2019 09:58:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 2/2] char-socket: Lock
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: vsementsov@virtuozzo.com, berto@igalia.com, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 12, 2019 at 06:58:29PM +0300, Andrey Shinkevich wrote:
> From: Alberto Garcia <berto@igalia.com>
>=20
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
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

