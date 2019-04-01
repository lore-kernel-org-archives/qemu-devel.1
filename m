Received: from eggs.gnu.org ([209.51.188.92]:48106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hB4Lz-0002ks-JZ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hB4Lu-00078q-Vm
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:20:26 -0400
MIME-Version: 1.0
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
	<20190401210011.16009-60-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20190401210011.16009-60-mdroth@linux.vnet.ibm.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 1 Apr 2019 14:19:59 -0700
Message-ID: <CAMo8BfLMM7RSXMcvA-jPJFUzt23fCGU-q=3fXZBv_=S_6UszSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 59/97] target/xtensa: drop num_[core_]regs
 from dc232b/dc233c configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

Hi Michael,

On Mon, Apr 1, 2019 at 2:04 PM Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> From: Max Filippov <jcmvbkbc@gmail.com>
>
> Now that xtensa_count_regs does the right thing, remove manual
> initialization of these fields from the affected configurations and let
> xtensa_finalize_config initialize them. Add XTREG_END to terminate
> register lists.
>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> (cherry picked from commit 7da9111e77b9cdb3a927dcd47642b7ffff9de636)
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>

I'm curious why this change was picked for stable, it wasn't marked for it.
I'm pretty sure it's not going to work without the corresponding change
in the xtensa_count_regs, which is pretty big.

-- 
Thanks.
-- Max
