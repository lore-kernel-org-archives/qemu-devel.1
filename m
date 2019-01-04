Received: from [208.118.235.92] (port=59808 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gfXNR-0003Ni-La
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 16:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gfXNI-0005Np-Bg
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 16:51:31 -0500
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a]:38753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gfXNA-0005Hq-JG
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 16:51:22 -0500
Received: by mail-io1-xd2a.google.com with SMTP id l14so30620982ioj.5
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 13:51:17 -0800 (PST)
References: <CAObpvQ=1dw4pTX3aiDvOvgnAkZQ0d9svMaL4Bwz55nkE8i4yrQ@mail.gmail.com>
	<945511ac-d99a-d483-12a2-e6ad4dda09c2@linaro.org>
	<CAObpvQktCHp-9V40z7kDaTU2CwRWSq8ZVS1PxRg3WK01TFXCzQ@mail.gmail.com>
	<b4cdc06a-8114-48d2-2c0a-9fea876fee4a@linaro.org>
	<CAObpvQmejWBh+RNz2vhk16-kcY_QveM_pSmM5ZeWqWv1d8AJzQ@mail.gmail.com>
	<aeeb8c50-0293-e37b-9f9f-5d392b7e10f6@linaro.org>
	<CAObpvQkjXLmXjB61w0Ecu8QfbA4+qBxLUVMjnDUD4dchOp+duA@mail.gmail.com>
	<38b906b7-56a6-a0dc-95f3-365452b59099@linaro.org>
	<CAObpvQmJzCQZzW4pL02KD7HntnTbn9JWUE9eLi5J-6md3_b0yA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dede13a1-d512-1b70-b863-0b71a7e52c30@linaro.org>
Date: Sat, 5 Jan 2019 07:51:09 +1000
MIME-Version: 1.0
In-Reply-To: <CAObpvQmJzCQZzW4pL02KD7HntnTbn9JWUE9eLi5J-6md3_b0yA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 1/5/19 7:43 AM, Nick Renieris wrote:
> Just curious, why is gvec-desc a bitfield instead of a normal struct?
> Surely it'd be more readable that way. Also this is C, so it's not
> even a typed bitfield, just a uint32. I'm guessing there's a reason
> behind this?

As an integer it is always passed by value.  As a structure some host abis pass
it by reference, and the TCG compiler doesn't know about that.


r~
