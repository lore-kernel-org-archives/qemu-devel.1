Received: from eggs.gnu.org ([2001:4830:134:3::10]:52147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eI7o6-0006qq-Uz
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 01:49:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eI7o4-0004QU-3s
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 01:49:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eI7o3-0004Pk-Tx
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 01:49:48 -0500
Date: Fri, 24 Nov 2017 14:49:42 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171124064942.GB10471@xz-mi>
References: <20171123092333.16085-1-peterx@redhat.com>
	<20171123092333.16085-2-peterx@redhat.com>
	<0be0e8b5-c697-3cd4-45ea-e53c28047bb0@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0be0e8b5-c697-3cd4-45ea-e53c28047bb0@ozlabs.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] pci: Initialize pci_dev->name before
 use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>

On Fri, Nov 24, 2017 at 11:16:53AM +1100, Alexey Kardashevskiy wrote:
> On 23/11/17 20:23, Peter Xu wrote:
> > From: Alexey Kardashevskiy <aik@ozlabs.ru>
> >=20
> > This moves pci_dev->name initialization earlier so
> > pci_dev->bus_master_as could get a name instead of an empty string.
> >=20
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
>=20
>=20
> It is in upstream:
>=20
> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dd06bce95ff8c6e2f2=
90db150695f826c3d57324f

Again, I thought I was using a relatively new tree but I was not...  Than=
ks,

--=20
Peter Xu
