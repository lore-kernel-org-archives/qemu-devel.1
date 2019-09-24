Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402C0C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 17:15:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB5F21841
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 17:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAQjhlmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB5F21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCoPR-0001Vd-1I
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 13:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1iCoMx-000865-Sj
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 13:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1iCoMw-0005By-B6
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 13:12:55 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:34039)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1iCoMv-00059b-7G
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 13:12:53 -0400
Received: by mail-wm1-x330.google.com with SMTP id y135so2062804wmc.1
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 10:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=7Re8607xsE2EFgbOb/u79e6UuknaOQ0hW16jhPtTq5k=;
 b=AAQjhlmcjCg/GvA2jjso+699ZtDvDznNJ2kUT+kyMygRiJ9jdjep7VCq67l4txXlkL
 Q1jqsDr+ETxKJp2K3cQvAE0l908z4BjQ6e3oThH7P55+achHOBxhdYKmOamE5u2N5lzn
 xEjtLZR+IBtiiMQ0Gepz93H/tqL+a5Z/50yPLsFN4/GlaROkQsGyTGFLW3h8kMjemYm6
 dT1RiZXQv/ZcmB8hvpguhmRJp2hqYTQmSWYyL74kOIoWaV72AsksjZUNWVArSgdqv1gU
 jgCXEoIAEJIoVUX7hZ7bQ4r2W1aHzyLVlytudWTwOqkcofeKCczcerzbGwBDO82V5hTn
 eu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=7Re8607xsE2EFgbOb/u79e6UuknaOQ0hW16jhPtTq5k=;
 b=G6GuWqNJ2bWESfIHyvJ3In/I+takQh4BQjdA4Gq3XwlMaJMCIt48UdmswV7U5j1H/a
 F9klMvXwO6XZ4DhirPC/w4UTRpcfaX1+2TctmlPOMD+DQdSVzmJpqcjz8KFv3F/7R85W
 I6pygGKMUEHjIaxFxrmKhJvkmP61Y8rsOS0/LTa2KUhE+HmaAnRV4z7n7OLjqGT/1hyV
 HudwGWUIogGaKOC1u5I9hAsNzH0vXhM9kpJTU8e5iENAalTTlMd9HKhJZR/1ZLkQAggG
 /GxVGaJo3bCUzZR2xSqRBRGqa4B2z+BQK6/2hjFmumY3/XbBopfyf9xw5xBkpwftr23v
 /DLg==
X-Gm-Message-State: APjAAAWDcNfnOM39e5f8LyCGtUQ0hu0IQMK3sLQ7gQD/G4WAFtFav8qP
 EnAX5aEwzuO4oTjPrU23J25e23nfRZqNk/Hch10=
X-Google-Smtp-Source: APXvYqxXN2bzQeBBoOVXv17CnCOzDsJtPdwf+VWiJT8fFtUZcPc3a8CAq4CrbUEsKdwdLXXPpbKKCI2GoJc/PId2K78=
X-Received: by 2002:a1c:9889:: with SMTP id a131mr1299814wme.38.1569345171780; 
 Tue, 24 Sep 2019 10:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <mailman.3388.1569330742.2187.qemu-devel@nongnu.org>
 <CAKyx-3O5KG7HrbXJs5nvQ0iNASStz0_hGLb2JEyTiw7pP4QR2A@mail.gmail.com>
In-Reply-To: <CAKyx-3O5KG7HrbXJs5nvQ0iNASStz0_hGLb2JEyTiw7pP4QR2A@mail.gmail.com>
From: G 3 <programmingkidx@gmail.com>
Date: Tue, 24 Sep 2019 13:12:40 -0400
Message-ID: <CAKyx-3OQduoga2vb9JEw7QhZ_sK44CV=oP96SxDC-EJfS+6N2g@mail.gmail.com>
Subject: Re: Qemu-devel Digest, Vol 198, Issue 358
To: Peter Maydell <peter.maydell@linaro.org>,
 Adrian Vladu <avladu@cloudbasesolutions.com>, 
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000007e7a1e05934fa54a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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

--0000000000007e7a1e05934fa54a
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 24, 2019 at 1:05 PM G 3 <programmingkidx@gmail.com> wrote:

> On top
>
>
> Message: 9
>> Date: Tue, 24 Sep 2019 10:56:53 -0000
>> From: Adrian Vladu <avladu@cloudbasesolutions.com>
>> To: qemu-devel@nongnu.org
>> Subject: [Bug 1826175] Re: Compilation on MSYS2/MinGW-w64 fails with
>>         error: "No rule to make target capstone.lib"
>> Message-ID:
>>         <
>> 156932261321.27303.8940310087786694778.malone@soybean.canonical.com>
>> Content-Type: text/plain; charset="utf-8"
>>
>> The fix in upstream capstone has been merged:
>>
>> https://github.com/aquynh/capstone/commit/29893c63e34ee21846744d02c396ae3c801b936b
>>
>> --
>> You received this bug notification because you are a member of qemu-
>> devel-ml, which is subscribed to QEMU.
>> https://bugs.launchpad.net/bugs/1826175
>>
>> Title:
>>   Compilation on MSYS2/MinGW-w64 fails with error: "No rule to make
>>   target capstone.lib"
>>
>> Status in QEMU:
>>   New
>>
>> Bug description:
>>   I submitted this bug to Capstone directly but I figured it'd be useful
>>   to post it here too. The IS_MINGW check in the Makefile for Capstone
>>   fails under MSYS2 MinGW-w64 because cc --version doesn't have mingw in
>>   the output anymore:
>>
>>   $ whereis cc
>>   cc: /mingw64/bin/cc.exe
>>
>>   $ cc --version
>>   cc.exe (Rev2, Built by MSYS2 project) 8.3.0
>>   Copyright (C) 2018 Free Software Foundation, Inc.
>>   This is free software; see the source for copying conditions.  There is
>> NO
>>   warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
>> PURPOSE.
>>
>>   Really simple patch:
>>
>>   diff --git "a/Makefile" "b/Makefile"
>>   index 063f50db..1d9f042e 100644
>>   --- "a/Makefile"
>>   +++ "b/Makefile"
>>   @@ -288,7 +288,7 @@ CFLAGS := $(CFLAGS:-fPIC=)
>>    # On Windows we need the shared library to be executable
>>    else
>>    # mingw?
>>   -IS_MINGW := $(shell $(CC) --version | grep -i mingw | wc -l)
>>   +IS_MINGW := $(shell $(CC) --version | grep -i msys2 | wc -l)
>>    ifeq ($(IS_MINGW),1)
>>    EXT = dll
>>    AR_EXT = lib
>>
>> To manage notifications about this bug go to:
>> https://bugs.launchpad.net/qemu/+bug/1826175/+subscriptions
>>
>> ********************************************
>>
>
Hi Peter, could we make capstone disabled by default please? It does cause
compiling problems and isn't needed to use QEMU.

