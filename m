Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3766BC282CE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 01:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D112070B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 01:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D112070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33685 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYKXj-0004qQ-8s
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 21:16:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hYKWd-0003sO-M3
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 21:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hYKWb-0004hk-JX
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 21:15:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1hYKWZ-0003sk-Ck
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 21:15:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C284C18B2D0
	for <qemu-devel@nongnu.org>; Wed,  5 Jun 2019 01:15:08 +0000 (UTC)
Received: from [10.18.17.164] (dhcp-17-164.bos.redhat.com [10.18.17.164])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9F2E618854;
	Wed,  5 Jun 2019 01:15:04 +0000 (UTC)
To: Gerd Hoffmann <kraxel@redhat.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
	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
Message-ID: <e7401f4d-e69b-2930-b070-fb0da55e4b98@redhat.com>
Date: Tue, 4 Jun 2019 21:15:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Wed, 05 Jun 2019 01:15:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] sigsegv in chardev on iotest 045 (raw)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Running tests on a development branch (I haven't touched chardev stuff,
I swear!); I ran into the below crash where s->ioc was NULL. I don't
have the time to investigate at this exact moment, so please excuse the
hasty report so I don't forget to tell someone.

It does not reproduce consistently, and I can't get it to show up again.

(Is this maybe just a race on close where the device went away too fast
and it had nowhere to print the information? --js)

--- /home/bos/jhuston/src/qemu/tests/qemu-iotests/045.out	2019-04-05
17:50:47.309213199 -0400
+++ /home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/045.out.bad
2019-06-04 20:55:34.410469853 -0400
@@ -1,3 +1,5 @@
+WARNING:qemu:qemu received signal 11:
/home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64
-chardev
socket,id=mon,path=/home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/tmp4pnjwtvk/qemu-21961-monitor.sock
-mon chardev=mon,mode=control -display none -vga none -qtest
unix:path=/home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/qemu-21961-qtest.sock
-machine accel=qtest -nodefaults -machine accel=qtest -add-fd
fd=3,set=1,opaque=image0:r -add-fd fd=4,set=1,opaque=image1:w+ -add-fd
fd=5,set=0,opaque=image2:r -add-fd fd=6,set=2,opaque=image3:r -add-fd
fd=7,set=2,opaque=image4:r -drive
if=virtio,id=drive0,file=/dev/fdset/1,format=raw,cache=writeback
+WARNING:qemu:qemu received signal 11:
/home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64
-chardev
socket,id=mon,path=/home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/tmp4pnjwtvk/qemu-21961-monitor.sock
-mon chardev=mon,mode=control -display none -vga none -qtest
unix:path=/home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/qemu-21961-qtest.sock
-machine accel=qtest -nodefaults -machine accel=qtest -add-fd
fd=3,set=1,opaque=image0:r -add-fd fd=4,set=1,opaque=image1:w+ -add-fd
fd=5,set=0,opaque=image2:r -add-fd fd=6,set=2,opaque=image3:r -add-fd
fd=7,set=2,opaque=image4:r -drive
if=virtio,id=drive0,file=/dev/fdset/1,format=raw,cache=writeback
 ...........
 ----------------------------------------------------------------------

#0  0x0000560165e2d431 in object_get_class (obj=0x0) at
/home/bos/jhuston/src/qemu/qom/object.c:905
#1  0x0000560165f1328c in qio_channel_writev_full (ioc=0x0,
iov=0x7ffe7d79e380, niov=1, fds=0x0, nfds=0, errp=0x0)
    at /home/bos/jhuston/src/qemu/io/channel.c:76
#2  0x0000560165efa7c0 in io_channel_send_full (ioc=0x0,
buf=0x7fd0dc004e20, len=138, fds=0x0, nfds=0)
    at /home/bos/jhuston/src/qemu/chardev/char-io.c:123
