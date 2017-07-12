Received: from eggs.gnu.org ([2001:4830:134:3::10]:44019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVJBY-00012E-FD
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVJBV-0002nY-3C
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:04:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dVJBU-0002nK-TH
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:04:13 -0400
Date: Wed, 12 Jul 2017 16:04:00 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170712150400.GH5237@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1499847753-8513-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1499847753-8513-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] hw/i386: Deprecate the machines pc-0.10
 to pc-1.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Jul 12, 2017 at 10:22:33AM +0200, Thomas Huth wrote:
> We don't want to carry along old machine types forever. If we are able to
> remove the pc machines up to 0.13 one day for example, this would allow
> us to eventually kill the code for rombar=0 (i.e. where QEMU copies ROM
> BARs directly to low memory). Everything up to pc-1.2 is also known to
> have issues with migration.  So let's start with a deprecation message
> for the old machine types so that the (hopefully) few users of these old
> systems start switching over to newer machine types instead.

I think we must document & agree on our support policy for machine
types, before we start marking them as deprecated. eg please consider
the following document before accepting this deprecation patch:

 https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00652.html

Note in that proposal there, I say we do *not* go through trouble of
explicitly marking machines as deprecated. We just document upfront
the intended lifecycle and then delete them when it is done.

Just use deprecation warnings for things where there is no predictable
lifecycle upfront.

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Note: Even if we mark all these old machines as deprecated, this ofcourse
>  doesn't mean that we also have to remove them all at once later when we
>  decide to finally really remove some. We could then also start by removing
>  0.10 and 0.11 only, for example (since there should really be no users left
>  for these), or only up to 0.13 (to be able to kill rombar=0).
> 
>  v3:
>  - Use a more generic approach by introducing a "deprecation_msg" in the
>    MachineClass instead.
> 
>  v2:
>  - Deprecate machines up to pc-1.2
> 
>  hw/i386/pc_piix.c   | 1 +
>  include/hw/boards.h | 1 +
>  vl.c                | 4 ++++
>  3 files changed, 6 insertions(+)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
