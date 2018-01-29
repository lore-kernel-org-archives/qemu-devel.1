Received: from eggs.gnu.org ([2001:4830:134:3::10]:39208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eg85j-00027s-KT
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:59:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eg85a-000873-3o
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:59:15 -0500
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:46429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eg85Z-00085W-SN
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:59:06 -0500
Received: by mail-wr0-x22d.google.com with SMTP id g21so6872550wrb.13
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 03:59:05 -0800 (PST)
References: <20180124131315.30567-1-alex.bennee@linaro.org>
	<20180124131315.30567-20-alex.bennee@linaro.org>
	<57ab078a-049b-72e7-5bc5-f73a3c947b45@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <57ab078a-049b-72e7-5bc5-f73a3c947b45@linaro.org>
Date: Mon, 29 Jan 2018 11:59:03 +0000
Message-ID: <87vafkyiyg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 19/22] fpu/softfloat: re-factor scalbn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 01/24/2018 05:13 AM, Alex Benn=C3=A9e wrote:
>> +/* Multiply A by 2 raised to the power N.  */
>> +static FloatParts scalbn_decomposed(FloatParts a, int n,
>> +                                          float_status *s)
>> +{
>> +    if (a.cls =3D=3D float_class_normal) {
>> +        a.exp +=3D n;
>> +    }
>> +    return a;
>> +}
>
> ...
>
>> -    if ( aExp =3D=3D 0x7FF ) {
>> -        if ( aSig ) {
>> -            return propagateFloat64NaN(a, a, status);
>
> This is where we used to raise inexact.
> In the new function we need to handle this as in round_to_int.

Why is the handling in round_canonical not good enough for this?

--
Alex Benn=C3=A9e
