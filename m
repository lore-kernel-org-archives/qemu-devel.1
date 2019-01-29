Received: from eggs.gnu.org ([209.51.188.92]:52265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1goOOz-0008TP-2l
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:05:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1goOOx-0000GJ-5U
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:05:49 -0500
Date: Tue, 29 Jan 2019 16:04:55 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190129080455.GA10084@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190125060157.29935-1-richardw.yang@linux.intel.com>
	<20190129000820.31190-1-richardw.yang@linux.intel.com>
	<feb8687e-0d0c-a20a-9b37-c8284aaae9f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <feb8687e-0d0c-a20a-9b37-c8284aaae9f5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Trivial cleanup in hw/acpi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, imammedo@redhat.com, laurent@vivier.eu, mst@redhat.com

On Tue, Jan 29, 2019 at 07:56:54AM +0100, Philippe Mathieu-Daudé wrote:
>Hi Wei,
>
>On 1/29/19 1:08 AM, Wei Yang wrote:
>> There are several functions/variable which are not used anymore.
>> 
>> This serials just remove those without functional change.
>> 
>> Wei Yang (3):
>>   hw/i386/pc.c: remove unused function pc_acpi_init()
>>   hw/acpi: remove unused function acpi_table_add_builtin()
>>   hw/acpi: remove unnecessary variable acpi_table_builtin
>> 
>>  hw/acpi/core.c         | 10 +---------
>>  hw/i386/pc.c           | 27 ---------------------------
>>  include/hw/acpi/acpi.h |  1 -
>>  include/hw/i386/pc.h   |  1 -
>>  4 files changed, 1 insertion(+), 38 deletions(-)
>> 
>
>Please do not post iterated series in reply to previous version, but as
>new thread:
>- patches are parsed by scripts
>- some email clients can tag a thread as "reviewed, skip" and replies to
>this thread will be masked.
>

Well, do I need to repost it in a new thread?

>Regards,
>
>Phil.

-- 
Wei Yang
Help you, Help me
