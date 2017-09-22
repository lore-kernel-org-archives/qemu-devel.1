Received: from eggs.gnu.org ([2001:4830:134:3::10]:46253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvDaf-0005I7-63
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 22:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvDac-0005Li-0s
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 22:21:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvDab-0005J0-RG
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 22:21:13 -0400
Date: Fri, 22 Sep 2017 10:21:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170922022110.GA1397@lemon.lan>
References: <20170921170209.9101-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170921170209.9101-1-ehabkost@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Fix subsystem name for "Build
 and test automation"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Thu, 09/21 14:02, Eduardo Habkost wrote:
> The subsystem name for the "Build test automation" section is
> "-------------------------", because an actual subsystem name
> line is missing:
>=20
>   $ ./scripts/get_maintainer.pl -f tests/docker/docker.py
>   "Alex Benn=E9e" <alex.bennee@linaro.org> (maintainer:----------------=
-...)
>   Fam Zheng <famz@redhat.com> (maintainer:-----------------...)
>   "Philippe Mathieu-Daud=E9" <f4bug@amsat.org> (reviewer:--------------=
---...)
>   qemu-devel@nongnu.org (open list:-----------------...)
>=20
> Fix the issue by inserting a subsystem name line where
> get_maintainer.pl expects it.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e511ba780f..13c1ac65b7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1896,6 +1896,7 @@ F: docs/block-replication.txt
> =20
>  Build and test automation
>  -------------------------
> +Build and test automation
>  M: Alex Benn=E9e <alex.bennee@linaro.org>
>  M: Fam Zheng <famz@redhat.com>
>  R: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> --=20
> 2.13.5
>=20

Queued, thanks.

Fam
