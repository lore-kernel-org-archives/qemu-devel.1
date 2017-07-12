Received: from eggs.gnu.org ([2001:4830:134:3::10]:56869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVOD8-00083m-Ct
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 16:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVOD5-0003DD-7y
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 16:26:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dVOD5-0003Ch-2P
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 16:26:11 -0400
Date: Wed, 12 Jul 2017 17:26:00 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170712202600.GO6020@localhost.localdomain>
References: <1499847753-8513-1-git-send-email-thuth@redhat.com>
	<20170712150400.GH5237@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170712150400.GH5237@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Jul 12, 2017 at 04:04:00PM +0100, Daniel P. Berrange wrote:
> On Wed, Jul 12, 2017 at 10:22:33AM +0200, Thomas Huth wrote:
> > We don't want to carry along old machine types forever. If we are able to
> > remove the pc machines up to 0.13 one day for example, this would allow
> > us to eventually kill the code for rombar=0 (i.e. where QEMU copies ROM
> > BARs directly to low memory). Everything up to pc-1.2 is also known to
> > have issues with migration.  So let's start with a deprecation message
> > for the old machine types so that the (hopefully) few users of these old
> > systems start switching over to newer machine types instead.
> 
> I think we must document & agree on our support policy for machine
> types, before we start marking them as deprecated. eg please consider
> the following document before accepting this deprecation patch:
> 
>  https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00652.html
> 
> Note in that proposal there, I say we do *not* go through trouble of
> explicitly marking machines as deprecated. We just document upfront
> the intended lifecycle and then delete them when it is done.
> 
> Just use deprecation warnings for things where there is no predictable
> lifecycle upfront.

I'd bet most people won't read the deprecation policy
documentation, and a deprecation warning for 1 or 2 releases
would be still useful before we finally remove a machine-type.

-- 
Eduardo
