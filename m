Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE83C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 966EA2073A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5tuSPGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966EA2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is3KH-0002Fn-LL
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 06:28:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1is3Jg-0001q0-6f
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 06:28:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1is3Jd-0000P1-G4
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 06:27:59 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1is3Jd-0000NV-7V
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 06:27:57 -0500
Received: by mail-ot1-x344.google.com with SMTP id 59so19005250otp.12
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 03:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=tTI8onj5B4nslbtusEcKMNx9Tnr3ZU5YyH0RvvnCbfU=;
 b=O5tuSPGEe0i+R+jDUyC6KgygyAq+RlGNuMam8TLogbUwIysUH4Gr/kfQLyTFH1yUxP
 4/Lg1fOuy/93ouBiGxLeaCOiijDID9+tiPz5SrjsNwoJUWUpPdo/EJxvhDdjx2C0fM4i
 XSLu4OziJxAjozUJGTYu/dvj0Ko1fV+3F6VyBL0QB6bBwD10Xp/gYqVhhaMD0AaFpMK5
 op9WYAMgeIYJgGd6gBpoXsIVCjU2pSqDNmlPdY49eNNfeVgwh70rGsiZVrsmh36c5KRF
 tIFuhF5hiur5fYOGEJrvNboxNtJtQe701nCiKUSUtNf3Fjd+CBA5DByjtpvOV3u9GyV0
 6YzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=tTI8onj5B4nslbtusEcKMNx9Tnr3ZU5YyH0RvvnCbfU=;
 b=Mooc/XnEmqEr9pD+8cg5oszYjvB+rY0kZ0AO+5XzwI9ltU2jkWLt2stkpSpKuO5Ht6
 DfrXPxL+6E2CLI6WpoD0IVCJzWfOWCe/cBIJqQY8Ya4ojWwolo6ez76TpqpbBIukMh/F
 41Vi6ONMRjvCJQC1vxjIWLW22L1tEEmLgaLnBgkjolRfDtM5bERkkV6zSm4wVOOTK7HA
 5q0LTRIqaj9/4N5+0u071nNxtLJNYuEfVaXeKDd7fIQ1o1owIrYbccIKryVjThqqJrK1
 FXhYqxFCKK30K63zAcE/MYIGLLwKeAEtznCPl7C1AdNCnHfOJnJ5nmJ7l46TWZKD1rVb
 4PTQ==
X-Gm-Message-State: APjAAAX154gMUDaLPQI88ux4pnjE1wmfu1sdQpTBor7/3CGg90wrtXt2
 ehHdV3zbmlSEJ+Av7nYJQtmJ+xlh9gmTyaog+6E=
X-Google-Smtp-Source: APXvYqytYLTjQPrKILmcvzMhV66Qsapovl311vLqxucK027BmcatCIa6veIZpRoNxP4Lk4oAiF5kEh8QcyoeyzYTay4=
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr1525444otp.306.1579174076076; 
 Thu, 16 Jan 2020 03:27:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Thu, 16 Jan 2020 03:27:55 -0800 (PST)
In-Reply-To: <CAL1e-=i3-nYJMo6ptA7fdcK8r6P4vv20x2+LLV6BA9ELO8H53w@mail.gmail.com>
References: <1579103618-20217-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1579103618-20217-9-git-send-email-Filip.Bozuta@rt-rk.com>
 <CAK8P3a187rPhma7Q6o+hCF3h0=5MLZwh49+JqKt6BvVsAB1efQ@mail.gmail.com>
 <ceaf44c0-fd6c-c280-7f95-7bc133553089@vivier.eu>
 <CAK8P3a36KqWD4fKBLDpFhJg079bNdJDSDUAP2Zu_i1+H62Q6ZQ@mail.gmail.com>
 <518d717d-9f1e-e00e-f2a9-df8861241d1c@rt-rk.com>
 <cdcce2a3-00f5-f6d1-3083-dc36892ac5b4@vivier.eu>
 <CAL1e-=i3-nYJMo6ptA7fdcK8r6P4vv20x2+LLV6BA9ELO8H53w@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 16 Jan 2020 12:27:55 +0100
