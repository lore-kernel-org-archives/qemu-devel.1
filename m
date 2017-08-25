Received: from eggs.gnu.org ([2001:4830:134:3::10]:41993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dlDKO-0001iW-W4
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 08:03:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dlDKO-0001Da-9G
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 08:03:09 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:36200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dlDKO-0001DB-3J
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 08:03:08 -0400
Received: by mail-wr0-x232.google.com with SMTP id p14so6730858wrg.3
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 05:03:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c31cb6e9-8b50-3b4a-ab1a-27632d516c9f@linaro.org>
References: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
	<1501867249-1924-5-git-send-email-peter.maydell@linaro.org>
	<50d6ba4d-cfa3-5b5f-5da1-dca2326d4f5d@amsat.org>
	<c38728a0-da49-635e-2954-1030b223e3c9@linaro.org>
	<CAFEAcA_nPya92Vatwt7RiZnhKTH4_GKypSrX_KgPj3GitxV0Tg@mail.gmail.com>
	<CAFEAcA97eXYPABgaE8Y_+EkWscR7CCH2WUHoM7ttZ6gVWQrqxw@mail.gmail.com>
	<aa6caac1-e06c-9e1c-2aba-18d672fafb55@amsat.org>
	<CAFEAcA9Ci+0cjFORmzL7-73Jj4pm4jST3iEbXmHjXuPyiyt03g@mail.gmail.com>
	<CAFEAcA_rSqsrfd_qJijtPFRe1qKEA=JiyHE+3J5atAgxAX8NBg@mail.gmail.com>
	<c31cb6e9-8b50-3b4a-ab1a-27632d516c9f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Aug 2017 13:02:46 +0100
Message-ID: <CAFEAcA8o2biMXi+fScJQjc7C-FEFxKcwHXvCD_vn4kPDj6oFFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 4/8] boards.h: Define new flag
 ignore_memory_transaction_failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 24 August 2017 at 21:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Peter and I had a chat on IRC about this.
>
> While I think the background region idea is tempting, it does nothing to help
> legacy boards once devices start signaling their own errors.  Therefore some
> sort of flag is the only reasonable solution.

Thanks; I'm going to put this series into target-arm.next as-is
(with the couple of minor comment tweaks suggested in review
applied to it), ready for the post-2.10-release pull request.

-- PMM
