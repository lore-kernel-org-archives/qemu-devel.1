Received: from eggs.gnu.org ([2001:4830:134:3::10]:56800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cdwZn-0005Wa-SX
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cdwZi-00049m-W4
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:12:43 -0500
References: <1486148371-11692-1-git-send-email-peter.maydell@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <3f200670-cce5-014a-eaed-e82302ed3e7f@msgid.tls.msk.ru>
Date: Wed, 15 Feb 2017 13:12:37 +0300
MIME-Version: 1.0
In-Reply-To: <1486148371-11692-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] softfloat: Use correct type in
 float64_to_uint64_round_to_zero()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org

03.02.2017 21:59, Peter Maydell wrote:
> In float64_to_uint64_round_to_zero() a typo meant that we were
> taking the uint64_t return value from float64_to_uint64() and
> putting it into an int64_t variable before returning it as
> uint64_t again. Use uint64_t instead of pointlessly casting it
> back and forth to int64_t.

Applied to -trivial, thanks!

/mjt
