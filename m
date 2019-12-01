Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5EBC432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 19:29:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C63820833
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 19:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSavegWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C63820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibUuV-0005yi-MC
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 14:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibUtq-0005NS-TI
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 14:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibUtp-0003f5-GU
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 14:28:54 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:45338)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ibUtp-0003ej-8Y
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 14:28:53 -0500
Received: by mail-ot1-x32f.google.com with SMTP id r24so29163354otk.12
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 11:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=4G+qrowq1rJ4K1Ee7gHS8BRwBq+W2MXdtWZerFkw3cY=;
 b=aSavegWIfHA3rqQ5pGWbU7ukPYMRlmrBh8OO0/fDe8ySIqR6k+/+1/FtczxX8P4ARb
 gfj9+bW2y+97JPJeGjYt5TJxlZwk8D5XgTqVTTWvb16YFwz4JV80mkHKd9K61HTFdiUh
 EEuGfLMf0+MNQo7Glwp45vdFTJ2px0G+ryN5cqy3PaNxwB+I0Gk7sRQeiKCKCE2uCvP6
 Ol7DpVwlJQJownInEz8cr0oW+q2yLHk7y9YQRykttE2iTUyGNBBivoTDRfSlFhecNbJu
 7VN3NZn6awyZj3B42e0StW2bQAk5PUQvNyo/R6Etfx2CpAFwMehjz277iB8PL4YW1HQ3
 s3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=4G+qrowq1rJ4K1Ee7gHS8BRwBq+W2MXdtWZerFkw3cY=;
 b=rcopfcZ/dywuZ4RSvDr07u93/qMv30XVXqVkTP75Xb7oKCoF6XSqsZb9JU2YvmtUk6
 g7SMHlDQ5amgh3J9kkozmwY4RvA/HdNm1qVs0nj9wW1HuCXGSXkyyLFzXkEiF6OWKGKy
 sHKiW/nULwDBGMPhyGya2jEnVqbDv07MTHpHbWvI5Xwomtr0avyb+MY8oD2N/POrUSgm
 58UTMXPZrFCKiNuy+pajgsvc3P/npUP7Ohdq3FOk1WfFMfDesp37lWqgH2JTsT0/rk58
 sv03VAYWq7hHzXq7l8ncoWwZspiCl+ahzHBfqvgZ/bUE8iZktngLt9eIDjgXYBz+2CpG
 dgtA==
X-Gm-Message-State: APjAAAXuYXMlHbBjvY/xqrXtG5cUeRGG7xOmbqHG2GXVEAL53bxZmXnZ
 oAxomJJWkHMGI62JIDyaqJHaHkoEVTcIbtO5QCA=
X-Google-Smtp-Source: APXvYqzrjzvb0mEi6NnZekzFoPjphv4RUjZWK4LbjyXPC3RwcFmyhPWMD+jXxq2DZ6w82EEc3cWMqDa4AqElPuuY5n8=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr20004434otc.295.1575228531938; 
 Sun, 01 Dec 2019 11:28:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sun, 1 Dec 2019 11:28:51
 -0800 (PST)
In-Reply-To: <CAL1e-=gy11o-uM_qJozuuJyOk34xrsF0L4U-hL0y6RdHV0z-aQ@mail.gmail.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <CAJ+F1CLV_JRhXX=tB7ZXYxa1En4LzYgJr+7egKzVRNBOLY2nSA@mail.gmail.com>
 <CAL1e-=hoxa3md+N4xraW99GyqG=nuPO48jaEc75=F+uyJBRYEQ@mail.gmail.com>
 <CAJ+F1CKwMntHSCnZpUUbaXn675BNaiYhrczG4NaSNz8naZa01w@mail.gmail.com>
 <CAL1e-=gy11o-uM_qJozuuJyOk34xrsF0L4U-hL0y6RdHV0z-aQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 1 Dec 2019 20:28:51 +0100
