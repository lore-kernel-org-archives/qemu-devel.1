Received: from eggs.gnu.org ([2001:4830:134:3::10]:34410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gM8KZ-00060Y-4f
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:16:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gM8KH-0001n8-I2
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:16:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gM8KH-0001hc-8A
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:16:09 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181109141447.13101-1-kraxel@redhat.com>
	<CAFEAcA89pAYe1ZQZDUHO33aP1jT7vfdsjJ4=aN7-c_fPSeYWgQ@mail.gmail.com>
Date: Mon, 12 Nov 2018 10:16:05 +0100
In-Reply-To: <CAFEAcA89pAYe1ZQZDUHO33aP1jT7vfdsjJ4=aN7-c_fPSeYWgQ@mail.gmail.com>
	(Peter Maydell's message of "Fri, 9 Nov 2018 19:02:13 +0000")
Message-ID: <875zx2fyga.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] hw/bt: drop bluetooth keyboard emulation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 9 November 2018 at 14:14, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> Broken (segfaultson first keypress) and appearently unused.
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Please show the reproducer in the commit message.  Stack backtrace
wouldn't hurt.

>> ---
>>  include/hw/bt.h     |   3 -
>>  hw/bt/hid.c         | 554 ----------------------------------------------------
>>  vl.c                |  34 +---
>>  hw/bt/Makefile.objs |   3 +-
>>  qemu-options.hx     |   9 -
>>  5 files changed, 2 insertions(+), 601 deletions(-)
>>  delete mode 100644 hw/bt/hid.c
>
> Are we definitely happy that all the use cases for
> this code segfault, not just the one you tested ?

Are there any others?

> Does it cost us much to mark this deprecated in 3.1
> and drop it in 4.0 ?

The cost is offering a known-to-be-broken option to users.

The other half of the tradeoff: what would it gain us?
