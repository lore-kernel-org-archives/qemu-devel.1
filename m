Received: from eggs.gnu.org ([209.51.188.92]:58403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1goOzi-0002iu-Gf
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1goOzh-0005M7-Pj
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:43:46 -0500
References: <20190125060157.29935-1-richardw.yang@linux.intel.com>
	<20190129000820.31190-1-richardw.yang@linux.intel.com>
	<feb8687e-0d0c-a20a-9b37-c8284aaae9f5@redhat.com>
	<20190129080455.GA10084@richard>
	<91c53c72-8e9c-f68d-1dc8-f6320ed3dfc0@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f6f1703e-1c77-055e-1906-300df3c79479@vivier.eu>
Date: Tue, 29 Jan 2019 09:43:20 +0100
MIME-Version: 1.0
In-Reply-To: <91c53c72-8e9c-f68d-1dc8-f6320ed3dfc0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Trivial cleanup in hw/acpi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, imammedo@redhat.com, mst@redhat.com

On 29/01/2019 09:23, Philippe Mathieu-Daudé wrote:
> On 1/29/19 9:04 AM, Wei Yang wrote:
>> On Tue, Jan 29, 2019 at 07:56:54AM +0100, Philippe Mathieu-Daudé wrote:
>>> Hi Wei,
>>>
>>> On 1/29/19 1:08 AM, Wei Yang wrote:
>>>> There are several functions/variable which are not used anymore.
>>>>
>>>> This serials just remove those without functional change.
>>>>
>>>> Wei Yang (3):
>>>>   hw/i386/pc.c: remove unused function pc_acpi_init()
>>>>   hw/acpi: remove unused function acpi_table_add_builtin()
>>>>   hw/acpi: remove unnecessary variable acpi_table_builtin
>>>>
>>>>  hw/acpi/core.c         | 10 +---------
>>>>  hw/i386/pc.c           | 27 ---------------------------
>>>>  include/hw/acpi/acpi.h |  1 -
>>>>  include/hw/i386/pc.h   |  1 -
>>>>  4 files changed, 1 insertion(+), 38 deletions(-)
>>>>
>>>
>>> Please do not post iterated series in reply to previous version, but as
>>> new thread:
>>> - patches are parsed by scripts
>>> - some email clients can tag a thread as "reviewed, skip" and replies to
>>> this thread will be masked.
>>>
>>
>> Well, do I need to repost it in a new thread?
> 
> It depends who will take this patchset and his mood :)
> Let's wait and see.
> 

No need to repost if they go through the trivial branch.

Thanks,
Laurent
