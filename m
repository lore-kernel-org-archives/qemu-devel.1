Received: from eggs.gnu.org ([209.51.188.92]:46773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hE7yF-0007RH-3Q
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 03:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hE7yE-0007k8-4C
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 03:48:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hE7yD-0007iS-Nv
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 03:48:34 -0400
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
	<b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
	<068f4832-7e0b-8850-ffa0-fcf1ecd50295@redhat.com>
	<20190405090212.GF6105@redhat.com>
	<740ce541-c92d-5369-1191-eb73fc861fdd@redhat.com>
	<a53b3bab-5aa4-b37f-f194-7788bce1d04b@weilnetz.de>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d3a11b60-8b66-2c1e-6cb8-2616ee2cabc6@redhat.com>
Date: Wed, 10 Apr 2019 09:48:26 +0200
MIME-Version: 1.0
In-Reply-To: <a53b3bab-5aa4-b37f-f194-7788bce1d04b@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: Automatically fall back to TCI
 on non-release architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>, Samuel Thibault <samuel.thibault@ens-lyon.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 09/04/2019 21.46, Stefan Weil wrote:
[...]
> The known problems with the current implementation are
[...]
> * Calling conventions. The current implementation works on many hosts,
> but for example not on Sparc
Is there also a problem with the sparc *target* (i.e. not only sparc
hosts)? TCI does not seem to work here:

 https://gitlab.com/huth/qemu/-/jobs/193861498

 Thomas
