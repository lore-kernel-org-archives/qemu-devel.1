Received: from eggs.gnu.org ([2001:4830:134:3::10]:60412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVnJj-000502-NV
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 19:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVnJg-0004AJ-KG
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 19:14:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dVnJg-00049u-E2
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 19:14:40 -0400
Date: Fri, 14 Jul 2017 02:14:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170714020546-mutt-send-email-mst@kernel.org>
References: <1499847753-8513-1-git-send-email-thuth@redhat.com>
	<20170712150400.GH5237@redhat.com>
	<9d51d348-7ad6-a98d-3f6d-89e8af5e3a16@redhat.com>
	<20170712161254.GJ5237@redhat.com>
	<d3c71dc9-1286-802a-b663-7d37f97daf72@redhat.com>
	<20170712162901.GL5237@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170712162901.GL5237@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Jul 12, 2017 at 05:29:01PM +0100, Daniel P. Berrange wrote:
> Yep, I'm amenable to that POV too. It is entirely valid to say that if
> downstream distros need to care about such ancient back-compat, then they
> will just have to do the extra work to use git history to undelete any bits
> they need that upstream has discarded.

Unfortunately people seem to conflate compatibility question of live
migration and of booting images.

Live migration is a complex topic, and you always have a work
around of restarting the VM to upgrade if it does not work.

But I don't think we can stop supporting booting old images, ever, for
all versions that have a decent number of users, until someone develops
a tool to upgrade machine type in XML painlessly and safely.

If we can guarantee that changing pc-0.10 to pc-1.13 will keep booting,
then we should just alias one to another so people can stil start their
VMs. If we can't then we really can't drop old machine types from
booting point of view.

-- 
MST
