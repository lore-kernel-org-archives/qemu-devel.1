Received: from eggs.gnu.org ([2001:4830:134:3::10]:47699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cjTGX-0004Ii-Lb
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:07:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cjTGV-0006vF-0y
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:07:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cjTGU-0006ud-Rs
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:07:38 -0500
Date: Thu, 2 Mar 2017 13:07:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170302160734.GB11509@thinpad.lan.raisama.net>
References: <20170227162501.29280-1-ehabkost@redhat.com>
	<CAFEAcA8b_tdQAP6YVDRaZKzHLed5xKbfABtJUV0U43HpkTiBdg@mail.gmail.com>
	<20170227194134.GH2778@thinpad.lan.raisama.net>
	<20170227205753.60b8a225@bahia.lan>
	<20170228191226.GI2778@thinpad.lan.raisama.net>
	<CAFEAcA8iZG8yB=4an9O2Mroej8bWNHBcANxsJkCOVbKHcxaGRg@mail.gmail.com>
	<20170302153913.GQ2778@thinpad.lan.raisama.net>
	<9dd3053b-1faf-e7a2-1cd7-aea934f5dc3c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dd3053b-1faf-e7a2-1cd7-aea934f5dc3c@redhat.com>
Subject: Re: [Qemu-devel] travis-ci 'make check' timeouts (was Re: [PULL
 00/11] x86 queue, 2017-02-27)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, Mar 02, 2017 at 04:54:26PM +0100, Paolo Bonzini wrote:
> On 02/03/2017 16:39, Eduardo Habkost wrote:
> > On Tue, Feb 28, 2017 at 07:17:39PM +0000, Peter Maydell wrote:
> >> On 28 February 2017 at 19:12, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >>> I saw a failure on x86-pull-request that seemed to be because of
> >>> vhost-user-test[1]. However, after restarting the job, it
> >>> passed[2].
> >>
> >> I'm currently processing a patch which (hopefully) fixes
> >> vhost-user-test's intermittent failures:
> >> http://patchwork.ozlabs.org/patch/732747/
> > 
> > I'm not sure it will solve the issues on hosts without KVM. As
> > far as I can see, if vhost-user-test is working without KVM, it
> > is working by accident.
> 
> Well, it has worked for a while before the patch.

Before which patch?

>                                                    As long as you don't
> overwrite code with vhost-user data and then try to run that data,
> things will be fine.  Just not something you can use in practice, but it
> works in tests.

Earlier this week I saw the wait_for_fds assertion (mentioned at
the thread above) on a travis-ci job again, and I was suspecting
it was the same vhost_set_mem_table() + TCG error seen at the
thread above.

Unfortunately travis-ci overwrote the previous logs when I
restarted the job, and now I can't confirm if it was really the
same vhost_set_mem_table() error. I guess we'll have to simply
wait and see if it fails again.

-- 
Eduardo
