Received: from eggs.gnu.org ([2001:4830:134:3::10]:44883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cswk6-0002El-Hw
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cswk2-0006mw-Jl
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:25:22 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:41256
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1cswk2-0006ma-Dn
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:25:18 -0400
References: <20170324231943.18768-1-Andrew.Baumann@microsoft.com>
	<bb0868d1-5c56-45e5-8b6c-ee08e77dfeaa@weilnetz.de>
	<fbb1c7da-1c51-8ee5-b94d-62fd17c068e0@redhat.com>
	<DM2PR21MB0060647969F7193B509AE8AF9E320@DM2PR21MB0060.namprd21.prod.outlook.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <304dcb46-bb8b-bdfc-c8af-aa3dc2792a88@weilnetz.de>
Date: Tue, 28 Mar 2017 21:25:14 +0200
MIME-Version: 1.0
In-Reply-To: <DM2PR21MB0060647969F7193B509AE8AF9E320@DM2PR21MB0060.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.9?] virtio: fix vring_align() on
 64-bit windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>, Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Am 28.03.2017 um 20:56 schrieb Andrew Baumann:
>> From: Eric Blake [mailto:eblake@redhat.com]
>>> Is this needed for 2.9?
>>
>> Yes, it's a correctness bug that avoids miscompilation on 64-bit targets
>> where long is 32 bits (which, at the moment, is really just Windows).
>
> I agree, this should be in 2.9. I dropped the tag by accident.
>
>>> I wonder why I never before noticed
>>> a problem or got a bug report for this issue.
>>
>> Probably because so few people are testing on native Windows, and it
>> doesn't affect other platforms.
>
> In addition to that, you only notice it on virtio devices mapped above the 32-bit limit...

I think that is the reason why most people don't get
that problem.

I also think that only a few people are testing on Windows,
but there seem to be more people than expected who simply
use it. Most of them will never complain when they have a
problem, but sometimes I also get e-mails which report
an issue.

By the way: I expect that more Windows users will be
attracted as soon as the HAXM acceleration works better
(Intel is just preparing a new HAXM version which fixes
CPUID, something which was reported to me by a Windows
user).

Stefan
