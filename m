Received: from eggs.gnu.org ([2001:4830:134:3::10]:48625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cUGqi-0005X9-QE
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:50:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cUGqf-0004Je-IA
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:50:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cUGqf-0004IH-CI
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:50:09 -0500
Date: Thu, 19 Jan 2017 17:50:03 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170119175003.GJ16641@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170116195452.23532-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170116195452.23532-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] i386: Support "-cpu host" on TCG too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

On Mon, Jan 16, 2017 at 05:54:52PM -0200, Eduardo Habkost wrote:
> Change the meaning of "-cpu host" to "enable all features
> supported by the accelerator in the current host", so that it can
> be used to enable/query all features supported by TCG.
> 
> To make sure "host" is still at the end of the list in "-cpu
> help", add a "ordering" field that will be used when sorting the
> CPU model list.

To be clear, "-cpu host" for TCG is not talking about the actual
host OS feature support, right ? x86_64 TCG can be run on a ppc host,
so presumably "-cpu host" just means "all features that this TCG binary
is able to emulate" ?

This feels like it is introducing scope for confusion vs KVM -cpu host,
so I wonder if different naming is better for this.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
