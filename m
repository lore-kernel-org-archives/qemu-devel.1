Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4B5C49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4FB920692
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FB920692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8MEF-0007P7-Dr
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 06:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i8MCy-00068Q-UX
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i8MCx-0007g8-49
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:20:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54374)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i8MCw-0007fb-TS
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:20:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4370DA37193;
 Thu, 12 Sep 2019 10:20:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99FC94524;
 Thu, 12 Sep 2019 10:20:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D1C4916E32; Thu, 12 Sep 2019 12:20:07 +0200 (CEST)
Date: Thu, 12 Sep 2019 12:20:07 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Message-ID: <20190912102007.73bch4avvmx3ugpe@sirius.home.kraxel.org>
References: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Thu, 12 Sep 2019 10:20:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 00/24] Audio: Mixeng-free 5.1/7.1 audio
 support
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Sep 08, 2019 at 11:22:00PM +0200, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1=
n wrote:
> Hi,
>=20
> This is the v2 of my patch series that makes mixeng optional and enable=
s
> more than two audio channels.
>=20
> Changes from v1:
>=20
> * renamed "mixeng" option to "mixing-engine"
> * dropped patch "audio: remove hw->samples, buffer_size_in/out pcm_ops"

What is the testing status of this?

I've tried (quick playback smoke test):
  - pa -- works
  - alsa -- works.
  - oss -- not working on linux (also in master), probably lack of
    support in the linux kernel, should be testing with bsd.
  - spice -- broken (see below), master works fine.
  - sdl -- not working: "audio: Failed to create voice `adc'" (also in
    master).

What about windows+macos?

cheers,
  Gerd

spice:

qemu-system-x86_64: /home/kraxel/projects/qemu/audio/spiceaudio.c:143:
line_out_put_buffer: Assertion `buf =3D=3D out->frame + out->fpos &&
out->fpos <=3D out->fsize' failed.

#0  0x00007f55ac24d377 in raise () at /lib64/libc.so.6
#1  0x00007f55ac24ea68 in abort () at /lib64/libc.so.6
#2  0x00007f55ac246196 in __assert_fail_base () at /lib64/libc.so.6
#3  0x00007f55ac246242 in  () at /lib64/libc.so.6
#4  0x0000557b648dfe30 in line_out_put_buffer (hw=3D0x557b66773a40,
buf=3D0x557b66709f5c, size=3D1764)
    at /home/kraxel/projects/qemu/audio/spiceaudio.c:143
#5  0x0000557b648d8bc6 in audio_pcm_hw_run_out (hw=3D0x557b66773a40,
live=3D441)
    at /home/kraxel/projects/qemu/audio/audio.c:1081
#6  0x0000557b648d8f16 in audio_run_out (s=3D0x557b65b68100)
    at /home/kraxel/projects/qemu/audio/audio.c:1166
#7  0x0000557b648d9804 in audio_run (s=3D0x557b65b68100,
msg=3D0x557b64e41f58 "timer")
    at /home/kraxel/projects/qemu/audio/audio.c:1349
#8  0x0000557b648d830b in audio_timer (opaque=3D0x557b65b68100)
    at /home/kraxel/projects/qemu/audio/audio.c:830
#9  0x0000557b64cdd1ec in timerlist_run_timers
(timer_list=3D0x557b65b23730)
    at /home/kraxel/projects/qemu/util/qemu-timer.c:592
#10 0x0000557b64cdd296 in qemu_clock_run_timers
(type=3DQEMU_CLOCK_VIRTUAL)
    at /home/kraxel/projects/qemu/util/qemu-timer.c:606
#11 0x0000557b64cdd556 in qemu_clock_run_all_timers ()
    at /home/kraxel/projects/qemu/util/qemu-timer.c:692
#12 0x0000557b64cddcf2 in main_loop_wait (nonblocking=3D0)
    at /home/kraxel/projects/qemu/util/main-loop.c:524
#13 0x0000557b648c9c9f in main_loop () at
/home/kraxel/projects/qemu/vl.c:1806
#14 0x0000557b648d135d in main (argc=3D18, argv=3D0x7ffda3815208,
envp=3D0x7ffda38152a0)
    at /home/kraxel/projects/qemu/vl.c:4488

(sleep 3; remote-viewer spice://localhost:12345) & qemu-default
-enable-kvm -name "qemu fedora audio testing" -M q35 -m 4G -cdrom
/vmdisk/iso/Fedora-Workstation-Live-x86_64-30-1.2.iso -device intel-hda
-device hda-micro,audiodev=3Dsnd0 -spice port=3D12345,disable-ticketing
-audiodev spice,id=3Dsnd0

