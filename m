Received: from eggs.gnu.org ([208.118.235.92]:40434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gfOdS-0008Ps-LZ
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 07:31:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gfOdN-0002PC-OA
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 07:31:34 -0500
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:59564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gfOdN-0002O6-H8
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 07:31:29 -0500
Received: from player762.ha.ovh.net (unknown [10.109.159.123])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 702F7D8F70
	for <qemu-devel@nongnu.org>; Fri,  4 Jan 2019 13:31:27 +0100 (CET)
References: <20190104090610.652-1-clg@kaod.org>
	<CAFEAcA9qKgxY=u4YdymWz3oEDx8Fu-Z5_PfSaznxuWWY-m+=ZA@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <12292c86-0e43-f969-311b-0eaa83254767@kaod.org>
Date: Fri, 4 Jan 2019 13:31:16 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9qKgxY=u4YdymWz3oEDx8Fu-Z5_PfSaznxuWWY-m+=ZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spapr: return from post_load method when
 RTC import fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 1/4/19 11:08 AM, Peter Maydell wrote:
> On Fri, 4 Jan 2019 at 09:07, C=C3=A9dric Le Goater <clg@kaod.org> wrote=
:
>>
>> The error value can be squashed by the section handling radix migratio=
n.
>> Simply bail out if an error occurs when the RTC offset is imported.
>>
>> Fixes: d39c90f5f3ae ("spapr: Fix migration of Radix guests")
>=20
> You could also mention that this fixes the Coverity
> issue CID 1398591.

ok. I will in a v2.

Is there a tag for it ?=20

or adding a comment "this fixes the Coverity issue CID 1398591."=20
is considered sufficient ?=20

Thanks,

C.=20
