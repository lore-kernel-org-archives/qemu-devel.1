Received: from eggs.gnu.org ([209.51.188.92]:53948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggHHY-0005eN-PZ
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 17:52:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggHHY-0006LM-2K
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 17:52:36 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:33172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggHHX-0006L7-TE
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 17:52:36 -0500
Received: by mail-pf1-x42b.google.com with SMTP id c123so20889840pfb.0
	for <qemu-devel@nongnu.org>; Sun, 06 Jan 2019 14:52:35 -0800 (PST)
References: <149893001258.15852.11258418521313176097.malonedeb@wampee.canonical.com>
	<154681323372.20138.8534715504744622137.malone@soybean.canonical.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2114516e-daac-e1f7-f911-48df8208281e@linaro.org>
Date: Mon, 7 Jan 2019 08:52:29 +1000
MIME-Version: 1.0
In-Reply-To: <154681323372.20138.8534715504744622137.malone@soybean.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1701835] Re: floating-point operation bugs in
 qemu-alpha
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1701835 <1701835@bugs.launchpad.net>, qemu-devel@nongnu.org

On 1/7/19 8:20 AM, Bruno Haible wrote:
> No, it is not fixed: even with this patch the program that fetches the
> fpcr still prints 600e800000000000, and the various program crashes
> still occur.

Are you sure you rebuilt properly?  The fpcr prints 680e800000000000 here.


r~