Message-ID: <CAL1e-=g8X___59zLPKLRjFNAP9bs3rVWhc8+OhMuF3TriBiynw@mail.gmail.com>
Subject: Re: [PATCH 08/12] linux-user: Add support for setting alsa timer
 enhanced read using ioctl
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="000000000000d7d671059c401dc5"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Filip Bozuta <Filip.Bozuta@rt-rk.com>, Max Filippov <jcmvbkbc@gmail.com>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d7d671059c401dc5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thursday, January 16, 2020, Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Wednesday, January 15, 2020, Laurent Vivier <laurent@vivier.eu> wrote:
>
>> Le 15/01/2020 =C3=A0 20:17, Filip Bozuta a =C3=A9crit :
>> >
>> > On 15.1.20. 17:37, Arnd Bergmann wrote:
>> >> On Wed, Jan 15, 2020 at 5:32 PM Laurent Vivier <laurent@vivier.eu>
>> wrote:
>> >>> Le 15/01/2020 =C3=A0 17:18, Arnd Bergmann a =C3=A9crit :
>> >>>> On Wed, Jan 15, 2020 at 4:53 PM Filip Bozuta
>> >>>> <Filip.Bozuta@rt-rk.com> wrote:
>> >>>>> This patch implements functionality of following ioctl:
>> >>>>>
>> >>>>> SNDRV_TIMER_IOCTL_TREAD - Setting enhanced time read
>> >>>>>
>> >>>>>      Sets enhanced time read which is used for reading time with
>> >>>>> timestamps
>> >>>>>      and events. The third ioctl's argument is a pointer to an
>> >>>>> 'int'. Enhanced
>> >>>>>      reading is set if the third argument is different than 0,
>> >>>>> otherwise normal
>> >>>>>      time reading is set.
>> >>>>>
>> >>>>> Implementation notes:
>> >>>>>
>> >>>>>      Because the implemented ioctl has 'int' as its third argument=
,
>> >>>>> the
>> >>>>>      implementation was straightforward.
>> >>>>>
>> >>>>> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
>> >>>> I think this one is wrong when you go between 32-bit and 64-bit
>> >>> kernel uses an "int" and "int" is always 32bit.
>> >>> The problem is most likely with timespec I think.
>> >>>
>> >>>> targets, and it gets worse with the kernel patches that just got
>> >>>> merged for linux-5.5, which extends the behavior to deal with
>> >>>> 64-bit time_t on 32-bit architectures.
>> >>>>
>> >>>> Please have a look at
>> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-n
>> ext.git/log/?h=3D80fe7430c70859
>> >>>>
>> >>> Yes, we already had the same kind of problem with SIOCGSTAMP and
>> >>> SIOCGSTAMPNS.
>> >>>
>> >>> Do the kernel patches add new ioctl numbers to differentiate 32bit a=
nd
>> >>> 64bit time_t?
>> >> Yes, though SNDRV_TIMER_IOCTL_TREAD is worse: the ioctl argument
>> >> is a pure 'int' that decides what format you get when you 'read' from
>> the
>> >> same file descriptor.
>> >>
>> >> For emulating 64-bit on 32-bit kernels, you have to use the new
>> >> SNDRV_TIMER_IOCTL_TREAD64, and for emulating 32-bit on
>> >> 64-bit kernels, you probably have to return -ENOTTY to
>> >> SNDRV_TIMER_IOCTL_TREAD_OLD unless you also want to
>> >> emulate the read() behavior.
>> >> When a 32-bit process calls SNDRV_TIMER_IOCTL_TREAD64,
>> >> you can translate that into the 64-bit
>> >> SNDRV_TIMER_IOCTL_TREAD_OLD.
>> >>
>> >>       Arnd
>> >
>> >
>> > Thank you for bringing this up to my attention. Unfortunately i have
>> > some duties of academic nature in next month so i won't have much time
>> > fix this bug. I will try to fix this as soon as possible.
>>
>> Could you at least to try to have a mergeable series before you have to
>> stop to work on this?
>>
>> You can only manage the case before the change reported by Arnd (I will
>> manage the new case myself later).
>>
>>
> Hi, all.
>
> Sorry for interjecting myself into this discussion, but I just want to le=
t
> you know about some related practicalities.
>
> Filip is a student that is from time to time (usually between two exam
> seasons) an intern in our company, working 4 hours each work day. He spen=
t
> his internship in different teams in prevous years, and, from around
> mid-October 2019, was appointed to QEMU team. After some introductory
> tasks, he was assigned his main task: linux-user support for RTCs and ALS=
A
> timers. This series is the result of his work, and, to my great pleasure,
> is virtually entirely his independant work. I am positive he can complete
> the series by himself, even in the light of additional complexities
> mentioned in this thread.
>
> However, his exam season just started (Jan. 15th), and lasts till Feb.
> 15th. Our policy, in general, is not to burden the students during exam
> seasons, and that is why we can't expect prompt updates from him for the
> time being.
>
> In view of this, Laurent, please take Filip's status into consideration.
> As far as mergeability is concerned, my impression is that patches 1-6 an=
d
> 13 are ready for merging, while patches 7-12 would require some additiona=
l
> (netlink-support-like) work, that would unfortunately be possible only
> after Feb. 15th.
>
> Best wishes,
> Aleksandar
>
>
>
Laurent, hi again.

