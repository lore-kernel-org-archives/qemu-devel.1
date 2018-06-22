Received: from eggs.gnu.org ([2001:4830:134:3::10]:37666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWKfa-0005TB-Mi
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWKfX-0005KF-La
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:56:02 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:42591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWKfX-0005K7-Gd
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:55:59 -0400
Received: by mail-qt0-x241.google.com with SMTP id y31-v6so5645330qty.9
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 04:55:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1529568501.git.balaton@eik.bme.hu>
	<3cbe516a-9c99-273a-49aa-2961a315aff8@amsat.org>
	<alpine.BSF.2.21.1806221042130.66303@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d90f71a8-f53e-24a6-8126-b69c735bb688@amsat.org>
Date: Fri, 22 Jun 2018 08:55:54 -0300
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1806221042130.66303@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/5] Misc sm501 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Sebastian Bauer <mail@sebastianbauer.info>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>

On 06/22/2018 05:55 AM, BALATON Zoltan wrote:
> On Thu, 21 Jun 2018, Philippe Mathieu-Daudé wrote:
>> Hi Zoltan,
>>
>> On 06/21/2018 05:08 AM, BALATON Zoltan wrote:
>>> These are fixes to sm501 emulation that were found while testing with
>>> AmigaOS 4.1FE (AmigaOS 4 is known to work on real hardware but we have
>>> no way to verify it against hardware). While this is mainly to improve
>>
>> Is it possible to fetch/use this image? (and add integration tests)
> 
> AmigaOS 4 is not freely available, it needs to be purchased so I'm not
> sure it could be used for tests. Also the current version available for
> Sam460 does not work too well with QEMU yet. To be able to use it
> according to Sebastian one needs at least updated ehci driver and maybe
> CLGD graphics driver which are not on this boot CD and editing the CD is
> not convenient or doable by most people. Therefore we are trying to fix
> QEMU with Sebastian to be usable with the current boot CD but maybe an
> updated CD with better drivers would be the way to go, although I don't
> know if the vendor wants to do that or not.

OK thanks for the explanation, I plan to add part of it somewhere in the
wiki.
