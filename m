Received: from eggs.gnu.org ([209.51.188.92]:40147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gn10I-0007Ns-Om
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 07:54:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gn0n3-0004p8-1B
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 07:40:58 -0500
References: <CAAJhNetR-8z37JuOmFDRuq3JfG_S03VDZkciqiKh_kieoqxQ1g@mail.gmail.com>
	<628a94ba-2202-6a15-865b-16d52653288d@redhat.com>
	<CAFEAcA8jvRRpphFS7jvisU+f0SEvU1DOhrBxgKSRWEMkZV3eOw@mail.gmail.com>
	<CAAJhNeta4fWX7y-ap-CSUhrHDGrZH_Xss6tyDa6=vn_uUJSk0Q@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c7e75a05-d1ca-8a7d-5f90-19e4efa0e28f@redhat.com>
Date: Fri, 25 Jan 2019 13:40:36 +0100
MIME-Version: 1.0
In-Reply-To: <CAAJhNeta4fWX7y-ap-CSUhrHDGrZH_Xss6tyDa6=vn_uUJSk0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] object owner argument of
 memory_region_init_ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ksourav <sourav.jb1988@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 2019-01-23 16:50, ksourav wrote:
> Thanks for the reply.
> Should I send patches for socs using NULL owner to qemu-trivial@nongnu.=
org ?

Sure, but please also CC: qemu-arm@nongnu.org for ARM-related patches.

> I have been reading qemu source code for soc and different device
> implementation for past few days to understand qemu internals.
> While I have a rough idea of qemu object model, I would like to have yo=
ur input.
> If someone has to learn about qemu object model or soc implementation,
> what would be the correct way ?

We certainly lack documentation here. Studying the available sources is
likely the best thing you can do. There were also a couple of
presentations about QOM and qdev during the various KVM Forums (see
https://www.linux-kvm.org/page/KVM_Forum for example), but they are
likely not quite up to date anymore.

 Thomas
