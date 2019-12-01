Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45F7C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 14:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4CA020705
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 14:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZYpFhwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CA020705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibPxb-0001in-Q9
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 09:12:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibPwo-0001GF-74
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 09:11:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibPwm-0007XM-Gf
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 09:11:38 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46109)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ibPwm-0007X0-8t
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 09:11:36 -0500
Received: by mail-oi1-x241.google.com with SMTP id a124so6358654oii.13
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 06:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=JfuP5/9QZ18e/AFLO7pRw5IIphj6h8l0CDbTcI/8kuA=;
 b=sZYpFhwnIuRSeLoa+/QfAG2ejEm82pEhaH82XB6LQP9Lly+QehS0H9ylBNSBMizSb3
 vri+Kkh9vNHX4znyzNxMuIivkjFsKwmeWI6F8dHlZaIJTRpHCTw9NmrcpeB+0hkw+ZQx
 rtv9Z5jCRCKH/kLxnRO/CUobe1/q9HgFDFIF59HKSvXzvVfHhwkbZ5GnNqxq+ZL9J3qv
 CTkjAu9/n3xDcRA0SNgyKpTa5a/3ErO0G/G/gBiNAmQkK1jQ/TG9DjOcKUXvzi0Bxj3P
 THyiyKL8or73OTYzasytPTkMZJEdGuTUs9kUqPvCNhN+0Mmh+c7O+3nyF4LWWWyPLyij
 wNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=JfuP5/9QZ18e/AFLO7pRw5IIphj6h8l0CDbTcI/8kuA=;
 b=sEKYpuMKFLtRjg+C6QBVY52KTqyi1o7fhp3yA7rdfrgzR/892VyLdfN35Bw3bEpwkb
 NG4Pf+3i7DjNMIYnflNtYsSW2F+FqWqWQRtVA8YGzJM3pCq+6m7TPHuuF2EpYT370JwU
 EVsKibIEnfvGupswrvNW2iRfujVVWs2rJJGL+31iqO9kgeYRhwoztpf2h0javbYtl4ua
 YCEsHTh5yj1Xy42qxZ6KLRxxaDDsWQs9eUUb2dmcExpSjSDfM7y5X5uAcywbdn+cGg8N
 bHQyVxYEyp3LdEXJlqqmq7rp2nv8NUI8ATK//ZGEHqPzrTLN3twDGLxg7iWaBg232WV9
 EBLA==
X-Gm-Message-State: APjAAAWT7IaOoQrcK6m/pH6rNQujPLfj2ZkiCay64YoAEQ0QDYq9xipm
 RoPXHyVrEDrG0E1Nqx3ZU10ug1+/xbxcYOgdU0A=
X-Google-Smtp-Source: APXvYqyAzPSyCiVc6gyioc5Y68a/g7N4GYxH49oPoEjOfuvWdfqcf2VNZ18pfcjyPYNu6UMVaJiDDcqnJEAdGbXyTH4=
X-Received: by 2002:aca:670b:: with SMTP id z11mr19258488oix.79.1575209495474; 
 Sun, 01 Dec 2019 06:11:35 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sun, 1 Dec 2019 06:11:34
 -0800 (PST)
In-Reply-To: <CAL1e-=jP3kYhxSFsGg2=w2rAK8mfMBFg5MvvFZd_4z_t3LSmcA@mail.gmail.com>
References: <20191130194240.10517-18-armbru@redhat.com>
 <9C97FEE6-D390-4CEB-9B00-50AE00AEA4D2@redhat.com>
 <CAL1e-=jst9hGBXy0zm-975QDvW0F0xBNJAypqM4KooWEUvJfjQ@mail.gmail.com>
 <CAL1e-=jP3kYhxSFsGg2=w2rAK8mfMBFg5MvvFZd_4z_t3LSmcA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 1 Dec 2019 15:11:34 +0100
Message-ID: <CAL1e-=jGCt+mAVTDF_F3G=p3fJfbSh-pBFcjpD-HTNrqaD0qgg@mail.gmail.com>
Subject: Re: [PATCH 17/21] s390x: Fix latent query-cpu-model-FOO error
 handling bugs
