Received: from eggs.gnu.org ([209.51.188.92]:38929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gleux-00081G-0u
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:07:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glemm-0005ex-A6
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:59:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glemm-0005eP-41
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:59:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so11927750wml.3
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:59:03 -0800 (PST)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <1547732292-14021-1-git-send-email-thuth@redhat.com>
	<CAFEAcA93W+-6xkBiGdqFStOx4t25oSq=GE07Mj86uUJ_xodFQg@mail.gmail.com>
	<2dbba1df-4dda-78f4-0a84-5c4577b34b6f@redhat.com>
Message-ID: <40ffc6cd-db33-988d-86bd-d261a70aefc8@redhat.com>
Date: Mon, 21 Jan 2019 19:59:01 +0100
MIME-Version: 1.0
In-Reply-To: <2dbba1df-4dda-78f4-0a84-5c4577b34b6f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL v3 00/28] ivshmem deprecation, qtests,
 typedefs and gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Wei Xu <wexu@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Li Qiang <liq3ea@163.com>, Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 1/21/19 6:42 PM, Philippe Mathieu-Daudé wrote:
> On 1/21/19 3:43 PM, Peter Maydell wrote:
>> On Thu, 17 Jan 2019 at 13:38, Thomas Huth <thuth@redhat.com> wrote:
>>>
>>>  Hi Peter!
>>>
>>> The following changes since commit 6f2f34177a25bffd6fd92a05e6e66c8d22d97094:
>>>
>>>   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2019-01-15 18:32:57 +0000)
>>>
>>> are available in the git repository at:
>>>
>>>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-01-17
>>>
>>> for you to fetch changes up to 3f0832c85380321ef697d64342b389648f8abb1c:
>>>
>>>   tests/hexloader-test: Don't pass -nographic to the QEMU under test (2019-01-17 14:25:12 +0100)
>>>
>>> ----------------------------------------------------------------
>>> - Remove deprecated "ivshmem" legacy device
>>> - Bug fix for vhost-user-test
>>> - Use more CONFIG Makefile switches for qtests
>>> - Get rid of global_qtests in some more qtests
>>> - typedef cleanups
>>> - Fixes for compiling with Clang
>>> - Force C standard to gnu99
>>> ----------------------------------------------------------------
>>
>> I gave this another run now the ipmi-bt test has been
>> disabled. It gets this compile failure on clang builds:
>>
>> In file included from
>> /home/petmay01/linaro/qemu-for-merges/hw/net/vhost_net.c:21:
>> /home/petmay01/linaro/qemu-for-merges/include/hw/virtio/virtio-net.h:189:3:
>> error: redefinition of typedef 'VirtIONet' is a C11 feature
>> [-Werror,-Wtypedef-redefinition]
>> } VirtIONet;
> 
> Oh this got introduced by 2974e916df8:
> "virtio-net: support RSC v4/v6 tcp traffic for Windows HCK".
> 
> Thomas I'm afraid you'll have to rebase and add a new fix :/

Fix sent here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg589185.html

>>   ^
>> /home/petmay01/linaro/qemu-for-merges/include/hw/virtio/virtio-net.h:110:26:
>> note: previous definition is here
>> typedef struct VirtIONet VirtIONet;
>>                          ^
>> 1 error generated.
>>
>> thanks
>> -- PMM
>>
