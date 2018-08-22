Received: from eggs.gnu.org ([2001:4830:134:3::10]:56700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jthumshirn@suse.de>) id 1fsSkE-00008k-8L
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 09:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jthumshirn@suse.de>) id 1fsSY8-0001jA-MX
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:47:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:47360 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jthumshirn@suse.de>) id 1fsSY8-0001hI-Fc
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:47:48 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id C1515AE10
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 12:47:46 +0000 (UTC)
Date: Wed, 22 Aug 2018 14:47:46 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <20180822124746.ls5akjzjpqwnhuuh@linux-x5ow.site>
References: <20180809114017.16643-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180809114017.16643-1-jthumshirn@suse.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Add support for Men Chameleon Bus
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Thu, Aug 09, 2018 at 01:40:13PM +0200, Johannes Thumshirn wrote:
> This series adds support for emulating FPGAs by Men Mikroelektronik
> N=FCrnberg and expose the FPGA itself as a bus. The IP-Cores implemente=
d
> in the FPGA are represented as devices hanging off that bus. This is th=
e
> same aproach that is used in the Linux kernel as well for these devices=
.
>=20
> The main intention for this series is to have a test-bed for Linux
> Kernel patches targeting the bus and/or sub-devices of it for people
> who do not have access the hardware.
>=20
> Changes since v1:
> * Updated License comments of the files (Peter Maydell)
> * Added <public>/<private> annotations (Philippe Mathieu-Daud=E9)

Ping?
--=20
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=FCrnberg)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
