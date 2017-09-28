Received: from eggs.gnu.org ([2001:4830:134:3::10]:32867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxeB9-0005WE-1K
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 15:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxeB5-00006H-QW
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 15:08:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38667)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxeB5-0008WG-Kp
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 15:08:55 -0400
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-6-david@redhat.com>
	<bcbe99e8-6b1a-6c50-794a-ab2601a9deda@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a94e596f-d543-3260-117a-ee21ac5b9945@redhat.com>
Date: Thu, 28 Sep 2017 21:08:49 +0200
MIME-Version: 1.0
In-Reply-To: <bcbe99e8-6b1a-6c50-794a-ab2601a9deda@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 05/27] s390/tcg: turn INTERRUPT_EXT into
 a mask
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
List-ID: <qemu-devel.nongnu.org>

On 26.09.2017 01:18, Richard Henderson wrote:
> On 09/18/2017 08:59 AM, David Hildenbrand wrote:
>> +    } else if (env->pending_int | INTERRUPT_EXT_FLOATING) {
> 
> Surely & here.
> 

Yes, the code just worked because the next check is a
g_assert_not_reached() :)

Thanks!

> Otherwise,
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 


-- 

Thanks,

David
