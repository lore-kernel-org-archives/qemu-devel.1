Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2332BCA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 07:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB47921655
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 07:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPrHjTka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB47921655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOGi7-0005BH-2g
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 03:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1iOGgx-0000jX-7Z
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 03:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1iOGgw-0007zs-4O
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 03:40:55 -0400
Received: from mail-yw1-xc2a.google.com ([2607:f8b0:4864:20::c2a]:43191)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1iOGgw-0007zT-0K
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 03:40:54 -0400
Received: by mail-yw1-xc2a.google.com with SMTP id g77so1812474ywb.10
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 00:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=C9L21U1nmOsJHdgYrr16hunNx/WTpJzQ6qjp0lhRypc=;
 b=gPrHjTkaS68QM+ZKEUj+f9iNXJrKga0XpLusH6iw/dOL/XvC1wKllMoUEMPDM6zczZ
 JyP9H01WBnw23io+oyRhnTne6aLnkl3WBcjCB4YbcEANdVLD/P2Er/S+H8RJkuqA9rM/
 6MPJrSScZDmqBjogr1nLUIPrlZIkSZ/EVkb0utHz5vKQs5x+Jj813/N3c+Fsg6Oz0wDA
 a857uqbiZmuVe5SCk/pecWdiiihFwrI47r3XL+dZwkTtdQzKgQD9eMF6zWcPy5x7LGGg
 +DQVpk9JI4rVPF1cnGCZDT4SpiYh9h++2C++4DDcYuvKYkSJZ5iyB/HF9J8hrDjNATAU
 Pl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=C9L21U1nmOsJHdgYrr16hunNx/WTpJzQ6qjp0lhRypc=;
 b=szpcteWLzPlx4hlm20qmPl8Kc7y1h4Fz+NXDjucONhO1lvmM+UiHz+9LBVAR5jr42F
 91Vo3cBZEi38VMjfq/yUnpAhmvToV5ItNt3LSUKfJCK2iIgGNcGMquWfgoCVi5dsyBNo
 fpzzsIEcd17RkC23WZnQdmhJcNzlhqGW5kb5JPwvipW6Jt+B075i/M9OKVPzlRKRLtkB
 lWT/4HIEfVHvIza71W1V8Ul3exab9vK/BOvz0w6cIpJddAbfVPJ6oE+dX6MkXlgorQgb
 KAxLIOgTN3vnPcLVkLRX42sVQAQjNYIVOm4poKCWl5JlH97frofmqnD+1gJKPLhdFDg0
 Igfw==
X-Gm-Message-State: APjAAAU2yZbexUmRX1aQd9DVcK3vbRbIn55dvYND/pekoh76Zj/lSnGM
 gTEpDiztpSGNPAV0UYw2PY7g36MFXdDewqhgZExm8A==
X-Google-Smtp-Source: APXvYqwZYGm+N52fKmYoE+yF65WiUCrt8Y4LxiDMo9yjOOqfwkhFVVgTR5NZQ/ScVAUXYVmeJGc7nDhl74K6K2GWtRQ=
X-Received: by 2002:a81:35c9:: with SMTP id c192mr5626113ywa.57.1572075652488; 
 Sat, 26 Oct 2019 00:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <CABLmASG1413=5he48wC0e2hrdoKjs7kasY18WVkyCrRypqZRqw@mail.gmail.com>
In-Reply-To: <CABLmASG1413=5he48wC0e2hrdoKjs7kasY18WVkyCrRypqZRqw@mail.gmail.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Sat, 26 Oct 2019 09:40:40 +0200
Message-ID: <CABLmASGCX07G7bOcTYZuqLDzoZ9eEyF9t61hKHhC343jxRtUdg@mail.gmail.com>
Subject: Re: USB-audio sound issues with qemu-system-ppc in Linux and Windows.
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000d3a3760595cb628e"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c2a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d3a3760595cb628e
Content-Type: text/plain; charset="UTF-8"

Hi,

I'd like to add to the previous report that similar issues are present in
OSX (Sierra) builds of qemu-system-ppc.

In Mac OS 9.2 and OS X 10.3 guests, sound through the usb-audio device is
unrecognisable.
After forcibly shutting down Mac OS 9.2 after it becomes unresponsive, qemu
crashes. The OS X crash reporter says this:
Thread 2 Crashed:
0   qemu-system-ppc               0x000000010999c4bd timer_del + 13
(qemu-timer.c:429)
1   qemu-system-ppc               0x00000001096d543f audio_reset_timer +
319 (audio.c:811)
2   qemu-system-ppc               0x00000001096ca2a6 vm_state_notify + 262
(vl.c:1433)
3   qemu-system-ppc               0x000000010953642f do_vm_stop + 47
(cpus.c:1104)
4   qemu-system-ppc               0x00000001096ceed7 qemu_main + 17239
(vl.c:4477)
5   qemu-system-ppc               0x000000010988a526 call_qemu_main + 38
(cocoa.m:1769)
6   qemu-system-ppc               0x00000001099a11ee qemu_thread_start +
126 (qemu-thread-posix.c:519)
7   libsystem_pthread.dylib       0x00007fffb864a93b _pthread_body + 180
8   libsystem_pthread.dylib       0x00007fffb864a887 _pthread_start + 286
9   libsystem_pthread.dylib       0x00007fffb864a08d thread_start + 13

Best,
Howard

--000000000000d3a3760595cb628e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div>Hi,<br></div><div><br></di=
v><div>I&#39;d like to add to the previous report that similar issues are p=
resent in OSX (Sierra) builds of qemu-system-ppc.</div><div><br></div><div>=
In Mac OS 9.2 and OS X 10.3 guests, sound through the usb-audio device is u=
nrecognisable.=C2=A0 <br></div><div>After forcibly shutting down Mac OS 9.2=
 after it becomes unresponsive, qemu crashes. The OS X crash reporter says =
this:</div><div>Thread 2 Crashed:<br>0 =C2=A0 qemu-system-ppc =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 	0x000000010999c4bd timer_del + 13 (qem=
u-timer.c:429)<br>1 =C2=A0 qemu-system-ppc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 	0x00000001096d543f audio_reset_timer + 319 (audio.c:811)=
<br>2 =C2=A0 qemu-system-ppc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 	0x00000001096ca2a6 vm_state_notify + 262 (vl.c:1433)<br>3 =C2=A0 qemu-=
system-ppc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 	0x000000010953=
642f do_vm_stop + 47 (cpus.c:1104)<br>4 =C2=A0 qemu-system-ppc =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 	0x00000001096ceed7 qemu_main + 1723=
9 (vl.c:4477)<br>5 =C2=A0 qemu-system-ppc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 	0x000000010988a526 call_qemu_main + 38 (cocoa.m:1769)<br=
>6 =C2=A0 qemu-system-ppc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
	0x00000001099a11ee qemu_thread_start + 126 (qemu-thread-posix.c:519)<br>7 =
=C2=A0 libsystem_pthread.dylib =C2=A0 =C2=A0 =C2=A0 	0x00007fffb864a93b _pt=
hread_body + 180<br>8 =C2=A0 libsystem_pthread.dylib =C2=A0 =C2=A0 =C2=A0 	=
0x00007fffb864a887 _pthread_start + 286<br>9 =C2=A0 libsystem_pthread.dylib=
 =C2=A0 =C2=A0 =C2=A0 	0x00007fffb864a08d thread_start + 13</div><div><br><=
/div><div>Best,</div><div>Howard<br></div><div><br></div></div>

--000000000000d3a3760595cb628e--

