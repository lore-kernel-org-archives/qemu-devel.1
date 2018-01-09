Received: from eggs.gnu.org ([2001:4830:134:3::10]:44267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eZ1Ts-0001Xu-9O
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 16:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eZ1Tn-0002Ma-Cr
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 16:30:48 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:34162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eZ1Tn-0002Kq-6f
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 16:30:43 -0500
Date: Tue, 9 Jan 2018 22:30:25 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180109213025.57kz45zed52nvyje@var.youpi.perso.aquilenet.fr>
References: <20180108172904.8772-1-f4bug@amsat.org>
	<20180108172904.8772-13-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180108172904.8772-13-f4bug@amsat.org>
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9, on lun. 08 janv. 2018 14:29:04 -0300, wrote:
> Access struct in6_addr with 'void *', then cast to 'u8 *' to avoid alig=
nment
> issues.

Err, I don't understand the point. in6_addr's s6_addr is already a
uint8_t by the standard.  There is no non-byte access in the existing
code.

Samuel
