Received: from eggs.gnu.org ([2001:4830:134:3::10]:52253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dMtAC-0007Id-6J
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 05:40:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dMtA9-0002yM-5f
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 05:40:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:35918 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1dMtA8-0002xN-VH
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 05:40:01 -0400
References: <CAFEAcA_3Uf-t7MgvTqO52XX61z3Mcnmpk1XNJRqgdFJiVP1ALQ@mail.gmail.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <08ab93cb-4d42-2b8b-71e6-057b9529d0b7@suse.de>
Date: Mon, 19 Jun 2017 11:39:57 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_3Uf-t7MgvTqO52XX61z3Mcnmpk1XNJRqgdFJiVP1ALQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] spapr guests warn "System page size 0x2000 is not
 enabled in page_size_mask (0x11000). Performance may be slow" on SPARC
 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: David Gibson <david@gibson.dropbear.id.au>

On 06/15/2017 03:33 PM, Peter Maydell wrote:
> I've just noticed that on a SPARC host, some of the PPC guests
> warn during make check:
>
>    /ppc64/prom-env/pseries:
> qemu-system-ppc64: System page size 0x2000 is not enabled in
> page_size_mask (0x11000). Performance may be slow
>
> Is this really a performance problem on a TCG guest?
> It makes the 'make check' output a bit noisy, but not
> unbearably so.

 From what I can tell this really only affects DDW which should be page 
size agnostic when only using emulated devices. Maybe Alexey thought of 
using VFIO-pci devices in a TCG guest?


Alex
