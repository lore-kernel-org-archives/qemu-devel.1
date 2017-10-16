Received: from eggs.gnu.org ([2001:4830:134:3::10]:52169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e3zle-0000UP-Q9
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 03:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e3zlb-0007dv-Mo
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 03:24:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1e3zlb-0007dV-GZ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 03:24:51 -0400
References: <20170927170027.8539-1-david@redhat.com>
	<20170927170027.8539-2-david@redhat.com>
	<30b6f3a1-bfeb-6172-5233-2f7d444399fc@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a1f27655-5a3b-0e1f-cca3-12c09b7cbe51@redhat.com>
Date: Mon, 16 Oct 2017 09:24:47 +0200
MIME-Version: 1.0
In-Reply-To: <30b6f3a1-bfeb-6172-5233-2f7d444399fc@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/3] accel/tcg: allow to invalidate a
 write TLB entry immediately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>

On 27.09.2017 19:48, Richard Henderson wrote:
> On 09/27/2017 10:00 AM, David Hildenbrand wrote:
>> Background: s390x implements Low-Address Protection (LAP). If LAP is
>> enabled, writing to effective addresses (before any transaltion)
>> 0-511 and 4096-4607 triggers a protection exception.
>>
>> So we have subpage protection on the first two pages of every address
>> space (where the lowcore - the CPU private data resides).
>>
>> By immediately invalidating the write entry but allowing the caller to
>> continue, we force every write access onto these first two pages into
>> the slow path. we will get a tlb fault with the specific accessed
>> addresses and can then evaluate if protection applies or not.
>>
>> We have to make sure to ignore the invalid bit if tlb_fill() succeeds.
> 
> This is similar to a scheme I proposed to PMM wrt handling ARM v8M translation.
>  Reusing TLB_INVALID_MASK would appear to work, but I wonder if it wouldn't be
> clearer to use another bit.  I believe I had proposed a TLB_FORCE_SLOW_MASK.
> 
> Thoughts, Peter?

As two weeks have passed:

Any further opinions? Richard, how do you want me to continue with this?

Thanks!

-- 

Thanks,

David
