Received: from eggs.gnu.org ([2001:4830:134:3::10]:37918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3YsJ-0004eV-MH
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 22:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3YsE-0004lG-OM
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 22:09:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d3YsE-0004l3-Hh
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 22:09:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5514BC04BD2B
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 02:09:37 +0000 (UTC)
Date: Thu, 27 Apr 2017 10:09:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170427020931.GD26792@pxdev.xzpeter.org>
References: <1493192675-16104-1-git-send-email-peterx@redhat.com>
	<1493192675-16104-3-git-send-email-peterx@redhat.com>
	<8760hrxtcn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8760hrxtcn.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] ramblock: add new hmp command "info
 ramblock"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Apr 26, 2017 at 02:10:16PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > To dump information about ramblocks. It looks like:
> >
> > (qemu) info ramblock
> >               Block Name    PSize              Offset               Used              Total
> >             /objects/mem       2M  0x0000000000000000 0x0000000080000000 0x0000000080000000
> >                 vga.vram       4K  0x0000000080060000 0x0000000001000000 0x0000000001000000
> >     /rom@etc/acpi/tables       4K  0x00000000810b0000 0x0000000000020000 0x0000000000200000
> >                  pc.bios       4K  0x0000000080000000 0x0000000000040000 0x0000000000040000
> >   0000:00:03.0/e1000.rom       4K  0x0000000081070000 0x0000000000040000 0x0000000000040000
> >                   pc.rom       4K  0x0000000080040000 0x0000000000020000 0x0000000000020000
> >     0000:00:02.0/vga.rom       4K  0x0000000081060000 0x0000000000010000 0x0000000000010000
> >    /rom@etc/table-loader       4K  0x00000000812b0000 0x0000000000001000 0x0000000000001000
> >       /rom@etc/acpi/rsdp       4K  0x00000000812b1000 0x0000000000001000 0x0000000000001000
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> You implemented this just for HMP.
> 
> In general, functionality available in HMP should also available in QMP.
> Exceptions include functionality that makes no sense in QMP, or is of
> use only for human users.  If you think your command is an exception,
> please explain why in the commit message.
> 
> If it isn't, you need to implement it for QMP, then rewrite the HMP
> version to reuse either the QMP command or a common core.

I see. I think it should belongs to the first condition, which should
only be used by human users, especially developers. Maybe I can repost
with some more comment in the commit message to emphasize that.

But, before that, I would also want to know whether anyone would think
this an useful thing even to QMP... If so, I would be glad to provide
QMP interface as well.

Thanks,

-- 
Peter Xu
