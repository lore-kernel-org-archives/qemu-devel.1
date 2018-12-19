Received: from eggs.gnu.org ([2001:4830:134:3::10]:59004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZgMO-00053x-T8
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:14:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZgMJ-0005pP-SM
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:14:20 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:34202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZgMJ-0005pB-Kw
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:14:15 -0500
Received: by mail-pl1-x634.google.com with SMTP id w4so9825497plz.1
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 10:14:15 -0800 (PST)
References: <154524068665.20249.14759163527388138129.malonedeb@wampee.canonical.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e0fea039-f15c-554a-6df7-441d8b9e133d@linaro.org>
Date: Wed, 19 Dec 2018 10:14:11 -0800
MIME-Version: 1.0
In-Reply-To: <154524068665.20249.14759163527388138129.malonedeb@wampee.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1809144] [NEW] SVM instructions fail with
 SVME bit enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1809144 <1809144@bugs.launchpad.net>, qemu-devel@nongnu.org

On 12/19/18 9:31 AM, Paolo Montesel wrote:
> A quick fix is to make the tb end after `wrmsr` instructions, but it's an hack afaik.

No, that's exactly the correct solution.


r~
