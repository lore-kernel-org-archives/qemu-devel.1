Received: from eggs.gnu.org ([2001:4830:134:3::10]:47568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dg8MO-0003lC-HR
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dg8MK-0000xQ-Lk
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:44:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dg8MK-0000x4-Ed
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:44:08 -0400
Date: Fri, 11 Aug 2017 13:43:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170811134355.0b0dfe58.cohuck@redhat.com>
In-Reply-To: <8783416d-367e-3a7c-76b5-eb979b0c8625@redhat.com>
References: <1502431076-22849-1-git-send-email-thuth@redhat.com>
	<20170811114922.2edda3a7.cohuck@redhat.com>
	<20170811121905.22bdc575.cohuck@redhat.com>
	<8783416d-367e-3a7c-76b5-eb979b0c8625@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11 0/2] Improvements for the pxe
 tester
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Victor Kaplansky <victork@redhat.com>

On Fri, 11 Aug 2017 12:52:54 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 11.08.2017 12:19, Cornelia Huck wrote:

> > A quick test on x86_64 with --disable-tcg showed no further problems
> > than boot-serial-test, so at least it's only the one for now (and it
> > might make sense to simply use accel=tcg:kvm for it).  
> 
> $ grep -rl accel=tcg tests/
> tests/pnv-xscom-test.c
> tests/boot-serial-test.c
> tests/prom-env-test.c
> 
> ... so the other problematic tests are for ppc only - which does not
> support --disable-tcg yet.

I'll send a patch for boot serial, then. You probably know more about
whether the ppc tests would make sense with kvm as well than I do :)