Message-ID: <CAL1e-=i3qTvooaXTZVYD991CP7kusu-c8iFp_PdEBROOD9-OjA@mail.gmail.com>
Subject: Re: [PATCH v6 00/37] Clean-ups: qom-ify serial and remove
 QDEV_PROP_PTR
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000001619380598a97919"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001619380598a97919
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sunday, December 1, 2019, Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Sunday, December 1, 2019, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gma=
il.com>
> wrote:
>
>> Hi Aleksandar
>>
>> On Sun, Dec 1, 2019 at 4:15 PM Aleksandar Markovic
>> <aleksandar.m.mail@gmail.com> wrote:
>> >
>> >
>> >
>> > On Sunday, December 1, 2019, Marc-Andr=C3=A9 Lureau <
>> marcandre.lureau@gmail.com> wrote:
>> >
>> >>
>> >> - "RFC: mips/cps: fix setting saar property"
>> >>
>> >> Perhaps I should have used FIX instead of RFC, because this should
>> >> actually be a real fix. However I could use someone help to exercise
>> >> the code path.
>> >>
>> >
>> > Marc-Andr=C3=A9, hi.
>> >
>> > There is a work in progress on fixing this. Can we in MIPS submit the
>> fix independently, since it involves some additional pieces of code that
>> are really deeply mips-specific? We acknowledge the bug, and want to
>> develop the real solution. Can you simply skip this RFC patch in your
>> series, since the issues will be handled separately in our patch, hopefu=
lly
>> soon after the merge window is open?
>> >
>> > For all other mips parts of your series, you have my "reviewed-by"s ,
>> in case I forgot to send them explicitely.
>> >
>>
>> This is a one-liner, and it is required to achieve the goal of the
>> series, to remove PROP_PTR.
>>
>> If you prefer, I can instead comment the line with a FIXME, since it
>> is apparently broken anyway?
>>
>> If you manage to get your fix merged earlier, then this patch can be
>> dropped. Else, is it a problem for the later fixes?
>>
>>
> OK, Marc-Andr=C3=A9,
>
> Please go ahead with this patch, so that the goal of the series is
> achieved, and we will later submitt a wider patch that will address the
> root cause. Just remove RFC from subject, everything else looks fine to m=
e.
> You can add my "reviewed-by".
>
>
I mean, yes, you are right, it is broken, with or without the patch, so go
ahead, at least your series will fulfill its purpose, and I'll have enough
time to integrate the fix later on, without interfering each other.

Thanks for the series!


Yours, Aleksandar
>
>
>
>
>> thanks
>>
>>
>> --
>> Marc-Andr=C3=A9 Lureau
>>
>

--0000000000001619380598a97919
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Sunday, December 1, 2019, Aleksandar Markovic &lt;<a href=3D"mai=
lto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt; wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><br><br>On Sunday, December 1, 2019, Mar=
c-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.com" targe=
t=3D"_blank">marcandre.lureau@gmail.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Hi Aleksandar<br>
<br>
On Sun, Dec 1, 2019 at 4:15 PM Aleksandar Markovic<br>
&lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"_blank">aleksa=
ndar.m.mail@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Sunday, December 1, 2019, Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mai=
lto:marcandre.lureau@gmail.com" target=3D"_blank">marcandre.lureau@gmail.co=
m</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; - &quot;RFC: mips/cps: fix setting saar property&quot;<br>
&gt;&gt;<br>
&gt;&gt; Perhaps I should have used FIX instead of RFC, because this should=
<br>
&gt;&gt; actually be a real fix. However I could use someone help to exerci=
se<br>
&gt;&gt; the code path.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Marc-Andr=C3=A9, hi.<br>
&gt;<br>
&gt; There is a work in progress on fixing this. Can we in MIPS submit the =
fix independently, since it involves some additional pieces of code that ar=
e really deeply mips-specific? We acknowledge the bug, and want to develop =
the real solution. Can you simply skip this RFC patch in your series, since=
 the issues will be handled separately in our patch, hopefully soon after t=
he merge window is open?<br>
&gt;<br>
&gt; For all other mips parts of your series, you have my &quot;reviewed-by=
&quot;s , in case I forgot to send them explicitely.<br>
&gt;<br>
<br>
This is a one-liner, and it is required to achieve the goal of the<br>
series, to remove PROP_PTR.<br>
<br>
If you prefer, I can instead comment the line with a FIXME, since it<br>
is apparently broken anyway?<br>
<br>
If you manage to get your fix merged earlier, then this patch can be<br>
dropped. Else, is it a problem for the later fixes?<br>
<br></blockquote><div><br></div><div>OK, Marc-Andr=C3=A9,</div><div><br></d=
iv><div>Please go ahead with this patch, so that the goal of the series is =
achieved, and we will later submitt a wider patch that will address the roo=
t cause. Just remove RFC from subject, everything else looks fine to me. Yo=
u can add my &quot;reviewed-by&quot;.</div><div><br></div></blockquote><div=
><br></div><div>I mean, yes, you are right, it is broken, with or without t=
he patch, so go ahead, at least your series will fulfill its purpose, and I=
&#39;ll have enough time to integrate the fix later on, without interfering=
 each other.</div><div><br></div><div>Thanks for the series!</div><div><br>=
</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div>Yours, Aleksandar<=
/div><div><br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
thanks<br>
<br>
<br>
-- <br>
Marc-Andr=C3=A9 Lureau<br>
</blockquote>
</blockquote>

--0000000000001619380598a97919--

