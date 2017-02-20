Received: from eggs.gnu.org ([2001:4830:134:3::10]:54169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cfp98-0006hS-Tq
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cfp95-0003ib-Px
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:40:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cfp95-0003iC-JZ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:40:55 -0500
Date: Mon, 20 Feb 2017 15:40:50 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170220154050.413c17b8@nial.brq.redhat.com>
In-Reply-To: <8cd4af0d-9e30-6949-36f5-04b0e585f455@redhat.com>
References: <cover.1487286467.git.ben@skyportsystems.com>
	<88232638f9ff3b17b54987624468678ea14a3037.1487286467.git.ben@skyportsystems.com>
	<20170217114321.6c8577e1@nial.brq.redhat.com>
	<918524f7-26cf-3fce-d9e3-7316ca69285b@redhat.com>
	<20170220102304.GC2372@work-vm>
	<1ea5fff1-6216-8a8f-1e98-571253a3f596@redhat.com>
	<20170220110014.GD2372@work-vm>
	<1b2ce22b-3085-af08-332c-9519322b207e@redhat.com>
	<20170220141335.3bbb9681@nial.brq.redhat.com>
	<8cd4af0d-9e30-6949-36f5-04b0e585f455@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 4/8] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: mst@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, ben@skyportsystems.com, qemu-devel@nongnu.org

On Mon, 20 Feb 2017 14:28:11 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> On 02/20/17 14:13, Igor Mammedov wrote:
> > On Mon, 20 Feb 2017 12:38:06 +0100
> > Laszlo Ersek <lersek@redhat.com> wrote:
[...]
> >> Interesting! I hope Igor can double-check this!  
> > I've retested v7, and it reliably fails (vmgenid_wait doesn't see change)
> > then I tested v8(qemu) + (seabios v5/v4) with the same steps as before
> > and it appears to work as expected, i.e. vmgenid_wait reports GUID
> > change after executing 'continue' monitor command so something
> > has been fixed in v8.  
> 
> Yes, I know what. Please see item (2) in this reply of mine, for v7 1/8:
> 
> msgid: <9e222b4c-c05d-8fd0-6c55-4b2e52cab7b0@redhat.com>
> URL: https://www.mail-archive.com/qemu-devel@nongnu.org/msg430440.html
> 
> With that copy/paste bug in the code, the "src_offset" field of
> WRITE_POINTER was not populated correctly. The BIOS would carry that out
> faithfully, of course, but then later QEMU would write the fresh GUID to
> an incorrect offset in the guest firmware allocated area -- the offset
> wouldn't match the AML code (ADDR method), so the guest OS wouldn't see
> the change.
> 
> 
> If you scroll to the end of my message linked above, I wrote -- again,
> for v7 --:
> 
>     I also tested this series (with the assignment under (2) fixed up,
>     of course), as documented earlier in
> <https://www.mail-archive.com/qemu-devel@nongnu.org/msg430075.html>
>     (msgid  <678c203f-3768-7e65-6e48-6729473b6...@redhat.com>).
> 
>     Hence, with (1) and (2) fixed, you can also add
> 
>     Tested-by: Laszlo Ersek <ler...@redhat.com>
> 
> In other words, my positive testing for v7 was conditional on my *local*
> (but reported, suggested) fix for bug (2) in v7 1/8. And that issue has
> been fixed in v8.
> 
> ... So, I guess we're all OK now. Can you confirm please?
Confirmed

> 
> Thanks!
> Laszlo
[...]