#3  0x0000560165efe262 in tcp_chr_write
    (chr=0x5601680fbeb0, buf=0x7fd0dc004e20 "{\"timestamp\":
{\"seconds\": 1559696132, \"microseconds\": 913471}, \"event\":
\"SHUTDOWN\", \"data\": {\"guest\": false, \"reason\":
\"host-qmp-quit\"}}\r\n", len=138) at
/home/bos/jhuston/src/qemu/chardev/char-socket.c:160
#4  0x0000560165ef62b4 in qemu_chr_write_buffer
    (s=0x5601680fbeb0, buf=0x7fd0dc004e20 "{\"timestamp\": {\"seconds\":
1559696132, \"microseconds\": 913471}, \"event\": \"SHUTDOWN\",
\"data\": {\"guest\": false, \"reason\": \"host-qmp-quit\"}}\r\n",
len=138, offset=0x7ffe7d79e460, write_all=false)
    at /home/bos/jhuston/src/qemu/chardev/char.c:113
#5  0x0000560165ef6421 in qemu_chr_write
    (s=0x5601680fbeb0, buf=0x7fd0dc004e20 "{\"timestamp\": {\"seconds\":
1559696132, \"microseconds\": 913471}, \"event\": \"SHUTDOWN\",
\"data\": {\"guest\": false, \"reason\": \"host-qmp-quit\"}}\r\n",
len=138, write_all=false) at /home/bos/jhuston/src/qemu/chardev/char.c:148
#6  0x0000560165ef9408 in qemu_chr_fe_write
    (be=0x5601680fb680, buf=0x7fd0dc004e20 "{\"timestamp\":
{\"seconds\": 1559696132, \"microseconds\": 913471}, \"event\":
\"SHUTDOWN\", \"data\": {\"guest\": false, \"reason\":
\"host-qmp-quit\"}}\r\n", len=138) at
/home/bos/jhuston/src/qemu/chardev/char-fe.c:42
#7  0x00005601659b8c4a in monitor_flush_locked (mon=0x5601680fb680) at
/home/bos/jhuston/src/qemu/monitor.c:404
#8  0x00005601659b8e54 in monitor_puts
    (mon=0x5601680fb680, str=0x560168a57110 "{\"timestamp\":
{\"seconds\": 1559696132, \"microseconds\": 913471}, \"event\":
\"SHUTDOWN\", \"data\": {\"guest\": false, \"reason\":
\"host-qmp-quit\"}}\n") at /home/bos/jhuston/src/qemu/monitor.c:446
#9  0x00005601659b909a in qmp_send_response (mon=0x5601680fb680,
rsp=0x560168f72310) at /home/bos/jhuston/src/qemu/monitor.c:493
#10 0x00005601659b912e in monitor_qapi_event_emit
(event=QAPI_EVENT_SHUTDOWN, qdict=0x560168f72310) at
/home/bos/jhuston/src/qemu/monitor.c:521
#11 0x00005601659b9229 in monitor_qapi_event_queue_no_reenter
(event=QAPI_EVENT_SHUTDOWN, qdict=0x560168f72310)
    at /home/bos/jhuston/src/qemu/monitor.c:546
#12 0x00005601659b95bc in qapi_event_emit (event=QAPI_EVENT_SHUTDOWN,
qdict=0x560168f72310) at /home/bos/jhuston/src/qemu/monitor.c:621
#13 0x0000560165f70707 in qapi_event_send_shutdown (guest=false,
reason=SHUTDOWN_CAUSE_HOST_QMP_QUIT) at qapi/qapi-events-run-state.c:44
#14 0x0000560165b60e88 in qemu_system_shutdown
(cause=SHUTDOWN_CAUSE_HOST_QMP_QUIT) at /home/bos/jhuston/src/qemu/vl.c:1777
#15 0x0000560165b60fa1 in main_loop_should_exit () at
/home/bos/jhuston/src/qemu/vl.c:1825
#16 0x0000560165b610a6 in main_loop () at
/home/bos/jhuston/src/qemu/vl.c:1864
#17 0x0000560165b68686 in main (argc=28, argv=0x7ffe7d79ea98,
envp=0x7ffe7d79eb80) at /home/bos/jhuston/src/qemu/vl.c:4526

