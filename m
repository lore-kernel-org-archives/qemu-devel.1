Received: from eggs.gnu.org ([2001:4830:134:3::10]:59078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g7FTn-0001mm-2f
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 03:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g7FTi-0004CT-Cj
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 03:52:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1g7FTf-0004Bx-92
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 03:52:21 -0400
References: <CAFEAcA_gCh-uSbMMbtbH9DsOLgzHhUgMABBSnLOYy7avW7DXxg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <16f5d73f-441c-0d25-ad6d-624641119d85@redhat.com>
Date: Tue, 2 Oct 2018 09:52:16 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_gCh-uSbMMbtbH9DsOLgzHhUgMABBSnLOYy7avW7DXxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 2018-09-27 10:11, Peter Maydell wrote:
> I had a look at how many devices are still using the SysBus init
> method (rather than the instance-init/realize pair), and it turns out
> to be only 41, which I think is reasonably tractable for doing some
> more conversions and completing this API transation.
[...]
> I'll probably have a look at some of the arm devices on the
> list at some point.
> 
> I would recommend that we do this by picking a handful
> of related devices (eg same board/target arch) and converting
> them, rather than trying to do the whole lot at once. We
> can gradually whittle down the number of remaining devices.

I think this is also a good candidate for
https://wiki.qemu.org/BiteSizedTasks ... if you agree, could you please
add an entry there (including a link to an example, if possible)?

 Thomas
