Received: from eggs.gnu.org ([2001:4830:134:3::10]:53197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1e4567-0000aI-Hc
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:06:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1e4562-0004kb-0o
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:06:23 -0400
Received: from jessie.kos.to ([212.47.231.226]:52512 helo=pilvi.kos.to)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <voipio@kos.to>) id 1e4561-0004k2-QX
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:06:17 -0400
Date: Mon, 16 Oct 2017 13:06:16 +0000
From: Riku Voipio <riku.voipio@iki.fi>
Message-ID: <20171016130616.GF1918@kos.to>
References: <1507822245-15748-1-git-send-email-peter.maydell@linaro.org>
	<1507822245-15748-3-git-send-email-peter.maydell@linaro.org>
	<b5d3e2e6-31c0-0496-bfee-3baad5d571f9@vivier.eu>
	<CAFEAcA8nyWgNDA23Cne8dpOMKXmZ98A0kR8K_MSkYt8bF3pZCg@mail.gmail.com>
	<c9e56a17-3c75-cfcf-7709-ee27efc291af@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9e56a17-3c75-cfcf-7709-ee27efc291af@vivier.eu>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] linux-user: Fix
 TARGET_MTIOCTOP/MTIOCGET/MTIOCPOS values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, pgndev <pgnet.dev@gmail.com>

On Thu, Oct 12, 2017 at 07:08:55PM +0200, Laurent Vivier wrote:
> Le 12/10/2017 =C3=A0 18:53, Peter Maydell a =C3=A9crit=C2=A0:
> > On 12 October 2017 at 17:49, Laurent Vivier <laurent@vivier.eu> wrote=
:
> >> Le 12/10/2017 =C3=A0 17:30, Peter Maydell a =C3=A9crit :
> >>> +#if defined(TARGET_SPARC) || defined(TARGET_MIPS)
> >>> +typedef abi_long target_kernel_daddr_t;
> >>> +#else
> >>> +typedef abi_int target_kernel_daddr_t;
> >>> +#endif
> >>
> >> Perhaps you can add these ones into include/exec/user/abitypes.h ?
> >=20
> > I don't think they belong there -- that file is for basic
> > CPU ABI dependent types, not things which are just part of
> > the kernel interface.

> I agree

So we should go with the patch as-is?

Riku
