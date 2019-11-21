Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E92C43141
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 467AA206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcuwH85Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467AA206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXptz-00051y-Dh
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 12:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXppM-0000ja-0C
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:01:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXppG-0000I4-4t
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:01:07 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38209)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iXppF-0000HW-VV
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:01:02 -0500
Received: by mail-oi1-x244.google.com with SMTP id a14so3840096oid.5
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 09:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=yaCmnMnCIcA6nWBfOP2YZs1sc7JCavrOolsdGFN0ggs=;
 b=gcuwH85QNSI8lKMJmHwVy/iXivo3vf41zmmcmJoih8zHdZqrNc+wkvDyAsruXUiAlH
 3pdwsIaz5EVMRPbC2Gg5cy3XC644RDmK/RChJ3ytbfbdPgczp3yUFe+l/hMEGMqPOejq
 517Sjf4R+WSqoCfuwoRKH0M9sypU/MKlHNkMxhN/7X0cAToiLA053xVPiTbMdG6M+mes
 wYCNbZ4cveUZguDL8iSbasHcZJ7jfi/FPHwrcc0WxZVwCDg0PGt8BkIW5w2qbZfnbkpC
 CuQunwnDBM2JtW24wQSSAYAifWXwS/HcELwj4nUqNvm/8fQgRA3j4VJq91HjoDRypnYV
 mN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=yaCmnMnCIcA6nWBfOP2YZs1sc7JCavrOolsdGFN0ggs=;
 b=gYnaevOFgzl90verUaEd6thl9bkcWqHWkr4WLKJ5tE/mFZKbjxoRSkYXLSbU/bKRAz
 9cCthyzaq94J8C6mBI0Ydx1647st7O/KLwTcaEEgBVjkGIZPf71eb869YuiTL9PtyyNa
 b3tsoIjGP9qLUFHSRTIf4D2RHWVUaLqNfbN4L8zq1mwV9yZUKQa62EpnWlreSKsuG8zL
 uhZgvnT3rLV5+s2Zq+/ECNGJnOLkIiNX64Me70JyQopD4YimeiaidVKMOPxkwHSEcHqE
 im0KM/CiB1umxS7FiLQ5SyEd4ZNWFS2Xrg6MNhXyFHJ3vdRYTtv1OM2dOezUaddmlGw2
 XGRw==
X-Gm-Message-State: APjAAAUKE5Si33l5vxJzJ1EL9vhc7tgn7PwWpS5rUBYRUylOLPvLEvzd
 ny/FsQQT76r+h/wq3nL97VtxZQkIZeDcwxL8VLw=
X-Google-Smtp-Source: APXvYqw4rka+IMuZNYfhvgxSVOpkXUHFUZuQq5ejTxWkuRcpY3berMTSyYUGPfVAmOmWXTXwYGdxraHRrE93Oyxho+I=
X-Received: by 2002:aca:484f:: with SMTP id v76mr8593659oia.62.1574355659961; 
 Thu, 21 Nov 2019 09:00:59 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Thu, 21 Nov 2019 09:00:59
 -0800 (PST)
In-Reply-To: <f7f4ff93-fad0-3d72-a224-c19302dff9e0@redhat.com>
References: <20191120145724.GA15677@ls3530.fritz.box>
 <CAL1e-=jqoV0v0NdpeL3NUTOfURNJ9qmD6FcCjV30pXsdBeCD=Q@mail.gmail.com>
 <CAL1e-=gOHZOTnyB0=HOAqzqS4gBF1YkB7x3yQYGJvi5qWg20Kg@mail.gmail.com>
 <015ab947-57ba-6d73-d99d-2e3263226c02@gmx.de>
 <f7f4ff93-fad0-3d72-a224-c19302dff9e0@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 21 Nov 2019 18:00:59 +0100
