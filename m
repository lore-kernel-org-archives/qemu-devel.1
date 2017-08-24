Received: from eggs.gnu.org ([2001:4830:134:3::10]:36602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1dkrsp-0003Uh-Dp
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1dkrsk-00022Q-Bc
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:09:15 -0400
Received: from prv-mh.provo.novell.com ([137.65.248.74]:38435)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <JBeulich@suse.com>) id 1dkrsk-00020y-1x
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:09:10 -0400
Message-Id: <599EEC140200007800173373@prv-mh.provo.novell.com>
Date: Thu, 24 Aug 2017 07:09:08 -0600
From: "Jan Beulich" <JBeulich@suse.com>
References: <20170824121919.78678-1-roger.pau@citrix.com>
	<20170824121919.78678-3-roger.pau@citrix.com>
In-Reply-To: <20170824121919.78678-3-roger.pau@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [PATCH QEMU v2] xen/pt: allow QEMU to request MSI
 unmasking at bind time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roger Pau Monne <roger.pau@citrix.com>
Cc: Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

>>> On 24.08.17 at 14:19, <roger.pau@citrix.com> wrote:
> When a MSI interrupt is bound to a guest using
> xc_domain_update_msi_irq (XEN_DOMCTL_bind_pt_irq) the interrupt is
> left masked by default.
>=20
> This causes problems with guests that first configure interrupts and
> clean the per-entry MSIX table mask bit and afterwards enable MSIX
> globally. In such scenario the Xen internal msixtbl handlers would not
> detect the unmasking of MSIX entries because vectors are not yet
> registered since MSIX is not enabled, and vectors would be left
> masked.
>=20
> Introduce a new flag in the gflags field to signal Xen whether a MSI
> interrupt should be unmasked after being bound.
>=20
> This also requires to track the mask register for MSI interrupts, so
> QEMU can also notify to Xen whether the MSI interrupt should be bound
> masked or unmasked
>=20
> Signed-off-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
> Reported-by: Andreas Kinzler <hfp@posteo.de>

Reviewed-by: Jan Beulich <jbeulich@suse.com>
