Received: from eggs.gnu.org ([2001:4830:134:3::10]:39905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWKrK-0001dq-3U
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:08:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWKrJ-0002pX-7M
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:08:10 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180621171257.14897-1-f4bug@amsat.org>
	<20180621171257.14897-6-f4bug@amsat.org>
	<20180622062225.ay4bubgshxjj3uey@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3a5e52f6-3b65-5ce8-f5d2-48b76e3e4f21@amsat.org>
Date: Fri, 22 Jun 2018 09:07:59 -0300
MIME-Version: 1.0
In-Reply-To: <20180622062225.ay4bubgshxjj3uey@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/11] hw/display/cirrus: Convert printf()
 calls to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Hi Gerd,

On 06/22/2018 03:22 AM, Gerd Hoffmann wrote:
> On Thu, Jun 21, 2018 at 02:12:51PM -0300, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/display/cirrus_vga.c | 25 ++++++-------------------
>>  hw/display/trace-events |  2 ++
>>  2 files changed, 8 insertions(+), 19 deletions(-)
>>
>> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
>> index 138ae961b9..a826bef6ec 100644
>> --- a/hw/display/cirrus_vga.c
>> +++ b/hw/display/cirrus_vga.c
>> @@ -2608,11 +2608,8 @@ static uint64_t cirrus_vga_ioport_read(void *opaque, hwaddr addr,
>>  	    break;
>>  	case 0x3c5:
>>  	    val = cirrus_vga_read_sr(c);
>> +        trace_vga_cirrus_read_reg("SR", s->sr_index, val);
>>              break;
>> -#ifdef DEBUG_VGA_REG
>> -	    printf("vga: read SR%x = 0x%02x\n", s->sr_index, val);
>> -#endif
> 
> Indention looks weird.

Actually this is the code around that is weirdly intended, a mix of
<tab> and <spaces>.
I noticed, except when upgrading generic API, there are very few logical
changes (except yours) in this file in the git history. Thus little
interest in doing an indentation cleanup previous patch (at this point
git history is more useful).

> 
> otherwise the patch looks fine.

Do you prefer a previous indent cleanup patch or can I add your Acked-by
tag?

Thanks,

Phil.

> 
> cheers,
>   Gerd
> 
