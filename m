Received: from eggs.gnu.org ([2001:4830:134:3::10]:60945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dOUpW-00054X-5g
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 16:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dOUpT-00084N-0d
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 16:05:22 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:35098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dOUpS-00083v-RG
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 16:05:18 -0400
Received: by mail-io0-x243.google.com with SMTP id 84so2179783iop.2
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 13:05:17 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Jun 2017 16:05:14 -0400
Message-Id: <04A047CA-48D8-4381-B08C-0A91B135D7D0@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Subject: Re: [Qemu-devel] [PATCH] Improve Cocoa modifier key handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian McKellar <ianloic@google.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

This patch is incompatible with anything below Mac OS 10.10. We support =
Mac OS 10.5 and up. I was able to make this patch work on Mac OS 10.6 by =
changing this line:

NSEventModifierFlags modifiers =3D [event modifierFlags];

to this:

NSUInteger modifiers =3D [event modifierFlags];

This wouldn't be enough. The [event modifierFlags] code would have to be =
replaced because the modifierFlags function is not available on Mac OS =
10.5.
