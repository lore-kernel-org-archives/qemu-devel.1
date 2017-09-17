Received: from eggs.gnu.org ([2001:4830:134:3::10]:40879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dtZW1-0005h2-3q
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 09:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dtZVx-00055w-V0
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 09:21:41 -0400
References: <1505580378-9044-1-git-send-email-peter.maydell@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <4e4c3ae1-853b-fb93-b891-8414c4aff493@ilande.co.uk>
Date: Sun, 17 Sep 2017 14:21:17 +0100
MIME-Version: 1.0
In-Reply-To: <1505580378-9044-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/6] convert some omap/palm devices from
 using old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 16/09/17 17:46, Peter Maydell wrote:

> This patchset converts a handful of old devices from the old_mmio
> fields in MemoryRegionOps. We don't have very many devices still
> using old_mmio, so it would be nice to get rid of the remainder
> and drop the field entirely at some point.

That reminds me - the macio IDE controller still uses old_mmio
accessors. I'm currently working around that area so I'll see if I can
slip a conversion into my next patchset.


ATB,

Mark.
