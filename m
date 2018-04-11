Received: from eggs.gnu.org ([2001:4830:134:3::10]:37121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6HtB-0002rK-JX
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6Ht7-0004KN-ND
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:42:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54022 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f6Ht7-0004K8-Ig
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:42:21 -0400
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-19-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ee4eaf43-e8e6-9a1a-2609-e5d6f1b84997@redhat.com>
Date: Wed, 11 Apr 2018 17:42:16 +0200
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-19-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 18/24] tests/tcg/arm: fix hello-arm
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
> As hello-arm is a bare bones syscall test it needs specific compiler
> flags so it doesn't try and link against glibc.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/tcg/arm/Makefile.target | 6 ++++++
>  1 file changed, 6 insertions(+)
>  create mode 100644 tests/tcg/arm/Makefile.target

Reviewed-by: Thomas Huth <thuth@redhat.com>
