Received: from eggs.gnu.org ([2001:4830:134:3::10]:53236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dvEQb-0007z7-79
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 23:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dvEQY-00040e-3B
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 23:14:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dvEQX-0003ye-T5
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 23:14:54 -0400
References: <20170921170209.9101-1-ehabkost@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7ad0e182-536b-42d8-5b80-bfcd03612a00@redhat.com>
Date: Fri, 22 Sep 2017 05:14:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170921170209.9101-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 21.09.2017 19:02, Eduardo Habkost wrote:
> The subsystem name for the "Build test automation" section is
> "-------------------------", because an actual subsystem name
> line is missing:
>=20
>   $ ./scripts/get_maintainer.pl -f tests/docker/docker.py
>   "Alex Benn=C3=A9e" <alex.bennee@linaro.org> (maintainer:-------------=
----...)
>   Fam Zheng <famz@redhat.com> (maintainer:-----------------...)
>   "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> (reviewer:-----------=
------...)
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

Would it make sense to use something more specific here? Like "Travis
and Docker" or so? ... in case we add other subsections in the future?

 Thomas
