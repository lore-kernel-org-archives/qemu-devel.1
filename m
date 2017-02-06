Received: from eggs.gnu.org ([2001:4830:134:3::10]:55185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cagZo-00034D-Ar
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cagZn-0007bk-BN
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:31:16 -0500
Date: Mon, 6 Feb 2017 10:31:04 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170206103104.GD3029@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170126123530.GB23095@lemon.Home>
	<20170126132708.GB29127@redhat.com>
	<6a9aeec8-d4ee-a0aa-7e04-0ee4295fef80@redhat.com>
	<8a13c995-c094-2704-c770-214132b2d6cf@redhat.com>
	<20170201121658.GF3232@redhat.com>
	<c4d38998-b862-90e6-6c4b-4b96a8d17bb4@redhat.com>
	<20170201122854.GG3232@redhat.com>
	<37f445c0-c174-bca4-7073-7aa6c64046b0@redhat.com>
	<87bmul9hfc.fsf@dusky.pond.sub.org>
	<d03de140-db6b-26ed-6cc9-958591843483@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d03de140-db6b-26ed-6cc9-958591843483@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/6] qemu-img: add support for -n arg to
 dd command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Fri, Feb 03, 2017 at 07:56:11PM +0100, Max Reitz wrote:
> > In case you say that's inconvenient: pretty much everything about dd's
> > archaic user interface is inconvenient.  If you want convenient, roll
> > your own.  If you want familiar, stick to the original.
> 
> I agree. But qemu-img dd already is not dd. It interprets disk image
> files as virtual disks instead of as plain files. The question is
> whether virtual disks are to be treated as block devices or as files.
> 
> I don't have a strong opinion on the matter. Either way will surprise
> some people. The original issue was whether to make nocreat/notrunc a
> mandatory option, so if we didn't have any backwards compatibility
> issues, it would be the following two surprises:
> 
> (1) Don't make nocreat/notrunc mandatory (as it is now). Then people
>     who expect qemu-img dd to treat image files as block devices will
>     be surprised that all their data is gone. Bad.

I don't think people really expect qemu-img to treat image file as if
they were block devices when operating on the host.

It is like saying people expect /usr/bin/dd to treat a plain file
as a block device, because they might use it with losetup later.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
