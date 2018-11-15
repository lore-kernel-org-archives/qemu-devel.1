Received: from eggs.gnu.org ([2001:4830:134:3::10]:35068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNPbD-0007rg-EO
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 16:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNPbA-0003Wl-3G
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 16:54:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gNPb9-0003TA-PA
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 16:54:52 -0500
References: <20181115140501.7872-1-david@redhat.com>
	<20181115140501.7872-4-david@redhat.com>
	<87a7mab832.fsf@dusky.pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fa91c795-bd1d-dde0-9137-307f203aeaa2@redhat.com>
Date: Thu, 15 Nov 2018 22:54:44 +0100
MIME-Version: 1.0
In-Reply-To: <87a7mab832.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/9] qapi: use qemu_strtod_finite() in
 string-input-visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 15.11.18 17:48, Markus Armbruster wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> Let's use the new function. "NaN" and "inf" are now properly rejected.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Whether this is a bug fix or just a change is debatable.  But the commit
> message's title should highlight the change.  Perhaps you want to steal
> from the one I suggested for the previous patch.

Yes, will copy+modify that one.

> 
> We need to assess backward compatibility impact.  I can do that.
Thanks! I assume this shouldn't be an issue.

-- 

Thanks,

David / dhildenb
