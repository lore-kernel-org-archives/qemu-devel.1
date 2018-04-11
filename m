Received: from eggs.gnu.org ([2001:4830:134:3::10]:33328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6Hn6-0006Wq-7Z
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6Hn5-0001O6-8P
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:36:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59844 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f6Hn5-0001Nh-3m
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:36:07 -0400
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-15-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d95e6bc9-3394-5e38-09b6-62bfe2187f01@redhat.com>
Date: Wed, 11 Apr 2018 17:36:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 14/24] tests/tcg/i386: fix test-i386
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
> The test-i386 test case is a little special as it includes assembler
> files. Add the additional compile magic to assemble these bits and
> link them to the final binary.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/tcg/i386/Makefile.target | 19 +++++++++++++++++++
>  tests/tcg/i386/test-i386.c     |  1 -
>  2 files changed, 19 insertions(+), 1 deletion(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
