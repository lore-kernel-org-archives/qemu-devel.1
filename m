Received: from eggs.gnu.org ([2001:4830:134:3::10]:54335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e3kuS-00026R-HD
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 11:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e3kuP-0004d2-DC
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 11:33:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e3kuP-0004cQ-8A
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 11:32:57 -0400
References: <20171013054842.32120-1-sw@weilnetz.de>
	<dacdf7e7-0b16-99a0-ab50-ea7a458e0ec6@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4028eece-c9ff-113a-3cab-1a95c9ce79cc@redhat.com>
Date: Sun, 15 Oct 2017 17:32:49 +0200
MIME-Version: 1.0
In-Reply-To: <dacdf7e7-0b16-99a0-ab50-ea7a458e0ec6@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] oslib-posix: Fix compiler warning and
 some data types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Stefan Weil <sw@weilnetz.de>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On 14/10/2017 18:53, Philippe Mathieu-Daud=C3=A9 wrote:
>> @@ -328,7 +328,7 @@ static void *do_touch_pages(void *arg)
>>               * don't need to write at all so we don't cause
>>               * wear on the storage backing the region...
>>               */
>> -            *(volatile char *)addr =3D *addr;
>> +            *addr =3D *addr;
> I personally prefer the other form which is mostly self-explicit when
> reviewing this code.
>=20
> Declaring addr non volatile and using volatile cast here:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20

I agree with Philippe; in genereal, volatile is more of a property of
the access rather than the variable.

Paolo
