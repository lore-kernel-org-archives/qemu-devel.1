Received: from eggs.gnu.org ([2001:4830:134:3::10]:52200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3NRS-0000DT-Jh
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3NRR-0006kC-PR
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:57:14 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:36210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d3NRR-0006ip-Ib
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:57:13 -0400
Received: by mail-wr0-x229.google.com with SMTP id l50so625447wrc.3
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 06:57:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <701a8274-5126-cc42-c438-d18a00f59f08@kaod.org>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
	<CAFEAcA-SR5LXw4uw_Xid94JTarDBpVO2nkGb2axRUu2BcX318Q@mail.gmail.com>
	<20170426023843.GJ16882@umbus.fritz.box>
	<fbf91cf1-53d1-4b75-74b3-fa9abefdd788@kaod.org>
	<CAFEAcA_WJP0tBKayzjZ4iVBCjfiQp+bGz_c2RpfwmhLwxM90ug@mail.gmail.com>
	<CAFEAcA-hhB4PC8QHDr3agixYqg-E=Z+7yQDGwAn78dARJWUY3Q@mail.gmail.com>
	<701a8274-5126-cc42-c438-d18a00f59f08@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Apr 2017 14:56:51 +0100
Message-ID: <CAFEAcA_g_MfU7-fFB+=8ZOVxnF858NXqGfBpCUr4D0qS5NKp_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/47] ppc-for-2.10 queue 20170424
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 26 April 2017 at 14:32, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 04/26/2017 03:15 PM, Peter Maydell wrote:
>> I just looked into this, and I think the best set of configure options i=
s:
>> '--cc=3Dclang' '--cxx=3Dclang++' '--extra-cflags=3D-fsanitize=3Dundefine=
d
>> -fno-sanitize=3Dshift-base -Werror'
>
> Ah ! Too fast you are for me :) you beat me to it.
>
>> Works with clang-3.8.0 at least.
>
> Yes. confirmed.

I've added info on how to use clang ubsan to
 http://wiki.qemu.org/Testing#clang_UBSan

thanks
-- PMM
