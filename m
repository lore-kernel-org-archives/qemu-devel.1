Received: from eggs.gnu.org ([2001:4830:134:3::10]:45582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOWwG-0001Um-DP
	for qemu-devel@nongnu.org; Thu, 31 May 2018 19:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOWwF-0004RW-FO
	for qemu-devel@nongnu.org; Thu, 31 May 2018 19:25:00 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180531222835.16558-1-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4689e55e-49cc-48ab-4e86-b80d5b07f479@amsat.org>
Date: Thu, 31 May 2018 20:24:51 -0300
MIME-Version: 1.0
In-Reply-To: <20180531222835.16558-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 00/16] AHCI: tracing improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On 05/31/2018 07:28 PM, John Snow wrote:
> This set just adds register names so that the read/write traces make
> more sense on their own without having to memorize register offsets.
> It also splits read/write traces into supported/unsupported subsets,
> so you can just monitor for things that QEMU is likely doing wrong.
> 
> v2:
>  - Added qemu_log_mask(LOG_UNIMP, ...) statements in addition to traces
>    for writes to unknown/unsupported registers. (Philippe)

Thanks,

With format string and style issues reported by checkpatch fixed:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

(I recommend you to setup the scripts/git.orderfile to ease reviews).

> 
> John Snow (16):
>   ahci: add port register enumeration
>   ahci: modify ahci_port_read to use register numbers
>   ahci: make port read traces more descriptive
>   ahci: fix spacing damage on ahci_port_write
>   ahci: combine identical clauses in port write
>   ahci: modify ahci_port_write to use register numbers
>   ahci: make port write traces more descriptive
>   ahci: delete old port register address definitions
>   ahci: add host register enumeration
>   ahci: fix host register max address
>   ahci: modify ahci_mem_read_32 to work on register numbers
>   ahci: make mem_read_32 traces more descriptive
>   ahci: fix spacing damage on ahci_mem_write
>   ahci: adjust ahci_mem_write to work on registers
>   ahci: delete old host register address definitions
>   ahci: make ahci_mem_write traces more descriptive
> 
>  hw/ide/ahci.c          | 314 ++++++++++++++++++++++++++++++-------------------
>  hw/ide/ahci_internal.h |  63 ++++++----
>  hw/ide/trace-events    |  13 +-
>  3 files changed, 241 insertions(+), 149 deletions(-)
> 
