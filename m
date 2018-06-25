Received: from eggs.gnu.org ([2001:4830:134:3::10]:45470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fXTWK-0000Yt-Sm
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fXTWH-0002Xy-7p
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:35:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38924 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fXTWG-0002Xd-U8
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:35:09 -0400
Date: Mon, 25 Jun 2018 16:35:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180625153502.GJ18580@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180625110706.23332-1-sameeh@daynix.com>
	<CAFEAcA_52bxjEvpZcDhMVJ=dQaLaLM8unq01kb-8y=jYAiggSw@mail.gmail.com>
	<CAKPgXcGLuY62tnHzo+12OLBaqJWo-_n=D=FLx2oSR9+owHb1zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKPgXcGLuY62tnHzo+12OLBaqJWo-_n=D=FLx2oSR9+owHb1zQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC v2 0/2] Add BPF suuport to Qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, Amnon Ilan <ailan@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>

On Mon, Jun 25, 2018 at 02:21:31PM +0300, Sameeh Jubran wrote:
> On Mon, Jun 25, 2018 at 2:16 PM, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> 
> > On 25 June 2018 at 12:07, Sameeh Jubran <sameeh@daynix.com> wrote:
> > > From: Sameeh Jubran <sjubran@redhat.com>
> > >
> > > The Berkeley Packet Filter has been in the kernel for a while now and I
> > > think it is time that it is introduced to Qemu. This patch is an
> > > infrastructure for any future usage of the BPF in Qemu.
> > >
> > > It is important to note that the tun driver had started supporting using
> > > BPF programs through ioctls (TUNSETSTEERINGEBPF and TUNSETFILTEREBPF).
> > > My plan is to use the bpf support from within virtio-net in order to set
> > > a bpf steering program to the tun device which would allow virtio-net to
> > > support RSS feature https://lists.oasis-open.org/
> > archives/virtio-dev/201805/msg00024.html
> > >
> > > Difference from v1:
> > > * Used libbpf library provided by linux
> > > * Added a configure option
> > > * Added a sample patch with demonstrates how to use the libbpf library
> > >   from within virtio-net. This patch should not be applied! It is for
> > >   demonstration purposes only
> > >
> > > The libbpf can be manually installed from the Linux source tree by
> > running make
> > > tools/bpf and make tools/bpf_install from the top level directory.
> >
> > I'm afraid this series still doesn't have a real use case for the
> > library, which is what we would need to be able to review whether
> > using BPF is a sensible design for whatever the underlying
> > feature to be implemented is. That is, what you should be sending
> > is "here is a patchset to implement RSS in virtio-net (and it
> > happens to be implemented using BPF)", not "here is a patchset
> > which links QEMU with libbpf and does nothing else".
> >
> I don't think the infrastructure should be coupled with the implementation.
> These are two separate patch sets, however I can combine them to one.

FWIW, it is perfectly ok to send the code as 2 separate patch sets if you
want to keep them separated. The key point is simply to be able to see a
real implementation.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
