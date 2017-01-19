Received: from eggs.gnu.org ([2001:4830:134:3::10]:60184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cUFjm-0000Fh-3x
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cUFjl-0006uE-0O
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:38:58 -0500
Date: Thu, 19 Jan 2017 16:38:45 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170119163845.GC16641@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <0bb184fe-d348-a1d4-ac14-0f02f070c287@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0bb184fe-d348-a1d4-ac14-0f02f070c287@kamp.de>
Subject: Re: [Qemu-devel] qemu-img: complains about missing iscsi option
 group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Thu, Jan 19, 2017 at 05:30:20PM +0100, Peter Lieven wrote:
> Hi all,
> 
> 
> since commit f57b4b5 (blockdev: prepare iSCSI block driver for dynamic loading)
> 
> qemu-img complains about a missing option group several times.
> 
> 
> ~/git/qemu$ ./qemu-img info iscsi://172.21.200.56:3260/iqn.2001-05.com.equallogic:0-8a0906-69d384e0a-aa3004e55e15878d-00lieven-data/0
> qemu-img: There is no option group 'iscsi'
> qemu-img: There is no option group 'iscsi'
> qemu-img: There is no option group 'iscsi'
> qemu-img: There is no option group 'iscsi'
> image: iscsi://172.21.200.56:3260/iqn.2001-05.com.equallogic:0-8a0906-69d384e0a-aa3004e55e15878d-00lieven-data/0
> file format: raw
> virtual size: 25G (26848788480 bytes)
> disk size: unavailable
> cluster_size: 15728640
> 
> I don't know whats the proper way to fix this?

Move the iscsi option registration out of vl.c and back into a shared file
in block/ such that all programs see the options, not just the emulators.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
