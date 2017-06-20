Received: from eggs.gnu.org ([2001:4830:134:3::10]:56097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNOPl-0004Ft-FG
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 15:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNOPi-0004Qh-8F
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 15:02:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dNOPi-0004P5-2D
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 15:02:10 -0400
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
	<b92af473-f00e-b956-ea97-eb4626601789@intel.com>
	<1497977049.20270.100.camel@redhat.com>
	<7b626551-6d1b-c8d5-4ef7-e357399e78dc@redhat.com>
	<20170620211445-mutt-send-email-mst@kernel.org>
	<f46768db-dcda-aa40-64b9-eb2929249db8@redhat.com>
	<20170620215552-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <338ec5ce-759b-6381-0442-ac0741f159b8@redhat.com>
Date: Tue, 20 Jun 2017 21:01:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170620215552-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 4/6] mm: function to offer a page block
 on the free list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, Nitesh Narayan Lal <nilal@redhat.com>


>> IMHO even simply writing all-zeros to all free pages before starting
>> migration (or even when freeing a page) would be a cleaner interface
>> than this (because it atomically works with the entity the host cares
>> about for migration). But yes, performance is horrible that's why I am
>> not even suggesting it. Just saying that this mm interface is very very
>> special and if we could find something better, I'd favor it.
> 
> As long as there's a single user, changing to a better interface
> once it's found won't be hard at all :)
> 

Hehe, more like "we made this beautiful virtio-balloon extension" - oh
there is free page hinting (assuming that it does not reuse the batch
interface here). Guess how long it would take to at least show that free
page hinting can be done. If it takes another 6 years, I am totally on
your side ;)

-- 

Thanks,

David
