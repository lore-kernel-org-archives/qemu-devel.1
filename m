Received: from eggs.gnu.org ([2001:4830:134:3::10]:49990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRghh-0002gM-7J
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRgZ5-00072Y-Qr
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:50:24 -0500
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-14-philmd@redhat.com>
	<20181127093552.4f53790d@x1.home>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a752d154-7158-7729-2ea4-3a1e1766efbc@vivier.eu>
Date: Tue, 27 Nov 2018 17:50:11 +0100
MIME-Version: 1.0
In-Reply-To: <20181127093552.4f53790d@x1.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 13/25] MAINTAINERS: Add missing
 entries to VFIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 27/11/2018 17:35, Alex Williamson wrote:
> On Sun, 25 Nov 2018 21:49:48 +0100
> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  MAINTAINERS | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index bfe71f2555..e124792557 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1326,6 +1326,8 @@ M: Alex Williamson <alex.williamson@redhat.com>
>>  S: Supported
>>  F: hw/vfio/*
>>  F: include/hw/vfio/
>> +F: include/qemu/vfio-helpers.h
> 
> This misses util/vfio-helpers.c, both of which are contributed by Fam
> and currently only used by nvme.  I really haven't done anything with
> them, so they should probably be under the NVMe block driver, but if it
> makes more sense for me to look after them, I can start paying more
> attention to them.  I'm not sure signing someone up for new files
> they've never touched counts as trivial ;)  Thanks,

Un-applied to my trivial-patches branch...

Thanks,
Laurent
