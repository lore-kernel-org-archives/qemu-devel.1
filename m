Received: from eggs.gnu.org ([2001:4830:134:3::10]:46527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eYbbl-0007pS-LG
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:53:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eYbbk-0002bM-Pc
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:53:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eYbbk-0002ah-JV
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:53:12 -0500
Date: Mon, 8 Jan 2018 19:53:06 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180108195134-mutt-send-email-mst@kernel.org>
References: <20180108172904.8772-1-f4bug@amsat.org>
	<20180108172904.8772-11-f4bug@amsat.org>
	<CAFEAcA_g7A6BN1qFc0REbjjNPmFCAEp-ReqfWEU1PtF9pURkdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA_g7A6BN1qFc0REbjjNPmFCAEp-ReqfWEU1PtF9pURkdQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Jan 08, 2018 at 05:32:54PM +0000, Peter Maydell wrote:
> On 8 January 2018 at 17:29, Philippe Mathieu-Daud=E9 <f4bug@amsat.org> =
wrote:
> > Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > ---
> >  configure | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
>=20
> This doesn't seem like the right approach to me. We
> want this sort of thing to be a warning/error on x86,
> because that's the host that everybody actually uses
> to develop with. If they only show up on non-x86
> hosts then the result will be a lot more bounced
> pull requests because of only-non-x86 warnings.
>=20
> thanks
> -- PMM

And we can't be sure the compiler won't be doing something tricky by
assuming alignment in the future.

--=20
MST
