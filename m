Received: from [208.118.235.92] (port=58451 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makren67@gmail.com>) id 1gfXGd-0000kT-SP
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 16:44:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makren67@gmail.com>) id 1gfXGX-0007qk-5g
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 16:44:29 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35]:35495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makren67@gmail.com>) id 1gfXGR-0007mh-Ua
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 16:44:25 -0500
Received: by mail-yb1-xb35.google.com with SMTP id f187so5465408ybb.2
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 13:44:11 -0800 (PST)
MIME-Version: 1.0
References: <CAObpvQ=1dw4pTX3aiDvOvgnAkZQ0d9svMaL4Bwz55nkE8i4yrQ@mail.gmail.com>
	<945511ac-d99a-d483-12a2-e6ad4dda09c2@linaro.org>
	<CAObpvQktCHp-9V40z7kDaTU2CwRWSq8ZVS1PxRg3WK01TFXCzQ@mail.gmail.com>
	<b4cdc06a-8114-48d2-2c0a-9fea876fee4a@linaro.org>
	<CAObpvQmejWBh+RNz2vhk16-kcY_QveM_pSmM5ZeWqWv1d8AJzQ@mail.gmail.com>
	<aeeb8c50-0293-e37b-9f9f-5d392b7e10f6@linaro.org>
	<CAObpvQkjXLmXjB61w0Ecu8QfbA4+qBxLUVMjnDUD4dchOp+duA@mail.gmail.com>
	<38b906b7-56a6-a0dc-95f3-365452b59099@linaro.org>
In-Reply-To: <38b906b7-56a6-a0dc-95f3-365452b59099@linaro.org>
From: Nick Renieris <makren67@gmail.com>
Date: Fri, 4 Jan 2019 23:43:45 +0200
Message-ID: <CAObpvQmJzCQZzW4pL02KD7HntnTbn9JWUE9eLi5J-6md3_b0yA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] AVX support for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Right, that makes sense, thanks for the explanations. As someone with
very little x86 experience (zero experience from this perspective)
it's kind of daunting that I'd have to refactor all this stuff. All
these helpers via macros to get around C's 'minimalism' also seem like
something I'd have to get accustomed to. I will think about it.

Just curious, why is gvec-desc a bitfield instead of a normal struct?
Surely it'd be more readable that way. Also this is C, so it's not
even a typed bitfield, just a uint32. I'm guessing there's a reason
behind this?
