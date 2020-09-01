Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40228C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:55:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2DEF206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF49WbYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DEF206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD9Ym-0006rx-1X
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 12:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kD9Y6-00062q-4Z
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:54:22 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:42698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kD9Y4-0003DK-Gt
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:54:21 -0400
Received: by mail-ed1-x541.google.com with SMTP id l63so2126781edl.9
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 09:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8WxRbOgX4F6Jk4oE+IqQYZBsB80JQnkE+t8+Xel50sA=;
 b=aF49WbYnM5fesl9rzOqXOTX/tSONIzg7NHqmLMbGbWb0X8l/fOlo7H77Ta8eUin9NZ
 KyX3ZSgpbrDrqV34U7FjAZfh+d1g3Z/L/2Jr9tEBm9dAQUoVjvzt3Dq0A+8+h3uBsti/
 28EipeWo8q7hJFpYxzmMtYKqOflCcPbezuWzZopwCiIHf/kx4+soy5Ofwbp+MGHBlBV9
 CUc269cT7vQ1kyJYknv5G2CjfHRFeZBD0CA2FgX7prStRigJij4EdwV+QnQfcBMUk+WW
 4LdmWyeTOb/M+LrbJ6aLjde/bMyKyO+bPek6Pwc2FbRtvq0nwr56QrbWO7Dylslo6sGK
 ZFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8WxRbOgX4F6Jk4oE+IqQYZBsB80JQnkE+t8+Xel50sA=;
 b=maznd/oO9u5DnaF69xU9GBEt+KNuaSl7hnDbA8ZrWCgVJM3fcXwJkSBu8ySaAUZkZC
 07AbP+OVFFLtWd4Uz66t1KlWgDaXuJ86NXlbJu9oJDKivEwCpqCMUIo29GplnCv6c08G
 +pi3CZOhB83rYLAtpaePezdx9+PHdPnzN+5AI3xK1w7JW9tfr1VbXS7djEcubdaRI0QQ
 fU+TVJR4XyowYsEHz8ZDAHIbNlxwT07Vk+bn/lO8Il5gT4cufly8AUI8VBJBWHjW+ogB
 IxQlVshy2bjEcV/MCRbgXTe0rN8xPD6skcPu8olSmUHBjZ0KbFCOcxnW3l2WYdnpiCui
 0iMA==
X-Gm-Message-State: AOAM530yQ6FDJwZwG/yrPOeAiw4MthjB5iSZBfatvPEoi63JOr9MwHt9
 4SnW9hkB9qfjgXKptdaO+o9TX3rrFDORVzDKjws=
X-Google-Smtp-Source: ABdhPJwBw3UsM2FvL8DKGo5AViuFePsupfNG8yxct1eJyjVNI0kZLuFCQHPJ0x1Rw5voUKOAqrgIgNcyAcerR1gqtI4=
X-Received: by 2002:a50:bb65:: with SMTP id y92mr2536358ede.53.1598979257876; 
 Tue, 01 Sep 2020 09:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200806130340.17316-1-f4bug@amsat.org>
 <bc283986-6f08-fb1c-2219-9b4af64eaaa0@amsat.org>
 <CAFEAcA_XP+XbsfE3XhyrB=yO7iaz69j_rydanao1abVz8jaPKg@mail.gmail.com>
 <CAAdtpL7=Q8zTftQYJQGbj=xtCyLu3tusd+M_P8qtbNTOubceEw@mail.gmail.com>
In-Reply-To: <CAAdtpL7=Q8zTftQYJQGbj=xtCyLu3tusd+M_P8qtbNTOubceEw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 1 Sep 2020 20:54:05 +0400
Message-ID: <CAJ+F1CLJJCFSWRYaGNnV7=hUPNPmiZ0wT+UaDbF=tnFuCewfsQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.2 0/4] hw/char/serial: Use the Clock API to feed the
 UART reference clock
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000ab45c605ae435e07"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ab45c605ae435e07
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Aug 26, 2020 at 1:52 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> Hi Peter,
>
> Le lun. 24 ao=C3=BBt 2020 17:20, Peter Maydell <peter.maydell@linaro.org>=
 a
