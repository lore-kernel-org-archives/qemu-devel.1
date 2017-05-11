Received: from eggs.gnu.org ([2001:4830:134:3::10]:35338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d8rZU-0007ST-9g
	for qemu-devel@nongnu.org; Thu, 11 May 2017 13:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d8rZR-0001Oi-5T
	for qemu-devel@nongnu.org; Thu, 11 May 2017 13:08:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d8rZR-0001OI-0W
	for qemu-devel@nongnu.org; Thu, 11 May 2017 13:08:09 -0400
Date: Thu, 11 May 2017 18:08:04 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170511170804.GJ2078@work-vm>
References: <CAGKXQyc1VN19p8whSXAj6Hz_A7RNsOVA0Www-zJQwMBVNA7P1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGKXQyc1VN19p8whSXAj6Hz_A7RNsOVA0Www-zJQwMBVNA7P1Q@mail.gmail.com>
Subject: Re: [Qemu-devel] order of dirtying pages in vm live migration
 iterations
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
> Is it possible to have the order of dirtying pages in every iteration of vm
> live migration?

I don't understand the question; we only sync the the dirty map once per
iteration, so we only know that they got dirty sometime in the last
iteration.  We already know that's not great and could be improved.

Dave

> thanks a lot
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
