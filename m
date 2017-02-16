Received: from eggs.gnu.org ([2001:4830:134:3::10]:59824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ceM1x-00020u-Ua
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:23:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ceM1u-0003sP-QL
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:23:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ceM1u-0003s4-Kt
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:23:26 -0500
Date: Thu, 16 Feb 2017 21:23:23 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170216132323.GC8817@lemon.lan>
References: <20170216123456.28621-1-alex.bennee@linaro.org>
	<20170216123456.28621-5-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170216123456.28621-5-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 4/4] MAINTAINERS: merge Build and test
 automation with Docker tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On Thu, 02/16 12:34, Alex Benn=E9e wrote:
> The docker framework is really just another piece in the build
> automation puzzle so lets merge it together. For added bonus I've also
> included the Travis and Patchew status links. The Shippable links will
> be added later once mainline tests have been configured and setup.
>=20
> Suggested-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  MAINTAINERS | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7afbadaa15..4e4a3fb83c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1802,9 +1802,14 @@ F: docs/block-replication.txt
>  Build and test automation
>  -------------------------
>  M: Alex Benn=E9e <alex.bennee@linaro.org>
> +M: Fam Zheng <famz@redhat.com>
>  L: qemu-devel@nongnu.org
> -S: Supported
> +S: Maintained

Yes:

> Supported:	Someone is actually paid to look after this.
> Maintained:	Someone actually looks after it.

While I'm paid to work on QEMU upstream, docker testing is not stricly my=
 job
responsibility. So as for patchew. That's probably why I put 'maintained'
before.

>  F: .travis.yml
> +F: .shippable.yml

This line could be pulled into patch 3.

> +F: tests/docker/
> +W: https://travis-ci.org/qemu/qemu
> +W: http://patchew.org/QEMU/

Thanks for the link!

If you move the 'shippable.yml' line:

Reviewed-by: Fam Zheng <famz@redhat.com>
