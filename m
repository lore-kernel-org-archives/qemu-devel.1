Received: from eggs.gnu.org ([2001:4830:134:3::10]:48822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eSJY5-0003pX-70
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 04:23:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eSJY4-00072w-53
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 04:23:25 -0500
Date: Fri, 22 Dec 2017 09:23:08 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171222092308.GF30605@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CACaajQsL3e+XWR0hBDLThmG_fd=ih-n+HJVz++XcnwLhhVstgg@mail.gmail.com>
	<56c5bcbb-02c0-a3f7-4363-e3141476b2f8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56c5bcbb-02c0-a3f7-4363-e3141476b2f8@redhat.com>
Subject: Re: [Qemu-devel] qemu 2.9.0 qcow2 file failed to open after hard
 server reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Vasiliy Tolstov <v.tolstov@selfip.ru>, qemu-devel <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On Thu, Dec 21, 2017 at 05:58:47PM -0500, John Snow wrote:
> 
> 
> On 12/21/2017 05:13 PM, Vasiliy Tolstov wrote:
> > Hi! Today my server have forced reboot and one of my vm can't start
> > with message:
> > qcow2: Marking image as corrupt: L2 table offset 0x3f786d6c207600
> > unaligned (L1 index: 0); further corruption events will be suppressed
> > 
> > i'm use debian jessie with hand builded qemu 2.9.0, i'm try to
> > qemu-img check but it not helps. How can i recover data inside qcow2
> > file? (i'm not use compression or encryption inside it).
> > 
> 
> Not looking good if you're missing the very first L2 table in its entirety.
> 
> You might be able to go through this thing by hand and learn for
> yourself where the L2 table is (it will be a 64KiB region, aligned to a
> 64KiB boundary, that all contain 64bit, 64KiB aligned pointers that will
> be less than the size of the file. the offset of this missing region is
> not likely to be referenced elsewhere in your file.)

Fun. That rather makes you wish that every single distinct type of table
in QCow2 files had a unique UUID value stored in it, to make forensics
like this easier :-)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
