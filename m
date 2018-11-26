Received: from eggs.gnu.org ([2001:4830:134:3::10]:36766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRL1V-0003JI-Q3
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:50:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRL1Q-0003j5-Bw
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:50:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRL1Q-0003iV-6c
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:50:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so13075991wmd.1
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 09:50:12 -0800 (PST)
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-11-philmd@redhat.com>
	<40c0e94b-687c-aaba-9d29-9ecdcbad937d@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2a9cf123-f677-3bdd-efeb-08c895a6243c@redhat.com>
Date: Mon, 26 Nov 2018 18:49:26 +0100
MIME-Version: 1.0
In-Reply-To: <40c0e94b-687c-aaba-9d29-9ecdcbad937d@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 10/25] MAINTAINERS: Add missing
 entries for the sun4u machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 26/11/18 18:05, Mark Cave-Ayland wrote:
> On 25/11/2018 20:49, Philippe Mathieu-Daudé wrote:
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  MAINTAINERS | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ba9cd9ac2b..d9cddb0cc8 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1019,6 +1019,10 @@ Sun4u
>>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>  S: Maintained
>>  F: hw/sparc64/sun4u.c
>> +F: hw/sparc64/sun4u_iommu.c
>> +F: include/hw/sparc/sun4u_iommu.h
>> +F: hw/pci-host/sabre.c
>> +F: include/hw/pci-host/sabre.h
>>  F: pc-bios/openbios-sparc64
> 
> These are correct, however you also want to add the simba PCI bridges i.e.
> 
> F: hw/pci-bridge/simba.c
> F: include/hw/pci-bridge/simba.h

OK, will update.

> 
> So with that:
> 
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Thanks!

Phil.
