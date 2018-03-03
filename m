Received: from eggs.gnu.org ([2001:4830:134:3::10]:53256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1es7rE-0005NO-GS
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 09:09:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1es7r9-0003GJ-He
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 09:09:52 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:50840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1es7r9-0003GB-8P
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 09:09:47 -0500
Received: by mail-wm0-x242.google.com with SMTP id w128so8088638wmw.0
	for <qemu-devel@nongnu.org>; Sat, 03 Mar 2018 06:09:47 -0800 (PST)
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-11-lukeshu@lukeshu.com>
	<CAFEAcA9joyBcXSOqDu=hWRUZPKA1wEKMpYhRr5+p0YCKQOs5Kw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3befdaff-0a84-d2ff-25b9-2df8018c7697@linaro.org>
Date: Sat, 3 Mar 2018 06:09:43 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9joyBcXSOqDu=hWRUZPKA1wEKMpYhRr5+p0YCKQOs5Kw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/10] linux-user: init_guest_space: Try to
 make ARM space+commpage continuous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Luke Shumaker <lukeshu@lukeshu.com>
Cc: Luke Shumaker <lukeshu@parabola.nu>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>, Paul Brook <paul@codesourcery.com>

On 03/02/2018 06:13 AM, Peter Maydell wrote:
> Does anybody know why we allow the user to specify
> it on the command line? (git revision history doesn't help, it just says
> there's been a -pagesize argument since commit 54936004fddc5 in 2003,
> right back when mmap emulation was first added...)

I *think* it is to allow two different hosts with different page sizes to
achieve the same memory layout, so that tcg traces are more easily compared, to
root out bugs in the second host's tcg backend.

That's the only thing that I've used it for, anyway.


r~
