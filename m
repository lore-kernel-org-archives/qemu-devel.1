Received: from eggs.gnu.org ([2001:4830:134:3::10]:46239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQ7YZ-000724-T2
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 04:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQ7YW-0004nn-QV
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 04:43:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56540 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fQ7YW-0004na-KD
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 04:43:04 -0400
Date: Tue, 5 Jun 2018 09:43:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180605084300.GF32286@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
	<20180605072746.v6xxabsbewiuw7ka@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180605072746.v6xxabsbewiuw7ka@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH RFC] hw/pc: set q35 as the default x86
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, Jun 05, 2018 at 09:27:46AM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > >   Add to that shortcuts like -cdrom
> > > stop working,
> > 
> > Maybe is fixable.
> 
> Already fixed for ages.
> 
> > I see marking Q35 as the default machine a first step.
> 
> Maybe the better option is to go the arm route:  Just don't define a
> default, so users have to specify pc or q35.  That will make them notice
> there is a world beside 'pc', and we also avoid breaking things
> silently.

If QEMU removes the default, then libvirt will have to hardcode
'pc' as the default to maintain back compatibility, so I don't
think that ends up as a net win

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
