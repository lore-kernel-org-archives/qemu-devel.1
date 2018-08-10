Received: from eggs.gnu.org ([2001:4830:134:3::10]:52357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fo78Z-00052F-U4
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fo78V-0000yD-Rw
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:07:27 -0400
References: <20180810030139.25916-1-pavel.zbitskiy@gmail.com>
	<20180810030139.25916-4-pavel.zbitskiy@gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0bc9ea43-6bdb-49de-ce8d-d3a455356a07@redhat.com>
Date: Fri, 10 Aug 2018 15:07:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180810030139.25916-4-pavel.zbitskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] target/s390x: fix CSST decoding and
 runtime alignment check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, richard.henderson@linaro.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On 10.08.2018 05:01, Pavel Zbitskiy wrote:
> CSST is defined as:
> 
>     C(0xc802, CSST,    SSF,   CASS, la1, a2, 0, 0, csst, 0)
> 
> It means that the first parameter is handled by in1_la1().
> in1_la1() fills addr1 field, and not in1.
> 
> Furthermore, when extract32() is used for the alignment check, the
> third parameter should specify the number of trailing bits that must
> be 0. For FC these numbers are:
> 
>     FC=0 (word, 4 bytes):        2
>     FC=1 (double word, 8 bytes): 3
>     FC=2 (quad word, 16 bytes):  4
> 
> For SC these numbers correspond to the size:
> 
>     SC=0: 0
>     SC=1: 1
>     SC=2: 2
>     SC=3: 3
>     SC=4: 4
> 
> Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 

Thanks,

David / dhildenb
