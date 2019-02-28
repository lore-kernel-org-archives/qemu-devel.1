Received: from eggs.gnu.org ([209.51.188.92]:48848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzG3W-0005In-Lq
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 02:24:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzG3V-0001vl-PQ
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 02:24:34 -0500
References: <20190226113915.20150-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c72e5b25-505f-02a2-be51-dafd449620d3@redhat.com>
Date: Thu, 28 Feb 2019 08:24:30 +0100
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 00/33] s390x/tcg: Vector Instruction
 Support Part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>

On 26.02.19 12:38, David Hildenbrand wrote:
> This is the first part of vector instruction support for s390x. Parts
> will be sent and reviewed piece by piece.
> 
> Part 1: Vector Support Instructions
> Part 2: Vector Integer Instructions
> Part 3: Vector String Instructions
> Part 4: Vector Floating-Point Instructions
> 
> The current state can be found at (kept updated):
>     https://github.com/davidhildenbrand/qemu/tree/vx
> It is based on
>     https://github.com/cohuck/qemu/tree/s390-next
> 
> To make use of vector instructions on my branch, make sure to specify
> "-cpu max" for now.
> 
> With the current state I can boot Linux kernel + user space compiled with
> SIMD support. This allows to boot distributions compiled exclusively for
> z13, requiring SIMD support. Also, I have a growing set of tests for
> kvm-unit-tests which I cross-test on a real s390x system.
> 
> In this part, the basic infrastructure and all Vector Support Instructions
> introduced with the "Vector Facility" are added. The Vector Extension
> Facilities are not considered for now.
> 
> We make use of the existing gvec expansion + ool (out-of-line) support.
> This will be heavily used especially for part 2 (Integer Instructions)
> where we can actually reuse quite some existing gvec expansions.
> 

I'll most probably introduce and use something like

#define ES_8    MO_8
#define ES_16   MO_16
#define ES_32   MO_32
#define ES_64   MO_64
#define ES_128  4

That will make handling of ES_128 nicer

-- 

Thanks,

David / dhildenb
