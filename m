Received: from eggs.gnu.org ([2001:4830:134:3::10]:57295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRb8T-0000Co-Uu
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 04:58:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRb8T-0004I1-7A
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 04:58:02 -0500
References: <20171219163713.31383-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f64a0bc6-311d-4d8f-4081-1cf0217aa00e@redhat.com>
Date: Wed, 20 Dec 2017 10:57:45 +0100
MIME-Version: 1.0
In-Reply-To: <20171219163713.31383-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] qemu-iotests: add missing make rule
 for socket_scm_helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Wenchao Xia <xiawenc@linux.vnet.ibm.com>, Stratos Psomadakis <psomas@grnet.gr>, Eric Blake <eblake@redhat.com>

On 19/12/2017 17:37, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>=20
> Apparently block-tests are only run on patchew CI, not Travis, so this =
went
> unnoticed.
>=20
> Now ./check does check for this helper, and errors are easier to figure=
 out.
>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=C3=A9 (2):
>   qemu-iotests: add missing rule to build socket_scm_helper
>   qemu-iotests: check socket_scm_helper is available
>=20
>  tests/Makefile.include   | 2 +-
>  tests/qemu-iotests/check | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
