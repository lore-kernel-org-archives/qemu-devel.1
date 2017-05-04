Received: from eggs.gnu.org ([2001:4830:134:3::10]:60390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d6Inc-0005xV-B3
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d6InY-0004Th-KQ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:36:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d6InY-0004Sp-Dm
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:36:08 -0400
Date: Thu, 4 May 2017 16:36:03 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170504153602.GC2078@work-vm>
References: <CAGKXQyfNiBsRr832X6gQZZxkhnWYk0cqVvjPeGQPoCKF8e+9-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGKXQyfNiBsRr832X6gQZZxkhnWYk0cqVvjPeGQPoCKF8e+9-Q@mail.gmail.com>
Subject: Re: [Qemu-devel] QEMU_VM_SECTION START/END/PART/FULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ali saeedi <ali.saeedi56@gmail.com>
Cc: qemu-devel@nongnu.org

* ali saeedi (ali.saeedi56@gmail.com) wrote:
> Hi
> What are  "QEMU_VM_SECTION START/END/PART/FULL" in savevm.c ?
> please explain them to me.

A QEMU migration stream is a sequence of 'sections'.
There are 4 (main) types of section:

  FULL: The entire contents of a device - that's most cases

  START: The start of a devices data that we're going to save
         split across multiple sections
  PART: More of a device previously that we had already sent a
        START for
  END: The end of a device that we sent a START for

Most devices we can send in one go (FULL); but some devices
are 'iterative' and need to be broken up into chunks - RAM is
the most common example because it's a lot of data that changes as
we're saving it.

Dave

> thanks a lot.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
