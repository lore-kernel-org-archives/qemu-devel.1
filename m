Received: from eggs.gnu.org ([2001:4830:134:3::10]:45525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpZRR-0003kb-4a
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpZRO-0002cQ-1F
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:28:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpZRN-0002br-RP
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:28:21 -0400
Date: Wed, 6 Sep 2017 13:28:14 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170906122814.GQ15510@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CADak6y7DSednJgLkivprv0fAkLvE2=Dge0LzNJ0MnigvBEz+_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADak6y7DSednJgLkivprv0fAkLvE2=Dge0LzNJ0MnigvBEz+_A@mail.gmail.com>
Subject: Re: [Qemu-devel] how to modify or add machines type ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Schlacter <wlfightup@gmail.com>
Cc: qemu-devel@nongnu.org

On Wed, Sep 06, 2017 at 08:13:38PM +0800, Paul Schlacter wrote:
> I made the default config build the qemu-kvm , But I used virsh xml
> corresponding machine-type inconsistent, resulting in an error.
> 
> error:
> 2017-09-06T12:16:36.036200Z qemu-kvm: -machine
> pc-i440fx-rhel7.0.0,accel=kvm,usb=off: unsupported machine type
> Use -machine help to list supported machines
> 
> 
> Is there any way to modify the machines in qemu-kvm?

Why do you want to change the QEMU machines, instead of just editting
your libvirt guest XML to use one of the machine types that QEMU
already supports ?  (virsh edit $GUESTNAME and then find the machine
type name & change it)


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
