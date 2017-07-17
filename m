Received: from eggs.gnu.org ([2001:4830:134:3::10]:42446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXCvx-00034C-Mj
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 16:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXCvu-0004Dn-TU
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 16:48:01 -0400
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:36670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXCvu-0004DM-M2
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 16:47:58 -0400
Received: by mail-qt0-x232.google.com with SMTP id 21so952351qtx.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 13:47:58 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170715173050.31018-1-rth@twiddle.net>
	<CAFEAcA-mVcamZ9oxqid25ny0FJgoXNXGb054Lc6Enk6tFF6WJA@mail.gmail.com>
	<854c3b2e-deaf-1c8d-fd84-9accd7331510@twiddle.net>
	<CAFEAcA_BDhF6EnQgLr52AL63T7xhs8cqMadhiEerK0HfS26brQ@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <37054f66-fe31-562e-0c67-3f1f8d425491@twiddle.net>
Date: Mon, 17 Jul 2017 10:47:52 -1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_BDhF6EnQgLr52AL63T7xhs8cqMadhiEerK0HfS26brQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/8] target/s390x tcg improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 07/17/2017 10:31 AM, Peter Maydell wrote:
> and Linux Ubuntu x86_64 Xenial running
> clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)

Ok, I can reproduce this just fine with debian stretch and clang 3.8.

> If we don't build with clang 3.9 that's worth fixing;
> it's not in my test set, which will be why the
> breakage has slipped through.

There's one bit of cpuid.h breakage and one bit of user error there.

Should we simply stop relying on the cpuid.h shipped with the compiler and 
provide our own?  Or at least wrap the compiler's version and add #ifndef for 
every bit_FOO used within qemu?


r~
