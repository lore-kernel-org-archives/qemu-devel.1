Received: from eggs.gnu.org ([209.51.188.92]:52444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h1vzf-00051Q-T2
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:35:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h1vza-0003Dl-5b
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:35:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h1vzZ-0003DL-T1
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:35:34 -0500
References: <20190307142822.8531-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d60ffd01-b8bf-c3e1-61f9-05e798622f1e@redhat.com>
Date: Thu, 7 Mar 2019 17:35:27 +0100
MIME-Version: 1.0
In-Reply-To: <20190307142822.8531-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/2] OpenBSD: Let QEMU 4.0 be usable
 from OpenBSD 6.0 and onwards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>

On 07/03/19 15:28, Philippe Mathieu-Daud=C3=A9 wrote:
> Since OpenBSD 6.0, the W^X protection is enforced by default.
> TCG is incompatible with this protection, to be able to use the
> QEMU binary, this protection has to be disabled.
> The OpenBSD ports seens to have downstream patches to be able to
> use QEMU, but these patches were never upstreamed.
> This series allow to run QEMU when built from the mainstream sources.
>=20
> I salvaged the minimum patches required to be able to run OpenBSD
> from a previous series, which aimed at running the QEMU QTest suite
> on OpenBSD. Sadly it seems there is not much interest in having this
> OS covered by tests (except by Peter Maydell).
>=20
> v2: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg07513.html
> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06676.html
>=20
> Philippe Mathieu-Daud=C3=A9 (2):
>   oslib-posix: Ignore fcntl("/dev/null", F_SETFL, O_NONBLOCK) failure
>   configure: Disable W^X on OpenBSD
>=20
>  configure          | 11 +++++++++++
>  util/oslib-posix.c | 12 ++++++++++++
>  2 files changed, 23 insertions(+)
>=20

Queued, thanks.

Paolo
