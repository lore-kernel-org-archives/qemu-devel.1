Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9745CC32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 23:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6573A246A5
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 23:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6573A246A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isxkb-00041X-Gu
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 18:43:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1isxjw-0003Po-UU
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 18:42:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1isxjv-0007AH-8F
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 18:42:52 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:30258)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1isxjv-00078D-2S
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 18:42:51 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id A3FC17482CB;
 Sun, 19 Jan 2020 00:42:48 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7EBE1745702; Sun, 19 Jan 2020 00:42:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7D2E97456F8;
 Sun, 19 Jan 2020 00:42:48 +0100 (CET)
Date: Sun, 19 Jan 2020 00:42:48 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Commit 3e7fb5811b or something in that series breaks build?
In-Reply-To: <CAFEAcA9-6eqk9nSJ+0YVSTEyYO8RRqFJwH0TAr8_tNthH1bjuQ@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.99999.352.2001190027510.68247@zero.eik.bme.hu>
References: <alpine.BSF.2.21.99999.352.2001182314430.68247@zero.eik.bme.hu>
 <CAFEAcA9-6eqk9nSJ+0YVSTEyYO8RRqFJwH0TAr8_tNthH1bjuQ@mail.gmail.com>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1182346319-1579390968=:68247"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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

--3866299591-1182346319-1579390968=:68247
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Sat, 18 Jan 2020, Peter Maydell wrote:
> On Sat, 18 Jan 2020 at 22:41, BALATON Zoltan <balaton@eik.bme.hu> wrote=
:
>> I'm getting errors about missing headers in qapi/* and build fails on
>> current master.
>>
>> I've tried bisecting it which lead to commit 3e7fb5811b where I get:
>>
>>    CC      qapi/qapi-types-audio.o
>> cc: error: qapi/qapi-types-audio.c: No such file or directory
>> cc: fatal error: no input files
>
> I haven't looked, but could you try the usual things to check:
> * does your tree have 'stale' files deleted by a commit
>   (ie listed in 'git status' as now unknown to git) ?
> * did you try a reconfigure and build from clean?
>   (ideally this should not be required, but it might help
>   narrow down the issue)
> * could you test whether you see the issue also with an
>   out-of-tree build?

Also fails after make distclean with out-of-tree build in the same way.=20
Seems that --disable-guest-agent option breaks earlier but even without=20
that option I get error later about some rtc chip and build does not=20
finish. I've tried with just

configure --target-list=3Dppc-softmmu --disable-guest-agent

and get the above error right after it built capstone.a and starts=20
building qapi/* (without --disable-guest-agent it almost gets to the end=20
but fails later). Sometimes I also see these errors:

In file included from qapi/qapi-types-crypto.c:15:0:
qapi/qapi-types-crypto.h:176:33: error: field =E2=80=98qcow=E2=80=99 has =
incomplete type
          QCryptoBlockOptionsQCow qcow;
                                  ^
qapi/qapi-types-crypto.h:177:33: error: field =E2=80=98luks=E2=80=99 has =
incomplete type
          QCryptoBlockOptionsLUKS luks;
                                  ^
qapi/qapi-types-crypto.h:193:33: error: field =E2=80=98qcow=E2=80=99 has =
incomplete type
          QCryptoBlockOptionsQCow qcow;
                                  ^
qapi/qapi-types-crypto.h:236:30: error: field =E2=80=98luks=E2=80=99 has =
incomplete type
          QCryptoBlockInfoLUKS luks;
                               ^

Regards,
BALATON Zoltan
--3866299591-1182346319-1579390968=:68247--

