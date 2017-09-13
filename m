Received: from eggs.gnu.org ([2001:4830:134:3::10]:44071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ds8s1-00051l-La
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ds8s0-0002hT-HS
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:42:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1ds8s0-0002g9-Ad
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:42:28 -0400
References: <20170913132417.24384-1-david@redhat.com>
	<20170913132417.24384-9-david@redhat.com>
	<fb0909ad-19bb-3a92-27c6-652bf4d32277@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d1c205de-5abe-0848-157a-41d25e16de57@redhat.com>
Date: Wed, 13 Sep 2017 16:42:20 +0200
MIME-Version: 1.0
In-Reply-To: <fb0909ad-19bb-3a92-27c6-652bf4d32277@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 08/22] s390x: move sclp_service_call()
 to sclp.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 13.09.2017 16:29, Thomas Huth wrote:
> On 13.09.2017 15:24, David Hildenbrand wrote:
>> Implemented in sclp.c, so let's move it to the right include file.
>> Fix up one include. Do a forward declaration of struct CPUS390XState to
>> fix the two sclp consoles complaining.
> 
> Is that sentence about the forward declaration still valid? I did not
> see that anymore here...

Nope, a leftover. Conny, can you fix this up if I don't have to resend?

Thanks!

> 
> Apart from that:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> 


-- 

Thanks,

David
