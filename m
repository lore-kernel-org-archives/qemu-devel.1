Received: from eggs.gnu.org ([2001:4830:134:3::10]:53690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fWHqy-0005C3-A1
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fWHqt-0005NU-C8
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:55:36 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:49021)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fWHqt-0005Mj-4l
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:55:31 -0400
Date: Fri, 22 Jun 2018 10:55:29 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <3cbe516a-9c99-273a-49aa-2961a315aff8@amsat.org>
Message-ID: <alpine.BSF.2.21.1806221042130.66303@zero.eik.bme.hu>
References: <cover.1529568501.git.balaton@eik.bme.hu>
	<3cbe516a-9c99-273a-49aa-2961a315aff8@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] Misc sm501 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Sebastian Bauer <mail@sebastianbauer.info>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>

On Thu, 21 Jun 2018, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Zoltan,
>
> On 06/21/2018 05:08 AM, BALATON Zoltan wrote:
>> These are fixes to sm501 emulation that were found while testing with
>> AmigaOS 4.1FE (AmigaOS 4 is known to work on real hardware but we have
>> no way to verify it against hardware). While this is mainly to improve
>
> Is it possible to fetch/use this image? (and add integration tests)

AmigaOS 4 is not freely available, it needs to be purchased so I'm not=20
sure it could be used for tests. Also the current version available for=20
Sam460 does not work too well with QEMU yet. To be able to use it=20
according to Sebastian one needs at least updated ehci driver and maybe=20
CLGD graphics driver which are not on this boot CD and editing the CD is=20
not convenient or doable by most people. Therefore we are trying to fix=20
QEMU with Sebastian to be usable with the current boot CD but maybe an=20
updated CD with better drivers would be the way to go, although I don't=20
know if the vendor wants to do that or not.

Regards,
BALATON Zoltan
