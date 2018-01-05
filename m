Received: from eggs.gnu.org ([2001:4830:134:3::10]:36165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eXRgj-0002Rc-V0
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 08:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eXRgg-0006AM-Mm
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 08:05:33 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eXRgg-00069x-FY
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 08:05:30 -0500
Received: by mail-wr0-x241.google.com with SMTP id p6so4310505wrd.0
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 05:05:30 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-7-alex.bennee@linaro.org>
	<1524831e-0651-5c64-76b4-7d2ef7c8fb9f@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1524831e-0651-5c64-76b4-7d2ef7c8fb9f@linaro.org>
Date: Fri, 05 Jan 2018 13:05:27 +0000
Message-ID: <87k1wwcv6w.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 06/19] fpu/softfloat: propagate
 signalling NaNs in MINMAX
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
>> While a comparison between a QNaN and a number will return the number
>> it is not the same with a signaling NaN. In this case the SNaN will
>> "win" and after potentially raising an exception it will be quietened.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> ---
>> v2
>>   - added return for propageFloat
>> ---
>>  fpu/softfloat.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> I suppose this fixes minmax for float128 too,
> and is thus not redundant with patch 18?

It was never expanded so I guess no one does float128 minmax's at the momen=
t.

>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~


--
Alex Benn=C3=A9e
