Received: from eggs.gnu.org ([2001:4830:134:3::10]:48990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1e1nGB-0000Oq-1e
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 01:39:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1e1nG7-0002Bh-VC
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 01:39:19 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:55702
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1e1nG7-0002BR-Oj
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 01:39:15 -0400
References: <20171007155522.25436-1-sw@weilnetz.de>
	<bfac5ec4-885e-7531-2d00-ce48bf518a6d@linaro.org>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <c01459d1-81f4-8af3-4e52-f7703ff389ea@weilnetz.de>
Date: Tue, 10 Oct 2017 07:39:13 +0200
MIME-Version: 1.0
In-Reply-To: <bfac5ec4-885e-7531-2d00-ce48bf518a6d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Fix compiler warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 09.10.2017 um 23:58 schrieb Richard Henderson:
> On 10/07/2017 08:55 AM, Stefan Weil wrote:
>> +        char *addr =3D memset_args->addr;
>> +        uint64_t numpages =3D memset_args->numpages;
>> +        uint64_t hpagesize =3D memset_args->hpagesize;
>> +        unsigned i;
>=20
> Match numpages properly while you're at it?
>=20
>=20
> r~

Do you mean using uint64_t for the loop variable i?

Sure. I only hesitated to do that because it is so huge.
A 64 bit loop variable looks strange, and the loop would
take some time if it really uses that range. :-)
Feel free to change that if you apply the patch.

Or did you think of using size_t for numpages?
The current code uses both size_t and uint64_t
which could be cleaned as well, maybe even replacing
both by uint32_t (or do we expect more pages?).

Stefan
