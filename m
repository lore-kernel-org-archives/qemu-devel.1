Received: from eggs.gnu.org ([2001:4830:134:3::10]:50007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRghe-0002gP-6A
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:59:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRgZC-00076j-6E
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:50:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRgZC-000769-0l
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:50:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so22886474wmh.0
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 08:50:29 -0800 (PST)
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-14-philmd@redhat.com>
	<20181127093552.4f53790d@x1.home>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9225e792-010f-4882-4d82-477f6cb393e9@redhat.com>
Date: Tue, 27 Nov 2018 17:50:24 +0100
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
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Fam Zheng <fam@euphon.net>, Fam Zheng <famz@redhat.com>

On 27/11/18 17:35, Alex Williamson wrote:
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

OK (Cc'ed Fam).

Laurent, can you unqueue this patch? (sorry).

Thanks,

Phil.

> 
> Alex
> 
>> +F: docs/igd-assign.txt
>>  
>>  vfio-ccw
>>  M: Cornelia Huck <cohuck@redhat.com>
> 
