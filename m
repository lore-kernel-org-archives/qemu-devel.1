Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D320C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 19:12:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4C4206D5
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 19:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4C4206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jB1LK-0005nr-4j
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 15:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vr_qemu@t-online.de>) id 1jB1Ka-0005Hb-5C
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 15:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vr_qemu@t-online.de>) id 1jB1KW-0006kZ-UE
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 15:11:18 -0400
Received: from mailout04.t-online.de ([194.25.134.18]:42872)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vr_qemu@t-online.de>) id 1jB1KW-0006ib-Kb
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 15:11:16 -0400
Received: from fwd23.aul.t-online.de (fwd23.aul.t-online.de [172.20.26.128])
 by mailout04.t-online.de (Postfix) with SMTP id 97EAB4195EAA;
 Sun,  8 Mar 2020 20:11:13 +0100 (CET)
Received: from [192.168.211.200]
 (SgVUOcZrYhJb0R6GHjNFGMnE1mdMEjmjANF3xvVMCtxa0V+YQaNkf7SA9NDt0VzQ63@[79.208.31.100])
 by fwd23.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jB1KT-1rUGUy0; Sun, 8 Mar 2020 20:11:13 +0100
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH 0/5] mostly changes related to audio float samples
To: Howard Spoelstra <hsp.cat7@gmail.com>
References: <417bfe2f-e3c1-d83d-b437-47859daf524d@t-online.de>
 <CABLmASHxx+x6rDo-Vk_wwKrHoq2+10oyH49AeKnmJXdQJSJnGw@mail.gmail.com>
Message-ID: <edd6c230-b0c6-7eca-a4d5-61954e095f73@t-online.de>
Date: Sun, 8 Mar 2020 20:11:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CABLmASHxx+x6rDo-Vk_wwKrHoq2+10oyH49AeKnmJXdQJSJnGw@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------197CECB9CDEF60788956442E"
Content-Language: en-US
X-ID: SgVUOcZrYhJb0R6GHjNFGMnE1mdMEjmjANF3xvVMCtxa0V+YQaNkf7SA9NDt0VzQ63
X-TOI-MSGID: d34c948b-9bc0-4357-8694-962e95bb33e9
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.18
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 John Arbuckle <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------197CECB9CDEF60788956442E
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Howard,

thank you for testing the patches.

> Hi,
>
> I applied these to Mark's screamer branch to create a new OSX build. Te=
sting was done by playing system sounds, and an MP3/Internet radio with Q=
uickTime/iTunes. With or without 6dB, the max volume is way out of my com=
fort zone. I hear no real difference in quality compared to a build from =
the

It wasn't my intention to annoy your neighbours. On my computer I use an =
analog output for playback. Clipping happens before DA conversion, so I c=
an use the volume control on the amplifier to have normal volume levels.

> current screamer branch. If any, it might sound a bit better. That mean=
s there still is some minimal crackling (clipping?) in the high volume pa=
rts of the

Crackling and clipping are two different things. Crackling is normally a =
timing problem where audio samples aren't delivered in time. Clipping pro=
duces harmonic distortions. For example a clipped sine wave will sound me=
tallic because of the harmonic distortions. The difference between a clip=
ped and a pure sine wave is clearly audible.

> audio I played with OSX guests, not Mac OS 9.x guests.=C2=A0=C2=A0
>
> So as there is no regression,
> tested by: howard spoelstra <hsp.cat7@gmail.com <mailto:hsp.cat7@gmail.=
com>>

With best regards,
Volker

--------------197CECB9CDEF60788956442E
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    Hi Howard,<br>
    <br>
    thank you for testing the patches.<br>
    <br>
    <blockquote type=3D"cite"
cite=3D"mid:CABLmASHxx+x6rDo-Vk_wwKrHoq2+10oyH49AeKnmJXdQJSJnGw@mail.gmai=
l.com">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div>Hi,</div>
          <div><br>
          </div>
          <div>I applied these to Mark's screamer branch to create a new
            OSX build. Testing was done by playing system sounds, and an
            MP3/Internet radio with QuickTime/iTunes. With or without
            6dB, the max volume is way out of my comfort zone. I hear no
            real difference in quality compared to a build from the </div=
>
        </div>
      </div>
    </blockquote>
    <br>
    It wasn't my intention to annoy your neighbours. On my computer I
    use an analog output for playback. Clipping happens before DA
    conversion, so I can use the volume control on the amplifier to have
    normal volume levels.<br>
    <br>
    <blockquote type=3D"cite"
cite=3D"mid:CABLmASHxx+x6rDo-Vk_wwKrHoq2+10oyH49AeKnmJXdQJSJnGw@mail.gmai=
l.com">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div>current screamer branch. If any, it might sound a bit
            better. That means there still is some minimal crackling
            (clipping?) in the high volume parts of the </div>
        </div>
      </div>
    </blockquote>
    <br>
    Crackling and clipping are two different things. Crackling is
    normally a timing problem where audio samples aren't delivered in
    time. Clipping produces harmonic distortions. For example a clipped
    sine wave will sound metallic because of the harmonic distortions.
    The difference between a clipped and a pure sine wave is clearly
    audible.<br>
    <br>
    <blockquote type=3D"cite"
cite=3D"mid:CABLmASHxx+x6rDo-Vk_wwKrHoq2+10oyH49AeKnmJXdQJSJnGw@mail.gmai=
l.com">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div>audio I played with OSX guests, not Mac OS 9.x guests.=C2=A0=
=C2=A0</div>
          <div><br>
          </div>
          <div>So as there is no regression,<br>
          </div>
          <div>tested by: howard spoelstra &lt;<a
              href=3D"mailto:hsp.cat7@gmail.com" moz-do-not-send=3D"true"=
>hsp.cat7@gmail.com</a>&gt;<br>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    With best regards,<br>
    Volker<br>
  </body>
</html>

--------------197CECB9CDEF60788956442E--

