Received: from eggs.gnu.org ([2001:4830:134:3::10]:58838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dT1sk-0007Ed-7Y
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:11:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dT1sg-0001Cu-6j
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:11:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dT1sg-0001Ca-0Q
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:11:22 -0400
Date: Thu, 6 Jul 2017 09:11:17 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170706081117.GC3988@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <895558F6EA4E3B41AC93A00D163B7274162E2512@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <895558F6EA4E3B41AC93A00D163B7274162E2512@SHSMSX103.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] The maximum limit of virtual network device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Wu, Jiaxin" <jiaxin.wu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Thu, Jul 06, 2017 at 06:20:54AM +0000, Wu, Jiaxin wrote:
> Hello experts,
> 
> We know QEMU has the capability to create the multiple network devices in one QEMU guest with the -device syntax. But I met the below failure when I'm trying to create more than 30 virtual devices with the each TAP backend:
> 
> qemu-system-x86_64: -device e1000: PCI: no slot/function available for e1000, all in use.
> 
> The corresponding QEMU command shows as following:

[snip]
 
> From above,  the max limit of virtual network device in one guest is about
> 29? If not, how can I avoid such failure? My use case is to create more than
> 150 network devices in one guest. Please provide your comments on this.

As the error message above shows, you have run out of PCI slots on the default
PCI bus. There are two ways to get around this. The first is to make use of
multifunction=on and specify individual PCI functions. There are 7 functions
per slot, so that would take you to 203 devices. The downside of multifunction
is that you can't hotplug individual functions.  The second approach is to
just add a bunch of PCI bridges, so that you have more slots available. 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
