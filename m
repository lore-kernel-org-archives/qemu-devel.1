Received: from eggs.gnu.org ([2001:4830:134:3::10]:48355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVcOr-0006vY-LS
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVcOm-0005lB-Qe
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:35:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dVcOm-0005kp-Kh
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:35:12 -0400
References: <1499765477-10541-1-git-send-email-thuth@redhat.com>
	<20170711185511.3033-1-f4bug@amsat.org>
	<db1350c0-192f-ab32-250a-2fd234ebe68e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4a1e2715-7811-c4ed-d76b-d49471eabafd@redhat.com>
Date: Thu, 13 Jul 2017 13:35:01 +0200
MIME-Version: 1.0
In-Reply-To: <db1350c0-192f-ab32-250a-2fd234ebe68e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg: move atomic_template.h to accel/tcg/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On 12/07/2017 07:52, Thomas Huth wrote:
> On 11.07.2017 20:55, Philippe Mathieu-Daud=C3=A9 wrote:
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> same as Thomas previous patch. this file had no entry in MAINTAINERS.
>>
>>  atomic_template.h =3D> accel/tcg/atomic_template.h | 0
>>  1 file changed, 0 insertions(+), 0 deletions(-)
>>  rename atomic_template.h =3D> accel/tcg/atomic_template.h (100%)
>>
>> diff --git a/atomic_template.h b/accel/tcg/atomic_template.h
>> similarity index 100%
>> rename from atomic_template.h
>> rename to accel/tcg/atomic_template.h
>=20
> It's also used by a file in tcg/, but I've checked, and yes, the code
> still compiles fine if the header gets moved to accel/tcg/.
>=20
> Tested-by: Thomas Huth <thuth@redhat.com>
>=20

That part of tcg/tcg-runtime.c probably should be moved to user-exec.c,
and user-exec.c should in turn be in accel/tcg.

Since this is just code movement we can do it after soft freeze.
Philippe, can you send v2?

Thanks,

Paolo
