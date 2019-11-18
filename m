Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEEDC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 261EF208CD
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKkzOk2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261EF208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWkpa-0006xi-8m
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 12:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iWkoR-0006Kn-P4
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:27:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iWkoQ-00066F-Gt
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:27:43 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37769)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iWkoQ-00065s-BB
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:27:42 -0500
Received: by mail-oi1-x242.google.com with SMTP id y194so16073533oie.4
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 09:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=yltmkOSL5c1bbddVUxoLrig7DDGAi//yIbAIxpjOrns=;
 b=gKkzOk2PejYwJH4vLrCKOL5BlcbqZUjp9By86NqDQjnZi6xerV/7+w1/17B+HhzK52
 NtOxK48uw+03Dpyvs1eON8wiS7IP82UIxecpPo1gvQJO/wlcTSnWtHB1cHj5mVKPBuH0
 HZ7xry3RMZc4eN7GI2D0/t2W1PxadaAf7O90PkLZ/et6crcm0V5moBuSp5jSra+OYs3m
 eLjEQHS8eUc9PAH5AjjimE3ASX6A4mboLvnINYeelmFvE/XV7pNiOTHY5RSdDuWCC8RT
 K7XDvVxYZfKMCKMXlPk7zwwh8IYPILsx1Z9iBdygm+8KgOc3TCRlPfuOlMb5tRdjkRfc
 8+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=yltmkOSL5c1bbddVUxoLrig7DDGAi//yIbAIxpjOrns=;
 b=IkBomYFHG5fjuX3uKayFrYUL+ABlAmpLDhldN950L1oSVJoY4NEy3eZIBaeH+POFf+
 fz3gfs+k49ZxiFv9G+68iF3npGmfEu0oBc6YHCCkdQy6pc6pWUklkgMzKgJqlc2ZYCRD
 lKf3ZmYF6caBSALUw8OWuZhLWJdmPRVU6+OVOcLdmFDZMd10c7494BPkcl0z16YeWprV
 mbv3f/CkG90///rXyPP3i/1M/bbvmRoXd692FJvL+v4sguRPJvXgq2OLxDa20XP8JXKO
 upG2DOnqyJEf1gEdPwifuQ9Vz5XFPIqfX63WBOCCNojCrV5JYgZPRkeHXCTp62OJWZmW
 CFVg==
X-Gm-Message-State: APjAAAX6SvHVRMKsT28j+1V0P4CNmVY+6rBOVjuepZihw2W08VfadTgC
 Pf6evRSvD4GfDLdRGaa6rrwJYK4Gyi3xmi4XofA=
X-Google-Smtp-Source: APXvYqyrtvOA9VgpE9STet8n5eoXrcOhNLVjnTiS0V0eJYzwd6YFxoOsfQrkfQOR1MoSiPDIqz47H7N+5s+vakJ3kiU=
X-Received: by 2002:aca:d17:: with SMTP id 23mr69499oin.136.1574098061052;
 Mon, 18 Nov 2019 09:27:41 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Mon, 18 Nov 2019 09:27:40
 -0800 (PST)
In-Reply-To: <71b94fba-c0b0-f745-1c11-f08041a865ec@redhat.com>
References: <20191012071210.13632-1-philmd@redhat.com>
 <CAL1e-=h2d8vBs3bKpsReFNgCW-f4FMTYvJuSahjyNgeF7x5cfw@mail.gmail.com>
 <71b94fba-c0b0-f745-1c11-f08041a865ec@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 18 Nov 2019 18:27:40 +0100
Message-ID: <CAL1e-=h4DpPRA-8B+8SkepkemmokHV4ptihXkd039agQQhjF0g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add a TILE-Gx section
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c54e9c0597a243ac"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Richard Henderson <rth@twiddle.net>, Chen Gang <gang.chen.5i5j@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c54e9c0597a243ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C5=AB

On Monday, November 18, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>
wrote:

> On 10/12/19 2:40 PM, Aleksandar Markovic wrote:
>
>>
>> 12.10.2019. 09.12, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com <mai=
lto:
>> philmd@redhat.com>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:
>>  >
>>  > The TILE-Gx architecture was missing its section, add it.
>>  >
>>  > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com <mailto=
:
>> philmd@redhat.com>>
>>  > ---
>>  >  MAINTAINERS | 5 +++++
>>  >  1 file changed, 5 insertions(+)
>>  >
>>
>> It is certainly good that there is a maintainer for each QEMU component.
>> But:
>>
>> - is Chen Gang available and willing to assume the role?
>>
>
> One month passed, so we can assume this architecture is orphan.
> I'll prepare a patch.
>
> - sadly, tilegx arch support was recently removed from kernel upstream.
>> That does not mean (in my understanding) automatic removal from QEMU, bu=
t
>> certainly raises some eyebrows. Should we continue supporting tilegx?
>> Isthete any feedback from users, or the company that owns tilegx?
>>
>
> We should properly deprecate it, to give any users a chance to notice it
> and tell us. I'll prepare another patch.
>
>
Philippe, all what you said here sounds reasonable and appropriate to me.
Thanks for readiness to follow up.

