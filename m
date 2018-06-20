Received: from eggs.gnu.org ([2001:4830:134:3::10]:58126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fVYF1-0002ZL-Fp
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:13:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fVYEx-0000cf-Bn
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:13:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54504 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fVYEx-0000cP-74
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:13:19 -0400
References: <20180619132200.12320-1-sameeh@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4f16bb8b-2061-847e-9e17-0a8f80b18197@redhat.com>
Date: Wed, 20 Jun 2018 16:13:10 +0800
MIME-Version: 1.0
In-Reply-To: <20180619132200.12320-1-sameeh@daynix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org
Cc: Amnon Ilan <ailan@redhat.com>, Yan Vugenfirer <yan@daynix.com>



On 2018=E5=B9=B406=E6=9C=8819=E6=97=A5 21:21, Sameeh Jubran wrote:
> From: Sameeh Jubran <sjubran@redhat.com>
>
> The Berkeley Packet Filter has been in the kernel for a while now and I
> think it is time that it is introduced to Qemu. This patch is an
> infrastructure for any future usage of the BPF in Qemu.
>
> It is important to note that the tun driver had started supporting usin=
g
> BPF programs through ioctls (TUNSETSTEERINGEBPF and TUNSETFILTEREBPF).
>
> At first, instead of adding the syscall wrappers, I wanted to integrate=
 libbpf
> library which resides in the Linux source tree under tools/lib/bpf. It =
appears
> to be that by default it compiles to x64 on x64 arch - which can't be
> integrated into Qemu  - and my attempts to compile the 32 bit versions =
have
> failed. What's more interesting is that the vendors don't provide this =
library
> in any package, which makes this library a nasty dependency.
>
> Please share your thoughts :)

I wonder, instead of a generic eBPF support, can we have a limited but=20
sufficient eBPF suppor for TAP only (see dpdk tap driver)? E.g if we=20
only do bytecode loading, there's no need for e.g map update helpers.

Thanks

>
> Sameeh Jubran (1):
>    Add BPF support to qemu
>
>   MAINTAINERS                     |   7 +
>   bpf/Makefile.objs               |   1 +
>   bpf/bpf_syscall.c               |  98 ++++++
>   include/bpf/bpf_syscall.h       |  35 +++
>   linux-headers/linux/bpf.h       | 673 +++++++++++++++++++++++++++++++=
+++++++++
>   scripts/update-linux-headers.sh |   3 +-
>   6 files changed, 816 insertions(+), 1 deletion(-)
>   create mode 100644 bpf/Makefile.objs
>   create mode 100644 bpf/bpf_syscall.c
>   create mode 100644 include/bpf/bpf_syscall.h
>   create mode 100644 linux-headers/linux/bpf.h
>
