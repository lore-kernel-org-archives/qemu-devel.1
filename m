Received: from eggs.gnu.org ([209.51.188.92]:41519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyGNU-00020b-CU
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 08:33:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyGNL-0006I0-DH
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 08:33:00 -0500
References: <20190225115552.7534-1-david@redhat.com>
	<20190225115552.7534-3-david@redhat.com>
	<20190225132101.72a67e3b.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <09ed9b95-122b-0617-53d4-5e3befca9a7f@redhat.com>
Date: Mon, 25 Feb 2019 14:32:35 +0100
MIME-Version: 1.0
In-Reply-To: <20190225132101.72a67e3b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/7] s390x/tcg: Simplify disassembler
 operands initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 25.02.19 13:21, Cornelia Huck wrote:
> On Mon, 25 Feb 2019 12:55:47 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Let's simply initialization to 0.
> 
> "Let's simply zero-initialize the structure." ?

Or "s/simply/simplify/", whatever you prefer.

> 
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/translate.c | 8 +-------
>>  1 file changed, 1 insertion(+), 7 deletions(-)


-- 

Thanks,

David / dhildenb
