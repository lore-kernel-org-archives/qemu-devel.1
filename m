Received: from eggs.gnu.org ([2001:4830:134:3::10]:38711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fcw1W-0002A0-W8
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fcw1V-0006Zm-Kc
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:01:59 -0400
Date: Tue, 10 Jul 2018 18:01:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180710170145.GG1612@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180704150256.408d4a07.cohuck@redhat.com>
	<20180704133440.GE4334@localhost.localdomain>
	<CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
	<20180706131103.4e713911.cohuck@redhat.com>
	<20180706145645.GB3939@localhost.localdomain>
	<20180709072953.GE7755@andariel.pipo.sk>
	<87k1q3ljgs.fsf@dusky.pond.sub.org>
	<20180710162208.7b1b5cdc.cohuck@redhat.com>
	<20180710143931.GQ1148@andariel.pipo.sk>
	<20180710170122.427ce3a4.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180710170122.427ce3a4.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>

On Tue, Jul 10, 2018 at 05:01:22PM +0200, Cornelia Huck wrote:
> Who is, in general, testing which libvirt version? I can think of:
> - libvirt developers, which will probably run libvirt current git, but
>   more likely a released QEMU?

In general libvirt devs tend to run a mixture of whatever the default QEMU
is in Fedora / RHEL, along side current QEMU git master, depending on what
feature(s) we're working on.

> - QEMU (and other related tools) developers, who will probably use QEMU
>   current git, but a released libvirt
> - normal (technical) users and (integration) testers, who will probably
>   use released versions of libvirt and QEMU

We don't currently have any integration testing CI system, but we are in
process of getting hardware resource to allow us to run CI. With that we
can setup jobs which test various relevant QEMU versions, both git master
and released versions.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
