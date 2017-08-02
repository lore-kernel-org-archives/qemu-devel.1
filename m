Received: from eggs.gnu.org ([2001:4830:134:3::10]:42200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dcscH-0003ks-6a
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:19:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dcscC-0006QF-3E
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:19:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dcscB-0006Lu-U3
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:19:04 -0400
Date: Wed, 2 Aug 2017 13:18:56 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170802121856.GG4098@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAK6XCv6oYSL=gQKhv6N5e7y620szz5Wc5g13OOMd=C54Lc=O7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On Wed, Aug 02, 2017 at 04:25:08PM +0530, Aditya Bhardwaj wrote:
> My lab setup is: 3 HP Servers each of 4 GB RAM. Server 1 and Server 2:
> installed with Virtualization using KVM on Redhat 6.5 System. On top of
> this I am using libvirtd for managing virtual machines. NFS server is
> installed on Server 3 for shared disk image. VM migration is working
> correctly. Now i need to do some changes in "migration.c" but did not find
> any source code of KVM-QEMU migration.
> 
> Where I can find the migration source code for KVM-QEMU. All are requested
> to help me for this issue.

QEMU source code is in GIT

  https://git.qemu.org/gitweb.cgi?p=qemu.git;a=summary

in the 'migration' directory.

If you're new writing code for QEMU then see this page too

https://wiki.qemu.org/index.php/Documentation/GettingStartedDevelopers

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
