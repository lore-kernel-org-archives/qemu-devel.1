Received: from eggs.gnu.org ([2001:4830:134:3::10]:56864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDOqq-0002Wm-2w
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDOqm-0002l3-VE
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:28:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dDOqm-0002kZ-OS
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:28:48 -0400
Date: Wed, 24 May 2017 13:28:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170524052844.GL12279@lemon.lan>
References: <20170521032956.27446-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170521032956.27446-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/24] docker/shippable: cross-build
 mipsel and powerpc targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Sun, 05/21 00:29, Philippe Mathieu-Daud=E9 wrote:
> This patchset add 2 more architectures to the cross-build farm.
>=20
> There is still some issue trying to cross-build mips64el-softmmu, it se=
ems the
> cross tools use the system outdated libfdt instead of the one checkoute=
d in the
> dtc submodule. I disabled this target for now.
>=20
> The branch https://github.com/philmd/qemu/tree/docker_shippable_v3 can =
be
> checked at Shippable:
>   https://app.shippable.com/github/philmd/qemu/status/dashboard
>=20
> Each arch builds in around ~9min. Using Shippable free open source proj=
ects
> service, the 5 jobs take ~38-44min in total.
>=20
> v3:
> - Addressed review feedbacks from Fam:
> - Keep building images in various layers, but use DEBIAN_FRONTEND=3Dnon=
interactive
> - Document '--extra-files', now it supports adding various files at onc=
e
> - Checksum extra files to trigger a docker image rebuild if modified
> - Use better regex to generate deb-src entries
> - Reordered extra libs, to ease further add/remove diffs

Looks good in general, thanks! I've had two small questions, apart from t=
hat
it's ready to go.

Fam
