Received: from eggs.gnu.org ([2001:4830:134:3::10]:47006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eGu7g-0001yD-Cy
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:01:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eGu7d-0003jR-Bd
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:01:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60238
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eGu7d-0003iz-6L
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:00:57 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAKLx3Eb081111
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 17:00:51 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ec6qwhv84-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 17:00:51 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Nov 2017 17:00:50 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20171107205201.10207-1-mdroth@linux.vnet.ibm.com>
References: <20171107205201.10207-1-mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Nov 2017 16:00:39 -0600
Message-Id: <151121523989.31225.8242493880994615406@sif>
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH for-2.11]
 scripts/make-release: ship u-boot source as a tarball
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org, Alexander Graf <agraf@suse.de>

Quoting Michael Roth (2017-11-07 14:52:01)
> The u-boot sources we ship currently cause problems with unpacking on
> a case-insensitive filesystem due to path conflicts. This has been
> fixed in upstream u-boot via commit 610eec7f, but since it is not
> yet included in an official release we implement this approach as a
> temporary workaround.
> =

> Once we move to a u-boot containing commit 610eec7f we should revert
> this patch.
> =

> Cc: qemu-stable@nongnu.org
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>

Ping.

Peter, would you be able to apply this directly? Not sure who else this
would go through.

> ---
>  scripts/make-release | 4 ++++
>  1 file changed, 4 insertions(+)
> =

> diff --git a/scripts/make-release b/scripts/make-release
> index fa6323fda8..3917df7142 100755
> --- a/scripts/make-release
> +++ b/scripts/make-release
> @@ -20,6 +20,10 @@ git checkout "v${version}"
>  git submodule update --init
>  (cd roms/seabios && git describe --tags --long --dirty > .version)
>  rm -rf .git roms/*/.git dtc/.git pixman/.git
> +# FIXME: The following line is a workaround for avoiding filename collis=
ions
> +# when unpacking u-boot sources on case-insensitive filesystems. Once we
> +# update to something with u-boot commit 610eec7f0 we can drop this line.
> +tar cfj roms/u-boot.tar.bz2 -C roms u-boot && rm -rf roms/u-boot
>  popd
>  tar cfj ${destination}.tar.bz2 ${destination}
>  rm -rf ${destination}
> -- =

> 2.11.0
> =

>=20
