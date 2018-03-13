Received: from eggs.gnu.org ([2001:4830:134:3::10]:35727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evg8A-0006TX-7d
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 05:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evg86-0007MM-LX
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 05:22:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51862 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evg86-0007Lw-FQ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 05:21:58 -0400
Date: Tue, 13 Mar 2018 09:21:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180313092154.GA3048@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <cover.1520867740.git.x1917x@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 00/30] Xen Q35 Bringup patches +
 support for PCIe Extended Capabilities for passed through devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Gerasimenko <x1917x@gmail.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

The subject line says to expect 30 patches, but you've only sent 18 to
the list here. I eventually figured out that the first 12 patches were
in Xen code and so not sent to qemu-devel.

For future if you have changes that affect multiple completely separate
projects, send them as separate series. ie just send PATCH 00/18 to
QEMU devel so it doesn't look like a bunch of patches have gone missing.

On Tue, Mar 13, 2018 at 04:33:45AM +1000, Alexey Gerasimenko wrote:
> How to use the Q35 feature:
> 
> A new domain config option was implemented: device_model_machine. It's
> a string which has following possible values:
> - "i440" -- i440 emulation (default)
> - "q35"  -- emulate a Q35 machine. By default, the storage interface is
>   AHCI.

Presumably this is mapping to the QEMU -machine arg, so it feels desirable
to keep the same naming scheme. ie allow any of the versioned machine
names that QEMU uses. eg any of "pc-q35-2.x" versioned types, or 'q35' as
an alias for latest, and use "pc-i440fx-2.x" versioned types of 'pc' as
an alias for latest, rather than 'i440' which is needlessly divering
from the QEMU machine type.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
