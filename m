Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A87C32771
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 00:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A1F2467B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 00:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A1F2467B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isy38-0002CE-0L
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 19:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1isy2P-0001Sa-E9
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 19:02:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1isy2L-0000kz-9C
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 19:01:56 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:21341)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1isy2I-0000jR-J3
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 19:01:53 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 37A227482CB;
 Sun, 19 Jan 2020 01:01:48 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 01082745702; Sun, 19 Jan 2020 01:01:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F1D4E7456F8;
 Sun, 19 Jan 2020 01:01:47 +0100 (CET)
Date: Sun, 19 Jan 2020 01:01:47 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Commit 3e7fb5811b or something in that series breaks build?
In-Reply-To: <alpine.BSF.2.21.99999.352.2001190027510.68247@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.21.99999.352.2001190059170.68247@zero.eik.bme.hu>
References: <alpine.BSF.2.21.99999.352.2001182314430.68247@zero.eik.bme.hu>
 <CAFEAcA9-6eqk9nSJ+0YVSTEyYO8RRqFJwH0TAr8_tNthH1bjuQ@mail.gmail.com>
 <alpine.BSF.2.21.99999.352.2001190027510.68247@zero.eik.bme.hu>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-153108062-1579392074=:68247"
Content-ID: <alpine.BSF.2.21.99999.352.2001190101190.68247@zero.eik.bme.hu>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-153108062-1579392074=:68247
Content-Type: text/plain; CHARSET=ISO-8859-7; format=flowed
Content-ID: <alpine.BSF.2.21.99999.352.2001190101191.68247@zero.eik.bme.hu>
Content-Transfer-Encoding: quoted-printable

On Sun, 19 Jan 2020, BALATON Zoltan wrote:
> On Sat, 18 Jan 2020, Peter Maydell wrote:
>> On Sat, 18 Jan 2020 at 22:41, BALATON Zoltan <balaton@eik.bme.hu> wrot=
e:
>>> I'm getting errors about missing headers in qapi/* and build fails on
>>> current master.
>>>=20
>>> I've tried bisecting it which lead to commit 3e7fb5811b where I get:
>>>
>>>    CC      qapi/qapi-types-audio.o
>>> cc: error: qapi/qapi-types-audio.c: No such file or directory
>>> cc: fatal error: no input files
>>=20
>> I haven't looked, but could you try the usual things to check:
>> * does your tree have 'stale' files deleted by a commit
>>   (ie listed in 'git status' as now unknown to git) ?
>> * did you try a reconfigure and build from clean?
>>   (ideally this should not be required, but it might help
>>   narrow down the issue)
>> * could you test whether you see the issue also with an
>>   out-of-tree build?
>
> Also fails after make distclean with out-of-tree build in the same way.=
 Seems=20
> that --disable-guest-agent option breaks earlier but even without that =
option=20
> I get error later about some rtc chip and build does not finish. I've t=
ried=20
> with just
>
> configure --target-list=3Dppc-softmmu --disable-guest-agent
>
> and get the above error right after it built capstone.a and starts buil=
ding=20
> qapi/* (without --disable-guest-agent it almost gets to the end but fai=
ls=20
> later). Sometimes I also see these errors:
>
> In file included from qapi/qapi-types-crypto.c:15:0:
> qapi/qapi-types-crypto.h:176:33: error: field =A1qcow=A2 has incomplete=
 type
>         QCryptoBlockOptionsQCow qcow;
>                                 ^
> qapi/qapi-types-crypto.h:177:33: error: field =A1luks=A2 has incomplete=
 type
>         QCryptoBlockOptionsLUKS luks;
>                                 ^
> qapi/qapi-types-crypto.h:193:33: error: field =A1qcow=A2 has incomplete=
 type
>         QCryptoBlockOptionsQCow qcow;
>                                 ^
> qapi/qapi-types-crypto.h:236:30: error: field =A1luks=A2 has incomplete=
 type
>         QCryptoBlockInfoLUKS luks;
>                              ^

I've found this:

https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg03486.html

which does fix the build for me (I happen to have python 3.5.7 still) so =
I=20
guess you can add

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>

to that patch.

Regards,
BALATON Zoltan
--3866299591-153108062-1579392074=:68247--

