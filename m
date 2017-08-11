Received: from eggs.gnu.org ([2001:4830:134:3::10]:45462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dg9sy-0001mA-Ik
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dg9st-0005gw-P7
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:21:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24039)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dg9st-0005fw-He
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:21:51 -0400
References: <20170811074652.31474-1-david@redhat.com>
	<20170811074652.31474-2-david@redhat.com>
	<bba66a1f-9f66-fd07-a04b-ac61c94b9f37@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <55e181ea-7715-71fa-7720-33d2a8767b20@redhat.com>
Date: Fri, 11 Aug 2017 15:21:44 +0200
MIME-Version: 1.0
In-Reply-To: <bba66a1f-9f66-fd07-a04b-ac61c94b9f37@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/5] target/s390x: introduce internal.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com

On 11.08.2017 15:15, Richard Henderson wrote:
> On 08/11/2017 12:46 AM, David Hildenbrand wrote:
>> +
>> +static const char *cc_names[] = {
>> +    [CC_OP_CONST0]    = "CC_OP_CONST0",
> 
> This should get moved out of the header to the c file that uses it.
> (Why it's ever there in the first place is a mystery...)
> 
> Otherwise,
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 

Thanks, I'll add a separate patch for that then!

-- 

Thanks,

David
