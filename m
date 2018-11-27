Received: from eggs.gnu.org ([2001:4830:134:3::10]:45978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRZdw-0000V0-Qi
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:26:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRZdt-00027B-Mt
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:26:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRZdt-00026i-Ga
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:26:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so17564509wrt.11
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 01:26:53 -0800 (PST)
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-23-philmd@redhat.com>
	<1fc0d0cb-dead-be57-e4d1-590eed9929a7@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <65812dfc-9c6d-5a82-482a-6cf9843f426a@redhat.com>
Date: Tue, 27 Nov 2018 10:26:50 +0100
MIME-Version: 1.0
In-Reply-To: <1fc0d0cb-dead-be57-e4d1-590eed9929a7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 22/25] MAINTAINERS: Add a missing
 entry to the New World machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org

On 27/11/18 8:22, Thomas Huth wrote:
> On 2018-11-25 21:49, Philippe Mathieu-Daudé wrote:
>> The CHRP NVRAM has his own section, but since the New World
>> section contains the mac_nvram.c, it makes sens to also monitor
>> the corresponding header.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 92691589b1..a248c8c564 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -930,6 +930,7 @@ F: hw/nvram/mac_nvram.c
>>  F: include/hw/misc/macio/
>>  F: include/hw/misc/mos6522.h
>>  F: include/hw/ppc/mac_dbdma.h
>> +F: include/hw/nvram/chrp_nvram.h
> 
> I don't see the point why we should add duplicated entries here? The
> header is also used by the Sparc machines, so why should this be added
> additionally to the Mac machines only here, too? I suggest to drop this
> patch.

OK, will drop.
