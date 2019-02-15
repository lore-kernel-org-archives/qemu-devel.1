Received: from eggs.gnu.org ([209.51.188.92]:50189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gui4o-0006SC-5m
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 13:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gui4n-0006bu-Eh
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 13:19:06 -0500
References: <20190214140714.15738-1-imammedo@redhat.com>
	<4d8518f7-5272-fc18-d5c7-20c4cafdf7e8@redhat.com>
	<20190215123317.6903b818@Igors-MacBook-Pro.local>
	<2d99aca8-5ed0-bea3-4a4f-7b2a8e89b049@redhat.com>
	<20190215164209.54a6f747@Igors-MacBook-Pro.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b94c91de-5390-b04f-27d3-f183d010f730@redhat.com>
Date: Fri, 15 Feb 2019 19:18:50 +0100
MIME-Version: 1.0
In-Reply-To: <20190215164209.54a6f747@Igors-MacBook-Pro.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] memory: use memory_region_init_ram() instead
 of memory_region_allocate_system_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org, qemu-arm@nongnu.org, jan.kiszka@web.de, atar4qemu@gmail.com

On 15/02/19 16:42, Igor Mammedov wrote:
>>
>> What about -m, too?  Then you'd specify a memdev instead of the initial
>> memory size.
> that somewhat what I've planned,
> make -m X translate into -object memory-backend-ram,id=magically-get-what-board-uses-now,size=X -machine memdev=thatid
> 
> one more reason for memdev vs device is that -numa now uses memdevs and so far it
> doesn't look that non-numa initial RAM would get immediate benefits from using -device
> on most boards (well, I couldn't come up with any modulo backend/frontend consistent usage)

What I meant is what about making the non-NUMA option -m memdev=thatid
(and the automatic translation you mention too).  Yes, bikeshedding. :)

Paolo