I am not completely familiar with all details of Filip's work, since, as I
said, he had large degree of independance (which was intentional, and is a
desired and good thing IMHO), but taking a closer look, a question starting
lingering: Do we need special handling od read() even for RTC devices - not
only ALSA timer devices?

Best regards,
Aleksandar


>
>
> Thanks,
>> Laurent
>>
>>
>>

--000000000000d7d671059c401dc5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, January 16, 2020, Aleksandar Markovic &lt;<a href=3D"m=
ailto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt; wrot=
e:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><br><br>On Wednesday, January 15, 2020=
, Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu" target=3D"_blank"=
>laurent@vivier.eu</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Le 15/0=
1/2020 =C3=A0 20:17, Filip Bozuta a =C3=A9crit=C2=A0:<br>
&gt; <br>
&gt; On 15.1.20. 17:37, Arnd Bergmann wrote:<br>
&gt;&gt; On Wed, Jan 15, 2020 at 5:32 PM Laurent Vivier &lt;<a href=3D"mail=
to:laurent@vivier.eu" target=3D"_blank">laurent@vivier.eu</a>&gt; wrote:<br=
>
&gt;&gt;&gt; Le 15/01/2020 =C3=A0 17:18, Arnd Bergmann a =C3=A9crit :<br>
&gt;&gt;&gt;&gt; On Wed, Jan 15, 2020 at 4:53 PM Filip Bozuta<br>
&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:Filip.Bozuta@rt-rk.com" target=3D"_b=
lank">Filip.Bozuta@rt-rk.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt; This patch implements functionality of following ioctl=
:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; SNDRV_TIMER_IOCTL_TREAD - Setting enhanced time read<b=
r>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 Sets enhanced time read which=
 is used for reading time with<br>
&gt;&gt;&gt;&gt;&gt; timestamps<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 and events. The third ioctl&#=
39;s argument is a pointer to an<br>
&gt;&gt;&gt;&gt;&gt; &#39;int&#39;. Enhanced<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 reading is set if the third a=
rgument is different than 0,<br>
&gt;&gt;&gt;&gt;&gt; otherwise normal<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 time reading is set.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Implementation notes:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 Because the implemented ioctl=
 has &#39;int&#39; as its third argument,<br>
