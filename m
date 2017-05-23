Received: from eggs.gnu.org ([2001:4830:134:3::10]:58189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dDBL6-00036N-FQ
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dDBL3-0008Gk-ST
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:03:12 -0400
References: <20170508233918.9043-1-f4bug@amsat.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <ad362ec8-86c5-1573-8d1e-755b2f55fc67@msgid.tls.msk.ru>
Date: Tue, 23 May 2017 18:03:08 +0300
MIME-Version: 1.0
In-Reply-To: <20170508233918.9043-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/11] various easy cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

09.05.2017 02:39, Philippe Mathieu-Daud=C3=A9 wrote:
> various easy patchs added while coding around:
> - remove old comments
> - add/remove includes
> - use TYPE_ names when available
> - use ARRAY_SIZE() macro
>=20
> Philippe Mathieu-Daud=C3=A9 (11):
>   hw/net: removed obsolete comments
>   hw/pci: define msi_nonbroken in pci-stub
>   hw/misc: add missing includes
>   ide/ahci: add missing includes
>   hw/mips: add missing include
>   hw/arm: removed unnecessary include
>   hw/arm: use defined type name instead of hard-coded string.
>   hw/sparc: use ARRAY_SIZE() macro
>   target/sparc: fix DEBUG_MMU DPRINTF() arguments
>   register: display register prefix (name) since it is available
>   MAINTAINERS: self-appoint me as reviewer of the Register API

>From this set, I've applied 4 patches:
 [PATCH 05/11] hw/mips: add missing include
 [PATCH 06/11] hw/arm: removed unnecessary include
 [PATCH 08/11] hw/sparc: use ARRAY_SIZE() macro
 [PATCH 10/11] register: display register prefix (name) since it is avail=
able

Thanks,

/mjt
