Received: from eggs.gnu.org ([2001:4830:134:3::10]:43306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cFBZN-0005Bi-L0
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 22:09:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cFBZK-0005Pn-H0
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 22:09:57 -0500
Received: from mga06.intel.com ([134.134.136.31]:65444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liang.z.li@intel.com>)
	id 1cFBZK-0005OP-52
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 22:09:54 -0500
From: "Li, Liang Z" <liang.z.li@intel.com>
Date: Fri, 9 Dec 2016 03:09:47 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3A14D246@SHSMSX104.ccr.corp.intel.com>
References: <1480495397-23225-1-git-send-email-liang.z.li@intel.com>
	<f67ca79c-ad34-59dd-835f-e7bc9dcaef58@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A130C01@shsmsx102.ccr.corp.intel.com>
	<f7b47cc4-ee94-bacb-5a17-d049b402263e@intel.com>
In-Reply-To: <f7b47cc4-ee94-bacb-5a17-d049b402263e@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH kernel v5 0/5] Extend virtio-balloon for
 fast (de)inflating & fast live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Hansen, Dave" <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mhocko@suse.com" <mhocko@suse.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>

> Subject: Re: [PATCH kernel v5 0/5] Extend virtio-balloon for fast (de)inf=
lating
> & fast live migration
>=20
> On 12/07/2016 05:35 AM, Li, Liang Z wrote:
> >> Am 30.11.2016 um 09:43 schrieb Liang Li:
> >> IOW in real examples, do we have really large consecutive areas or
> >> are all pages just completely distributed over our memory?
> >
> > The buddy system of Linux kernel memory management shows there
> should
> > be quite a lot of consecutive pages as long as there are a portion of
> > free memory in the guest.
> ...
> > If all pages just completely distributed over our memory, it means the
> > memory fragmentation is very serious, the kernel has the mechanism to
> > avoid this happened.
>=20
> While it is correct that the kernel has anti-fragmentation mechanisms, I =
don't
> think it invalidates the question as to whether a bitmap would be too spa=
rse
> to be effective.
>=20
> > In the other hand, the inflating should not happen at this time
> > because the guest is almost 'out of memory'.
>=20
> I don't think this is correct.  Most systems try to run with relatively l=
ittle free
> memory all the time, using the bulk of it as page cache.  We have no reas=
on
> to expect that ballooning will only occur when there is lots of actual fr=
ee
> memory and that it will not occur when that same memory is in use as page
> cache.
>=20

Yes.
> In these patches, you're effectively still sending pfns.  You're just sen=
ding
> one pfn per high-order page which is giving a really nice speedup.  IMNHO=
,
> you're avoiding doing a real bitmap because creating a bitmap means eithe=
r
> have a really big bitmap, or you would have to do some sorting (or multip=
le
> passes) of the free lists before populating a smaller bitmap.
>=20
> Like David, I would still like to see some data on whether the choice bet=
ween
> bitmaps and pfn lists is ever clearly in favor of bitmaps.  You haven't
> convinced me, at least, that the data isn't even worth collecting.

I will try to get some data with the real workload and share it with your g=
uys.

Thanks!
Liang