&gt;&gt;&gt;&gt;&gt; the<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 implementation was straightfo=
rward.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Signed-off-by: Filip Bozuta &lt;<a href=3D"mailto:Fili=
p.Bozuta@rt-rk.com" target=3D"_blank">Filip.Bozuta@rt-rk.com</a>&gt;<br>
&gt;&gt;&gt;&gt; I think this one is wrong when you go between 32-bit and 6=
4-bit<br>
&gt;&gt;&gt; kernel uses an &quot;int&quot; and &quot;int&quot; is always 3=
2bit.<br>
&gt;&gt;&gt; The problem is most likely with timespec I think.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; targets, and it gets worse with the kernel patches that ju=
st got<br>
&gt;&gt;&gt;&gt; merged for linux-5.5, which extends the behavior to deal w=
ith<br>
&gt;&gt;&gt;&gt; 64-bit time_t on 32-bit architectures.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Please have a look at<br>
&gt;&gt;&gt;&gt; <a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git=
/next/linux-next.git/log/?h=3D80fe7430c70859" target=3D"_blank">https://git=
.kernel.org/pub/scm<wbr>/linux/kernel/git/next/linux-n<wbr>ext.git/log/?h=
=3D80fe7430c70859</a><br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; Yes, we already had the same kind of problem with SIOCGSTAMP a=
nd<br>
&gt;&gt;&gt; SIOCGSTAMPNS.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Do the kernel patches add new ioctl numbers to differentiate 3=
2bit and<br>
&gt;&gt;&gt; 64bit time_t?<br>
&gt;&gt; Yes, though SNDRV_TIMER_IOCTL_TREAD is worse: the ioctl argument<b=
r>
&gt;&gt; is a pure &#39;int&#39; that decides what format you get when you =
&#39;read&#39; from the<br>
&gt;&gt; same file descriptor.<br>
&gt;&gt;<br>
&gt;&gt; For emulating 64-bit on 32-bit kernels, you have to use the new<br=
>
&gt;&gt; SNDRV_TIMER_IOCTL_TREAD64, and for emulating 32-bit on<br>
&gt;&gt; 64-bit kernels, you probably have to return -ENOTTY to<br>
&gt;&gt; SNDRV_TIMER_IOCTL_TREAD_OLD unless you also want to<br>
&gt;&gt; emulate the read() behavior.<br>
&gt;&gt; When a 32-bit process calls SNDRV_TIMER_IOCTL_TREAD64,<br>
&gt;&gt; you can translate that into the 64-bit<br>
&gt;&gt; SNDRV_TIMER_IOCTL_TREAD_OLD.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Arnd<br>
&gt; <br>
&gt; <br>
&gt; Thank you for bringing this up to my attention. Unfortunately i have<b=
r>
&gt; some duties of academic nature in next month so i won&#39;t have much =
time<br>
&gt; fix this bug. I will try to fix this as soon as possible.<br>
<br>
Could you at least to try to have a mergeable series before you have to<br>
stop to work on this?<br>
<br>
You can only manage the case before the change reported by Arnd (I will<br>
manage the new case myself later).<br>
<br></blockquote><div><br></div><div>Hi, all.</div><div><br></div><div>Sorr=
y for interjecting myself into this discussion, but I just want to let you =
know about some related practicalities.</div><div><br></div><div>Filip is a=
 student that is from time to time (usually between two exam seasons) an in=
tern in our company, working 4 hours each work day. He spent his internship=
 in different teams in prevous years, and, from around mid-October 2019, wa=
s appointed to QEMU team. After some introductory tasks, he was assigned hi=
s main task: linux-user support for RTCs and ALSA timers. This series is th=
e result of his work, and, to my great pleasure, is virtually entirely his =
independant work. I am positive he can complete the series by himself, even=
 in the light of additional complexities mentioned in this thread.</div><di=
v><br></div><div>However, his exam season just started (Jan. 15th), and las=
ts till Feb. 15th. Our policy, in general, is not to burden the students du=
ring exam seasons, and that is why we can&#39;t expect prompt updates from =
him for the time being.</div><div><br></div><div>In view of this, Laurent, =
please take Filip&#39;s status into consideration. As far as mergeability i=
s concerned, my impression is that patches 1-6 and 13 are ready for merging=
, while patches 7-12 would require some additional (netlink-support-like) w=
ork, that would unfortunately be possible only after Feb. 15th.</div><div><=
br></div><div>Best wishes,</div><div>Aleksandar</div><div><br></div><div><b=
r></div></blockquote><div><br></div><div>Laurent, hi again.</div><div><br><=
/div><div>I am not completely familiar with all details of Filip&#39;s work=
, since, as I said, he had large degree of independance (which was intentio=
nal, and is a desired and good thing IMHO), but taking a closer look, a que=
stion starting lingering: Do we need special handling od read() even for RT=
C devices - not only ALSA timer devices?</div><div><br></div><div>Best rega=
rds,</div><div>Aleksandar</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><div><br></div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Thanks,<br>
Laurent<br>
<br>
<br>
</blockquote>
</blockquote>

--000000000000d7d671059c401dc5--

