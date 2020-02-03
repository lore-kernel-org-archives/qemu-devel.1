Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2EAC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E62E92082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62E92082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyb89-0000TA-4G
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:47:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iyb6g-0007ZN-14
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iyb6d-0000gW-Ql
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:45:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:52872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iyb6d-0000eh-Jx
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:45:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iyb6c-0001Qf-6U
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 12:45:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 2E6052E80C0
 for <qemu-devel@nongnu.org>; Mon,  3 Feb 2020 12:45:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Feb 2020 12:36:57 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1861677@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: audio
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
Message-Id: <158073341807.19403.15811772889635903332.malonedeb@gac.canonical.com>
Subject: [Bug 1861677] [NEW] wavcapture crash with pulseaudio
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0a62c17273454a1313f81a74a2198ec30b44c7b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6672a11dfcd22e15d5cf88d4d18b52938042344b
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1861677 <1861677@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

As of commit 28db64fce55,
using demo from QEMU advent calendar 2018 day 1:
https://www.qemu-advent-calendar.org/2018/download/day01.tar.xz

$ qemu-system-x86_64 -M pc \
  -net none -soundhw pcspk \
  -drive file=3Dday01/fbird.img,format=3Draw,if=3Dfloppy \
  -monitor stdio -S
(qemu) info qtree =

bus: main-system-bus
  type System
  dev: i440FX-pcihost, id ""
    bus: pci.0
      dev: PIIX3, id ""
        bus: isa.0
          dev: isa-pcspk, id ""
            audiodev =3D "pa"
            iobase =3D 97 (0x61)
            migrate =3D true
(qemu) wavcapture out.wav pa
(qemu) cont
(qemu) # Press 'up' key in demo
Segmentation fault (core dumped)

(gdb) bt
#0  0x0000555bfef0dc51 in audio_pcm_sw_write (sw=3D0x555c01333930, buf=3D0x=
0, size=3D14728) at audio/audio.c:725
#1  0x0000555bfef10a49 in audio_capture_mix_and_clear (hw=3D0x555c012379b0,=
 rpos=3D0, samples=3D3682) at audio/audio.c:1054
#2  0x0000555bfef11059 in audio_run_out (s=3D0x555c01235550) at audio/audio=
.c:1186
#3  0x0000555bfef11894 in audio_run (s=3D0x555c01235550, msg=3D0x555bff3e37=
e8 "timer") at audio/audio.c:1355
#4  0x0000555bfef10334 in audio_timer (opaque=3D0x555c01235550) at audio/au=
dio.c:831
#5  0x0000555bff33f041 in timerlist_run_timers (timer_list=3D0x555c00377b50=
) at util/qemu-timer.c:588
#6  0x0000555bff33f0eb in qemu_clock_run_timers (type=3DQEMU_CLOCK_VIRTUAL)=
 at util/qemu-timer.c:602
#7  0x0000555bff33f3b6 in qemu_clock_run_all_timers () at util/qemu-timer.c=
:688
#8  0x0000555bff33fb60 in main_loop_wait (nonblocking=3D0) at util/main-loo=
p.c:525
#9  0x0000555bfef0187c in main_loop () at vl.c:1683
#10 0x0000555bfef090ab in main (argc=3D12, argv=3D0x7ffec49184c8, envp=3D0x=
7ffec4918530) at vl.c:4438
(gdb) p *sw
$1 =3D {card =3D 0x0, s =3D 0x0, info =3D {bits =3D 16, sign =3D 1, freq =
=3D 44100, nchannels =3D 2, bytes_per_frame =3D 4, bytes_per_second =3D 176=
400, swap_endianness =3D 0}, conv =3D 0x555bfef0ced1 <noop_conv>, ratio =3D=
 4294967296, buf =3D 0x555c0123f6f0, =

  rate =3D 0x555c007c0ec0, total_hw_samples_mixed =3D 0, active =3D 1, empt=
y =3D 1, hw =3D 0x555c014b12a0, name =3D 0x0, vol =3D {mute =3D 0, r =3D 42=
94967296, l =3D 4294967296}, callback =3D {opaque =3D 0x0, fn =3D 0x0}, ent=
ries =3D {le_next =3D 0x0, =

    le_prev =3D 0x555c014b1310}}
(gdb) p *sw->hw
$2 =3D {s =3D 0x555c01235550, enabled =3D 1, poll_mode =3D 0, pending_disab=
le =3D 0, info =3D {bits =3D 16, sign =3D 1, freq =3D 44100, nchannels =3D =
2, bytes_per_frame =3D 4, bytes_per_second =3D 176400, swap_endianness =3D =
0}, =

  clip =3D 0x555bfef16376 <clip_natural_int16_t_from_stereo>, ts_helper =3D=
 0, mix_buf =3D 0x555c0059d680, buf_emul =3D 0x0, pos_emul =3D 0, pending_e=
mul =3D 0, size_emul =3D 0, samples =3D 16384, sw_head =3D {lh_first =3D 0x=
555c01333930}, cap_head =3D {
    lh_first =3D 0x0}, pcm_ops =3D 0x0, entries =3D {le_next =3D 0x0, le_pr=
ev =3D 0x0}}

