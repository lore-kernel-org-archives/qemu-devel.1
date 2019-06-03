Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE15FC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F9B27278
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F9B27278
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39361 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXrsw-0003zM-Ns
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 14:40:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hXrr4-0002iJ-KG
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hXrjL-0004Mt-Or
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:30:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:36584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hXrjL-0004KI-Ho
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:30:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hXrjJ-000867-FX
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 18:30:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 713322E80C8
	for <qemu-devel@nongnu.org>; Mon,  3 Jun 2019 18:30:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Jun 2019 18:22:13 -0000
From: elmarco <marcandre.lureau@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: marcandre-lureau
X-Launchpad-Bug-Reporter: elmarco (marcandre-lureau)
X-Launchpad-Bug-Modifier: elmarco (marcandre-lureau)
Message-Id: <155958613349.25037.18347376667379404456.malonedeb@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18968";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: b4a7f8091aeaa260d815a11c897160aa85df4042
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1831486] [NEW] qmp monitor deadlock (with spice
 events for ex)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1831486 <1831486@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

If an event is emitted during monitor_flush_locked() it will deadlock.

Thread 1 (Thread 0x7f14f1854000 (LWP 7245)):
#0  0x00007f14fc30592d in __lll_lock_wait () at /lib64/libpthread.so.0
#1  0x00007f14fc2fedc9 in pthread_mutex_lock () at /lib64/libpthread.so.0
#2  0x000055de60e19327 in qemu_mutex_lock_impl (mutex=3D0x55de61859e58, fil=
e=3D0x55de60f1a640 "/home/elmarco/src/qq/monitor.c", line=3D438) at /home/e=
lmarco/src/qq/util/qemu-thread-posix.c:66
#3  0x000055de6085c5af in monitor_puts (mon=3D0x55de61859d30, str=3D0x55de6=
2a61d30 "{\"timestamp\": {\"seconds\": 1559585795, \"microseconds\": 508720=
}, \"event\": \"SPICE_DISCONNECTED\", \"data\": {\"server\": {\"port\": \"/=
tmp/.9IW52Z/spice.sock\", \"family\": \"unix\", \"host\": \"localhost\"}, \=
"client\": {"...) at /home/elmarco/src/qq/monitor.c:438
#4  0x000055de6085c85a in qmp_send_response (mon=3D0x55de61859d30, rsp=3D0x=
55de61ed19a0) at /home/elmarco/src/qq/monitor.c:493
#5  0x000055de6085c8ee in monitor_qapi_event_emit (event=3DQAPI_EVENT_SPICE=
_DISCONNECTED, qdict=3D0x55de61ed19a0) at /home/elmarco/src/qq/monitor.c:521
#6  0x000055de6085c9ea in monitor_qapi_event_queue_no_reenter (event=3DQAPI=
_EVENT_SPICE_DISCONNECTED, qdict=3D0x55de61ed19a0) at /home/elmarco/src/qq/=
monitor.c:546
#7  0x000055de6085cd7a in qapi_event_emit (event=3DQAPI_EVENT_SPICE_DISCONN=
ECTED, qdict=3D0x55de61ed19a0) at /home/elmarco/src/qq/monitor.c:621
#8  0x000055de60e04bc3 in qapi_event_send_spice_disconnected (server=3D0x55=
de61ee7b30, client=3D0x55de620c9090) at qapi/qapi-events-ui.c:101
#9  0x000055de60c84381 in channel_event (event=3D3, info=3D0x55de6222f4c0) =
at /home/elmarco/src/qq/ui/spice-core.c:234
#10 0x00007f14fc70ba3b in reds_handle_channel_event (reds=3D<optimized out>=
, event=3D3, info=3D0x55de6222f4c0) at reds.c:318
#11 0x00007f14fc6f407b in main_dispatcher_self_handle_channel_event (info=
=3D0x55de6222f4c0, event=3D3, self=3D0x55de61a5b0b0) at main-dispatcher.c:1=
91
#12 0x00007f14fc6f407b in main_dispatcher_channel_event (self=3D0x55de61a5b=
0b0, event=3Devent@entry=3D3, info=3D0x55de6222f4c0) at main-dispatcher.c:1=
91
#13 0x00007f14fc713cf3 in red_stream_push_channel_event (s=3Ds@entry=3D0x55=
de6222f400, event=3Devent@entry=3D3) at red-stream.c:416
#14 0x00007f14fc713d2b in red_stream_free (s=3D0x55de6222f400) at red-strea=
m.c:390
#15 0x00007f14fc6fa67c in red_channel_client_finalize (object=3D0x55de62511=
360) at red-channel-client.c:347
#16 0x00007f14fe4cfcf0 in g_object_unref () at /lib64/libgobject-2.0.so.0
#17 0x00007f14fc6fca12 in red_channel_client_push (rcc=3D0x55de62511360) at=
 red-channel-client.c:1340
#18 0x00007f14fc6fca12 in red_channel_client_push (rcc=3D0x55de62511360) at=
 red-channel-client.c:1303
