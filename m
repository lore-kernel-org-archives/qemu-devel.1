Received: from eggs.gnu.org ([209.51.188.92]:56532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGJGK-0006S3-68
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGJGJ-0004Xl-0J
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:16:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hGJGI-0004Vz-Od
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:16:14 -0400
Date: Tue, 16 Apr 2019 09:16:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190416081605.GB31311@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1555124080-27089-1-git-send-email-puwen@hygon.cn>
	<20190415203917.GA32317@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190415203917.GA32317@habkost.net>
Subject: Re: [Qemu-devel] [PATCH v2] i386: Add new Hygon 'Dhyana' CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Pu Wen <puwen@hygon.cn>, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com, marcel.apfelbaum@gmail.com

On Mon, Apr 15, 2019 at 05:39:17PM -0300, Eduardo Habkost wrote:
> On Sat, Apr 13, 2019 at 10:54:40AM +0800, Pu Wen wrote:
> > Add a new base CPU model called 'Dhyana' to model processors from Hygon
> > Dhyana(family 18h), which derived from AMD EPYC(family 17h).
> > 
> > The following features bits have been removed compare to AMD EPYC:
> > aes, pclmulqdq, sha_ni
> > 
> > The Hygon Dhyana support to KVM in Linux is already accepted upstream[1].
> > So add Hygon Dhyana support to Qemu is necessary to create Hygon's own
> > CPU model.
> > 
> > Reference:
> > [1] https://git.kernel.org/tip/fec98069fb72fb656304a3e52265e0c2fc9adf87
> > 
> > Signed-off-by: Pu Wen <puwen@hygon.cn>
> 
> Thanks for the patch.
> 
> I'm wondering if we should let the CPU model be used only on
> Hygon hosts, to avoid confusion.

Why should we artificially restrict it ?  All the other CPUs are able to
be used on any host that is able to support the feature list required by
the CPU model. If some other host has sufficient features to run Dhyana
the CPU model we shouldn't block it.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
