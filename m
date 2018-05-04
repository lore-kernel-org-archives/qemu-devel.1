Received: from eggs.gnu.org ([2001:4830:134:3::10]:54356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fEZn0-0000uX-PQ
	for qemu-devel@nongnu.org; Fri, 04 May 2018 08:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fEZmv-0002DT-Up
	for qemu-devel@nongnu.org; Fri, 04 May 2018 08:26:18 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:37333)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fEZmv-0002BZ-Ms
	for qemu-devel@nongnu.org; Fri, 04 May 2018 08:26:13 -0400
Received: by mail-wr0-x235.google.com with SMTP id c14-v6so20893221wrd.4
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 05:26:13 -0700 (PDT)
References: <20180502154344.10585-1-alex.bennee@linaro.org>
	<20180502154344.10585-3-alex.bennee@linaro.org>
	<CAFEAcA80vTz25WHGKteTU3nxSi2fUHN8dp+z8paNP03conAghQ@mail.gmail.com>
	<9549d686-899d-7b3b-dae3-d3cc22528e50@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <9549d686-899d-7b3b-dae3-d3cc22528e50@linaro.org>
Date: Fri, 04 May 2018 13:26:09 +0100
Message-ID: <87y3gz8v4u.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 05/03/2018 11:17 AM, Peter Maydell wrote:
>> (target/i386 notably does not do this, we should check how
>> SSE and x87 handle NaNs in fp conversions first.)
>
> Hardware does silence NaNs.  I tested that earlier:
>
> https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg03114.html

Does that include SSE? I know the hardware will silence NaN's if the
value is ever pushed into an x87 register (as GCC will do when
spilling/filling float).

>
>
> r~


--
Alex Benn=C3=A9e
