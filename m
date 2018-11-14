Received: from eggs.gnu.org ([2001:4830:134:3::10]:53614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gMyS3-0005Xc-Qz
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:55:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gMyRw-0006m2-8C
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:55:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59930
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1gMyRt-0006kX-3E
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:55:30 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAEGrpwU063650
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 11:55:28 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nrn96fhrc-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 11:55:27 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Nov 2018 16:55:27 -0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181109161352.29873-1-mdroth@linux.vnet.ibm.com>
References: <20181109161352.29873-1-mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Nov 2018 10:55:15 -0600
Message-Id: <154221451552.7171.627568455010820489@sif>
Subject: Re: [Qemu-devel] [PATCH resend for-3.1] make-release: add skiboot
 .version file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: qemu-stable@nongnu.org

Quoting Michael Roth (2018-11-09 10:13:52)
> This is needed to build skiboot from tarball-distributed sources
> since the git data the make_release.sh script relies on to generate
> it is not available.
> =

> Cc: qemu-stable@nongnu.org
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>

Hi Peter,

Should I go ahead and send this as a standalone pull or should it go in
through someone else?

> ---
>  scripts/make-release | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/scripts/make-release b/scripts/make-release
> index 04fa9defdc..c14f75b12c 100755
> --- a/scripts/make-release
> +++ b/scripts/make-release
> @@ -19,6 +19,7 @@ pushd ${destination}
>  git checkout "v${version}"
>  git submodule update --init
>  (cd roms/seabios && git describe --tags --long --dirty > .version)
> +(cd roms/skiboot && ./make_version.sh > .version)
>  # FIXME: The following line is a workaround for avoiding filename collis=
ions
>  # when unpacking u-boot sources on case-insensitive filesystems. Once we
>  # update to something with u-boot commit 610eec7f0 we can drop this line.
> -- =

> 2.17.1
>=20
