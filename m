Received: from eggs.gnu.org ([209.51.188.92]:48029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gmJn7-0007mH-VY
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:46:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gmJn6-0008Ji-Ma
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:46:09 -0500
References: <1548252536-6242-1-git-send-email-thuth@redhat.com>
	<1548252536-6242-4-git-send-email-thuth@redhat.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <038f7582-e5de-ab67-a2b3-0ff1e4d27c5b@mail.uni-paderborn.de>
Date: Wed, 23 Jan 2019 15:45:47 +0100
MIME-Version: 1.0
In-Reply-To: <1548252536-6242-4-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH 3/4] target/tricore: Fix LGPL version number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org


On 1/23/19 3:08 PM, Thomas Huth wrote:
> It's either "GNU *Library* General Public version 2" or "GNU Lesser
> General Public version *2.1*", but there was no "version 2.0" of the
> "Lesser" library. So assume that version 2.1 is meant here.
>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/tricore/cpu-qom.h         | 2 +-
>   target/tricore/cpu.c             | 2 +-
>   target/tricore/cpu.h             | 2 +-
>   target/tricore/fpu_helper.c      | 2 +-
>   target/tricore/helper.c          | 2 +-
>   target/tricore/helper.h          | 2 +-
>   target/tricore/op_helper.c       | 2 +-
>   target/tricore/translate.c       | 2 +-
>   target/tricore/tricore-defs.h    | 2 +-
>   target/tricore/tricore-opcodes.h | 2 +-
>   10 files changed, 10 insertions(+), 10 deletions(-)


We can re-license it to GPL v2, but I'm also fine with this variant, so

Acked-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
