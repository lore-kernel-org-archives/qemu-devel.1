Received: from eggs.gnu.org ([2001:4830:134:3::10]:50441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dx6vH-0006G4-Hj
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dx6vD-0008Pm-Ug
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:38:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dx6vD-0008Ou-M7
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:38:19 -0400
References: <20170926183318.12995-1-david@redhat.com>
	<a0e0add6-d9d6-2b9a-a875-00e1883db150@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8b408306-1d36-7524-30aa-22aaa0a0eba4@redhat.com>
Date: Wed, 27 Sep 2017 09:38:10 +0200
MIME-Version: 1.0
In-Reply-To: <a0e0add6-d9d6-2b9a-a875-00e1883db150@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/6] s390x/tcg: fix some accesses using
 low address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>

On 27.09.2017 01:10, Richard Henderson wrote:
> On 09/26/2017 11:33 AM, David Hildenbrand wrote:
>> David Hildenbrand (6):
>>   s390x/tcg: fix checking for invalid memory check
>>   s390x/tcg: add MMU for real addresses
>>   s390x/tcg: make lura(g) use the new _real mmu.
>>   s390x/tcg: make stora(g) use the new _real mmu
>>   s390x/tcg: make testblock use the new _real mmu
>>   s390x/tcg: make idte/ipte use the new _real mmu
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Watch out for a couple of blank lines left over while deleting stuff.

Yes, the HELPER(lura) hunk in the third patch has a superfluous empty
line now. Apart from that, the series also looks good to me:

Reviewed-by: Thomas Huth <thuth@redhat.com>
