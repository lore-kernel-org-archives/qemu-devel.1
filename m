Received: from eggs.gnu.org ([2001:4830:134:3::10]:41661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1diKWk-0002QS-GU
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1diKWf-0005ZJ-IG
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:07:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1diKWf-0005Yu-Bg
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:07:53 -0400
Date: Thu, 17 Aug 2017 15:07:46 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170817150746.54ca6150.cohuck@redhat.com>
In-Reply-To: <42546fae-b442-2061-1b70-9b5603cab21d@redhat.com>
References: <20170817092225.4264-1-david@redhat.com>
	<20170817092225.4264-10-david@redhat.com>
	<f2b025c6-bfd9-2b01-497c-d08f262bd0d5@amsat.org>
	<1cb3a142-be2d-920e-7b9e-f3ea3df0ad52@redhat.com>
	<c38eee58-0e16-1a3f-47f5-550f7cbc943f@redhat.com>
	<42546fae-b442-2061-1b70-9b5603cab21d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 09/10] s390x/kvm: move KVM
 declarations and stubs to separate files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1E?= =?UTF-8?B?YXVkw6k=?= <f4bug@amsat.org>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, Aurelien Jarno <aurelien@aurel32.net>, rth@twiddle.net

On Thu, 17 Aug 2017 15:06:10 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 17.08.2017 14:55, David Hildenbrand wrote:
> > On 17.08.2017 14:35, Thomas Huth wrote: =20
> >> On 17.08.2017 13:40, Philippe Mathieu-Daud=C3=A9 wrote: =20
> >>> On 08/17/2017 06:22 AM, David Hildenbrand wrote: =20
> [...]
> >>>>   feat-src =3D $(SRC_PATH)/target/$(TARGET_BASE_ARCH)/
> >>>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> >>>> index 74d5b35..aeb730c 100644
> >>>> --- a/target/s390x/cpu.h
> >>>> +++ b/target/s390x/cpu.h
> >>>> @@ -41,6 +41,7 @@
> >>>>   #include "exec/cpu-all.h"
> >>>>     #include "fpu/softfloat.h"
> >>>> +#include "kvm_s390x.h" =20
> >>
> >> Do we still need that? cpu.h should theoretically be independent from
> >> kvm now, shouldn't it? And for the .c files, it's likely better to
> >> include kvm_s390x.h directly there if they require it. =20
> >=20
> > It should work if:
> >=20
> > a) we include "sysemu/kvm.h" in hw/s390x/s390-virtio-ccw.c
> > b) we include "target/s390x/kvm_s390x.h" in hw/intc/s390_flic_kvm.c
> > c) we include "kvm_s390x.h" in "internal.h"
> > d) we drop the "KVMState" parameter from kvm_s390_get_memslot_count()
> > (separate patch) =20
>=20
> Ok, that's rather a lot of changes already. Maybe that's rather
> something for a later patch instead, so I'm also fine if you keep in
> #include "kvm_s390x.h" in cpu.h here.

Yup, let's defer it. It's not like that is the last series that will
ever go in.
