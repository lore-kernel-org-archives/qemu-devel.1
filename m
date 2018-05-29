Received: from eggs.gnu.org ([2001:4830:134:3::10]:36707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fNkRj-0000qP-N6
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:38:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fNkRi-0006VX-Gv
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:38:15 -0400
References: <20180529174821.19964-1-f4bug@amsat.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b093773f-fe16-776f-f379-13ad776a954c@redhat.com>
Date: Tue, 29 May 2018 21:38:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180529174821.19964-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] qapi/error: converts
 error_setg(&error_fatal) to error_report() + exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Hi,

On 05/29/2018 07:48 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>=20
> This series converts error_setg(&error_fatal) to error_report() + exit(=
) as
> suggested by the "qapi/error.h" documentation.
>=20
> This reduce Coverity and Clang static analyzer positive falses.
>=20
> See http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg07585.ht=
ml:
>=20
>     On 07/24/2017 04:52 PM, Eric Blake wrote:
>     That's a shame.  Rather, we should patch this file (and others) to =
avoid
>     all the inconsistent uses of error_setg(&error_*), to comply with t=
he
>     error.h documentation.

Thanks for the fix.

For the series:
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=C3=A9 (4):
>   hw/block/fdc: Replace error_setg(&error_abort) by error_report() + ab=
ort()
>   hw/ppc/spapr_drc: Replace error_setg(&error_abort) by error_report() =
+
>     abort()
>   hw/arm/sysbus-fdt: Replace error_setg(&error_fatal) by error_report()
>     + exit()
>   device_tree: Replace error_setg(&error_fatal) by error_report() + exi=
t()
>=20
>  device_tree.c       | 23 +++++++++++++----------
>  hw/arm/sysbus-fdt.c | 45 ++++++++++++++++++++++++++-------------------
>  hw/block/fdc.c      |  7 ++++---
>  hw/ppc/spapr_drc.c  |  3 ++-
>  4 files changed, 45 insertions(+), 33 deletions(-)
>=20