#19 0x00007f14fc6cd479 in red_char_device_send_msg_to_client (client=3D<opt=
imized out>, msg=3D0x55de62512c00, dev=3D0x55de61a5b3b0) at char-device.c:3=
07
#20 0x00007f14fc6cd479 in red_char_device_send_msg_to_clients (msg=3D0x55de=
62512c00, dev=3D0x55de61a5b3b0) at char-device.c:307
#21 0x00007f14fc6cd479 in red_char_device_read_from_device (dev=3D0x55de61a=
5b3b0) at char-device.c:355
#22 0x000055de60a27dba in spice_chr_write (chr=3D0x55de61924c00, buf=3D0x55=
de6236c070 "{\"return\": {}, \"id\": 2}\r\n", len=3D25) at /home/elmarco/sr=
c/qq/chardev/spice.c:201
#23 0x000055de60d89e29 in qemu_chr_write_buffer (s=3D0x55de61924c00, buf=3D=
0x55de6236c070 "{\"return\": {}, \"id\": 2}\r\n", len=3D25, offset=3D0x7ffc=
d5e1a860, write_all=3Dfalse) at /home/elmarco/src/qq/chardev/char.c:113
#24 0x000055de60d89f96 in qemu_chr_write (s=3D0x55de61924c00, buf=3D0x55de6=
236c070 "{\"return\": {}, \"id\": 2}\r\n", len=3D25, write_all=3Dfalse) at =
/home/elmarco/src/qq/chardev/char.c:148
#25 0x000055de60d8cf78 in qemu_chr_fe_write (be=3D0x55de61859d30, buf=3D0x5=
5de6236c070 "{\"return\": {}, \"id\": 2}\r\n", len=3D25) at /home/elmarco/s=
rc/qq/chardev/char-fe.c:42
#26 0x000055de6085c40f in monitor_flush_locked (mon=3D0x55de61859d30) at /h=
ome/elmarco/src/qq/monitor.c:404
#27 0x000055de6085c614 in monitor_puts (mon=3D0x55de61859d30, str=3D0x55de6=
22f6a40 "{\"return\": {}, \"id\": 2}\n") at /home/elmarco/src/qq/monitor.c:=
446
#28 0x000055de6085c85a in qmp_send_response (mon=3D0x55de61859d30, rsp=3D0x=
55de61ecf960) at /home/elmarco/src/qq/monitor.c:493
#29 0x000055de60865902 in monitor_qmp_respond (mon=3D0x55de61859d30, rsp=3D=
0x55de61ecf960) at /home/elmarco/src/qq/monitor.c:4128
#30 0x000055de60865a19 in monitor_qmp_dispatch (mon=3D0x55de61859d30, req=
=3D0x55de622ec000) at /home/elmarco/src/qq/monitor.c:4157
#31 0x000055de60865ce2 in monitor_qmp_bh_dispatcher (data=3D0x0) at /home/e=
lmarco/src/qq/monitor.c:4224

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1831486

Title:
  qmp monitor deadlock (with spice events for ex)

Status in QEMU:
  New

Bug description:
  If an event is emitted during monitor_flush_locked() it will deadlock.

  Thread 1 (Thread 0x7f14f1854000 (LWP 7245)):
  #0  0x00007f14fc30592d in __lll_lock_wait () at /lib64/libpthread.so.0
  #1  0x00007f14fc2fedc9 in pthread_mutex_lock () at /lib64/libpthread.so.0
  #2  0x000055de60e19327 in qemu_mutex_lock_impl (mutex=3D0x55de61859e58, f=
ile=3D0x55de60f1a640 "/home/elmarco/src/qq/monitor.c", line=3D438) at /home=
/elmarco/src/qq/util/qemu-thread-posix.c:66
  #3  0x000055de6085c5af in monitor_puts (mon=3D0x55de61859d30, str=3D0x55d=
e62a61d30 "{\"timestamp\": {\"seconds\": 1559585795, \"microseconds\": 5087=
20}, \"event\": \"SPICE_DISCONNECTED\", \"data\": {\"server\": {\"port\": \=
"/tmp/.9IW52Z/spice.sock\", \"family\": \"unix\", \"host\": \"localhost\"},=
 \"client\": {"...) at /home/elmarco/src/qq/monitor.c:438
  #4  0x000055de6085c85a in qmp_send_response (mon=3D0x55de61859d30, rsp=3D=
0x55de61ed19a0) at /home/elmarco/src/qq/monitor.c:493
  #5  0x000055de6085c8ee in monitor_qapi_event_emit (event=3DQAPI_EVENT_SPI=
CE_DISCONNECTED, qdict=3D0x55de61ed19a0) at /home/elmarco/src/qq/monitor.c:=
521
  #6  0x000055de6085c9ea in monitor_qapi_event_queue_no_reenter (event=3DQA=
PI_EVENT_SPICE_DISCONNECTED, qdict=3D0x55de61ed19a0) at /home/elmarco/src/q=
q/monitor.c:546
  #7  0x000055de6085cd7a in qapi_event_emit (event=3DQAPI_EVENT_SPICE_DISCO=
