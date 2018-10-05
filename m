Received: from eggs.gnu.org ([2001:4830:134:3::10]:50316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8TQ3-0007RP-QW
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8TN2-0003da-Sk
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:54:33 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:46283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g8TMz-0003Si-4I
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:54:30 -0400
Received: by mail-oi1-x22a.google.com with SMTP id k64-v6so10919214oia.13
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 09:54:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181004152857.14525-1-cohuck@redhat.com>
References: <20181004152857.14525-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Oct 2018 17:53:57 +0100
Message-ID: <CAFEAcA87E1F5vbmU8-xv=jtoezpOcp-oyPQjE0gAVga_9YufXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/15] s390x updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 4 October 2018 at 16:28, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit dafd95053611aa14dda40266857608d12ddce658:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-10-02 18:27:18 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20181004
>
> for you to fetch changes up to b576d582ea2b03f4eada186fff59308d22b40a6a:
>
>   hw/s390x/s390-pci-bus: Convert sysbus init function to realize function (2018-10-04 12:10:40 +0200)
>
> ----------------------------------------------------------------
> Various s390x updates:
> - fix several struct definitions so that sparc hosts do not trip over
>   unaligned accesses
> - fence enabling huge pages for pre-3.1 machines
> - sysbus init -> realize conversion
> - fixes and improvements in tcg (instruction flags and AFP registers)

Applied, thanks.

-- PMM
