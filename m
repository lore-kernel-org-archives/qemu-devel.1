Received: from eggs.gnu.org ([2001:4830:134:3::10]:46113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dfAwR-0008Dn-Nr
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dfAwQ-0003tz-NI
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:17:27 -0400
References: <20170808183306.27474-1-jsnow@redhat.com>
	<20170808183306.27474-4-jsnow@redhat.com>
	<23640b58-68ad-52f7-c004-64661f994f93@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <2482c76f-10a0-75aa-2d9a-fa171aaf3f15@redhat.com>
Date: Tue, 8 Aug 2017 16:17:17 -0400
MIME-Version: 1.0
In-Reply-To: <23640b58-68ad-52f7-c004-64661f994f93@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/9] IDE: add tracing for data ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org



On 08/08/2017 04:10 PM, Eric Blake wrote:
> On 08/08/2017 01:33 PM, John Snow wrote:
>> To be used sparingly, but still interesting in the case of small
>> firmwares designed to reproduce bugs in QEMU IDE.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  hw/ide/core.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>> index 6235bdf..29848ff 100644
>> --- a/hw/ide/core.c
>> +++ b/hw/ide/core.c
>> @@ -2251,6 +2251,8 @@ void ide_data_writew(void *opaque, uint32_t addr, uint32_t val)
>>      IDEState *s = idebus_active_if(bus);
>>      uint8_t *p;
>>  
>> +    trace_ide_data_writew(addr, val, bus, s);
> 
> Umm, where's the trace-events addition for this?
> 

Accidentally traveled forward through time to patch 04.
