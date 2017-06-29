Received: from eggs.gnu.org ([2001:4830:134:3::10]:58980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dQfOP-0005iU-JZ
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dQfOO-0007em-LG
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:46:21 -0400
References: <20170623220926.11479-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <74fb8c3e-b85a-211b-a8da-3ffe5b2d08ef@redhat.com>
Date: Thu, 29 Jun 2017 15:46:13 -0400
MIME-Version: 1.0
In-Reply-To: <20170623220926.11479-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] AHCI: re-privatize ahci headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: f4bug@amsat.org, qemu-devel@nongnu.org



On 06/23/2017 06:09 PM, John Snow wrote:
> As reported by Philippe Mathieu-Daud=C3=A9, including AHCI headers can
> quickly pull in more dependencies than is sane. To remedy this,
> split the AHCI headers into public and private areas as best as we
> can and move the private information back into hw/ide/.
>=20
> The only code movement is performed in patch 2.
> Patch 3 looks terrible, but all it is doing are two different moves,
> renaming one include directive. If you have suggestions for doing
> this diffstat differently, please advise.
>=20
> John Snow (3):
>   ahci: add ahci_get_num_ports
>   ahci: Isolate public AHCI interface
>   ahci: split public and private interface
>=20
>  hw/i386/pc_q35.c       |   4 +-
>  hw/ide/ahci.c          |  10 +-
>  hw/ide/ahci_internal.h | 359 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  hw/ide/ich.c           |   2 +-
>  hw/mips/boston.c       |   4 +-
>  include/hw/ide/ahci.h  | 320 +----------------------------------------=
--
>  6 files changed, 376 insertions(+), 323 deletions(-)
>  create mode 100644 hw/ide/ahci_internal.h
>=20

Thanks, applied to my IDE tree:

https://github.com/jnsnow/qemu/commits/ide
https://github.com/jnsnow/qemu.git

--js
