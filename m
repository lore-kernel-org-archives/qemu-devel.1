Received: from eggs.gnu.org ([2001:4830:134:3::10]:37058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gSMeC-0000u8-GF
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 08:46:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gSMe7-0004KD-ND
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 08:46:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34461)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gSMe3-0004Gn-Nw
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 08:46:20 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CDF33082A36
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 13:46:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20181128101603-mutt-send-email-mst@kernel.org> (Michael
	S. Tsirkin's message of "Wed, 28 Nov 2018 10:16:44 -0500")
References: <20181126200009.862-1-quintela@redhat.com>
	<20181127221219-mutt-send-email-mst@kernel.org>
	<874lc13arc.fsf@trasno.org>
	<20181128101603-mutt-send-email-mst@kernel.org>
Reply-To: quintela@redhat.com
Date: Thu, 29 Nov 2018 14:46:01 +0100
Message-ID: <87h8g00zfq.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 00/16] Virtio devices split from
 virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

"Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, Nov 28, 2018 at 08:46:15AM +0100, Juan Quintela wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> > On Mon, Nov 26, 2018 at 08:59:53PM +0100, Juan Quintela wrote:
>> >> Hi
>> >> 
>> >> V2:
>> >> 
>> >> - Rebase on top of master
>> >> 
>> >> Please review.
>> >> 
>> >> Later, Juan.
>> >
>> > And just making sure the point is so that one
>> > can disable virtio-pci and still build virtio?
>> >
>> > And the point of that is mostly as a cleanup on
>> > generic principles, right? Or is there a project that
>> > actually wants to do it?
>> 
>> This allows "make check" to work with them disabled.  Without this
>> changes, introspection fails, because we have the "name" (kind of)
>> "virtio-pci-blk", but not the real virtio device, so it tries to use it
>> while it is not there.  See the equivalent change for virtio-ccw-*.
>> 
>> Thanks, Juan.
>> 
>> PD.  Without this change, you can build a qemu with virtio devices
>>      disabled (i.e. not compiled in), but it fails "make check".  With
>>      the changes, it also works for "make check".
>
> And just to complete the picture the point of that is I guess enabling
> testing of random configs?

Not yet.
But for developing, I try _not_ to compile the bits that I am not
using.  Here I just went for being general.  After this patches, you can
disable  all CONFIG_VIRTIO_* stuff, and "make check" still works.
(Ok CONFIG_VIRTIO_GPU/VGA can't be disable, it needs changes inside the
tests themselves).

Later, Juan.
