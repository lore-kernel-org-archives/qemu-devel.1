Received: from eggs.gnu.org ([2001:4830:134:3::10]:43157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eRCMu-0003NK-0i
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 02:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eRCMo-0005oM-W7
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 02:31:16 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:36481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eRCMo-0005nf-Oc
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 02:31:10 -0500
Received: by mail-wm0-x230.google.com with SMTP id b76so1753269wmg.1
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 23:31:10 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-5-alex.bennee@linaro.org>
	<c17e6c00-0a9f-054a-88c4-5868081daccf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <c17e6c00-0a9f-054a-88c4-5868081daccf@linaro.org>
Date: Tue, 19 Dec 2017 07:31:07 +0000
Message-ID: <87d13b6uo4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 04/19] include/fpu/softfloat: implement
 float16_set_sign helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 12/11/2017 04:56 AM, Alex Benn=C3=A9e wrote:
>> +static inline float16 float16_set_sign(float16 a, int sign)
>> +{
>> +    return make_float16((float16_val(a) & 0x7fff) | (sign << 15));
>> +}
>> +
>
> 1) Do we use this anywhere?

Yes in the target specific helpers

>
> 2) While this is probably in line with the other implementations,
> but going to a more qemu-ish style this should use deposit32.

OK, will do.

>
> Anyway,
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~


--
Alex Benn=C3=A9e
