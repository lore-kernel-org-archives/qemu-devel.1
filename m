Received: from eggs.gnu.org ([2001:4830:134:3::10]:52823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffj6b-0008QH-Py
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffj6X-0000ny-So
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:50:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53362 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ffj6X-0000n4-ML
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:50:41 -0400
Date: Wed, 18 Jul 2018 10:50:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180718095034.GJ9812@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CANhJxzwZny93TOTKTpEoThN8bnw1tXENPH_S60wczUAQodBMNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANhJxzwZny93TOTKTpEoThN8bnw1tXENPH_S60wczUAQodBMNw@mail.gmail.com>
Subject: Re: [Qemu-devel] [libvirt] CPU Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hetz Ben Hamo <hetz@hetz.biz>, qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Jul 18, 2018 at 12:41:48PM +0300, Hetz Ben Hamo wrote:
> Hi,
> 
> I've been looking at the CPU list and although I see lots of CPU's, I
> cannot find 2 CPU families:
> 
> * AMD Ryzen
> * AMD Threadripper
> 
> Although EPYC has been added recently.
> 
> Are there any missing details which preventing adding those CPU's to the
> list?

Libvirt adds CPU models based on what QEMU supports. So from libvirt side the
answer is simply that QEMU doesn't expose any models for Ryzen/Threadripper,
but I'm not clear why it doesn't...

For a while I thought Ryzen/Threadripper would have same feature set as
EPYC, but I've seen bugs recently suggesting that is not in fact the
case. So it does look like having those models exposed by QEMU might
be useful.

Copy'ing QEMU devel & the CPU model maintainers for opinions.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
