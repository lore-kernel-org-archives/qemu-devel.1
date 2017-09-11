Received: from eggs.gnu.org ([2001:4830:134:3::10]:58509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drNFW-0001IG-Q6
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drNFW-0005T0-4g
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:51:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1drNFV-0005S9-UZ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:51:34 -0400
Date: Mon, 11 Sep 2017 13:51:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170911135129.365b3cdf.cohuck@redhat.com>
In-Reply-To: <afe815b5-d5a6-8b22-b30f-50f52dbe540e@redhat.com>
References: <20170906094927.22376-1-cohuck@redhat.com>
	<20170906132936.7cf49b24.cohuck@redhat.com>
	<CAFEAcA9oOmX1u2zYHJ28AYFDUXVUs=8i04fC05TsxopbvxPmBQ@mail.gmail.com>
	<afe815b5-d5a6-8b22-b30f-50f52dbe540e@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Mon, 11 Sep 2017 13:48:46 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 06/09/2017 16:35, Peter Maydell wrote:
> >>>      accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
> >>>      if (accel == NULL) {
> >>> -        /* Use the default "accelerator", tcg */
> >>> -        accel = "tcg";
> >>> +        accel = default_accelerator();  
> >> It actually may be easier to just switch the default to
> >> "tcg:kvm:xen:hax". Haven't tested that, though.  
> > Does it make sense to include Xen in the default list?
> > I don't know much about Xen but I was under the impression
> > that it's a special purpose thing that you can only use
> > as part of a Xen setup, whereas tcg, kvm, hax are all
> > more-or-less interchangeable ways to run a VM under a
> > Linux/etc host. Do I have the wrong end of the Xen stick?  
> 
> Yes, that is correct (in fact, -xen-domid is required too).

OK, so we should use "tcg:kvm:hax"?

(Not sure how useful the hax statement is, I'm not familiar with that
one.)
