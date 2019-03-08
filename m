Received: from eggs.gnu.org ([209.51.188.92]:55204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2GSf-000739-CP
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:27:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2GSe-0003EA-Ke
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:26:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2GSe-0002xn-ES
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:26:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id g20so12463084wmh.5
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 06:26:53 -0800 (PST)
References: <20190308062455.29755-1-armbru@redhat.com>
	<481d398a-e26c-6c0a-20b7-7466ae1ebf1f@redhat.com>
	<875zsteeih.fsf@dusky.pond.sub.org>
	<20190308133510.GC31583@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <952775a8-3736-320a-9f4a-1b3ec396e208@redhat.com>
Date: Fri, 8 Mar 2019 15:26:51 +0100
MIME-Version: 1.0
In-Reply-To: <20190308133510.GC31583@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7] pflash: Require backend size to match
 device, improve errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, alex.bennee@linaro.org, qemu-block@nongnu.org, mreitz@redhat.com

On 3/8/19 2:35 PM, Kevin Wolf wrote:
> Am 08.03.2019 um 13:28 hat Markus Armbruster geschrieben:
>> Laszlo Ersek <lersek@redhat.com> writes:
>>> This one has got to be one of the longest bike-shedding sessions! :)
>>>
>>> I'm fine with this patch, but I could suggest two improvements.
>>>
>>> (1) When blk_getlength() fails, we could format the negative error code
>>> returned by it into the error message.
>>
>> I can do that.
> 
> By using error_setg_errno(), I assume. Not throwing away error details
> is always good.
> 
>>> (2) We could extract the common code to a new function in
>>> "hw/block/block.c". (It says "Common code for block device models" on
>>> the tin.)
>>
>> There's so much common code in these two files even before this patch...
> 
> My understanding is that hw/block/block.c contains code that is
> potentially useful to all kinds of block devices, not random code that
> two specific similar devices happen to share.
> 
> If we want to deduplicate some code in the flash devices, without any
> expectation that other devices will use it at some point, I'd rather
> create a new source file hw/block/pflash_common.c or something like
> that.

Agreed, I like that suggestion too.
Actually we already have been talking about a such
cleanup/refactor/rewrite with Markus, but this will wait the next QEMU
dev cycle.
