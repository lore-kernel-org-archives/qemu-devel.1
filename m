Received: from eggs.gnu.org ([2001:4830:134:3::10]:56193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dct62-0007CU-HC
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dct5w-0001SH-Hi
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:49:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dct5w-0001Rm-BT
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:49:48 -0400
Date: Wed, 2 Aug 2017 13:49:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170802124943.GA2380@work-vm>
References: <CAK6XCv6oYSL=gQKhv6N5e7y620szz5Wc5g13OOMd=C54Lc=O7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK6XCv6oYSL=gQKhv6N5e7y620szz5Wc5g13OOMd=C54Lc=O7w@mail.gmail.com>
Subject: Re: [Qemu-devel] Where is the VM live migration code?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aditya Bhardwaj <adityaform@gmail.com>
Cc: qemu-devel@nongnu.org

* Aditya Bhardwaj (adityaform@gmail.com) wrote:
> My lab setup is: 3 HP Servers each of 4 GB RAM. Server 1 and Server 2:
> installed with Virtualization using KVM on Redhat 6.5 System. On top of
> this I am using libvirtd for managing virtual machines. NFS server is
> installed on Server 3 for shared disk image. VM migration is working
> correctly. Now i need to do some changes in "migration.c" but did not find
> any source code of KVM-QEMU migration.
> 
> Where I can find the migration source code for KVM-QEMU. All are requested
> to help me for this issue.

Migration is quite big - so take a step back first and understand how
a migration works before diving into the code too far.
First I'd suggest going for something newer than 6.5 - it has a very
very old QEMU on it;  If you can upgrade to a 7.x it'll make your life a
lot easier for building and working with current code.

The current QEMU has a whole migration/ subdirectory with quite a bit of
code, and there's also some kernel code that helps, and code in
individual devices.

Then there's also the code in libvirt that drives it.

A lot of code - so the trick is to figure out what you want to change
and then find the right place.

Dave
> 
> 
> 
> 
> 
> *Thank youWith Regards:Aditya Bhardwaj*
> *Dept. of CSE *
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
