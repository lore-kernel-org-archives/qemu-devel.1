Received: from eggs.gnu.org ([2001:4830:134:3::10]:42936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cUGSS-0000Jv-7o
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:25:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cUGSO-0007m2-Cf
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:25:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cUGSO-0007ln-60
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:25:04 -0500
References: <1482303148-22059-1-git-send-email-liang.z.li@intel.com>
	<2a32f616-25a8-ba5a-f74c-d619fc8ab333@redhat.com>
	<20170118173139-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b11c5cbe-6c63-e9dc-0313-e2dff3830951@redhat.com>
Date: Thu, 19 Jan 2017 18:24:59 +0100
MIME-Version: 1.0
In-Reply-To: <20170118173139-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 kernel 0/5] Extend virtio-balloon for
 fast (de)inflating & fast live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Liang Li <liang.z.li@intel.com>, kvm@vger.kernel.org, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, amit.shah@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, aarcange@redhat.com, dgilbert@redhat.com, quintela@redhat.com


> As long as the interface is similar, it seems to make
> sense for me - why invent a completely new device that
> looks very much like the old one?

The only reason would be that this feature could be used independently
of virtio-balloon. But this would of course only be the case, if
ballooning is strictly not wanted in a configuration, or the current
balloon driver gets replaced by an alternative solution.

I don't have any strong feelings about this, just wanted to double check.

Thanks,

David

> 
> So this boils down to whether the speedup patches are merged.
> 
> 
>> -- 
>>
>> David
