Received: from eggs.gnu.org ([2001:4830:134:3::10]:34425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e57H0-0002Lc-KX
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e57Gz-0001iA-R9
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:37:54 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:56691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e57Gz-0001hY-Ko
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:37:53 -0400
Received: by mail-wr0-x242.google.com with SMTP id r79so7630227wrb.13
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 02:37:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171019041134.GX2776@umbus.fritz.box>
References: <20171018223116.6035-1-programmingkidx@gmail.com>
	<20171019013126.GR2776@umbus.fritz.box>
	<73CB718C-E1F1-4028-9E64-55759471792A@gmail.com>
	<20171019041134.GX2776@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Oct 2017 10:37:31 +0100
Message-ID: <CAFEAcA_0X59g3uyLcmVQ=ffjaz_=tHi_KLqsJ4rLsrhV91FrtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] fdt_ro.c: implement strnlen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Programmingkid <programmingkidx@gmail.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 19 October 2017 at 05:11, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Wed, Oct 18, 2017 at 10:39:57PM -0400, Programmingkid wrote:
>> QEMU supports Mac OS 10.5 and higher. The strnlen() function might
>> have been added to Mac OS X in version 10.7.
>
> Wow.  No strnlen() in MacOS until that recently, that's pretty shit.

It's pretty poor, but the 10.7 release date was 2011, five years
ago now, and it's been out of security-fix support for 2 or 3 years.

thanks
-- PMM
