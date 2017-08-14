Received: from eggs.gnu.org ([2001:4830:134:3::10]:49256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dhGSl-0003Kw-5j
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dhGSh-00025r-SM
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:35:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dhGSh-00023T-MB
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:35:23 -0400
Date: Mon, 14 Aug 2017 17:35:19 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170814173419-mutt-send-email-mst@kernel.org>
References: <1502431076-22849-1-git-send-email-thuth@redhat.com>
	<20170811114922.2edda3a7.cohuck@redhat.com>
	<20170811121905.22bdc575.cohuck@redhat.com>
	<8783416d-367e-3a7c-76b5-eb979b0c8625@redhat.com>
	<20170811134355.0b0dfe58.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170811134355.0b0dfe58.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Victor Kaplansky <victork@redhat.com>

On Fri, Aug 11, 2017 at 01:43:55PM +0200, Cornelia Huck wrote:
> On Fri, 11 Aug 2017 12:52:54 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
> > On 11.08.2017 12:19, Cornelia Huck wrote:
> 
> > > A quick test on x86_64 with --disable-tcg showed no further problems
> > > than boot-serial-test, so at least it's only the one for now (and it
> > > might make sense to simply use accel=tcg:kvm for it).  
> > 
> > $ grep -rl accel=tcg tests/
> > tests/pnv-xscom-test.c
> > tests/boot-serial-test.c
> > tests/prom-env-test.c
> > 
> > ... so the other problematic tests are for ppc only - which does not
> > support --disable-tcg yet.
> 
> I'll send a patch for boot serial, then. You probably know more about
> whether the ppc tests would make sense with kvm as well than I do :)

Weird I thought I fixed that one.  Tweaking that is trivial though.
Posted - could someone try on ppc pls? If it helps pls merge through the
ppc tree.

-- 
MST
