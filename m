Received: from eggs.gnu.org ([2001:4830:134:3::10]:47895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNI8J-0006kT-Km
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 07:52:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNI8G-00056f-Eq
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 07:52:03 -0500
References: <20171207165355.7559-1-david@redhat.com>
	<20171207165355.7559-3-david@redhat.com>
	<155a4b3e-dea0-ff2f-5e04-43fdd4bcd473@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2292ec5a-1fb8-58c0-3b3e-b749d17b039a@redhat.com>
Date: Fri, 8 Dec 2017 13:51:57 +0100
MIME-Version: 1.0
In-Reply-To: <155a4b3e-dea0-ff2f-5e04-43fdd4bcd473@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 02/10] s390x/tcg: ALSI/ALSGI
 are atomic with interlocked-acccess facility 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 08.12.2017 00:43, Richard Henderson wrote:
> On 12/07/2017 08:53 AM, David Hildenbrand wrote:
>> We can simply reuse our ASI implementation. Only the way CC is
>> calculated differs.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/insn-data.def | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Squash with previous?

Yes, can do that!

> 
> 
> r~
> 


-- 

Thanks,

David / dhildenb
