Received: from eggs.gnu.org ([2001:4830:134:3::10]:56241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXPUI-0003wx-B1
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXPUH-0007N7-8W
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:16:50 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:33008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXPUH-0007N1-3U
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:16:49 -0400
Received: by mail-oi0-x242.google.com with SMTP id c6-v6so12112475oiy.0
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 04:16:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180625110706.23332-1-sameeh@daynix.com>
References: <20180625110706.23332-1-sameeh@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 12:16:28 +0100
Message-ID: <CAFEAcA_52bxjEvpZcDhMVJ=dQaLaLM8unq01kb-8y=jYAiggSw@mail.gmail.com>
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
To: Sameeh Jubran <sameeh@daynix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, Amnon Ilan <ailan@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 25 June 2018 at 12:07, Sameeh Jubran <sameeh@daynix.com> wrote:
> From: Sameeh Jubran <sjubran@redhat.com>
>
> The Berkeley Packet Filter has been in the kernel for a while now and I
> think it is time that it is introduced to Qemu. This patch is an
> infrastructure for any future usage of the BPF in Qemu.
>
> It is important to note that the tun driver had started supporting using
> BPF programs through ioctls (TUNSETSTEERINGEBPF and TUNSETFILTEREBPF).
> My plan is to use the bpf support from within virtio-net in order to set
> a bpf steering program to the tun device which would allow virtio-net to
> support RSS feature https://lists.oasis-open.org/archives/virtio-dev/201805/msg00024.html
>
> Difference from v1:
> * Used libbpf library provided by linux
> * Added a configure option
> * Added a sample patch with demonstrates how to use the libbpf library
>   from within virtio-net. This patch should not be applied! It is for
>   demonstration purposes only
>
> The libbpf can be manually installed from the Linux source tree by running make
> tools/bpf and make tools/bpf_install from the top level directory.

I'm afraid this series still doesn't have a real use case for the
library, which is what we would need to be able to review whether
using BPF is a sensible design for whatever the underlying
feature to be implemented is. That is, what you should be sending
is "here is a patchset to implement RSS in virtio-net (and it
happens to be implemented using BPF)", not "here is a patchset
which links QEMU with libbpf and does nothing else".

thanks
-- PMM
