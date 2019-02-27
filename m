Received: from eggs.gnu.org ([209.51.188.92]:51322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gyzUN-0005cE-LQ
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:43:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gyzMU-0005Vq-4y
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:35:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32899)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gyzMS-0005OD-7s
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:35:00 -0500
Date: Wed, 27 Feb 2019 12:58:35 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190227125834.GF2602@work-vm>
References: <1550847320-25110-1-git-send-email-jasowang@redhat.com>
	<1550847320-25110-11-git-send-email-jasowang@redhat.com>
	<30e7bd39-7ca1-fd1a-1864-b3a0a390f4fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30e7bd39-7ca1-fd1a-1864-b3a0a390f4fc@redhat.com>
Subject: Re: [Qemu-devel] [PULL 10/13] tests: Add a test for qemu self
 announcements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, Vlad Yasevich <vyasevic@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

* Thomas Huth (thuth@redhat.com) wrote:
> On 22/02/2019 15.55, Jason Wang wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > We now expose qemu_announce_self through QMP and HMP.  Add a test
> > with some very basic packet validation (make sure we get a RARP).
> > 
> > Signed-off-by: Vlad Yasevich <vyasevic@redhat.com>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  tests/Makefile.include     |  3 ++
> >  tests/test-announce-self.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 86 insertions(+)
> >  create mode 100644 tests/test-announce-self.c
> > 
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index b39e989..1b0874c 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -144,6 +144,7 @@ check-qtest-generic-y += tests/qmp-cmd-test$(EXESUF)
> >  
> >  check-qtest-generic-y += tests/device-introspect-test$(EXESUF)
> >  check-qtest-generic-y += tests/cdrom-test$(EXESUF)
> > +gcov-files-generic-y = migration/savevm.c
> 
> AFAIK you don't need these gcov lines anymore. See commit
> 26830e9325d05d537dd9a3765437908771d19475.

Deleted, thanks.

Dave

> 
>  Thomas
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
