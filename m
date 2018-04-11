Received: from eggs.gnu.org ([2001:4830:134:3::10]:59755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6Hkb-0004X7-Fl
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6HkW-00088H-NR
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:33:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60342 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f6HkW-00087w-Iv
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:33:28 -0400
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-14-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7ee5d1d4-6310-66ae-0730-cb88f9d260a8@redhat.com>
Date: Wed, 11 Apr 2018 17:33:16 +0200
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 13/24] tests/tcg/i386: move
 test-i386-sse.c to tests/tcg/x86_64/test-sse.c
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
> The test mixes up 32bit and 64 bit code. It should probably be split
> into two distinct test cases. However for now just move it out of the
> way of the i386 build.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/tcg/{i386/test-i386-ssse3.c =3D> x86_64/test-sse.c} | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>  rename tests/tcg/{i386/test-i386-ssse3.c =3D> x86_64/test-sse.c} (93%)

Do we really want to have a separate x86_64 folder here? We also have
64-bit code in hw/i386/ and target/i386/ so I don't think that we should
handle this differently for tests/tcg/i386 ? Wouldn't it be sufficient
to simply move this code to a separate file? ... just my 0.02 =E2=82=AC

 Thomas
