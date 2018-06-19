Received: from eggs.gnu.org ([2001:4830:134:3::10]:44077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fVHkx-00084x-O5
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fVHku-0001h4-4o
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:37:15 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:55283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fVHkt-0001fe-QD
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:37:12 -0400
Received: by mail-wm0-x244.google.com with SMTP id o13-v6so773973wmf.4
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 07:37:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619134933.GY20929@redhat.com>
References: <20180619132200.12320-1-sameeh@daynix.com>
	<20180619134933.GY20929@redhat.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 19 Jun 2018 17:37:10 +0300
Message-ID: <CAKPgXcHrZY1=65jOg3Y3bDdwNnik7x-Ti-3PAryYsRuvRWk=iA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/1] Add BPF suuport to Qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Yan Vugenfirer <yan@daynix.com>, Amnon Ilan <ailan@redhat.com>

This patch is actually a preparation for an upcoming patch set that I want
to integrate into virtio-net which implements the RSS feature. (
https://lists.oasis-open.org/archives/virtio-dev/201805/msg00024.html)
So there is a use case. The rationale behind this is to distinguish the
infrastructure preparation needed for the BPF from the actual RSS feature
implementation.

On Tue, Jun 19, 2018 at 4:49 PM, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om>
wrote:

> On Tue, Jun 19, 2018 at 04:21:59PM +0300, Sameeh Jubran wrote:
> > From: Sameeh Jubran <sjubran@redhat.com>
> >
> > The Berkeley Packet Filter has been in the kernel for a while now and I
> > think it is time that it is introduced to Qemu. This patch is an
> > infrastructure for any future usage of the BPF in Qemu.
> >
> > It is important to note that the tun driver had started supporting usin=
g
> > BPF programs through ioctls (TUNSETSTEERINGEBPF and TUNSETFILTEREBPF).
> >
> > At first, instead of adding the syscall wrappers, I wanted to integrate
> libbpf
> > library which resides in the Linux source tree under tools/lib/bpf. It
> appears
> > to be that by default it compiles to x64 on x64 arch - which can't be
> > integrated into Qemu  - and my attempts to compile the 32 bit versions
> have
> > failed. What's more interesting is that the vendors don't provide this
> library
> > in any package, which makes this library a nasty dependency.
> >
> > Please share your thoughts :)
>
> IMHO there should be example usage illustrated for some part of QEMU
> before we add any general infrastructure, as you can't really do a
> useful design evaluation without understanding its usage.
>
> It isn't clear that QEMU is neccessarily the best place to even do it, if
> the intended usage is to provide network traffic firewalling for guest
> NICs. eg libvirt already provides a firewalling system based on iptables,
> that could have an BPFilter implementation added to it.
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/
> dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/
> dberrange :|
>



--=20
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
