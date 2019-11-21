Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9C6C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB6E82067D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+XIYhU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6E82067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXr7j-0008So-4h
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 13:24:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXr6o-0007pb-D9
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:23:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXr6l-0005Xk-DG
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:23:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38376
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXr6k-0005XG-VZ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574360589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B7KO8Her6pRkQlwEbwhTnnIdWfHWsYvQI4ryJIWIcbQ=;
 b=R+XIYhU36YmmAnuQ76Z4u/K3GU+UhzgNWuql42d3a6oUnG+u5TG7B13GjY54iWGq9DhyNY
 ACca+kXNNi8Zp9pOUcC5H8Rb14bZa+OedBAsu4aUvXyW5+w7avKp26EvGn38TrjrqiLRDk
 9y9PQDpUTE26W0LdZ2Uasi0GpIQjga0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-moxaqF1JP7GXtBNRkTXqmA-1; Thu, 21 Nov 2019 13:23:06 -0500
Received: by mail-wr1-f71.google.com with SMTP id e10so2482449wrt.16
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 10:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p1eT8sxTRg9UMLj9iOPqcfdk7ItkC09JHaZPSWJzpf4=;
 b=e4lQURp2JonhavX30/uQ3bo4BIlB1I+3Rbr0/aLRnGSssZwBlwo7TtjMFhEgNAxGq3
 /iVKMWBeRLoCb815j3gqDGSAQvRLrwutLo1yONRanviTMRWTJGigyjoawdhe6YK/zmuT
 fa+oRz2bSECQa53yIV/BIdpCTwQHu1vQ1cDGNBu2dOl8zOP7SSR/pca1ax6Zj5eayQIL
 VOl0Cjcjz6EjoT69fod7YOvirFcD2Pw1p9zcaxXuiRWFGzZP9SOAjeZlrEE+U0IzQioW
 G9GQOSsLEoXJ9EAD0qolTDd+cF71TM4fo46I+ok9uEqOGt5c2edYSX2SgaXU0g0KXA9l
 /tDw==
X-Gm-Message-State: APjAAAXJcqaFEzP8u1Xc0FAqlUlFQdPclbYhKJ/vo+nLlo54SpNPn+Iy
 Njl+DFLNjXKGMSu6LT9VZMVYmlfNTs/F0UczOPF+mRAA6HwZKzUY9IQNUS9PFfpBXSAw7L2a4gV
 7rM+Jn/Pe2QVbDQU=
X-Received: by 2002:adf:dd0a:: with SMTP id a10mr11668987wrm.299.1574360585139; 
 Thu, 21 Nov 2019 10:23:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqx8n0OoVX8Qc45dqq+6CGYk7HZWJzPrOxlDtbL2ucCDl6gFEEJ97dIgQY09oQWrDCfpy6SciQ==
X-Received: by 2002:adf:dd0a:: with SMTP id a10mr11668955wrm.299.1574360584882; 
 Thu, 21 Nov 2019 10:23:04 -0800 (PST)
Received: from [192.168.43.238] (92.red-95-127-154.staticip.rima-tde.net.
 [95.127.154.92])
 by smtp.gmail.com with ESMTPSA id t134sm506644wmt.24.2019.11.21.10.23.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2019 10:23:04 -0800 (PST)
Subject: Re: [PATCH v2] linux-user/strace: Improve output of various syscalls
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191120145724.GA15677@ls3530.fritz.box>
 <CAL1e-=jqoV0v0NdpeL3NUTOfURNJ9qmD6FcCjV30pXsdBeCD=Q@mail.gmail.com>
 <CAL1e-=gOHZOTnyB0=HOAqzqS4gBF1YkB7x3yQYGJvi5qWg20Kg@mail.gmail.com>
 <015ab947-57ba-6d73-d99d-2e3263226c02@gmx.de>
 <f7f4ff93-fad0-3d72-a224-c19302dff9e0@redhat.com>
 <CAL1e-=hHFfkJ3bmOLhk5bBCExvnazA4NgmoCJtN+X3KQ8=9Pjw@mail.gmail.com>
 <32d6aa36-3240-7a80-89c1-5cba13bbc022@redhat.com>
 <CAL1e-=hDgLB-n2aOdB_ZOnVC0f3x3SGvQDUCcBWSobme7JSV4Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e0a8faac-b02a-2787-20a3-97f451c9d798@redhat.com>
