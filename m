Received: from eggs.gnu.org ([2001:4830:134:3::10]:60337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eYqa4-0002QU-Cf
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 04:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eYqZz-00036D-OU
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 04:52:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eYqZz-00035Z-Iq
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 04:52:23 -0500
References: <20180108172904.8772-1-f4bug@amsat.org>
	<20180108172904.8772-13-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <36374d47-b912-e208-4d32-4cc8c7985c0f@redhat.com>
Date: Tue, 9 Jan 2018 10:52:18 +0100
MIME-Version: 1.0
In-Reply-To: <20180108172904.8772-13-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 12/12] slirp: use
 HOST_SUPPORTS_UNALIGNED_ACCESS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

On 08/01/2018 18:29, Philippe Mathieu-Daud=C3=A9 wrote:
> Access struct in6_addr with 'void *', then cast to 'u8 *' to avoid alig=
nment
> issues.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> ugly...
>=20
>  slirp/ip6.h | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
>  1 file changed, 58 insertions(+)

What is the bug exactly?  If a->s6_addr can be unaligned, this should be
in the commit message.

In any case, there is no need to keep the versions that use struct
in6_addr, you can use the void* version unconditionally.

Paolo
