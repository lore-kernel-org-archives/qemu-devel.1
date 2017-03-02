Received: from eggs.gnu.org ([2001:4830:134:3::10]:44178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjT8C-0000r9-Cu
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 10:59:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjT8B-0002NU-9c
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 10:59:04 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjT8B-0002Mb-3d
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 10:59:03 -0500
Received: by mail-wm0-x236.google.com with SMTP id n11so29094404wma.0
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 07:59:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170228215801.10472-2-Andrew.Baumann@microsoft.com>
References: <20170228215801.10472-1-Andrew.Baumann@microsoft.com>
	<20170228215801.10472-2-Andrew.Baumann@microsoft.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 15:58:41 +0000
Message-ID: <CAFEAcA_FiuYxR16TJgNwCz=FYkuXjBNZfizZxAuDGrCAV54fZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/2] target/arm: implement armv8 PMUSERENR
 (user-mode enable bits)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 28 February 2017 at 21:58, Andrew Baumann
<Andrew.Baumann@microsoft.com> wrote:
> In armv8, this register implements more than a single bit, with
> fine-grained enables for read access to event counters, cycles
> counters, and write access to the software increment. This change
> implements those checks using custom access functions for the relevant
> registers.
>
> Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>

This looks good to me. Since it is a bug fix I think we can
put it into 2.9. Applied to target-arm.next.

thanks
-- PMM
