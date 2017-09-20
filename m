Received: from eggs.gnu.org ([2001:4830:134:3::10]:35694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duYOc-0004xP-Os
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duYOZ-0000wk-Hk
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:22:06 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:60780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1duYOZ-0000n8-Br
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:22:03 -0400
Received: from player157.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id B95D2AC494
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 08:22:01 +0200 (CEST)
References: <20170919111721.7931-1-clg@kaod.org>
	<4e5b4255-8e4d-2240-fb60-942559c2586d@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e82bf474-780a-3c44-01f4-5d58443b87d4@kaod.org>
Date: Wed, 20 Sep 2017 08:21:51 +0200
MIME-Version: 1.0
In-Reply-To: <4e5b4255-8e4d-2240-fb60-942559c2586d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] watchdog/aspeed: fix variable type to
 store reload value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, "Anton D . Kachalov" <mouse@yandex-team.ru>, qemu-devel@nongnu.org

On 09/19/2017 07:15 PM, Richard Henderson wrote:
> On 09/19/2017 06:17 AM, C=C3=A9dric Le Goater wrote:
>> +    uint64_t reload;
>> =20
>>      if (pclk) {
>>          reload =3D muldiv64(s->regs[WDT_RELOAD_VALUE], NANOSECONDS_PE=
R_SECOND,
>>                            s->pclk_freq);
>>      } else {
>> -        reload =3D s->regs[WDT_RELOAD_VALUE] * 1000;
>> +        reload =3D s->regs[WDT_RELOAD_VALUE] * 1000UL;
>=20
> UL does not help ilp32 hosts.  Need ULL or an explicit cast.

ok. I will send a fix.

Thanks,

C.=20
