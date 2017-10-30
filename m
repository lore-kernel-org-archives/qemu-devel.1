Received: from eggs.gnu.org ([2001:4830:134:3::10]:37439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e9GTW-0005ij-SI
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e9GTS-0001yU-9m
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:15:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e9GTS-0001wh-3M
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:15:54 -0400
Date: Mon, 30 Oct 2017 20:15:49 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171030201549.GE8941@work-vm>
References: <7CA6B03C-DFAA-4A15-9E33-E3FAD6647140@gmail.com>
	<38c3125f-b050-c0ba-282f-bc1e9e11d297@redhat.com>
	<20171029102106.GA2841@work-vm>
	<847196B3-8C4D-4B8E-A6A4-5ADAEC73FF62@gmail.com>
	<20171030143220.GA5438@work-vm>
	<40acf44f-a8d2-890e-556b-02f551b05f2d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40acf44f-a8d2-890e-556b-02f551b05f2d@redhat.com>
Subject: Re: [Qemu-devel] drive_add: file names with spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Programmingkid <programmingkidx@gmail.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

* Eric Blake (eblake@redhat.com) wrote:
> On 10/30/2017 03:32 PM, Dr. David Alan Gilbert wrote:
> 
> > Now, the real challenge is how to deal with a filename with a comma in;
> >    drive_add 1 "file=foo,bar"
> >    Could not open 'foo': No such file or directory
> > 
> 
> Does HMP use the QemuOpts parser?  If so, try:
> 
> drive_add 1 "file=foo,,bar"
> 
> (that is, reproduce the double-comma escaping mechanism that we use on
> the command line).
> 
> But I haven't personally tried this, so I have no idea if it will help.

Ah yes it does;  I never knew that worked.

Dave

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
