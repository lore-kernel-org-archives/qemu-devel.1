Received: from eggs.gnu.org ([2001:4830:134:3::10]:57265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fXPYv-0006RG-7g
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fXPYr-0000xB-EE
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:21:37 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:46268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fXPYr-0000ww-1V
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:21:33 -0400
Received: by mail-ed1-x541.google.com with SMTP id r17-v6so5173480edo.13
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 04:21:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_52bxjEvpZcDhMVJ=dQaLaLM8unq01kb-8y=jYAiggSw@mail.gmail.com>
References: <20180625110706.23332-1-sameeh@daynix.com>
	<CAFEAcA_52bxjEvpZcDhMVJ=dQaLaLM8unq01kb-8y=jYAiggSw@mail.gmail.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon, 25 Jun 2018 14:21:31 +0300
Message-ID: <CAKPgXcGLuY62tnHzo+12OLBaqJWo-_n=D=FLx2oSR9+owHb1zQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v2 0/2] Add BPF suuport to Qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, Amnon Ilan <ailan@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On Mon, Jun 25, 2018 at 2:16 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 25 June 2018 at 12:07, Sameeh Jubran <sameeh@daynix.com> wrote:
> > From: Sameeh Jubran <sjubran@redhat.com>
> >
> > The Berkeley Packet Filter has been in the kernel for a while now and I
> > think it is time that it is introduced to Qemu. This patch is an
> > infrastructure for any future usage of the BPF in Qemu.
> >
> > It is important to note that the tun driver had started supporting using
> > BPF programs through ioctls (TUNSETSTEERINGEBPF and TUNSETFILTEREBPF).
> > My plan is to use the bpf support from within virtio-net in order to set
> > a bpf steering program to the tun device which would allow virtio-net to
> > support RSS feature https://lists.oasis-open.org/
> archives/virtio-dev/201805/msg00024.html
> >
> > Difference from v1:
> > * Used libbpf library provided by linux
> > * Added a configure option
> > * Added a sample patch with demonstrates how to use the libbpf library
> >   from within virtio-net. This patch should not be applied! It is for
> >   demonstration purposes only
> >
> > The libbpf can be manually installed from the Linux source tree by
> running make
> > tools/bpf and make tools/bpf_install from the top level directory.
>
> I'm afraid this series still doesn't have a real use case for the
> library, which is what we would need to be able to review whether
> using BPF is a sensible design for whatever the underlying
> feature to be implemented is. That is, what you should be sending
> is "here is a patchset to implement RSS in virtio-net (and it
> happens to be implemented using BPF)", not "here is a patchset
> which links QEMU with libbpf and does nothing else".
>
I don't think the infrastructure should be coupled with the implementation.
These are two separate patch sets, however I can combine them to one.

>
> thanks
> -- PMM
>



-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
