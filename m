Received: from eggs.gnu.org ([209.51.188.92]:52677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hGQre-0004sn-1y
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hGQrb-0004WB-1m
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:23:17 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:33746
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hGQra-0004Tq-9j
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:23:14 -0400
References: <CAMo8BfLCON2wbQ36dkVQ92tcVPWoPdje12CqySFnJyoYDDOdDg@mail.gmail.com>
	<20190416074135.qo4l3vra2g6n2rts@steredhat.homenet.telecomitalia.it>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <06b923b2-8406-b599-f3b8-a300bb6a22a5@weilnetz.de>
Date: Tue, 16 Apr 2019 18:13:29 +0200
MIME-Version: 1.0
In-Reply-To: <20190416074135.qo4l3vra2g6n2rts@steredhat.homenet.telecomitalia.it>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] recent QEMU-w64 does not load multiboot kernels by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 16.04.19 09:41, Stefano Garzarella wrote:
> On Mon, Apr 15, 2019 at 03:20:42PM -0700, Max Filippov wrote:
>> Hello,
>>
>> recent qemu-system-i386 for w64 (e.g. one installed from
>> https://qemu.weilnetz.de/w64/qemu-w64-setup-20190218.exe )
>> refuses to load multiboot kernel by default:
>>
>>   "C:\Program Files\qemu\qemu-system-i386.exe" -kernel p:\tmp\kernel
>>   C:\Program Files\qemu\qemu-system-i386.exe: Error loading
>> uncompressed kernel without PVH ELF Note
>>
>> Adding -M pc-i440fx-3.1 (as well as most other machines, but not
>> pc-i440fx-4.0) fixes that. On linux host the same kernel gets loaded
>> either way (with or without -M).
> 
> Hi Max,
> there was an issue when we introduced PVH support and we fixed it. [1]
> Maybe the build that you used (20190218) was compiled before the merge of
> that fix (20190311).
> 
> Can you try to build the 4.0-rc3?
> 
> Cheers,
> Stefano


The build of qemu-w64-setup-20190218.exe only contains patches merged up
to that date, so the fix is missing.

The next release of the installer will include the fix.

Kind regards
Stefan
