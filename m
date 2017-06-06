Received: from eggs.gnu.org ([2001:4830:134:3::10]:35250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIFZA-00057S-Vd
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIFZ6-0002cC-3A
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:34:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIFZ5-0002c4-TN
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:34:36 -0400
References: <1496404254-17429-1-git-send-email-peterx@redhat.com>
	<1496404254-17429-3-git-send-email-peterx@redhat.com>
	<20170602194523-mutt-send-email-mst@kernel.org>
	<20170605030725.GF4056@pxdev.xzpeter.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f68502e6-875c-0e46-f7cf-127c23513d20@redhat.com>
Date: Tue, 6 Jun 2017 16:34:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170605030725.GF4056@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] exec: simplify
 address_space_get_iotlb_entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>



On 05/06/2017 05:07, Peter Xu wrote:
> I don't sure whether it'll be a good interface for IOTLB. AFAIU at
> least for VT-d, the IOMMU translation is page aligned which is defined
> by spec, so it makes sense that (again at least for VT-d) here we'd
> better just use page_mask/addr_mask.
> 
> That's also how I know about IOMMU in general - I assume it do the
> translations always with page masks (never arbitary length), though
> page size can differ from platfrom to platform, that's why here the
> IOTLB interface used addr_mask, then it works for all platforms. I
> don't know whether I'm 100% correct here though.
> 
> Maybe David/Paolo/... would comment as well?

I would ask David.  There are PowerPC MMUs that allow fast lookup of
arbitrarily-sized windows (not necessarily power of two), so maybe the
IOMMUs can do the same.

Paolo