Message-ID: <CAL1e-=hHFfkJ3bmOLhk5bBCExvnazA4NgmoCJtN+X3KQ8=9Pjw@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user/strace: Improve output of various syscalls
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000dcb8ac0597de3d49"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000dcb8ac0597de3d49
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C5=AB

On Thursday, November 21, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 11/21/19 9:19 AM, Helge Deller wrote:
>
>> On 20.11.19 23:20, Aleksandar Markovic wrote:
>>
>>> On Wed, Nov 20, 2019 at 10:13 PM Aleksandar Markovic
>>> <aleksandar.m.mail@gmail.com> wrote:
>>>
>>>>
>>>> On Wed, Nov 20, 2019 at 3:58 PM Helge Deller <deller@gmx.de> wrote:
>>>>
>>>>>
>>>>> Improve strace output of various syscalls which either have none
>>>>> or only int-type parameters.
>>>>>
>>>>
>>>> It would be nice if you included a history of the patch (after the lin=
e
>>>> "---", as it is customary for single patch submission). You changed
>>>> only ioctl() in v2, right?
>>>>
>>>
>> Yes. Will add history in next round.
>>
>> I missed your v2, but responded with several hints to v1.
>>>>
>>>
>> Yes, I saw all your mails.
>> Thanks for your feedback!
>>
>> userfaultfd(), membarrier(), mlock2()... - all could be included into
>>> your patch.
>>>
>>
>> I think there are quite some more which I didn't included.
>> That's why I wrote "*various*" and not "*all*" in my changelog.
>> I'm debugging other code, and the ones I fixed are the ones I
>> actually tested with my code.
>>
>
> If you don't have handy way to test the other syscalls, I'll rather
> restrict your patch to the one you tested, at least you are certain you
> didn't introduced regressions. Unless their implementation is trivial, of
> course.
>
>
What can be handier than writing a program that contains a single system
call?

--000000000000dcb8ac0597de3d49
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C5=AB<br><br>On Thursday, November 21, 2019, Philippe Mathieu-Daud=C3=A9 &=
lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">On 11/21/19 9:19 AM, Helge Deller wrote:<br=
>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 20.11.19 23:20, Aleksandar Markovic wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Wed, Nov 20, 2019 at 10:13 PM Aleksandar Markovic<br>
&lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"_blank">aleksa=
ndar.m.mail@gmail.com</a>&gt; wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
On Wed, Nov 20, 2019 at 3:58 PM Helge Deller &lt;<a href=3D"mailto:deller@g=
mx.de" target=3D"_blank">deller@gmx.de</a>&gt; wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Improve strace output of various syscalls which either have none<br>
or only int-type parameters.<br>
</blockquote>
<br>
It would be nice if you included a history of the patch (after the line<br>
&quot;---&quot;, as it is customary for single patch submission). You chang=
ed<br>
only ioctl() in v2, right?<br>
</blockquote></blockquote>
<br>
Yes. Will add history in next round.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
I missed your v2, but responded with several hints to v1.<br>
</blockquote></blockquote>
<br>
Yes, I saw all your mails.<br>
Thanks for your feedback!<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
userfaultfd(), membarrier(), mlock2()... - all could be included into<br>
your patch.<br>
</blockquote>
<br>
I think there are quite some more which I didn&#39;t included.<br>
That&#39;s why I wrote &quot;*various*&quot; and not &quot;*all*&quot; in m=
y changelog.<br>
I&#39;m debugging other code, and the ones I fixed are the ones I<br>
actually tested with my code.<br>
</blockquote>
<br>
If you don&#39;t have handy way to test the other syscalls, I&#39;ll rather=
 restrict your patch to the one you tested, at least you are certain you di=
dn&#39;t introduced regressions. Unless their implementation is trivial, of=
 course.<br>
<br>
</blockquote><div><br></div><div>What can be handier than writing a program=
 that contains a single system call?</div><div><br></div><div>=C2=A0</div>

--000000000000dcb8ac0597de3d49--

