Received: from eggs.gnu.org ([2001:4830:134:3::10]:60177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSUgp-0001YW-6r
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 16:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSUgm-0005nu-3T
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 16:44:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dSUgl-0005nn-TG
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 16:44:52 -0400
Date: Tue, 4 Jul 2017 21:44:47 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170704204447.GA19979@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <74424b67-f20b-27c1-6c96-e2ee54bf5bd6@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <74424b67-f20b-27c1-6c96-e2ee54bf5bd6@ilande.co.uk>
Subject: Re: [Qemu-devel] Managing architectural restrictions with -device
 and libvirt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Tue, Jul 04, 2017 at 07:25:41PM +0100, Mark Cave-Ayland wrote:
> Hi all,
> 
> I've been working on a patchset that brings the sun4u machine on
> qemu-system-sparc64 much closer to a real Ultra 5, however due to
> various design restrictions I need to be able to restrict how devices
> are added to the machine with -device.
> 
> On a real Ultra 5, the root PCI bus (sabre) has 2 PCI bridges (simba A
> and simba B) with the onboard devices attached to simba A with 2 free
> slots, and an initially empty simba B.
> 
> Firstly, is it possible to restrict the machine so that devices cannot
> be directly plugged into the root PCI bus, but only behind one of the
> PCI bridges? There is also an additional restriction in that slot 0
> behind simba A must be left empty to ensure that the ebus (containing
> the onboard devices) is the first device allocated.
> 
> Secondly, how does libvirt handle these type of restrictions? Is it able
> to get the information from QEMU or is there some kind of libvirt
> profile that needs to be updated? And do newer versions of libvirt have
> the ability to attach devices behind PCI bridges using a GUI such as
> virt-manager, or is that only something that can only be done by
> directly editing the domain XML?

Libvirt has a bunch of code that provides different logic for various
machine types when doing addressing & setting up default PCI controllers.
Libvirt support for sparc machine types almost certainly broken since
I'm not aware of anyone having looked at it forever. Probably best to
re-ask your Q's on the libvir-list to get info from the people familiar
with this, since I'm fuzzy on precise details of what you'd need todo.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
