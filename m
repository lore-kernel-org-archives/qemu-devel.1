Received: from eggs.gnu.org ([2001:4830:134:3::10]:39889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e9B7A-0005Vc-0K
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 10:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e9B74-0002z7-AU
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 10:32:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e9B74-0002xY-3t
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 10:32:26 -0400
Date: Mon, 30 Oct 2017 14:32:21 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171030143220.GA5438@work-vm>
References: <7CA6B03C-DFAA-4A15-9E33-E3FAD6647140@gmail.com>
	<38c3125f-b050-c0ba-282f-bc1e9e11d297@redhat.com>
	<20171029102106.GA2841@work-vm>
	<847196B3-8C4D-4B8E-A6A4-5ADAEC73FF62@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <847196B3-8C4D-4B8E-A6A4-5ADAEC73FF62@gmail.com>
Subject: Re: [Qemu-devel] drive_add: file names with spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

* Programmingkid (programmingkidx@gmail.com) wrote:
> 
> > On Oct 29, 2017, at 6:21 AM, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> > 
> > * Eric Blake (eblake@redhat.com) wrote:
> >> On 10/28/2017 06:44 AM, Programmingkid wrote:
> >>> I'm trying to use an image file that has spaces in its file name (and sometimes in the path) to be used as a USB flash drive. When I try adding the image file using the drive_add command I see this error: drive_add: extraneous characters at the end of the line
> >>> 
> >>> I have tried using single and double quotes around the file name but this does not help. Is there a way to use files that have spaces in it's name with drive_add?
> >> 
> >> Not in HMP, which lacks quoting.  (Unless you want to patch HMP to learn
> >> quoting)
> > 
> > I think it's already got that code at least in some places.
> > monitor_parse_arguments calls get_str, and get_str understands " wrapped
> > arguments.
> > 
> > drive_add 1 "file=foo bar"
> > 
> > gives me:
> > Could not open 'foo bar': No such file or directory
> > 
> > so I think that's doing the right thing.
> > 
> > Dave
> > 
> >> But using spaces in filenames works fine in QMP.
> >> 
> >> -- 
> >> Eric Blake, Principal Software Engineer
> >> Red Hat, Inc.           +1-919-301-3266
> >> Virtualization:  qemu.org | libvirt.org
> >> 
> > 
> > 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> Thank you so much for this info. It solved my problem :)

Now, the real challenge is how to deal with a filename with a comma in;
   drive_add 1 "file=foo,bar"
   Could not open 'foo': No such file or directory

Dave

> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
