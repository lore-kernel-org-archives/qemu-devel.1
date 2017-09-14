Received: from eggs.gnu.org ([2001:4830:134:3::10]:54138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dsSVd-0006qd-58
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dsSVY-0001hO-OP
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:40:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dsSVY-0001fo-J7
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:40:36 -0400
References: <20170913221149.30382-1-f4bug@amsat.org>
	<2acadeb5-41e1-ce09-6e3b-37001dd57042@weilnetz.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e9714f5a-b328-8f6c-6cca-725f0851bc66@redhat.com>
Date: Thu, 14 Sep 2017 13:40:31 +0200
MIME-Version: 1.0
In-Reply-To: <2acadeb5-41e1-ce09-6e3b-37001dd57042@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] accel/hax: move hax-stub.c to accel/stubs/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Jiang Yunhong <yunhong.jiang@intel.com>, Vincent Palatin <vpalatin@chromium.org>
Cc: qemu-devel@nongnu.org

On 14/09/2017 05:30, Stefan Weil wrote:
> Am 14.09.2017 um 00:11 schrieb Philippe Mathieu-Daud=C3=A9:
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  Makefile.target                      | 1 -
>>  hax-stub.c =3D> accel/stubs/hax-stub.c | 0
>>  accel/stubs/Makefile.objs            | 1 +
>>  3 files changed, 1 insertion(+), 1 deletion(-)
>>  rename hax-stub.c =3D> accel/stubs/hax-stub.c (100%)
>>
>> diff --git a/Makefile.target b/Makefile.target
>> index 6361f957fb..af4b60d012 100644
>> --- a/Makefile.target
>> +++ b/Makefile.target
>> @@ -101,7 +101,6 @@ obj-y +=3D fpu/softfloat.o
>>  obj-y +=3D target/$(TARGET_BASE_ARCH)/
>>  obj-y +=3D disas.o
>>  obj-$(call notempty,$(TARGET_XML_FILES)) +=3D gdbstub-xml.o
>> -obj-$(call lnot,$(CONFIG_HAX)) +=3D hax-stub.o
>> =20
>>  obj-$(CONFIG_LIBDECNUMBER) +=3D libdecnumber/decContext.o
>>  obj-$(CONFIG_LIBDECNUMBER) +=3D libdecnumber/decNumber.o
>> diff --git a/hax-stub.c b/accel/stubs/hax-stub.c
>> similarity index 100%
>> rename from hax-stub.c
>> rename to accel/stubs/hax-stub.c
>> diff --git a/accel/stubs/Makefile.objs b/accel/stubs/Makefile.objs
>> index fdfbf7332c..8038ad6553 100644
>> --- a/accel/stubs/Makefile.objs
>> +++ b/accel/stubs/Makefile.objs
>> @@ -1,2 +1,3 @@
>>  obj-$(call lnot,$(CONFIG_KVM)) +=3D kvm-stub.o
>>  obj-$(call lnot,$(CONFIG_TCG)) +=3D tcg-stub.o
>> +obj-$(call lnot,$(CONFIG_HAX)) +=3D hax-stub.o
>=20
> Reviewed-by: Stefan Weil <sw@weilnetz.de>
>=20
> Personally, I like alphabetic order for such lines.
> Maybe that can be done when it is applied.

Done and queued, thanks both.

Paolo
