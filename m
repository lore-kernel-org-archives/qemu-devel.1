Received: from eggs.gnu.org ([2001:4830:134:3::10]:43263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dpwCs-0001oq-4a
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dpwCn-0003Yn-LZ
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:46:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dpwCn-0003Y4-FQ
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:46:49 -0400
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-8-david@redhat.com>
	<3f858041-2cc1-7beb-78bc-d43c3b42b6ab@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <09ff8ae8-3ad2-7dd3-16d9-0528c1ee665a@redhat.com>
Date: Thu, 7 Sep 2017 14:46:44 +0200
MIME-Version: 1.0
In-Reply-To: <3f858041-2cc1-7beb-78bc-d43c3b42b6ab@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/19] s390x: move two function
 declarations to s390-virtio-ccw.h
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


>> +++ b/target/s390x/interrupt.c
>> @@ -15,6 +15,9 @@
>>  #include "exec/exec-all.h"
>>  #include "sysemu/kvm.h"
>>  #include "hw/s390x/ioinst.h"
>> +#if !defined(CONFIG_USER_ONLY)
>> +#include "hw/s390x/s390-virtio-ccw.h"
>> +#endif
>> =20
>>  /* Ensure to exit the TB after this call! */
>>  void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_=
t ilen)
>>
>=20
> If I listen to my gut feeling, I still think we should rather move
> s390_cpu_addr2state() to cpu.c instead. It does not sound as it's reall=
y
> specific to the virtio-ccw machine... Just my 0.02 =E2=82=AC
>=20

I prefer to leave it as is for now, so just a header cleanup. E.g. with
patch 18 we could implement it directly using ms->possible_cpus.

>  Thomas


--=20

Thanks,

David