A.




> Sincerely,
>> Aleksandar
>>
>>  > diff --git a/MAINTAINERS b/MAINTAINERS
>>  > index 3ca814850e..a3be0a4a31 100644
>>  > --- a/MAINTAINERS
>>  > +++ b/MAINTAINERS
>>  > @@ -299,6 +299,11 @@ F: hw/sparc64/
>>  >  F: include/hw/sparc/sparc64.h
>>  >  F: disas/sparc.c
>>  >
>>  > +TILE-Gx CPUs
>>  > +M: Chen Gang <gang.chen.5i5j@gmail.com <mailto:gang.chen.5i5j@gmail.
>> com>>
>>  > +S: Maintained
>>  > +F: target/tilegx/
>>  > +
>>  >  UniCore32 TCG CPUs
>>  >  M: Guan Xuetao <gxt@mprc.pku.edu.cn <mailto:gxt@mprc.pku.edu.cn>>
>>  >  S: Maintained
>>  > --
>>  > 2.21.0
>>  >
>>  >
>>
>>
>

--000000000000c54e9c0597a243ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C5=AB<br><br>On Monday, November 18, 2019, Philippe Mathieu-Daud=C3=A9 &lt=
;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">On 10/12/19 2:40 PM, Aleksandar Markovic wrot=
e:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
12.10.2019. 09.12, &quot;Philippe Mathieu-Daud=C3=A9&quot; &lt;<a href=3D"m=
ailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a> &lt;mailto=
:<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</=
a>&gt;&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=
=D0=B0:<br>
=C2=A0&gt;<br>
=C2=A0&gt; The TILE-Gx architecture was missing its section, add it.<br>
=C2=A0&gt;<br>
=C2=A0&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto=
:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a> &lt;mailto:<a h=
ref=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt=
;&gt;<br>
=C2=A0&gt; ---<br>
=C2=A0&gt; =C2=A0MAINTAINERS | 5 +++++<br>
=C2=A0&gt; =C2=A01 file changed, 5 insertions(+)<br>
=C2=A0&gt;<br>
<br>
It is certainly good that there is a maintainer for each QEMU component. Bu=
t:<br>
<br>
- is Chen Gang available and willing to assume the role?<br>
</blockquote>
<br>
One month passed, so we can assume this architecture is orphan.<br>
I&#39;ll prepare a patch.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
- sadly, tilegx arch support was recently removed from kernel upstream. Tha=
t does not mean (in my understanding) automatic removal from QEMU, but cert=
ainly raises some eyebrows. Should we continue supporting tilegx? Isthete a=
ny feedback from users, or the company that owns tilegx?<br>
</blockquote>
<br>
We should properly deprecate it, to give any users a chance to notice it an=
d tell us. I&#39;ll prepare another patch.<br>
<br></blockquote><div><br></div><div>Philippe, all what you said here sound=
s reasonable and appropriate to me. Thanks for readiness to follow up.</div=
><div><br></div><div>A.</div><div><br></div><div><br></div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Sincerely,<br>
Aleksandar<br>
<br>
=C2=A0&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
=C2=A0&gt; index 3ca814850e..a3be0a4a31 100644<br>
=C2=A0&gt; --- a/MAINTAINERS<br>
=C2=A0&gt; +++ b/MAINTAINERS<br>
=C2=A0&gt; @@ -299,6 +299,11 @@ F: hw/sparc64/<br>
=C2=A0&gt; =C2=A0F: include/hw/sparc/sparc64.h<br>
=C2=A0&gt; =C2=A0F: disas/sparc.c<br>
=C2=A0&gt;<br>
=C2=A0&gt; +TILE-Gx CPUs<br>
=C2=A0&gt; +M: Chen Gang &lt;<a href=3D"mailto:gang.chen.5i5j@gmail.com" ta=
rget=3D"_blank">gang.chen.5i5j@gmail.com</a> &lt;mailto:<a href=3D"mailto:g=
ang.chen.5i5j@gmail.com" target=3D"_blank">gang.chen.5i5j@gmail.<wbr>com</a=
>&gt;&gt;<br>
=C2=A0&gt; +S: Maintained<br>
=C2=A0&gt; +F: target/tilegx/<br>
=C2=A0&gt; +<br>
=C2=A0&gt; =C2=A0UniCore32 TCG CPUs<br>
=C2=A0&gt; =C2=A0M: Guan Xuetao &lt;<a href=3D"mailto:gxt@mprc.pku.edu.cn" =
target=3D"_blank">gxt@mprc.pku.edu.cn</a> &lt;mailto:<a href=3D"mailto:gxt@=
mprc.pku.edu.cn" target=3D"_blank">gxt@mprc.pku.edu.cn</a>&gt;&gt;<br>
=C2=A0&gt; =C2=A0S: Maintained<br>
=C2=A0&gt; --<br>
=C2=A0&gt; 2.21.0<br>
=C2=A0&gt;<br>
=C2=A0&gt;<br>
<br>
</blockquote>
<br>
</blockquote>

--000000000000c54e9c0597a243ac--

