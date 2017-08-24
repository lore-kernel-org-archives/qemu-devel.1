Received: from eggs.gnu.org ([2001:4830:134:3::10]:51676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1dkoqI-0000X7-Fn
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1dkoqF-0004fq-A5
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:54:26 -0400
Received: from prv-mh.provo.novell.com ([137.65.248.74]:33865)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <JBeulich@suse.com>) id 1dkoqF-0004fK-3g
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:54:23 -0400
Message-Id: <599EBE6D020000780017310E@prv-mh.provo.novell.com>
Date: Thu, 24 Aug 2017 03:54:21 -0600
From: "Jan Beulich" <JBeulich@suse.com>
References: <20170824094753.77795-1-roger.pau@citrix.com>
	<20170824094753.77795-3-roger.pau@citrix.com>
In-Reply-To: <20170824094753.77795-3-roger.pau@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [PATCH QEMU] xen/pt: allow QEMU to request MSI
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
Cc: Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, hfp@posteo.de

>>> On 24.08.17 at 11:47, <roger.pau@citrix.com> wrote:
> @@ -274,7 +278,7 @@ int xen_pt_msi_update(XenPCIPassthroughState *s)
>  {
>      XenPTMSI *msi =3D s->msi;
>      return msi_msix_update(s, msi_addr64(msi), msi->data, msi->pirq,
> -                           false, 0, &msi->pirq);
> +                           false, 0, &msi->pirq, false);
>  }

I don't think this is correct when the device has mask bits.

Jan