To: David Hildenbrand <dhildenb@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006cb69a0598a50adf"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "vsementsov@virtuozzo.com" <vsementsov@virtuozzo.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006cb69a0598a50adf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sunday, December 1, 2019, Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Sunday, December 1, 2019, Aleksandar Markovic <
> aleksandar.m.mail@gmail.com> wrote:
>
>>
>>
>> On Saturday, November 30, 2019, David Hildenbrand <dhildenb@redhat.com>
>> wrote:
>>
>>>
>>>
>>> > Am 30.11.2019 um 20:42 schrieb Markus Armbruster <armbru@redhat.com>:
>>> >
>>> > =EF=BB=BFcpu_model_from_info() is a helper for qmp_query_cpu_model_ex=
pansion(
>>> ),
>>> > qmp_query_cpu_model_comparison(), qmp_query_cpu_model_baseline().  It
>>> > crashes when the visitor or the QOM setter fails, and its @errp
>>> > argument is null.  Messed up in commit 137974cea3 's390x/cpumodel:
>>> > implement QMP interface "query-cpu-model-expansion"'.
>>> >
>>> > Its three callers have the same bug.  Messed up in commit 4e82ef0502
>>> > 's390x/cpumodel: implement QMP interface "query-cpu-model-comparison"=
'
>>> > and commit f1a47d08ef 's390x/cpumodel: implement QMP interface
>>> > "query-cpu-model-baseline"'.
>>> >
>>> > The bugs can't bite as no caller actually passes null.  Fix them
>>> > anyway.
>>>
>>> https://en.m.wikipedia.org/wiki/Software_bug
>>>
>>>   =E2=80=9E A software bug is an error, flaw or fault in a computer pro=
gram or
>>> system that causes it to produce an incorrect or unexpected result, or =
to
>>> behave in unintended ways. =E2=80=9E
>>>
>>> Please make it clear in the descriptions that these are cleanups and no=
t
>>> bugfixes. It might be very confusing for people looking out for real bu=
gs.
>>
>>
>>>
>> Disclaimer: I am not entirely familiar with the code in question, so tak=
e
>> my opinion with reasonablereservation.
>>
>> It looks that we here deal with latent bugs. As you probably know from
>> experience, a latent bugs, when they are activated with some ostensibly
>> unrelated code change, can be much more difficult to diagnose and fix th=
an
>> regular bugs.
>>
>>
> Oops, I didn't even realize that the patch title contains the word
> "latent". (I wrote the previous message without that knowledge. For some
> strange reason, my email client doesn't display email subject while
> replying.)
>
> In this case, I would suggest usage of phrase "latent bug" instead of
> "latent error" or so in the message title, to strenghten the point that
> this is not a cleanup.
>
>
Actually, the message title already does use "latent .... bugs". So it is
fine - in my opinion.



> Yours, Aleksandar
>
>
>
>> In that light, this change is not a clean up. It is a fix of a latent
>> bugs, and Markus' aproach to treat it as a bug fix looks right to me. I
>> would just add a word "latent" or similar, which would even more distanc=
e
>> the patch from "cleanup" meaning.
>>
>> David, if I understand well, this patch fixes the commit done by you. I
>> definitely understand this is not a pleasant position, but we all
>> (definitelly including myself too) should learn to handle such situation=
s
>> as gracefully as we can.
>>
>> Yours,
>> Aleksandar
>>
>>
>>
>>>
>>>
>>>
>>> Also, please change the terminology =E2=80=9Emessed up=E2=80=9C to =E2=
=80=9Eintroduced in=E2=80=9C or
>>> similar.
>>>
>>> (applies to all s390x patches)
>>>
>>> Thanks.
>>
>>

