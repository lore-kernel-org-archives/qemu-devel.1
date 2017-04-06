Received: from eggs.gnu.org ([2001:4830:134:3::10]:46601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cw3fg-00008b-M4
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cw3fd-0000nB-Gv
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:25:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cw3fd-0000n1-AL
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:25:37 -0400
Date: Thu, 6 Apr 2017 10:25:31 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170406092530.GD2135@work-vm>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<CAFEAcA9cM=LjBRzrZdfsOss2xm4bKC6QM7gyg3HD4z-yeumTyw@mail.gmail.com>
	<940ff281-82cd-18cf-160e-c5234f65db18@redhat.com>
	<9d6c61bc-4a95-ce72-3565-e498f9c2b351@redhat.com>
	<b815c2f9-1ce9-efed-4afa-c3553786dab1@redhat.com>
	<7829c1dc-9138-c784-dcc5-3c46ec9b5c05@innervision.pl>
	<20170309122641.GE2480@work-vm>
	<a153e773-52c1-5d49-e78d-387eb0e712b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a153e773-52c1-5d49-e78d-387eb0e712b5@redhat.com>
Subject: Re: [Qemu-devel] external snapshots freezes block device since qemu
 2.8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Piotr Rybicki <piotr.rybicki@innervision.pl>, qemu-devel@nongnu.org

* John Snow (jsnow@redhat.com) wrote:
> 
> 
> On 03/09/2017 07:26 AM, Dr. David Alan Gilbert wrote:
> > * Piotr Rybicki (piotr.rybicki@innervision.pl) wrote:
> >> Hello there.
> >>
> >> I discovered, that since qemu 2.8 , external snapshots (very similar to:
> >> http://wiki.libvirt.org/page/Live-disk-backup-with-active-blockcommit),
> >> freezes block device after:
> >>
> >> # virsh blockcommit (...)
> >>
> >> There is no error message after completion of the command above.
> >> I'm using gluster + ZFS fuse mount as a storage for a VM on gentoo.
> >> libvirt debug showed nothing helpful.
> >> With qemu <2.8 -: snapshots are working as expected.
> >>
> >> Is this a known issue?
> >> Is it qemu or libvirt ?
> >>
> >> If it helps, how can i diagnose this further?
> > 
> > I don't know of it, cc'd in jsnow.
> > Have you tried bisecting?
> > 
> > Dave
> > 
> >> Thank You & Best regards
> >> Piotr Rybicki
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
> I'm cleaning out my inbox and I seem to have missed this thread. Was
> there any resolution?

Not that I remember.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
