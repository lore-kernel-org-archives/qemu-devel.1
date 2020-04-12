Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D37C2BA2B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 09:16:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20870206DA
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 09:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcwjimPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20870206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNYih-0007Vl-82
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 05:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1jNYi1-0006yx-8q
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 05:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1jNYi0-0005St-4U
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 05:15:21 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:36909)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1jNYi0-0005Sb-0c
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 05:15:20 -0400
Received: by mail-qt1-x841.google.com with SMTP id q17so4697987qtp.4
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2020 02:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3U1qj3o6QEsmXuWh3a8R+Av6avW64WyTo3s6lImj8xs=;
 b=lcwjimPZssusqwzrG48fPDY+9gGQ23X+qtyWagDWXl20a/cVXYzQF1Dvzn8pfZQybZ
 6HwkjCM4jon1ICTTPALqBX38K0pNgvWJ0mkslycxw3LE5kueaXOta2x/wnyLeucjHEWC
 sz/j4uLM5wtwaQLgkHzhVGwBYcjDf9kEwOkjbSusnZUh7fxa57zoafpqv7hTrlCpUY3W
 CMWkCi/K5KZUlpTOjd76I582dE6dL32reJA/c+deCGTzuEID1JTgh7l3DqOJPTo8ARt+
 f4yftpNCSE0Y3qCgc9X7NOGCYuNU8vsJTSHDrJRKY/2ZcNWA9oT3O7KpfFEBof2GLs6S
 snfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3U1qj3o6QEsmXuWh3a8R+Av6avW64WyTo3s6lImj8xs=;
 b=HbQp5Ra9hyafZHMr9Ims7Es2ocf1E/4Nae5Q3mS+fwqnzYQydkklYu907IYr+t1VM9
 3cvYgtItU0eURrIUHJVTYxwWKEuOv3/+8FbWUKWROqpb4hF0d00iA9DZ8NIsWu6zCiSB
 eCPD/PwCNj6eQ4ai9ifPiDLZ5vl+DJXobpRrUxPUqAhVc0breat8w19Hgb+jmdTt2jqg
 Vm5YJxG2okYjiOogdVGiQ5+x+QSgV+KVNdcQCdlJVprrMu5GKCu+DbXqeQquS2Xf2qSF
 GJ0Dxh/0San8aqPeamtRGDSVy1TeTAWNF9EbmzL43K5wFBUitq/cgizkphJyLosr2MEJ
 NQFQ==
X-Gm-Message-State: AGi0PubIA1Qu9Ovi9T7sMIN+wiZNyO0Wi5Xj1s9N23Om2URGpQxWoApt
 R677M2XOaKnJWJ6T/GaXewiea64kj2a0BgABVtU=
X-Google-Smtp-Source: APiQypIlZ60AEi541/pXL+KUiVdfjWkR2DyBJXG2o+712jsRjmsLpjgNvxNq2MicD1ay50IR5QJH3o1hXsSJn/xba58=
X-Received: by 2002:ac8:4f03:: with SMTP id b3mr6537717qte.282.1586682919047; 
 Sun, 12 Apr 2020 02:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200118191416.19934-1-mrolnik@gmail.com>
 <20200118191416.19934-2-mrolnik@gmail.com>
 <80141c57-7fb7-6e95-4070-54f7cc23e166@redhat.com>
 <CAK4993ie33Awp=sqUOcubqCLFqTd5mTPAkWQfhh3zvorMwnSig@mail.gmail.com>
 <8ac9a03a-a02f-1b48-c75d-77e4b8aea9ef@linaro.org>
 <45d68295-416b-b6d2-a512-86f6120432f0@redhat.com>
 <CAK4993iVT358BOU9gQKcNEDLw_smTfvzm0ePDO1WLubtGx_Mvw@mail.gmail.com>
In-Reply-To: <CAK4993iVT358BOU9gQKcNEDLw_smTfvzm0ePDO1WLubtGx_Mvw@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Sun, 12 Apr 2020 12:14:33 +0300
Message-ID: <CAK4993ignoQ2c8hz7WSYVORTmmzrFaLM+XB-yczSAaTcyVs8Dw@mail.gmail.com>
Subject: Re: [PATCH v41 01/21] target/avr: Add outward facing interfaces and
 core CPU logic
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c2d70205a3146786"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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
Cc: Thomas Huth <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c2d70205a3146786
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi all.

are there any news / updates about AVR support?

On Mon, Mar 23, 2020 at 10:14 PM Michael Rolnik <mrolnik@gmail.com> wrote:

> thanks Philippe.
>
> On Mon, Mar 23, 2020 at 9:20 PM Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com>
> wrote:
>
>> On 3/23/20 7:03 PM, Richard Henderson wrote:
>> > On 3/23/20 10:03 AM, Michael Rolnik wrote:
>> >> Hi Philippe.
>> >>
>> >> It's been a while. let me think about it and get back to you. what is
>> your
>> >> concern ?
>>
>> We are using this series with Joaquin for a Google Summit of Code
>> project, so we are noticing some bugs and fixing them.
>> As it has not been merged, we work in a fork.
>> Since it was posted on the list, I prefer to ask on the list than
>> directly to you.
>>
>> >
>> > It shouldn't be there.  See commit 1f5c00cfdb81.
>>
>> Ah it has been moved to cpu_common_reset, thanks :)
>> I suppose it is because this port is based on some quite old work.
>>
>> >
>> >>      > +    memset(env->r, 0, sizeof(env->r));
>> >>      > +
>> >>      > +    tlb_flush(cs);
>> >>
>> >>      Why are you calling tlb_flush() here?
>> >
>> >
>> > r~
>> >
>>
>>
>
> --
> Best Regards,
> Michael Rolnik
>


--=20
Best Regards,
Michael Rolnik

--000000000000c2d70205a3146786
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">hi all.<div><br></div><div>are there any news / updates ab=
out AVR support?</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Mon, Mar 23, 2020 at 10:14 PM Michael Rolnik &lt;<=
a href=3D"mailto:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">thank=
s Philippe.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Mon, Mar 23, 2020 at 9:20 PM Philippe Mathieu-Daud=C3=A9 &lt;=
<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
3/23/20 7:03 PM, Richard Henderson wrote:<br>
&gt; On 3/23/20 10:03 AM, Michael Rolnik wrote:<br>
&gt;&gt; Hi Philippe.<br>
&gt;&gt;<br>
&gt;&gt; It&#39;s been a while. let me think about it=C2=A0and get back to =
you. what is your<br>
&gt;&gt; concern ?<br>
<br>
We are using this series with Joaquin for a Google Summit of Code <br>
project, so we are noticing some bugs and fixing them.<br>
As it has not been merged, we work in a fork.<br>
Since it was posted on the list, I prefer to ask on the list than <br>
directly to you.<br>
<br>
&gt; <br>
&gt; It shouldn&#39;t be there.=C2=A0 See commit 1f5c00cfdb81.<br>
<br>
Ah it has been moved to cpu_common_reset, thanks :)<br>
I suppose it is because this port is based on some quite old work.<br>
<br>
&gt; <br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 memset(env-&gt;r, 0, sizeo=
f(env-&gt;r));<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 tlb_flush(cs);<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 Why are you calling tlb_flush() here?<br>
&gt; <br>
&gt; <br>
&gt; r~<br>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Best Regards,<br>Michael Rolnik</div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--000000000000c2d70205a3146786--