--0000000000006cb69a0598a50adf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Sunday, December 1, 2019, Aleksandar Markovic &lt;<a href=3D"mai=
lto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt; wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><br><br>On Sunday, December 1, 2019, Ale=
ksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=
=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><br><br>On Saturday, November 30, 2019, David Hildenbrand &lt=
;<a href=3D"mailto:dhildenb@redhat.com" target=3D"_blank">dhildenb@redhat.c=
om</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
&gt; Am 30.11.2019 um 20:42 schrieb Markus Armbruster &lt;<a href=3D"mailto=
:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt;:<br>
&gt; <br>
&gt; =EF=BB=BFcpu_model_from_info() is a helper for qmp_query_cpu_model_exp=
ansion(<wbr>),<br>
&gt; qmp_query_cpu_model_comparison<wbr>(), qmp_query_cpu_model_baseline()<=
wbr>.=C2=A0 It<br>
&gt; crashes when the visitor or the QOM setter fails, and its @errp<br>
&gt; argument is null.=C2=A0 Messed up in commit 137974cea3 &#39;s390x/cpum=
odel:<br>
&gt; implement QMP interface &quot;query-cpu-model-expansion&quot;&#39;.<br=
>
&gt; <br>
&gt; Its three callers have the same bug.=C2=A0 Messed up in commit 4e82ef0=
502<br>
&gt; &#39;s390x/cpumodel: implement QMP interface &quot;query-cpu-model-com=
parison&quot;&#39;<br>
&gt; and commit f1a47d08ef &#39;s390x/cpumodel: implement QMP interface<br>
&gt; &quot;query-cpu-model-baseline&quot;&#39;.<br>
&gt; <br>
&gt; The bugs can&#39;t bite as no caller actually passes null.=C2=A0 Fix t=
hem<br>
&gt; anyway.<br>
<br>
<a href=3D"https://en.m.wikipedia.org/wiki/Software_bug" target=3D"_blank">=
https://en.m.wikipedia.org/wik<wbr>i/Software_bug</a><br>
<br>
=C2=A0 =E2=80=9E A software bug is an error, flaw or fault in a computer pr=
ogram or system that causes it to produce an incorrect or unexpected result=
, or to behave in unintended ways. =E2=80=9E<br>
<br>
Please make it clear in the descriptions that these are cleanups and not bu=
gfixes. It might be very confusing for people looking out for real bugs.</b=
lockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><br></blockquote><div><br></div><d=
iv>Disclaimer: I am not entirely familiar with the code in question, so tak=
e my opinion with reasonablereservation.</div><div><br></div><div>It looks =
that we here deal with latent bugs. As you probably know from experience, a=
 latent bugs, when they are activated with some ostensibly unrelated code c=
hange, can be much more difficult to diagnose and fix than regular bugs.</d=
iv><div><br></div></blockquote><div><br></div><div>Oops, I didn&#39;t even =
realize that the patch title contains the word &quot;latent&quot;. (I wrote=
 the previous message without that knowledge. For some strange reason, my e=
mail client doesn&#39;t display email subject while replying.)</div><div><b=
r></div><div>In this case, I would suggest usage of phrase &quot;latent bug=
&quot; instead of &quot;latent error&quot; or so in the message title, to s=
trenghten the point that this is not a cleanup.</div><div><br></div></block=
quote><div><br></div><div>Actually, the message title already does use &quo=
t;latent .... bugs&quot;. So it is fine - in my opinion.</div><div><br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><div>Yours, Aleksandar</d=
iv><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div>In =
that light, this change is not a clean up. It is a fix of a latent bugs, an=
d Markus&#39; aproach to treat it as a bug fix looks right to me. I would j=
ust add a word &quot;latent&quot; or similar, which would even more distanc=
e the patch from &quot;cleanup&quot; meaning.</div><div><br></div><div>Davi=
d, if I understand well, this patch fixes the commit done by you. I definit=
ely understand this is not a pleasant position, but we all (definitelly inc=
luding myself too) should learn to handle such situations as gracefully as =
we can.</div><div><br></div><div>Yours,</div><div>Aleksandar</div><div><br>=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br></blockquote><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex"><br></blockquote><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">Also, please change the ter=
minology =E2=80=9Emessed up=E2=80=9C to =E2=80=9Eintroduced in=E2=80=9C or =
similar.<br>
<br>
(applies to all s390x patches)<br>
<br>
Thanks.</blockquote>
</blockquote>
</blockquote>

--0000000000006cb69a0598a50adf--

