Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB96C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:58:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267D121655
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBBbTIOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267D121655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBJrR-0005zi-CL
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 10:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1jBJqq-0005X3-AO
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1jBJqp-0007ac-8Y
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:57:52 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:45217)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1jBJqo-0007Yh-Um
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:57:51 -0400
Received: by mail-lj1-x241.google.com with SMTP id e18so10254623ljn.12
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 07:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NG/+2E2yJXfAobbP39HnRV3sJcTkO9w6qXpzxBFiGOc=;
 b=hBBbTIOgFhOlPZ62ZFjStdegM4zxFgXvp+q43vv2rwc1FhugGazF0oExUjaPaD2tcn
 WepBdHSd+FWXDb4wTQMN5t7z0wjowXGP1B1zOoekO7dFp5b4SYHt8xGIT6MIIUAOLzOJ
 ZWh29eht2IXAaKd/DMYQlo1MgmA11pjqH7ciFo910fVU2NXqFrIwCdb5QUdLhim42fX5
 l4MYarZkHJz5SDK2lKL/WdAChNlniW07RF5mvAG64VcCnuih2lWIRAB3HKv45dUxDkT0
 tT8rZ2bPXsGKTKEsOR9SxInUM79bBQRPnvQ4HeajBjW9kiavUSBMwn2vzY0wM3x05RkG
 zWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NG/+2E2yJXfAobbP39HnRV3sJcTkO9w6qXpzxBFiGOc=;
 b=YmNduR14Bbo+F3T4b4Q5lshiX6+D7fdikzhwv65eXSMmkuqJNc+lTm8dHGCTw1Vb7L
 QGSfmhS8kAR8TkMT2nDESbUBYf/kGErzt/DHjudV1QmADiM5gUIYbzBl16aSCBhuYOEu
 K6hz4HFu6GiDfiTKhp9MDNekr2ruLGdORg/2RTNvrS+Gx/b/jNoV7VxuSZU/zZfRZiPO
 UTyTAu1dg889cx6jY+Ne9QaxE6KAVKSPn17wThFkjuTTgV0Qy5BKwrK502NoLVrq4zu6
 u6OcONRjUQTvMv0n/Kc0QPlvPnzGd1bmDUji1HZ3Dg6pky37KpQsPxD0Lgy8oNZRUwKq
 67qg==
X-Gm-Message-State: ANhLgQ0whcYcip2vdmgvT+zysh4UDn3YmiYlvt3L2c7GtHwB5hYk/HqL
 IWYb8BYBsFTAm905bXdYGAb7xpvlVHilx9FL5dY=
X-Google-Smtp-Source: ADFU+vtTDWMaCH36XW4Xo+R5nBmD4ENx7xOrn6y+ufToB4sE1FpH3aw1nEUu3itXEQDZb2D8L7kLS3Xp+tI/04/saKw=
X-Received: by 2002:a05:651c:1212:: with SMTP id
 i18mr6455818lja.88.1583765868996; 
 Mon, 09 Mar 2020 07:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <2a4ade5f-d39b-3094-578f-6cced4650720@t-online.de>
 <20200308193321.20668-1-vr_qemu@t-online.de>
In-Reply-To: <20200308193321.20668-1-vr_qemu@t-online.de>
From: G 3 <programmingkidx@gmail.com>
Date: Mon, 9 Mar 2020 10:57:37 -0400
Message-ID: <CAKyx-3M0RMLspKhmUQ66is=5zc3ND5Jw0z7qT55kSAXZRUfAvA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] qapi/audio: add documentation for AudioFormat
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Content-Type: multipart/alternative; boundary="000000000000076b5205a06d3a6f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
Cc: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000076b5205a06d3a6f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2020 at 3:33 PM Volker R=C3=BCmelin <vr_qemu@t-online.de> wr=
ote:

> The review for patch ed2a4a7941 "audio: proper support for
> float samples in mixeng" suggested this would be a good idea.
>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> ---
>   <snip>
>
> Your patch applied cleanly to the latest commit I tried it out with. For
testing I used qemu-system-i386 with the AC97 sound card and a Windows 2000
guest. The audio played perfectly.

Tested-by: John Arbuckle <programmingkidx@gmail.com>

--000000000000076b5205a06d3a6f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Mar 8, 2020 at 3:33 PM Volker=
 R=C3=BCmelin &lt;<a href=3D"mailto:vr_qemu@t-online.de">vr_qemu@t-online.d=
e</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
><div>The review for patch ed2a4a7941 &quot;audio: proper support for<br>
float samples in mixeng&quot; suggested this would be a good idea.<br>
<br>
Acked-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" target=
=3D"_blank">armbru@redhat.com</a>&gt;<br>
Signed-off-by: Volker R=C3=BCmelin &lt;<a href=3D"mailto:vr_qemu@t-online.d=
e" target=3D"_blank">vr_qemu@t-online.de</a>&gt;<br>
---<br></div>=C2=A0
&lt;snip&gt;<br><div><div>
<br></div></div></blockquote><div>Your patch applied cleanly to the latest =
commit I tried it out with. For testing I used qemu-system-i386 with the AC=
97 sound card and a Windows 2000 guest. The audio played perfectly.</div><d=
iv><br></div><div>Tested-by: John Arbuckle &lt;<a href=3D"mailto:programmin=
gkidx@gmail.com">programmingkidx@gmail.com</a>&gt;<br></div><div> <br></div=
></div></div>

--000000000000076b5205a06d3a6f--

