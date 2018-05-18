Received: from eggs.gnu.org ([2001:4830:134:3::10]:43987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fJc1O-0001rF-N1
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:50:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fJc1K-0004zq-KA
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:49:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41202 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fJc1K-0004xn-El
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:49:54 -0400
References: <20180518091440.1559-1-alex.bennee@linaro.org>
	<20180518091440.1559-3-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e15ff8a0-44d8-e312-2d7d-bdf95c7d4965@redhat.com>
Date: Fri, 18 May 2018 11:49:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180518091440.1559-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] tests/Makefile: comment out flakey
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, famz@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org

On 18/05/2018 11:14, Alex Benn=C3=A9e wrote:
> The following tests keep showing up in failed Travis runs:
>=20
>   - test-aio
>   - rcutorture
>   - tpm-crb-test
>   - tpm-tis-test
>=20
> I suspect it is load that causes the problems but they really need to
> be fixed properly.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---

Can you point to a failed run for rcutorture?

Paolo
