Received: from eggs.gnu.org ([2001:4830:134:3::10]:41028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3Mn6-0000E5-Qs
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3Mn6-0005vB-2x
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:15:32 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:35542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d3Mn5-0005un-RJ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:15:32 -0400
Received: by mail-wr0-x232.google.com with SMTP id z52so84101338wrc.2
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 06:15:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_WJP0tBKayzjZ4iVBCjfiQp+bGz_c2RpfwmhLwxM90ug@mail.gmail.com>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
	<CAFEAcA-SR5LXw4uw_Xid94JTarDBpVO2nkGb2axRUu2BcX318Q@mail.gmail.com>
	<20170426023843.GJ16882@umbus.fritz.box>
	<fbf91cf1-53d1-4b75-74b3-fa9abefdd788@kaod.org>
	<CAFEAcA_WJP0tBKayzjZ4iVBCjfiQp+bGz_c2RpfwmhLwxM90ug@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Apr 2017 14:15:09 +0100
Message-ID: <CAFEAcA-hhB4PC8QHDr3agixYqg-E=Z+7yQDGwAn78dARJWUY3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 26 April 2017 at 11:46, Peter Maydell <peter.maydell@linaro.org> wrote:
> All the stuff about shifts is false positives, because the sanitizer
> doesn't know that -fwrapv makes these operations defined behaviour.
>
> Newer versions of clang I think get this correct, and less new
> but not ancient clang has a flag that says "don't report that
> particular set of shift errors".

I just looked into this, and I think the best set of configure options is:
'--cc=clang' '--cxx=clang++' '--extra-cflags=-fsanitize=undefined
-fno-sanitize=shift-base -Werror'

Works with clang-3.8.0 at least.

thanks
-- PMM