> =C3=A9crit :
>
>> On Sat, 22 Aug 2020 at 21:00, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
>> wrote:
>> >
>> > On 8/6/20 3:03 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> > > This series improve tracing of multiple UART device in the same
>> > > chipset, and allow to use the Clock API to feed each device with
>> > > an (updatable) input clock.
>> > >
>> > > Based-on: <20200730165900.7030-1-philmd@redhat.com>
>> > > "hw/char: Remove TYPE_SERIAL_IO"
>> > >
>> > > Philippe Mathieu-Daud=C3=A9 (4):
>> > >   hw/char/serial: Replace commented DPRINTF() by trace event
>> > >   hw/char/serial: Remove old DEBUG_SERIAL commented code
>> > >   hw/char/serial: Let SerialState have an 'id' field
>> > >   hw/char/serial: Use the Clock API to feed the UART reference clock
>> > >
>> > >  include/hw/char/serial.h |  4 +++
>> > >  hw/char/serial.c         | 55
>> +++++++++++++++++++++++-----------------
>> > >  hw/char/trace-events     |  5 ++--
>> > >  3 files changed, 39 insertions(+), 25 deletions(-)
>> > >
>> >
>> > ping? Should I resend with the typo from patch 4 fixed?
>>
>> Which tree are you expecting the patches to go in via ?
>>
>
> I cc'ed you because having reviewed the Clock API series you are familiar
> with it.
> However I expect this series to be merged by the chardev maintainers.
> In particular to verify the default values (when no input clock provided)=
.
>

Sorry, I am not of much help here. (other than it looks reasonable to me)


--=20
Marc-Andr=C3=A9 Lureau

--000000000000ab45c605ae435e07
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 26, 2020 at 1:52 PM Phi=
lippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat=
.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><div dir=3D"auto"><div>Hi Peter,<br><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">Le lun. 24 ao=C3=BBt 2020 17:20, Peter Ma=
ydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">pet=
er.maydell@linaro.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On Sat, 22 Aug 2020 at 21:00, Philippe Ma=
thieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org" rel=3D"noreferrer" =
target=3D"_blank">f4bug@amsat.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On 8/6/20 3:03 PM, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; &gt; This series improve tracing of multiple UART device in the same<b=
r>
&gt; &gt; chipset, and allow to use the Clock API to feed each device with<=
br>
&gt; &gt; an (updatable) input clock.<br>
&gt; &gt;<br>
&gt; &gt; Based-on: &lt;<a href=3D"mailto:20200730165900.7030-1-philmd@redh=
at.com" rel=3D"noreferrer" target=3D"_blank">20200730165900.7030-1-philmd@r=
edhat.com</a>&gt;<br>
&gt; &gt; &quot;hw/char: Remove TYPE_SERIAL_IO&quot;<br>
&gt; &gt;<br>
&gt; &gt; Philippe Mathieu-Daud=C3=A9 (4):<br>
&gt; &gt;=C2=A0 =C2=A0hw/char/serial: Replace commented DPRINTF() by trace =
event<br>
&gt; &gt;=C2=A0 =C2=A0hw/char/serial: Remove old DEBUG_SERIAL commented cod=
e<br>
&gt; &gt;=C2=A0 =C2=A0hw/char/serial: Let SerialState have an &#39;id&#39; =
field<br>
&gt; &gt;=C2=A0 =C2=A0hw/char/serial: Use the Clock API to feed the UART re=
ference clock<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 include/hw/char/serial.h |=C2=A0 4 +++<br>
&gt; &gt;=C2=A0 hw/char/serial.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 55 ++++=
+++++++++++++++++++-----------------<br>
&gt; &gt;=C2=A0 hw/char/trace-events=C2=A0 =C2=A0 =C2=A0|=C2=A0 5 ++--<br>
&gt; &gt;=C2=A0 3 files changed, 39 insertions(+), 25 deletions(-)<br>
&gt; &gt;<br>
&gt;<br>
&gt; ping? Should I resend with the typo from patch 4 fixed?<br>
<br>
Which tree are you expecting the patches to go in via ?<br></blockquote></d=
iv></div><div dir=3D"auto"><br></div><div dir=3D"auto">I cc&#39;ed you beca=
use having reviewed the Clock API series you are familiar with it.</div><di=
v dir=3D"auto">However I expect this series to be merged by the chardev mai=
ntainers.</div><div dir=3D"auto">In particular to verify the default values=
 (when no input clock provided).</div></div></blockquote><div><br></div><di=
v>Sorry, I am not of much help here. (other than it looks reasonable to me)=
<br></div></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"gmai=
l_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000ab45c605ae435e07--

