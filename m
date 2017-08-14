Received: from eggs.gnu.org ([2001:4830:134:3::10]:46508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhGJ5-0004QP-Ly
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhGJ4-00032Z-RX
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:25:27 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:36496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dhGJ4-0002zW-M3
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:25:26 -0400
Received: by mail-wm0-x22b.google.com with SMTP id t201so38710254wmt.1
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 07:25:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1708141316200.10227@zero.eik.bme.hu>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<f07c7c77f83136f938f346e1f3b2aa5296ff4223.1502643878.git.balaton@eik.bme.hu>
	<0d150f9d-bca2-7bbd-aecf-584d65646c23@redhat.com>
	<alpine.BSF.2.21.1708141316200.10227@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Aug 2017 15:25:04 +0100
Message-ID: <CAFEAcA8X2K+d7FuAw0YW3Z9g7RbjfTYT0z-fsnM-X8QUOm9ROw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH 05/12] ppc4xx: Split off 4xx I2C
 emulation from ppc405_uc to its own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Francois Revol <revol@free.fr>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

On 14 August 2017 at 12:18, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Mon, 14 Aug 2017, Paolo Bonzini wrote:
>> Can you move it to hw/i2c while you're at it?

> I could if that's the preferred way but I've left it in hw/ppc because this
> is not a generic device but specific to PPC SoCs and it was easier
> to work with files in one dir than scattered through the tree. Should I
> still move it to hw/i2c?

Yeah, when you have a device that's both "type X" and
"architecture Y" you can't put it both in hw/Y and hw/X,
and the choice we've made is that hw/$ARCH is for:
 * board models
 * SoC container objects which just instantiate other devices
and "leaf" devices go under the relevand hw/$CATEGORY
(which may be hw/misc if nothing more appropriate exists).
It's a little bit arbitrary, but it follows a similar practice
in the Linux kernel source tree layout.

thanks
-- PMM
