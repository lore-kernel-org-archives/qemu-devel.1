Received: from eggs.gnu.org ([2001:4830:134:3::10]:47954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEcl1-0000D3-Eu
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEcky-0007VC-B7
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:36:27 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:43233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fEcky-0007UT-5m
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:36:24 -0400
Received: by mail-pf0-x242.google.com with SMTP id j20so3404441pff.10
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 08:36:24 -0700 (PDT)
References: <20180502154344.10585-1-alex.bennee@linaro.org>
	<20180502154344.10585-3-alex.bennee@linaro.org>
	<CAFEAcA80vTz25WHGKteTU3nxSi2fUHN8dp+z8paNP03conAghQ@mail.gmail.com>
	<9549d686-899d-7b3b-dae3-d3cc22528e50@linaro.org>
	<87y3gz8v4u.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a65d185a-1cb8-727d-1f44-5b3a1cd910a6@linaro.org>
Date: Fri, 4 May 2018 08:36:20 -0700
MIME-Version: 1.0
In-Reply-To: <87y3gz8v4u.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] fpu/softfloat: support ARM
 Alternative half-precision
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 05/04/2018 05:26 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 05/03/2018 11:17 AM, Peter Maydell wrote:
>>> (target/i386 notably does not do this, we should check how
>>> SSE and x87 handle NaNs in fp conversions first.)
>>
>> Hardware does silence NaNs.  I tested that earlier:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg03114.html
> 
> Does that include SSE?

Yes.

> I know the hardware will silence NaN's if the
> value is ever pushed into an x87 register (as GCC will do when
> spilling/filling float).

Actually, loads and stores are purely bit operations that do not modify data.


r~
