Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49020C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 18:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1966320671
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 18:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2uAoCpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1966320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jakHm-0003RC-5U
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 14:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <johnnymarler@gmail.com>)
 id 1jakGx-0002g2-P1
 for qemu-devel@nongnu.org; Mon, 18 May 2020 14:13:55 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:43878)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <johnnymarler@gmail.com>)
 id 1jakGw-00060D-RE
 for qemu-devel@nongnu.org; Mon, 18 May 2020 14:13:55 -0400
Received: by mail-lj1-x243.google.com with SMTP id l19so10904426lje.10
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 11:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=enOA4m3VcOe8cQIwJnS/mJ9sBamwq+crpLDaM/D0dUc=;
 b=H2uAoCpYDe38K6FkUKnVdViOdC42gzJD0sMzxiREgGMPgBJXhUt0/4JfXbfhbC+poH
 bl2RCNkHvVGMC0jOv4LG0KZN0RdPnEs/QwptgIWep4MjHH4k0ybF8akopyzQ1QDiM10a
 Zt829FLl2/OAORUZC9JsMrJ5j3gvAv79uJ4G1A6bvgkssmn5q1FtEGXLH2y4n3/PzobS
 +4nDCBdOe0HQa4T3PJ/4hHkry6xjym3DfRJD1OiUq99p7HNRUjYa5+lyximQGndRe11I
 MPq2/JuheqNj7z/asEjspRdypcfURMLzkTQQBI7kagzn/VeF+Wg+d0ikWvVEYqYbUcMH
 8Qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=enOA4m3VcOe8cQIwJnS/mJ9sBamwq+crpLDaM/D0dUc=;
 b=G3QqGP2GIhfADqyUdwAr8fKgdsXFR49vw99iogZSZ9R0Z2el9jl5M9dPGehTjuUqZT
 wpAtzQSBrGEGVOL14iZ2luPeqRRSJQ+V9aLdKLlI+V9HsmnznzwUNwKYFQnEaTlC5X14
 sRs9d33s9jhr/ez+uH4gX0Fmkww6zxhn79DrfJ8xArhhzmjkVf3DeLC+/DC9sBjxQNcl
 64PT8sXAY62Vg6rH2lh85KniWKVxKyutb8WEwui0GchhcYrICNlyO/BubPiTekX2jYwb
 jRdUJPMbzIAhuZVflNOfd1W9lImQ/WJVURyvLQqhaksEOx0pKAbCq3nDFwdqAtMKsjEo
 S8pw==
X-Gm-Message-State: AOAM533KbpM6Oll9aFWg2AZF5OXtFfyoVyukP0GE6msd8Q49fi5u+VwW
 b9QtRrxKs60HeWrX+OQhFBxiL+hp40BqywV6tJEaUF2sfVA=
X-Google-Smtp-Source: ABdhPJwdlhMZ3uySsybRyQVUnDFN/ASey1EUTGIa9kNjLOlnEuRxzP1Nkd0YyDdPPc5EbZR21KA0XJCL4w77z0xE2oM=
X-Received: by 2002:a2e:6c08:: with SMTP id h8mr10756711ljc.48.1589825632365; 
 Mon, 18 May 2020 11:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200502161225.14346-1-johnnymarler@gmail.com>
 <CACKT+Ao+hRRuSarAcWy0PDzV8u5CF9KQq07dgVsLmQddSTfj6Q@mail.gmail.com>
 <CACKT+ApwXFEK3tu5=ZpOZrGNYLXcO6w9rv7QUEDrJKBkCQ8wGw@mail.gmail.com>
In-Reply-To: <CACKT+ApwXFEK3tu5=ZpOZrGNYLXcO6w9rv7QUEDrJKBkCQ8wGw@mail.gmail.com>
From: Jonathan Marler <johnnymarler@gmail.com>
Date: Mon, 18 May 2020 12:13:41 -0600
Message-ID: <CACKT+AoOJGtBE+9wwo8Pkp2=1WCA-3m7i80rhNa9yxc24FH+7A@mail.gmail.com>
Subject: Re: [PATCH] linux-user/mmap.c: fix integer underflow in target_mremap
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000012741a05a5f020f7"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=johnnymarler@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000012741a05a5f020f7
Content-Type: text/plain; charset="UTF-8"

Been a few more days.  Not sure how often I should be pinging.  If this is
too much to ping every few days let me know.

On Fri, May 15, 2020 at 7:36 AM Jonathan Marler <johnnymarler@gmail.com>
wrote:

> Been a couple weeks, checking to see if anyone has looked at this.
>
> On Sat, May 2, 2020 at 5:43 PM Jonathan Marler <johnnymarler@gmail.com>
> wrote:
>
>> FYI, I applied this patch to the qemu build that zig uses to run
>> non-native tests (
>> https://github.com/ziglang/qemu-static/blob/master/patch/mremap-underflow.diff
>> )
>>
>> After applying it, my new code that calls mremap now passes,
>> whereas before the fix I was getting a segfault.
>>
>> On Sat, May 2, 2020 at 10:12 AM Jonathan Marler <johnnymarler@gmail.com>
>> wrote:
>>
>>> Fixes: https://bugs.launchpad.net/bugs/1876373
>>>
>>> This code path in mmap occurs when a page size is decreased with
>>> mremap.  When a section of pages is shrunk, qemu calls mmap_reserve on the
>>> pages that were released.  However, it has the diff operation reversed,
>>> subtracting the larger old_size from the smaller new_size.  Instead, it
>>> should be subtracting the smaller new_size from the larger old_size.  You
>>> can also see in the previous line of the change that this mmap_reserve call
>>> only occurs when old_size > new_size.
>>>
>>> Signed-off-by: Jonathan Marler <johnnymarler@gmail.com>
>>> ---
>>>  linux-user/mmap.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
>>> index e378033797..caab62909e 100644
>>> --- a/linux-user/mmap.c
>>> +++ b/linux-user/mmap.c
>>> @@ -708,7 +708,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong
>>> old_size,
>>>          if (prot == 0) {
>>>              host_addr = mremap(g2h(old_addr), old_size, new_size,
>>> flags);
>>>              if (host_addr != MAP_FAILED && reserved_va && old_size >
>>> new_size) {
>>> -                mmap_reserve(old_addr + old_size, new_size - old_size);
>>> +                mmap_reserve(old_addr + old_size, old_size - new_size);
>>>              }
>>>          } else {
>>>              errno = ENOMEM;
>>> --
>>> 2.23.1
>>>
>>>

--00000000000012741a05a5f020f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Been a few more days.=C2=A0 Not sure how often I should be=
 pinging.=C2=A0 If this is too much to ping every few days let me know.</di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On F=
ri, May 15, 2020 at 7:36 AM Jonathan Marler &lt;<a href=3D"mailto:johnnymar=
ler@gmail.com">johnnymarler@gmail.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Been a couple weeks, =
checking to see if anyone has looked at this.</div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 2, 2020 at 5:43 PM=
 Jonathan Marler &lt;<a href=3D"mailto:johnnymarler@gmail.com" target=3D"_b=
lank">johnnymarler@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><div dir=3D"ltr">FYI, I applied this patch to t=
he qemu build that zig uses=C2=A0to run non-native tests (

<a href=3D"https://github.com/ziglang/qemu-static/blob/master/patch/mremap-=
underflow.diff" target=3D"_blank">https://github.com/ziglang/qemu-static/bl=
ob/master/patch/mremap-underflow.diff</a>)<div><br><div>After applying it, =
my new code that calls mremap now passes, whereas=C2=A0before the fix I was=
 getting a segfault.</div></div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Sat, May 2, 2020 at 10:12 AM Jonathan Ma=
rler &lt;<a href=3D"mailto:johnnymarler@gmail.com" target=3D"_blank">johnny=
marler@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">Fixes: <a href=3D"https://bugs.launchpad.net/bugs/1876373" =
rel=3D"noreferrer" target=3D"_blank">https://bugs.launchpad.net/bugs/187637=
3</a><br>
<br>
This code path in mmap occurs when a page size is decreased with mremap.=C2=
=A0 When a section of pages is shrunk, qemu calls mmap_reserve on the pages=
 that were released.=C2=A0 However, it has the diff operation reversed, sub=
tracting the larger old_size from the smaller new_size.=C2=A0 Instead, it s=
hould be subtracting the smaller new_size from the larger old_size.=C2=A0 Y=
ou can also see in the previous line of the change that this mmap_reserve c=
all only occurs when old_size &gt; new_size.<br>
<br>
Signed-off-by: Jonathan Marler &lt;<a href=3D"mailto:johnnymarler@gmail.com=
" target=3D"_blank">johnnymarler@gmail.com</a>&gt;<br>
---<br>
=C2=A0linux-user/mmap.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/linux-user/mmap.c b/linux-user/mmap.c<br>
index e378033797..caab62909e 100644<br>
--- a/linux-user/mmap.c<br>
+++ b/linux-user/mmap.c<br>
@@ -708,7 +708,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong ol=
d_size,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (prot =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host_addr =3D mremap(g2h(ol=
d_addr), old_size, new_size, flags);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (host_addr !=3D MAP_FAIL=
ED &amp;&amp; reserved_va &amp;&amp; old_size &gt; new_size) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_reserve(old_a=
ddr + old_size, new_size - old_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_reserve(old_a=
ddr + old_size, old_size - new_size);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D ENOMEM;<br>
-- <br>
2.23.1<br>
<br>
</blockquote></div>
</blockquote></div>
</blockquote></div>

--00000000000012741a05a5f020f7--

