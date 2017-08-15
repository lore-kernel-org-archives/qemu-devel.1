Received: from eggs.gnu.org ([2001:4830:134:3::10]:42026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhWkb-000119-Du
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:58:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhWkY-0004iL-Ts
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:58:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dhWkY-0004i9-NN
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:58:54 -0400
Date: Tue, 15 Aug 2017 15:58:49 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170815075849.GC29320@lemon>
References: <20170728233316.13352-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170728233316.13352-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] docker: improve code coverage on
 CentOS images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Olaf Hering <olaf@aepfle.de>, Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org

On Fri, 07/28 20:33, Philippe Mathieu-Daud=E9 wrote:
> This series installs more packages to docker images to extend CI code
> coverage.
>=20
> Debian already have those but these images are only used on Shippable.
> Extending CentOS images could improve patchew, and local user not custo=
m to
> Debian.

Thanks, queued.

>=20
> The first idea was to add Suse images but only OpenSUSE 13.2 is availab=
le on
> DockerHub and the problem reported on [1] is using SUSE SLE11.

Have you checked if it is covered by the min-glib image?

Fam
