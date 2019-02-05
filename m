Received: from eggs.gnu.org ([209.51.188.92]:44111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gr3Fi-0003aX-OB
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:07:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gr3FX-0002ZQ-L9
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:07:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gr3FR-0002RJ-Gm
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:06:57 -0500
Date: Tue, 5 Feb 2019 11:06:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190205110518-mutt-send-email-mst@kernel.org>
References: <20190204142638.27021-1-mst@redhat.com>
	<CAFEAcA8VGhubZk5HFEjNm5f9xdsgO2RdRR6Vcxzmzzyuj-b5JQ@mail.gmail.com>
	<20190204205105-mutt-send-email-mst@kernel.org>
	<CAFEAcA_m8Ebz8NTKM19FV-APQCOJpXVwyWm48uHRdfdKsHu7Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_m8Ebz8NTKM19FV-APQCOJpXVwyWm48uHRdfdKsHu7Bg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/25] pci, pc, virtio: fixes, cleanups,
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, Feb 05, 2019 at 12:41:55PM +0000, Peter Maydell wrote:
> On Tue, 5 Feb 2019 at 01:52, Michael S. Tsirkin <mst@redhat.com> wrote:
> > So I think I fixed the build errors. And who knows maybe
> > that will fix the runtime ones somehow ..
> > Could you try pls? Re-pushed to same tag.
> 
> these failures still remain:
> 
> unused variable for OSX and the BSDs:
> 
> tests/vhost-user-test.c:942:17: warning: unused variable 'hugefs'
> [-Wunused-variable]
>     const char *hugefs;
>                 ^
> 
> Assertion failure on sparc, s390x and PPC64 hosts:
> 
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=i386-softmmu/qemu-system-i386
> QTEST_QEMU_IMG=qemu-img tests/vhost-user-test -m=quick -k --tap <
> /dev/null | ./scripts/tap-driver.pl --test-name="vhost-user-test"
> qemu-system-i386: backend does not support LE vnet headers; falling
> back on userspace virtio
> qemu-system-i386: backend does not support LE vnet headers; falling
> back on userspace virtio
> **
> ERROR:/home/pm215/qemu/tests/vhost-user-test.c:243:wait_for_fds:
> assertion failed: (s->fds_num)
> ERROR - too few tests run (expected 4, got 0)
> 
> Given the set of hosts affected this is almost certainly
> a big-endian-host specific bug.
> 
> thanks
> -- PMM

You were right.

OK I reverted the whole part dealing with vhost-user and reposted.

I'm sure it's fine now.


-- 
MST
