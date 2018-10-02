Received: from eggs.gnu.org ([2001:4830:134:3::10]:34863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7FgD-0006jC-PY
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7Fg8-0004e9-EP
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:05:16 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:37101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7Fg3-0004Yg-Ou
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:05:08 -0400
Received: by mail-oi1-x22c.google.com with SMTP id e17-v6so807265oib.4
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 01:05:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <16f5d73f-441c-0d25-ad6d-624641119d85@redhat.com>
References: <CAFEAcA_gCh-uSbMMbtbH9DsOLgzHhUgMABBSnLOYy7avW7DXxg@mail.gmail.com>
	<16f5d73f-441c-0d25-ad6d-624641119d85@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 09:04:45 +0100
Message-ID: <CAFEAcA84iJZsxRWvWxfs=zZ5yAs8vbC-528U1jkVxgZvq7rwAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] finishing the transition away from SysBus init
 methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 October 2018 at 08:52, Thomas Huth <thuth@redhat.com> wrote:
> On 2018-09-27 10:11, Peter Maydell wrote:
>> I had a look at how many devices are still using the SysBus init
>> method (rather than the instance-init/realize pair), and it turns out
>> to be only 41, which I think is reasonably tractable for doing some
>> more conversions and completing this API transation.
> [...]
>> I'll probably have a look at some of the arm devices on the
>> list at some point.
>>
>> I would recommend that we do this by picking a handful
>> of related devices (eg same board/target arch) and converting
>> them, rather than trying to do the whole lot at once. We
>> can gradually whittle down the number of remaining devices.
>
> I think this is also a good candidate for
> https://wiki.qemu.org/BiteSizedTasks ... if you agree, could you please
> add an entry there (including a link to an example, if possible)?

It's already listed in https://wiki.qemu.org/ToDo/CodeTransitions,
which BiteSizedTasks links to.

thanks
-- PMM