--0000000000007e7a1e05934fa54a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 24, 2019 at 1:05 PM G 3 &=
lt;<a href=3D"mailto:programmingkidx@gmail.com">programmingkidx@gmail.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><d=
iv dir=3D"ltr"><div>On top<br></div><br><div class=3D"gmail_quote"><br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
Message: 9<br>
Date: Tue, 24 Sep 2019 10:56:53 -0000<br>
From: Adrian Vladu &lt;<a href=3D"mailto:avladu@cloudbasesolutions.com" tar=
get=3D"_blank">avladu@cloudbasesolutions.com</a>&gt;<br>
To: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a><br>
Subject: [Bug 1826175] Re: Compilation on MSYS2/MinGW-w64 fails with<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 error: &quot;No rule to make target capstone.li=
b&quot;<br>
Message-ID:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:156932261321.27303.894031=
0087786694778.malone@soybean.canonical.com" target=3D"_blank">156932261321.=
27303.8940310087786694778.malone@soybean.canonical.com</a>&gt;<br>
Content-Type: text/plain; charset=3D&quot;utf-8&quot;<br>
<br>
The fix in upstream capstone has been merged:<br>
<a href=3D"https://github.com/aquynh/capstone/commit/29893c63e34ee21846744d=
02c396ae3c801b936b" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/aquynh/capstone/commit/29893c63e34ee21846744d02c396ae3c801b936b</a><br>
<br>
-- <br>
You received this bug notification because you are a member of qemu-<br>
devel-ml, which is subscribed to QEMU.<br>
<a href=3D"https://bugs.launchpad.net/bugs/1826175" rel=3D"noreferrer" targ=
et=3D"_blank">https://bugs.launchpad.net/bugs/1826175</a><br>
<br>
Title:<br>
=C2=A0 Compilation on MSYS2/MinGW-w64 fails with error: &quot;No rule to ma=
ke<br>
=C2=A0 target capstone.lib&quot;<br>
<br>
Status in QEMU:<br>
=C2=A0 New<br>
<br>
Bug description:<br>
=C2=A0 I submitted this bug to Capstone directly but I figured it&#39;d be =
useful<br>
=C2=A0 to post it here too. The IS_MINGW check in the Makefile for Capstone=
<br>
=C2=A0 fails under MSYS2 MinGW-w64 because cc --version doesn&#39;t have mi=
ngw in<br>
=C2=A0 the output anymore:<br>
<br>
=C2=A0 $ whereis cc<br>
=C2=A0 cc: /mingw64/bin/cc.exe<br>
<br>
=C2=A0 $ cc --version<br>
=C2=A0 cc.exe (Rev2, Built by MSYS2 project) 8.3.0<br>
=C2=A0 Copyright (C) 2018 Free Software Foundation, Inc.<br>
=C2=A0 This is free software; see the source for copying conditions.=C2=A0 =
There is NO<br>
=C2=A0 warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR P=
URPOSE.<br>
<br>
=C2=A0 Really simple patch:<br>
<br>
=C2=A0 diff --git &quot;a/Makefile&quot; &quot;b/Makefile&quot;<br>
=C2=A0 index 063f50db..1d9f042e 100644<br>
=C2=A0 --- &quot;a/Makefile&quot;<br>
=C2=A0 +++ &quot;b/Makefile&quot;<br>
=C2=A0 @@ -288,7 +288,7 @@ CFLAGS :=3D $(CFLAGS:-fPIC=3D)<br>
=C2=A0 =C2=A0# On Windows we need the shared library to be executable<br>
=C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0# mingw?<br>
=C2=A0 -IS_MINGW :=3D $(shell $(CC) --version | grep -i mingw | wc -l)<br>
=C2=A0 +IS_MINGW :=3D $(shell $(CC) --version | grep -i msys2 | wc -l)<br>
=C2=A0 =C2=A0ifeq ($(IS_MINGW),1)<br>
=C2=A0 =C2=A0EXT =3D dll<br>
=C2=A0 =C2=A0AR_EXT =3D lib<br>
<br>
To manage notifications about this bug go to:<br>
<a href=3D"https://bugs.launchpad.net/qemu/+bug/1826175/+subscriptions" rel=
=3D"noreferrer" target=3D"_blank">https://bugs.launchpad.net/qemu/+bug/1826=
175/+subscriptions</a><br>
<br>
********************************************<br></blockquote></div></div></=
blockquote><div><br></div><div>Hi Peter, could we make capstone disabled by=
 default please? It does cause compiling problems and isn&#39;t needed to u=
se QEMU. <br></div></div></div>

--0000000000007e7a1e05934fa54a--

