Received: from eggs.gnu.org ([2001:4830:134:3::10]:39399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNwuJ-0008LL-MK
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNwuG-0005hZ-Kf
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:52:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dNwuG-0005ga-E5
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:52:00 -0400
References: <20170620123553.16186-1-david@redhat.com>
	<20170620123553.16186-2-david@redhat.com>
	<301234db-ca25-555c-7d87-6a6bce53094e@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0ed8ac19-3e75-9158-8165-20bb9cfb612f@redhat.com>
Date: Thu, 22 Jun 2017 09:51:56 +0200
MIME-Version: 1.0
In-Reply-To: <301234db-ca25-555c-7d87-6a6bce53094e@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/3] target/s390x: Indicate and check
 for local tlb clearing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>

On 20.06.2017 19:25, Richard Henderson wrote:
> On 06/20/2017 05:35 AM, David Hildenbrand wrote:
>> +    if (s390_has_feat(S390_FEAT_LOCAL_TLB_CLEARING) && (m4 & 1)) {
> 
> Surely better to let m4 == 0 without local-tlb-clearing during translate.
> 

Yes, that makes sense!


-- 

Thanks,

David
