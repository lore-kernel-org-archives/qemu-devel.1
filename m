Received: from eggs.gnu.org ([2001:4830:134:3::10]:38410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpcel-0002jT-8W
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpceh-0001vk-5V
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:54:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dpceg-0001vH-VX
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:54:19 -0400
Date: Wed, 6 Sep 2017 17:54:13 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170906175413.57fecf21.cohuck@redhat.com>
In-Reply-To: <CAFEAcA9oOmX1u2zYHJ28AYFDUXVUs=8i04fC05TsxopbvxPmBQ@mail.gmail.com>
References: <20170906094927.22376-1-cohuck@redhat.com>
	<20170906132936.7cf49b24.cohuck@redhat.com>
	<CAFEAcA9oOmX1u2zYHJ28AYFDUXVUs=8i04fC05TsxopbvxPmBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] accel: default to an actually
 available accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, 6 Sep 2017 15:35:16 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 6 September 2017 at 12:29, Cornelia Huck <cohuck@redhat.com> wrote:
> > On Wed,  6 Sep 2017 11:49:27 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:  
> >> @@ -79,8 +98,7 @@ void configure_accelerator(MachineState *ms)
> >>
> >>      accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
> >>      if (accel == NULL) {
> >> -        /* Use the default "accelerator", tcg */
> >> -        accel = "tcg";
> >> +        accel = default_accelerator();  
> >
> > It actually may be easier to just switch the default to
> > "tcg:kvm:xen:hax". Haven't tested that, though.  
> 
> Does it make sense to include Xen in the default list?
> I don't know much about Xen but I was under the impression
> that it's a special purpose thing that you can only use
> as part of a Xen setup, whereas tcg, kvm, hax are all
> more-or-less interchangeable ways to run a VM under a
> Linux/etc host. Do I have the wrong end of the Xen stick?

I'm unfortunately not familiar with xen either.

I was going with what configure considers as an available accelerator
(in supported_target()). FWIW, I can build x86_64 with xen as the only
available accelerator, but have not been able to get it to work (in all
of the 5 minutes I tried). I can't get it to build with hax as the only
accelerator (although configure does not complain; I might be missing
something).

Switching the default from "tcg" to "tcg:kvm" would already fix the
problem for s390x ;), but maybe someone else has a better idea?
