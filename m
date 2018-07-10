Received: from eggs.gnu.org ([2001:4830:134:3::10]:52649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fcocY-0000TQ-Ie
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fcocS-0007aR-Ho
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:07:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36384 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fcocS-0007a9-Bu
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:07:36 -0400
Date: Tue, 10 Jul 2018 10:07:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180710090731.GC1612@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180709203731.19865-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180709203731.19865-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.0] pc: Use "3.0+" constant as default
 SMBIOS version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Wei Huang <wei@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Mon, Jul 09, 2018 at 05:37:31PM -0300, Eduardo Habkost wrote:
> Every time we create new PC machine-types in QEMU, the defaults
> for SMBIOS fields change unnecessarily because the version field
> defaults to MachineClass::name.
> 
> This can cause unexpected side-effects, like triggering license
> reactivation on guest software, or changing the VM memory layout
> because of BIOS table size changes.

Does that really matter though ? By its very nature the 'Version'
field in SMBIOS is expected to change if you alter something about
the hardware. If guests OS don't want to be exposed to changes in
SMBIOS they would be using a fixed machine type, not the variable
"pc" type that continually changes.

We could put padding in the string if we want to avoid BIOS table
layout changes.

Having version change though feels like it is working as intended
for the semantics of these Version: fields in BIOS.

> Change the SMBIOS version string for pc-*-3.0 to "3.0+" to avoid
> doing this on every QEMU release, and keep compatible version
> strings on older machine-types using a new
> MachineClass::smbios_version field.



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
