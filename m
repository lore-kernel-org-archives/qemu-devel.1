Received: from eggs.gnu.org ([209.51.188.92]:35513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghB2e-0001QW-V2
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:24:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghB2e-0005Yu-8p
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:24:56 -0500
References: <1546615943-16274-1-git-send-email-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4b9b4d5a-d124-19df-46c9-f3b2a68f46d8@vivier.eu>
Date: Wed, 9 Jan 2019 11:24:50 +0100
MIME-Version: 1.0
In-Reply-To: <1546615943-16274-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] trivial: Don't include
 isa.h if it is not really necessary
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

On 04/01/2019 16:32, Thomas Huth wrote:
> These files don't seem to do anything related to ISA directly, so
> there is no need to include isa.h here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/display/ramfb-standalone.c | 1 -
>  hw/ide/pci.c                  | 1 -
>  hw/ide/piix.c                 | 1 -
>  hw/ide/via.c                  | 1 -
>  hw/misc/macio/mac_dbdma.c     | 1 -
>  hw/moxie/moxiesim.c           | 1 -
>  hw/nvram/fw_cfg.c             | 1 -
>  hw/sparc/sun4m.c              | 1 -
>  hw/timer/i8254.c              | 1 -
>  9 files changed, 9 deletions(-)
> 


Applied to my trivial-patches branch.

Thanks,
Laurent
