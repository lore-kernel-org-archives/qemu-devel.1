Received: from eggs.gnu.org ([209.51.188.92]:41576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goNKM-0004Th-6l
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 01:56:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goNKL-00072n-9S
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 01:56:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1goNKL-00072B-39
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 01:56:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so20681120wrt.11
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 22:56:56 -0800 (PST)
References: <20190125060157.29935-1-richardw.yang@linux.intel.com>
	<20190129000820.31190-1-richardw.yang@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <feb8687e-0d0c-a20a-9b37-c8284aaae9f5@redhat.com>
Date: Tue, 29 Jan 2019 07:56:54 +0100
MIME-Version: 1.0
In-Reply-To: <20190129000820.31190-1-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Trivial cleanup in hw/acpi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, laurent@vivier.eu, mst@redhat.com

Hi Wei,

On 1/29/19 1:08 AM, Wei Yang wrote:
> There are several functions/variable which are not used anymore.
> 
> This serials just remove those without functional change.
> 
> Wei Yang (3):
>   hw/i386/pc.c: remove unused function pc_acpi_init()
>   hw/acpi: remove unused function acpi_table_add_builtin()
>   hw/acpi: remove unnecessary variable acpi_table_builtin
> 
>  hw/acpi/core.c         | 10 +---------
>  hw/i386/pc.c           | 27 ---------------------------
>  include/hw/acpi/acpi.h |  1 -
>  include/hw/i386/pc.h   |  1 -
>  4 files changed, 1 insertion(+), 38 deletions(-)
> 

Please do not post iterated series in reply to previous version, but as
new thread:
- patches are parsed by scripts
- some email clients can tag a thread as "reviewed, skip" and replies to
this thread will be masked.

Regards,

Phil.
