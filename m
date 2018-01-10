Received: from eggs.gnu.org ([2001:4830:134:3::10]:47361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZG1U-0002Qj-Sc
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:02:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZG1P-0000KH-77
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:02:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50855)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eZG1P-0000Jz-07
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:02:23 -0500
Date: Wed, 10 Jan 2018 13:02:05 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180110130205.GN3205@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cb61acc7-1a7a-616a-e2f7-29e8226ca0c3@profihost.ag>
	<a094668d-3294-e4b8-47a0-08ed8da5f9df@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a094668d-3294-e4b8-47a0-08ed8da5f9df@redhat.com>
Subject: Re: [Qemu-devel] how to pass pcid to guest?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, qemu-devel <qemu-devel@nongnu.org>

On Mon, Jan 08, 2018 at 04:07:53PM -0600, Eric Blake wrote:
> On 01/08/2018 02:03 PM, Stefan Priebe - Profihost AG wrote:
> > Hello,
> > 
> > for meltdown mitigation and performance it's important to have the pcid
> > flag passed down to the guest (f.e.
> > https://groups.google.com/forum/m/#!topic/mechanical-sympathy/L9mHTbeQLNU).
> 
> Indeed; you are still waiting on the qemu patch mentioned here:
> https://www.qemu.org/2018/01/04/spectre/
> 
> which is still undergoing the review process, but should be up (in the
> form of 2.11.1) "in the next few days".

There's two different things here. The Spectre patch you mention is about
exposing a new CPUID feature 'ibrs' that is added to fix Spectre. The 'pcid'
feature Stefan mentions is a pre-existing feature that is not a security fix,
but rather a way to improve the performance when the KAISER/KPTI patches are
enabled for Meltdown.

'pcid' is available in QEMU's  Haswell, Broadwell & Skylake based CPU
models by default. For other named CPU models, you can turn it on using
',+pcid' after the model name. eg  '-cpu  Westmere,+pcid' (as long as your
host supports it of course)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
