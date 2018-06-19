Received: from eggs.gnu.org ([2001:4830:134:3::10]:57937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVH0v-0001GI-4L
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVH0s-0008Dw-28
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:49:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51348 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fVH0r-0008Dr-Tf
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:49:37 -0400
Date: Tue, 19 Jun 2018 14:49:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180619134933.GY20929@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180619132200.12320-1-sameeh@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180619132200.12320-1-sameeh@daynix.com>
Subject: Re: [Qemu-devel] [RFC 0/1] Add BPF suuport to Qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Yan Vugenfirer <yan@daynix.com>, Amnon Ilan <ailan@redhat.com>

On Tue, Jun 19, 2018 at 04:21:59PM +0300, Sameeh Jubran wrote:
> From: Sameeh Jubran <sjubran@redhat.com>
> 
> The Berkeley Packet Filter has been in the kernel for a while now and I
> think it is time that it is introduced to Qemu. This patch is an
> infrastructure for any future usage of the BPF in Qemu.
> 
> It is important to note that the tun driver had started supporting using
> BPF programs through ioctls (TUNSETSTEERINGEBPF and TUNSETFILTEREBPF).
> 
> At first, instead of adding the syscall wrappers, I wanted to integrate libbpf
> library which resides in the Linux source tree under tools/lib/bpf. It appears
> to be that by default it compiles to x64 on x64 arch - which can't be
> integrated into Qemu  - and my attempts to compile the 32 bit versions have
> failed. What's more interesting is that the vendors don't provide this library
> in any package, which makes this library a nasty dependency.
> 
> Please share your thoughts :)

IMHO there should be example usage illustrated for some part of QEMU
before we add any general infrastructure, as you can't really do a
useful design evaluation without understanding its usage.

It isn't clear that QEMU is neccessarily the best place to even do it, if
the intended usage is to provide network traffic firewalling for guest
NICs. eg libvirt already provides a firewalling system based on iptables,
that could have an BPFilter implementation added to it.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
