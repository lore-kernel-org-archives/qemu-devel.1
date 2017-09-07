Received: from eggs.gnu.org ([2001:4830:134:3::10]:41670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dpw7d-00085V-IE
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dpw7Z-0007da-1c
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:41:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dpw7Y-0007cp-Rc
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:41:24 -0400
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-2-david@redhat.com>
	<934be1e8-469e-6d54-bcc1-21e12da2e408@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4cb9db9c-7294-abde-92eb-8247ae354d86@redhat.com>
Date: Thu, 7 Sep 2017 14:41:21 +0200
MIME-Version: 1.0
In-Reply-To: <934be1e8-469e-6d54-bcc1-21e12da2e408@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/19] exec, dump, i386, ppc,
 s390x: don't include exec/cpu-all.h explicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

On 07.09.2017 07:46, Thomas Huth wrote:
>>  #include "qemu/cutils.h"
>>  #include "cpu.h"
>> -#include "exec/exec-all.h"
> You should maybe mention exec-all.h in the patch description, too.
> (I think it can be dropped here because it is included by
> translate-all.h already).
> 
> If you tweak the patch description:
> Reviewed-by: Thomas Huth <thuth@redhat.com>

I'll just drop that hunk although it can also be removed.

Yes, this was not included on purpose - these similar names still
confuse me :)

-- 

Thanks,

David
