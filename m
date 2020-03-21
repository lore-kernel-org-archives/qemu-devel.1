Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0031FC4332D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 15:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C743A20722
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 15:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C743A20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFfnw-000511-W8
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 11:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jFfnA-0004GJ-7C
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 11:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jFfn9-0001Dm-6W
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 11:12:04 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:52287)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jFfn3-0001BP-VL; Sat, 21 Mar 2020 11:11:58 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 142A3747DCF;
 Sat, 21 Mar 2020 16:11:56 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E38E6747DF8; Sat, 21 Mar 2020 16:11:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DE5A3747871;
 Sat, 21 Mar 2020 16:11:55 +0100 (CET)
Date: Sat, 21 Mar 2020 16:11:55 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [PATCH-for-5.0 01/11] block: Remove dead assignment
In-Reply-To: <CAHiYmc5gpHCUfc5bPMs8Qa7NETYkkj8rfV5dTyqZF4ZQTeNa8Q@mail.gmail.com>
Message-ID: <alpine.BSF.2.22.395.2003211608170.82121@zero.eik.bme.hu>
References: <20200321114615.5360-1-philmd@redhat.com>
 <20200321114615.5360-2-philmd@redhat.com>
 <CAHiYmc5gpHCUfc5bPMs8Qa7NETYkkj8rfV5dTyqZF4ZQTeNa8Q@mail.gmail.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1870441923-1584803515=:82121"
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Kevin Wolf <kwolf@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Max Reitz <mreitz@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1870441923-1584803515=:82121
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Sat, 21 Mar 2020, Aleksandar Markovic wrote:
> 12:49 PM Sub, 21.03.2020. Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> =D1=98=D0=B5
> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>
>> Fix warning reported by Clang static code analyzer:
>>
>>   block.c:3167:5: warning: Value stored to 'ret' is never read
>>       ret =3D bdrv_fill_options(&options, filename, &flags, &local_err=
);
>>       ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Reported-by: Clang Static Analyzer
>
> Peter, and others,
>
> Is this allowed use of "Reported-by:" mark?
>
> I did not notice it being used this way before. And was under impressio=
n
> that all similar tags/marks must be followed by a person, not a tool.

I think there were previous patches with Reported-by: Euler Robot which=20
may be similar to this usage.

Regards,
BALATON Zoltan

>
> Regards,
> Aleksandar
>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>  block.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block.c b/block.c
>> index a2542c977b..908c109a8c 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -3164,7 +3164,7 @@ static BlockDriverState *bdrv_open_inherit(const
> char *filename,
>>                                      parent->open_flags, parent->optio=
ns);
>>      }
>>
>> -    ret =3D bdrv_fill_options(&options, filename, &flags, &local_err)=
;
>> +    bdrv_fill_options(&options, filename, &flags, &local_err);
>>      if (local_err) {
>>          goto fail;
>>      }
>> --
>> 2.21.1
>>
>>
>
--3866299591-1870441923-1584803515=:82121--