Date: Thu, 21 Nov 2019 19:23:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hDgLB-n2aOdB_ZOnVC0f3x3SGvQDUCcBWSobme7JSV4Q@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: moxaqF1JP7GXtBNRkTXqmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/21/19 6:35 PM, Aleksandar Markovic wrote:
> On Thursday, November 21, 2019, Philippe Mathieu-Daud=C3=A9=20
> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>=20
>     On 11/21/19 6:00 PM, Aleksandar Markovic wrote:
>=20
>         On Thursday, November 21, 2019, Philippe Mathieu-Daud=C3=A9
>         <philmd@redhat.com <mailto:philmd@redhat.com>
>         <mailto:philmd@redhat.com <mailto:philmd@redhat.com>>> wrote:
>=20
>          =C2=A0 =C2=A0 On 11/21/19 9:19 AM, Helge Deller wrote:
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 On 20.11.19 23:20, Aleksandar Markov=
ic wrote:
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 On Wed, Nov 20, 2019 a=
t 10:13 PM Aleksandar Markovic
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <aleksandar.m.mail@gma=
il.com
>         <mailto:aleksandar.m.mail@gmail.com>
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <mailto:aleksandar.m.m=
ail@gmail.com
>         <mailto:aleksandar.m.mail@gmail.com>>> wrote:
>=20
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 On Wed, =
Nov 20, 2019 at 3:58 PM Helge Deller
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <deller@=
gmx.de <mailto:deller@gmx.de>
>         <mailto:deller@gmx.de <mailto:deller@gmx.de>>> wrote:
>=20
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Improve strace output of various syscalls which
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 either have none
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 or only int-type parameters.
>=20
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 It would=
 be nice if you included a history of
>         the patch
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (after t=
he line
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "---", a=
s it is customary for single patch
>         submission).
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 You chan=
ged
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 only ioc=
tl() in v2, right?
>=20
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 Yes. Will add history in next round.
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I missed=
 your v2, but responded with several
>         hints to v1.
>=20
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 Yes, I saw all your mails.
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 Thanks for your feedback!
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 userfaultfd(), membarr=
ier(), mlock2()... - all could be
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 included into
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 your patch.
>=20
>=20
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 I think there are quite some more wh=
ich I didn't included.
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 That's why I wrote "*various*" and n=
ot "*all*" in my
>         changelog.
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 I'm debugging other code, and the on=
es I fixed are the
>         ones I
>          =C2=A0 =C2=A0 =C2=A0 =C2=A0 actually tested with my code.
>=20
>=20
>          =C2=A0 =C2=A0 If you don't have handy way to test the other sysc=
alls,
>         I'll rather
>          =C2=A0 =C2=A0 restrict your patch to the one you tested, at leas=
t you are
>         certain
>          =C2=A0 =C2=A0 you didn't introduced regressions. Unless their
>         implementation is
>          =C2=A0 =C2=A0 trivial, of course.
>=20
>=20
>         What can be handier than writing a program that contains a
>         single system call?
>=20
>=20
>     Ahah very easy indeed :) Not noticing it shows how busy I am with
>     firmware world than I forgot linux-user can be a simpler/powerful
>     way to easily test stuff, as the Hexagon recent port also demonstrate=
d.
>=20
>=20
> Hexagon port doesn't have anything to do with this patch and didn't=20
> demonstrate anything new wrt linux-user. I have no idea what you meant=20
> to say.

I simply meant to say, if your port can run linux-user binaries, it=20
simplifies a lot the testing/coverage.

Hexagon is simpler to test than AVR.

> But, OK, Helge is the submitter, and he decides on the scope of his=20
> patch. I am fine if he wants to limit it only to handful of syscalls. I=
=20
> just hinted he could increase the vslue of the patch significantly in an=
=20
> easy way.
>=20
> Thanks,
> Aleksandar
>=20