NNECTED, qdict=3D0x55de61ed19a0) at /home/elmarco/src/qq/monitor.c:621
  #8  0x000055de60e04bc3 in qapi_event_send_spice_disconnected (server=3D0x=
55de61ee7b30, client=3D0x55de620c9090) at qapi/qapi-events-ui.c:101
  #9  0x000055de60c84381 in channel_event (event=3D3, info=3D0x55de6222f4c0=
) at /home/elmarco/src/qq/ui/spice-core.c:234
  #10 0x00007f14fc70ba3b in reds_handle_channel_event (reds=3D<optimized ou=
t>, event=3D3, info=3D0x55de6222f4c0) at reds.c:318
  #11 0x00007f14fc6f407b in main_dispatcher_self_handle_channel_event (info=
=3D0x55de6222f4c0, event=3D3, self=3D0x55de61a5b0b0) at main-dispatcher.c:1=
91
  #12 0x00007f14fc6f407b in main_dispatcher_channel_event (self=3D0x55de61a=
5b0b0, event=3Devent@entry=3D3, info=3D0x55de6222f4c0) at main-dispatcher.c=
:191
  #13 0x00007f14fc713cf3 in red_stream_push_channel_event (s=3Ds@entry=3D0x=
55de6222f400, event=3Devent@entry=3D3) at red-stream.c:416
  #14 0x00007f14fc713d2b in red_stream_free (s=3D0x55de6222f400) at red-str=
eam.c:390
  #15 0x00007f14fc6fa67c in red_channel_client_finalize (object=3D0x55de625=
11360) at red-channel-client.c:347
  #16 0x00007f14fe4cfcf0 in g_object_unref () at /lib64/libgobject-2.0.so.0
  #17 0x00007f14fc6fca12 in red_channel_client_push (rcc=3D0x55de62511360) =
at red-channel-client.c:1340
  #18 0x00007f14fc6fca12 in red_channel_client_push (rcc=3D0x55de62511360) =
at red-channel-client.c:1303
  #19 0x00007f14fc6cd479 in red_char_device_send_msg_to_client (client=3D<o=
ptimized out>, msg=3D0x55de62512c00, dev=3D0x55de61a5b3b0) at char-device.c=
:307
  #20 0x00007f14fc6cd479 in red_char_device_send_msg_to_clients (msg=3D0x55=
de62512c00, dev=3D0x55de61a5b3b0) at char-device.c:307
  #21 0x00007f14fc6cd479 in red_char_device_read_from_device (dev=3D0x55de6=
1a5b3b0) at char-device.c:355
  #22 0x000055de60a27dba in spice_chr_write (chr=3D0x55de61924c00, buf=3D0x=
55de6236c070 "{\"return\": {}, \"id\": 2}\r\n", len=3D25) at /home/elmarco/=
src/qq/chardev/spice.c:201
  #23 0x000055de60d89e29 in qemu_chr_write_buffer (s=3D0x55de61924c00, buf=
=3D0x55de6236c070 "{\"return\": {}, \"id\": 2}\r\n", len=3D25, offset=3D0x7=
ffcd5e1a860, write_all=3Dfalse) at /home/elmarco/src/qq/chardev/char.c:113
  #24 0x000055de60d89f96 in qemu_chr_write (s=3D0x55de61924c00, buf=3D0x55d=
e6236c070 "{\"return\": {}, \"id\": 2}\r\n", len=3D25, write_all=3Dfalse) a=
t /home/elmarco/src/qq/chardev/char.c:148
  #25 0x000055de60d8cf78 in qemu_chr_fe_write (be=3D0x55de61859d30, buf=3D0=
x55de6236c070 "{\"return\": {}, \"id\": 2}\r\n", len=3D25) at /home/elmarco=
/src/qq/chardev/char-fe.c:42
  #26 0x000055de6085c40f in monitor_flush_locked (mon=3D0x55de61859d30) at =
/home/elmarco/src/qq/monitor.c:404
  #27 0x000055de6085c614 in monitor_puts (mon=3D0x55de61859d30, str=3D0x55d=
e622f6a40 "{\"return\": {}, \"id\": 2}\n") at /home/elmarco/src/qq/monitor.=
c:446
  #28 0x000055de6085c85a in qmp_send_response (mon=3D0x55de61859d30, rsp=3D=
0x55de61ecf960) at /home/elmarco/src/qq/monitor.c:493
  #29 0x000055de60865902 in monitor_qmp_respond (mon=3D0x55de61859d30, rsp=
=3D0x55de61ecf960) at /home/elmarco/src/qq/monitor.c:4128
  #30 0x000055de60865a19 in monitor_qmp_dispatch (mon=3D0x55de61859d30, req=
=3D0x55de622ec000) at /home/elmarco/src/qq/monitor.c:4157
  #31 0x000055de60865ce2 in monitor_qmp_bh_dispatcher (data=3D0x0) at /home=
/elmarco/src/qq/monitor.c:4224

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1831486/+subscriptions

