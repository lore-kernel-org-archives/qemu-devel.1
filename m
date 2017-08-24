Received: from eggs.gnu.org ([2001:4830:134:3::10]:55357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1dkp9H-0006ao-4u
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1dkp9E-0004jl-0P
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:14:03 -0400
Received: from prv-mh.provo.novell.com ([137.65.248.74]:48447)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <JBeulich@suse.com>) id 1dkp9D-0004jd-NS
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:13:59 -0400
Message-Id: <599EC30602000078001731A4@prv-mh.provo.novell.com>
Date: Thu, 24 Aug 2017 04:13:58 -0600
From: "Jan Beulich" <JBeulich@suse.com>
References: <20170824094753.77795-1-roger.pau@citrix.com>
	<20170824094753.77795-3-roger.pau@citrix.com>
	<599EBE6D020000780017310E@prv-mh.provo.novell.com>
	<20170824100653.mqilcui6mmcqy7io@dhcp-3-128.uk.xensource.com>
In-Reply-To: <20170824100653.mqilcui6mmcqy7io@dhcp-3-128.uk.xensource.com>
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

>>> On 24.08.17 at 12:06, <roger.pau@citrix.com> wrote:
> On Thu, Aug 24, 2017 at 03:54:21AM -0600, Jan Beulich wrote:
>> >>> On 24.08.17 at 11:47, <roger.pau@citrix.com> wrote:
>> > @@ -274,7 +278,7 @@ int xen_pt_msi_update(XenPCIPassthroughState *s)
>> >  {
>> >      XenPTMSI *msi =3D s->msi;
>> >      return msi_msix_update(s, msi_addr64(msi), msi->data, msi->pirq,
>> > -                           false, 0, &msi->pirq);
>> > +                           false, 0, &msi->pirq, false);
>> >  }
>>=20
>> I don't think this is correct when the device has mask bits.
>=20
> Right, I thought I modified this. I've already changed
> pt_irq_create_bind so that the original behavior is keep if the unmask
> bit is not set. In this case this should be 'true' in order to keep
> the previous behavior, which was correct for MSI.

Wouldn't you want to pass the state of the mask bit here,
rather than uniformly hard coding true or false?

> It also makes me wonder whether it would be better to change the name
> of the parameter to "unmask", so that false -> no change to mask, true
> -> unconditionally unmask.

I don't care much about this aspect, but perhaps the qemu
maintainers do.

Jan
