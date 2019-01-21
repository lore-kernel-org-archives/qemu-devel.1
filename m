Received: from eggs.gnu.org ([209.51.188.92]:55102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1glU6O-0007tm-Ea
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 02:34:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1glU6N-0003nt-NM
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 02:34:36 -0500
Date: Mon, 21 Jan 2019 08:34:25 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190121083425.154d9c29.cohuck@redhat.com>
In-Reply-To: <20190118171848.27332-1-alex.bennee@linaro.org>
References: <20190118171848.27332-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/s390x: define TCG_GUEST_DEFAULT_MO
 for MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, "open list:S390" <qemu-s390x@nongnu.org>

On Fri, 18 Jan 2019 17:18:48 +0000
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> MTTCG should be enabled by default whenever the memory model allows
> it. s390x was missing its definition of TCG_GUEST_DEFAULT_MO meaning
> the user had to manually specify  --accel tcg,thread=3Dmulti.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h | 4 ++++
>  1 file changed, 4 insertions(+)

Thanks, applied.
