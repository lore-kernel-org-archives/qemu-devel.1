Received: from eggs.gnu.org ([208.118.235.92]:55697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gEWUd-0001Af-7A
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 05:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gEWUX-0000UN-8t
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 05:27:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gEWUX-0000Tv-3K
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 05:27:17 -0400
Date: Mon, 22 Oct 2018 10:27:10 +0100
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181022092710.GH32717@xz-x1>
References: <CAHyh4xiVxNOxwWeKDw2ccAURx3zRMTd+nVLD=oav6ShqCBdjXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHyh4xiVxNOxwWeKDw2ccAURx3zRMTd+nVLD=oav6ShqCBdjXw@mail.gmail.com>
Subject: Re: [Qemu-devel] Virtual IOMMU is working for Windows VM?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jintack Lim <jintack@cs.columbia.edu>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>

On Mon, Oct 22, 2018 at 12:22:02AM -0400, Jintack Lim wrote:
> Hi,
> 
> I wonder if vIOMMU is working for Windows VM?
> 
> I tried it with v2.11.0, but it didn't seem to work. I assume that seaBIOS
> sets IOMMU on by default as is the case when I launched a Linux VM. But I
> might be missing something. Can somebody shed some light on it?

Hi, Jintack,

I think at least the latest QEMU should work for Windows, but I don't
really run Windows that frequently.

What is the error you've encountered?  Have you tried the latest QEMU,
or switching Windows versions to try?

What I can remember about Windows is that Ladi had fixed a bug for
windows-only (8991c460be, "intel_iommu: relax iq tail check on
VTD_GCMD_QIE enable", 2017-07-03) but it should be even in 2.10 so I
guess it's not the problem you've encountered.

Regards,

-- 
Peter Xu
