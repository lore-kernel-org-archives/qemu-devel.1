Received: from eggs.gnu.org ([2001:4830:134:3::10]:48494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1djtKT-0007z8-6x
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 16:29:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1djtKO-0004Ax-9b
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 16:29:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1djtKO-00048E-3v
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 16:29:40 -0400
Date: Mon, 21 Aug 2017 13:29:36 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <d11787d1-dc57-1f22-86cc-9da639fd28af@intel.com>
Message-ID: <alpine.DEB.2.10.1708211327330.12143@sstabellini-ThinkPad-X260>
References: <1502311882-11038-1-git-send-email-tianyu.lan@intel.com>
	<1502311882-11038-3-git-send-email-tianyu.lan@intel.com>
	<20170811180438.GI1519@perard.uk.xensource.com>
	<d11787d1-dc57-1f22-86cc-9da639fd28af@intel.com>
MIME-Version: 1.0
Content-ID: <alpine.DEB.2.10.1708211327480.12143@sstabellini-ThinkPad-X260>
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2 2/3] xen-pt: bind/unbind interrupt
 remapping format MSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Chao Gao <chao.gao@intel.com>, sstabellini@kernel.org, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, marcel@redhat.com, kevin.tian@intel.com

On Tue, 15 Aug 2017, Lan Tianyu wrote:
> Hi Anthony:
>=20
> On 2017=E5=B9=B408=E6=9C=8812=E6=97=A5 02:04, Anthony PERARD wrote:
> > On Wed, Aug 09, 2017 at 04:51:21PM -0400, Lan Tianyu wrote:
> >> From: Chao Gao <chao.gao@intel.com>
> >>
> >> If a vIOMMU is exposed to guest, guest will configure the msi to rem=
apping
> >> format. The original code isn't suitable to the new format. A new pa=
ir
> >> bind/unbind interfaces are added for this usage. This patch recogniz=
es
> >> this case and uses new interfaces to bind/unbind msi.
> >>
> >> Signed-off-by: Chao Gao <chao.gao@intel.com>
> >> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> >=20
> > Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
> >=20
> > That patch series can be applied once the Xen side patches are merged=
.
> >=20
>=20
> Great. Thanks for your review.

Lan,

Could you please add a reference to the Xen side patch series in the
description of this patch? That way, it is easier to check what is the
dependecy. In fact, it would be even better to add a reference to the
commit id, once the patches are committed to xen.git.

Thanks,

Stefano
