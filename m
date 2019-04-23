Received: from eggs.gnu.org ([209.51.188.92]:37009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJ0tg-00051G-Nn
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJ0te-0004MS-Iw
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:16:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hJ0td-0004LI-KN
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:16:02 -0400
References: <20190420073442.7488-1-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e2359b84-622b-d7ad-c9cf-92121934e123@redhat.com>
Date: Tue, 23 Apr 2019 21:15:59 +0200
MIME-Version: 1.0
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/38] tcg vector improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 20.04.19 09:34, Richard Henderson wrote:
> Based-on: tcg-next, which at present is only tcg_gen_extract2.
> 
> The dupm patches have been on list before, with a larger context
> of supporting tcg/ppc.  The rest of the set was written to support
> David's s390 vector patches.  In particular:
> 
> (1) Add vector absolute value.
> (2) Add vector shift by non-constant scalar.
> (3) Add vector shift by vector.
> (4) Add vector select.

Remind me, is this for VECTOR SELECT on s390x where we already added a
vector variant? At least VECTOR SELECT on s390x works on bit, not
element granularity.

> (5) Be more precise in handling target-specific vector expansions.
> 
> And then there's a set of bugs that I encountered while working
> on this across x86, aa64, and ppc hosts.  Tested primarily with
> aa64 as the guest, via RISU.
> 
> 
> r~


-- 

Thanks,

David / dhildenb
