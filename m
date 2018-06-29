Received: from eggs.gnu.org ([2001:4830:134:3::10]:35996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYrLy-0007Dn-Kv
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:14:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYrLu-0000A3-L0
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:14:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37808 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYrLu-00009f-Dr
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:14:10 -0400
Date: Fri, 29 Jun 2018 12:14:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180629111405.GG27016@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <153026817452.402489.13386335348113684056.stgit@bahia.lan>
	<8730183a-3e16-931e-c990-24a5e169b2d9@redhat.com>
	<20180629103910.GE27016@redhat.com>
	<65a3597e-5560-1fd3-4f04-8a60e9e99b44@redhat.com>
	<20180629130701.6ab5d88a@bahia.lan>
	<29caab50-f853-66bf-805e-984e76619a9a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <29caab50-f853-66bf-805e-984e76619a9a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] accel: forbid early use of
 kvm_enabled() and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Jun 29, 2018 at 01:08:38PM +0200, Paolo Bonzini wrote:
> On 29/06/2018 13:07, Greg Kurz wrote:
> >>>> Also asserting current_machine != NULL is not necessary, since you're
> >>>> immediately dereferencing it.  
> >>> Is there a practical way to simply initialize the accelerators earlier
> >>> in startup sequence, so we just remove or at least reduce, the liklihood
> >>> of accessing it too early ?  
> >> We can try, though not for 3.0 of course.
> >>
> > FWIW, the motivation for this patch was kvm_enabled() being called under
> > the class_init function of the machine TypeInfo. This happens way earlier
> > than accelerator init. Not sure this is doable, but I can have a look.
> > 
> 
> Probably not, that's way too early indeed.

Yeah, doing anything non-trivial in class_init is just asking for trouble,
as conceivably nothing is initialized at that point. 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
