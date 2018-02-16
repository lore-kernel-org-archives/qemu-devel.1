Received: from eggs.gnu.org ([2001:4830:134:3::10]:47956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andy.shevchenko@gmail.com>) id 1emk45-0006lz-7e
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:44:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andy.shevchenko@gmail.com>) id 1emk44-0007ZZ-9T
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:44:53 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:45631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andy.shevchenko@gmail.com>)
	id 1emk44-0007ZB-3i
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:44:52 -0500
Received: by mail-qk0-x242.google.com with SMTP id g2so4721025qkd.12
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 09:44:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1515496262-7533-2-git-send-email-wei.w.wang@intel.com>
References: <1515496262-7533-1-git-send-email-wei.w.wang@intel.com>
	<1515496262-7533-2-git-send-email-wei.w.wang@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Feb 2018 19:44:50 +0200
Message-ID: <CAHp75Ve-1-TOVJUZ4anhwkkeq-RhpSg3EmN3N0r09rj6sFrQZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v21 1/5] xbitmap: Introduce xbitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm <linux-mm@kvack.org>, "Michael S. Tsirkin" <mst@redhat.com>, mhocko@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <mawilcox@microsoft.com>, david@redhat.com, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Matthew Wilcox <willy@infradead.org>, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On Tue, Jan 9, 2018 at 1:10 PM, Wei Wang <wei.w.wang@intel.com> wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
>
> The eXtensible Bitmap is a sparse bitmap representation which is
> efficient for set bits which tend to cluster. It supports up to
> 'unsigned long' worth of bits.

>  lib/xbitmap.c                            | 444 +++++++++++++++++++++++++++++++

Please, split tests to a separate module.

-- 
With Best Regards,
Andy Shevchenko
