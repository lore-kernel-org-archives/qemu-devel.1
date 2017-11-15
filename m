Received: from eggs.gnu.org ([2001:4830:134:3::10]:36106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eF3bH-0002us-So
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 14:43:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eF3bD-0004om-Nj
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 14:43:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1eF3bD-0004oQ-Ha
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 14:43:51 -0500
Date: Wed, 15 Nov 2017 19:43:47 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171115194347.GA2450@redhat.com>
References: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
Subject: Re: [Qemu-devel] [qemu-img] support for XVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, libguestfs@redhat.com

On Wed, Nov 15, 2017 at 04:52:56PM +0100, Gandalf Corvotempesta wrote:
> I'm thinking if support for XVA files could be added to qemu-img
> The file-format is well known (it's just a tar archive) and there are scripts
> that are able to convert an XVA file to a RAW image. (ie:
> https://gist.github.com/miebach/0433947bcf053de23159)
> 
> Running these script on their own is very time consuming, as you have to
> extract the XVA, convert any disk image from "single chunks" to a raw image
> and then use qemu-img to convert from raw to qcow.
> 
> Maybe a native support will be able to skip some steps. (like the
> conversion from
> "single chunks" to raw and raw to qcow2)

Why not use the offset/size support in the raw driver?

We use that to access files inside OVA files (also a tar file with a
funny extension) in virt-v2v:

https://github.com/libguestfs/libguestfs/blob/994ca8d87361a4eb52a05bb4496b074fc9cb705a/v2v/input_ova.ml#L300

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top
