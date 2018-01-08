Received: from eggs.gnu.org ([2001:4830:134:3::10]:35011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYbIS-0002pl-6r
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:33:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYbIR-00050u-D4
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:33:16 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:32998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYbIR-00050A-62
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:33:15 -0500
Received: by mail-oi0-x241.google.com with SMTP id y141so1483702oia.0
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:33:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180108172904.8772-11-f4bug@amsat.org>
References: <20180108172904.8772-1-f4bug@amsat.org>
	<20180108172904.8772-11-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 17:32:54 +0000
Message-ID: <CAFEAcA_g7A6BN1qFc0REbjjNPmFCAEp-ReqfWEU1PtF9pURkdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/12] configure: disable unaligned access
 warning on x86 arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 8 January 2018 at 17:29, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  configure | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

This doesn't seem like the right approach to me. We
want this sort of thing to be a warning/error on x86,
because that's the host that everybody actually uses
to develop with. If they only show up on non-x86
hosts then the result will be a lot more bounced
pull requests because of only-non-x86 warnings.

thanks
-- PMM