sw->hw->pcm_ops is NULL.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: audio

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1861677

Title:
  wavcapture crash with pulseaudio

Status in QEMU:
  New

Bug description:
  As of commit 28db64fce55,
  using demo from QEMU advent calendar 2018 day 1:
  https://www.qemu-advent-calendar.org/2018/download/day01.tar.xz

  $ qemu-system-x86_64 -M pc \
    -net none -soundhw pcspk \
    -drive file=3Dday01/fbird.img,format=3Draw,if=3Dfloppy \
    -monitor stdio -S
  (qemu) info qtree =

  bus: main-system-bus
    type System
    dev: i440FX-pcihost, id ""
      bus: pci.0
        dev: PIIX3, id ""
          bus: isa.0
            dev: isa-pcspk, id ""
              audiodev =3D "pa"
              iobase =3D 97 (0x61)
              migrate =3D true
  (qemu) wavcapture out.wav pa
  (qemu) cont
  (qemu) # Press 'up' key in demo
  Segmentation fault (core dumped)

  (gdb) bt
  #0  0x0000555bfef0dc51 in audio_pcm_sw_write (sw=3D0x555c01333930, buf=3D=
0x0, size=3D14728) at audio/audio.c:725
  #1  0x0000555bfef10a49 in audio_capture_mix_and_clear (hw=3D0x555c012379b=
0, rpos=3D0, samples=3D3682) at audio/audio.c:1054
  #2  0x0000555bfef11059 in audio_run_out (s=3D0x555c01235550) at audio/aud=
io.c:1186
  #3  0x0000555bfef11894 in audio_run (s=3D0x555c01235550, msg=3D0x555bff3e=
37e8 "timer") at audio/audio.c:1355
  #4  0x0000555bfef10334 in audio_timer (opaque=3D0x555c01235550) at audio/=
audio.c:831
  #5  0x0000555bff33f041 in timerlist_run_timers (timer_list=3D0x555c00377b=
50) at util/qemu-timer.c:588
  #6  0x0000555bff33f0eb in qemu_clock_run_timers (type=3DQEMU_CLOCK_VIRTUA=
L) at util/qemu-timer.c:602
  #7  0x0000555bff33f3b6 in qemu_clock_run_all_timers () at util/qemu-timer=
.c:688
  #8  0x0000555bff33fb60 in main_loop_wait (nonblocking=3D0) at util/main-l=
oop.c:525
  #9  0x0000555bfef0187c in main_loop () at vl.c:1683
  #10 0x0000555bfef090ab in main (argc=3D12, argv=3D0x7ffec49184c8, envp=3D=
0x7ffec4918530) at vl.c:4438
  (gdb) p *sw
  $1 =3D {card =3D 0x0, s =3D 0x0, info =3D {bits =3D 16, sign =3D 1, freq =
=3D 44100, nchannels =3D 2, bytes_per_frame =3D 4, bytes_per_second =3D 176=
400, swap_endianness =3D 0}, conv =3D 0x555bfef0ced1 <noop_conv>, ratio =3D=
 4294967296, buf =3D 0x555c0123f6f0, =

    rate =3D 0x555c007c0ec0, total_hw_samples_mixed =3D 0, active =3D 1, em=
pty =3D 1, hw =3D 0x555c014b12a0, name =3D 0x0, vol =3D {mute =3D 0, r =3D =
4294967296, l =3D 4294967296}, callback =3D {opaque =3D 0x0, fn =3D 0x0}, e=
ntries =3D {le_next =3D 0x0, =

      le_prev =3D 0x555c014b1310}}
  (gdb) p *sw->hw
  $2 =3D {s =3D 0x555c01235550, enabled =3D 1, poll_mode =3D 0, pending_dis=
able =3D 0, info =3D {bits =3D 16, sign =3D 1, freq =3D 44100, nchannels =
=3D 2, bytes_per_frame =3D 4, bytes_per_second =3D 176400, swap_endianness =
=3D 0}, =

    clip =3D 0x555bfef16376 <clip_natural_int16_t_from_stereo>, ts_helper =
=3D 0, mix_buf =3D 0x555c0059d680, buf_emul =3D 0x0, pos_emul =3D 0, pendin=
g_emul =3D 0, size_emul =3D 0, samples =3D 16384, sw_head =3D {lh_first =3D=
 0x555c01333930}, cap_head =3D {
      lh_first =3D 0x0}, pcm_ops =3D 0x0, entries =3D {le_next =3D 0x0, le_=
prev =3D 0x0}}

  sw->hw->pcm_ops is NULL.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1861677/+subscriptions

