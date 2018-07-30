Received: from eggs.gnu.org ([2001:4830:134:3::10]:50071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1fk2MS-0006mC-N0
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 03:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1fk2MR-0001LS-Rx
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 03:12:56 -0400
References: <20180730024701.7613-1-yuchenlin@synology.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <96bc216a-d335-dd36-06f0-5985bb52df53@weilnetz.de>
Date: Mon, 30 Jul 2018 09:12:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180730024701.7613-1-yuchenlin@synology.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] Refine some vdi code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin@synology.com, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

Am 30.07.2018 um 04:46 schrieb yuchenlin@synology.com:
> From: yuchenlin <yuchenlin@synology.com>
>=20
> This series refine some code in vdi.c, includes:
>=20
> * Remvoe CONFIG_VDI_WRITE because there is no reason to leave an always=
 on
>   and cannot configure option in the code-side.
> * decouple if else if chain to get more readability.
>=20
> Thanks,
> yuchenlin
>=20
> yuchenlin (2):
>   vdi: remove CONFIG_VDI_WRITE
>   vdi: refine code for vdi_open
>=20
>  block/vdi.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)


Technically these changes are fine, but personally I prefer my old code.
If else is rendundant here, but redundancy helps humans to understand
the code. CONFIG_VDI_WRITE still has a similar function as it documents
which code parts are relevant for write support.

Stefan
