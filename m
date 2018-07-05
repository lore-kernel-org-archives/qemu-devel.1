Received: from eggs.gnu.org ([2001:4830:134:3::10]:46196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fb7p2-0004Kr-0E
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fb7oy-0000C8-2Z
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:13:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56138 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fb7ox-00009D-Tm
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:13:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0EAA3400ADCC
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 17:13:26 +0000 (UTC)
Date: Thu, 5 Jul 2018 18:13:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180705171320.GM3814@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180705123929.GB16293@redhat.com>
	<20180705125231.GD16293@redhat.com>
	<d154245b-46c0-58b0-b6f9-1f1313634c80@redhat.com>
	<20180705164343.GE16293@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180705164343.GE16293@redhat.com>
Subject: Re: [Qemu-devel] Byte ordering of VM Generation ID in Windows VMs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, jferlan@redhat.com

On Thu, Jul 05, 2018 at 05:43:43PM +0100, Richard W.M. Jones wrote:
> On Thu, Jul 05, 2018 at 04:20:33PM +0200, Laszlo Ersek wrote:
> > QEMU does the right thing. If other hypervisors don't do this -- while
> > still taking and displaying the value in UUID / GUID textual format --,
> > they are wrong. The VMGENID spec from Microsoft
> > <http://go.microsoft.com/fwlink/?LinkId=260709> specifically mentions
> > "GUID".
> 
> The MSFT spec does mention GUID, but it seems to me that it's only
> using GUID as an incidental example -- ie. that you might use the VM
> Generation ID to generate a GUID.  Outside that example it
> consistently refers to the VM Gen ID as a 128-bit integer.  It also
> says that it could be used as a "high entropy random data source",
> which is not in fact true if it's a UUID.
> 
> It has to be said that after reading the spec again [the MSFT spec,
> not qemu's spec] and what other hypervisors are doing, I'm not sure
> qemu is doing the right thing here.

I'm not sure it particularly matters, as long as there is a way to
encode the 128-bit integer as a UUID without irreversable mangling
or data loss.  We could document it, or if we really wanted to,
provide an alternative syntax that QEMU internals changes into its
UUID form (or the reverse).  Libvirt would probably still need to
expose it as a UUID though, due to compatibility needs in the XML.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
