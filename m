Received: from eggs.gnu.org ([2001:4830:134:3::10]:36633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMVKW-0000ev-57
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:49:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMVKR-0005Qi-Tj
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:49:56 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:56019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gMVKR-0005Oc-JD
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:49:51 -0500
Received: by mail-wm1-x32c.google.com with SMTP id i73-v6so5897283wmd.5
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 01:49:44 -0800 (PST)
References: <20180629145347.652-1-peter.maydell@linaro.org>
	<20180629145347.652-41-peter.maydell@linaro.org>
	<e8d62bcd-f8a9-2a6a-7765-0cf69cc8c1b5@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0840beac-a764-2fa9-98e3-da10f1f7d6bc@linaro.org>
Date: Tue, 13 Nov 2018 10:49:39 +0100
MIME-Version: 1.0
In-Reply-To: <e8d62bcd-f8a9-2a6a-7765-0cf69cc8c1b5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 40/55] target/arm: Enable SVE for
 aarch64-linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 11/12/18 10:10 PM, Laurent Vivier wrote:
> Running some tests for my pull request, I've found this commit breaks
> ltp-full-20180515 sigaltstack01 tests with ubuntu arm64/trusty.
> 
> sigaltstack01  274  TBROK  :  tst_sig.c:233: unexpected signal
> SIGIOT/SIGABRT(6) received (pid = 15241).
> *** Error in `/opt/ltp/testcases/bin/sigaltstack01': free(): invalid
> pointer: 0x000000000042a010 ***

How exactly does one reproduce this failure?

$ ~/qemu/bld/aarch64-linux-user/qemu-aarch64 -cpu max
./testcases/kernel/syscalls/sigaltstack/sigaltstack01
sigaltstack01    1  TPASS  :  Functionality of sigaltstack() successful


r~
