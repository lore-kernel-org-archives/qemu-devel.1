Received: from eggs.gnu.org ([2001:4830:134:3::10]:57790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cjV1X-000699-Mm
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:00:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cjV1S-0007Nh-4r
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:00:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cjV1R-0007Mh-Vm
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:00:14 -0500
Date: Thu, 2 Mar 2017 15:00:09 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170302180009.GS2778@thinpad.lan.raisama.net>
References: <20170227162501.29280-1-ehabkost@redhat.com>
	<CAFEAcA8b_tdQAP6YVDRaZKzHLed5xKbfABtJUV0U43HpkTiBdg@mail.gmail.com>
	<20170227194134.GH2778@thinpad.lan.raisama.net>
	<20170227205753.60b8a225@bahia.lan>
	<20170228191226.GI2778@thinpad.lan.raisama.net>
	<CAFEAcA8iZG8yB=4an9O2Mroej8bWNHBcANxsJkCOVbKHcxaGRg@mail.gmail.com>
	<20170302153913.GQ2778@thinpad.lan.raisama.net>
	<9dd3053b-1faf-e7a2-1cd7-aea934f5dc3c@redhat.com>
	<20170302160734.GB11509@thinpad.lan.raisama.net>
	<CAFEAcA_rB9biK2sic1NCtMkk-w=5Zis+SjtB22+Jw4e4zzUc6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_rB9biK2sic1NCtMkk-w=5Zis+SjtB22+Jw4e4zzUc6g@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, Mar 02, 2017 at 04:16:53PM +0000, Peter Maydell wrote:
> On 2 March 2017 at 16:07, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > Earlier this week I saw the wait_for_fds assertion (mentioned at
> > the thread above) on a travis-ci job again, and I was suspecting
> > it was the same vhost_set_mem_table() + TCG error seen at the
> > thread above.
> >
> > Unfortunately travis-ci overwrote the previous logs when I
> > restarted the job, and now I can't confirm if it was really the
> > same vhost_set_mem_table() error. I guess we'll have to simply
> > wait and see if it fails again.
> 
> Here's a fresh new travis job failing like that:
> https://travis-ci.org/qemu/qemu/builds/207005044
> (specifically https://travis-ci.org/qemu/qemu/jobs/207005050)

Indeed, it is not exactly the same TCG-related error we've seen
in August. It looks like vhost-user-test + TCG is not as broken
as I thought.

-- 
Eduardo
