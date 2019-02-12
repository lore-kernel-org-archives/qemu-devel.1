Received: from eggs.gnu.org ([209.51.188.92]:45985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gtQiL-00041X-Rp
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 00:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gtQXD-0003VZ-Lg
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 00:23:08 -0500
Date: Tue, 12 Feb 2019 13:22:24 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190212052224.GA4839@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190130000653.16267-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130000653.16267-1-richardw.yang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Trivial cleanup in hw/acpi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com, laurent@vivier.eu, imammedo@redhat.com, philmd@redhat.com

On Wed, Jan 30, 2019 at 08:06:50AM +0800, Wei Yang wrote:
>There are several functions/variable which are not used anymore.
>
>This serials just remove those without functional change.
>
>v3: add ack and repost in a new thread
>v2: change commit log from "is now used in no place" to "in not used anymore"

Michael,

Looks this serials is not merged yet.

Is there any problem I need to fix?

>
>Wei Yang (3):
>  hw/i386/pc.c: remove unused function pc_acpi_init()
>  hw/acpi: remove unused function acpi_table_add_builtin()
>  hw/acpi: remove unnecessary variable acpi_table_builtin
>
> hw/acpi/core.c         | 10 +---------
> hw/i386/pc.c           | 27 ---------------------------
> include/hw/acpi/acpi.h |  1 -
> include/hw/i386/pc.h   |  1 -
> 4 files changed, 1 insertion(+), 38 deletions(-)
>
>-- 
>2.19.1

-- 
Wei Yang
Help you, Help me
