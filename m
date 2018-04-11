Received: from eggs.gnu.org ([2001:4830:134:3::10]:54739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6CwZ-0003i9-0C
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 06:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6CwU-0007Te-6n
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 06:25:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36664 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f6CwU-0007TK-2U
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 06:25:30 -0400
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-11-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <97e37d92-53f4-2456-e42f-2d569769dd16@redhat.com>
Date: Wed, 11 Apr 2018 12:25:24 +0200
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 10/24] tests/tcg/multiarch: Build fix
 for linux-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: famz@redhat.com, cota@braap.org

On 10.04.2018 21:39, Alex Benn=C3=A9e wrote:
> From: Fam Zheng <famz@redhat.com>
>=20
> To keep the compiler happy, and to fit in our buildsys flags:
>=20
> - Make local functions "static"
> - #ifdef out unused functions
> - drop cutils/osdep dependencies
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> [AJB: drop cutils/osdep dependencies]
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/tcg/multiarch/linux-test.c | 68 +++++++++++++-------------------=
--------
>  1 file changed, 21 insertions(+), 47 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
