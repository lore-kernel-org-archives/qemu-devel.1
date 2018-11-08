Received: from eggs.gnu.org ([2001:4830:134:3::10]:40067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gKj1e-00031R-54
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:03:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gKj1d-0006rH-A0
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:03:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gKj1d-0006qc-0p
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:03:05 -0500
Date: Thu, 8 Nov 2018 13:02:43 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181108130243.537375f2.cohuck@redhat.com>
In-Reply-To: <20181108111531.30671-8-stefanha@redhat.com>
References: <20181108111531.30671-1-stefanha@redhat.com>
	<20181108111531.30671-8-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 7/8] target-alpha: use HTTPS git URL for
 palcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Daniel Berrange <berrange@redhat.com>, eblake@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Jeff Cody <jcody@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, Alex =?UTF-8?B?QmVu?= =?UTF-8?B?bsOpZQ==?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu,  8 Nov 2018 11:15:30 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> When you clone the repository without previous commit history, 'git://'
> doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
> since the client verifies the server certificate.
>=20
> Cc: Richard Henderson <rth@twiddle.net>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Acked-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  pc-bios/README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
