Received: from eggsout.gnu.org ([209.51.188.92]:52027 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gfXsP-0001O2-Ve
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 17:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gfXjs-0005zv-3y
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 17:14:51 -0500
Received: from mail-it1-x12d.google.com ([2607:f8b0:4864:20::12d]:40297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gfXjr-0005ym-5W
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 17:14:47 -0500
Received: by mail-it1-x12d.google.com with SMTP id h193so3388510ita.5
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 14:14:45 -0800 (PST)
References: <CAObpvQ=1dw4pTX3aiDvOvgnAkZQ0d9svMaL4Bwz55nkE8i4yrQ@mail.gmail.com>
	<945511ac-d99a-d483-12a2-e6ad4dda09c2@linaro.org>
	<CAObpvQktCHp-9V40z7kDaTU2CwRWSq8ZVS1PxRg3WK01TFXCzQ@mail.gmail.com>
	<b4cdc06a-8114-48d2-2c0a-9fea876fee4a@linaro.org>
	<CAObpvQmejWBh+RNz2vhk16-kcY_QveM_pSmM5ZeWqWv1d8AJzQ@mail.gmail.com>
	<aeeb8c50-0293-e37b-9f9f-5d392b7e10f6@linaro.org>
	<CAObpvQkjXLmXjB61w0Ecu8QfbA4+qBxLUVMjnDUD4dchOp+duA@mail.gmail.com>
	<38b906b7-56a6-a0dc-95f3-365452b59099@linaro.org>
	<CAObpvQmJzCQZzW4pL02KD7HntnTbn9JWUE9eLi5J-6md3_b0yA@mail.gmail.com>
	<dede13a1-d512-1b70-b863-0b71a7e52c30@linaro.org>
	<CAObpvQ=uzvxqFxD0AC=F6kcAysqwAdLwvwUWEGqWGa3mWgVQmQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <85031ff4-cc90-32f7-1ec4-e342a5d52f34@linaro.org>
Date: Sat, 5 Jan 2019 08:14:37 +1000
MIME-Version: 1.0
In-Reply-To: <CAObpvQ=uzvxqFxD0AC=F6kcAysqwAdLwvwUWEGqWGa3mWgVQmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] AVX support for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nick Renieris <makren67@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1/5/19 8:09 AM, Nick Renieris wrote:
> Στις Παρ, 4 Ιαν 2019 στις 11:51 μ.μ., ο/η Richard Henderson
> <richard.henderson@linaro.org> έγραψε:
>> As an integer it is always passed by value.  As a structure some host abis pass
>> it by reference, and the TCG compiler doesn't know about that.
> 
> Ah so they modify it? If so it could surely be worked around with
> explicit stack copies, right?

No, it's just calling conventions.  And it could be worked around, but I think
what we have is convenient enough.

Especially since the sizes are encoded as (n+1)*8, which also shows the
compiler that the size is positive, so the for loop must iterate at least once.


r~
