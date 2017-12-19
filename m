Received: from eggs.gnu.org ([2001:4830:134:3::10]:48496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pombredanne@nexb.com>) id 1eRKIA-0000h1-F7
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:58:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pombredanne@nexb.com>) id 1eRKI9-000483-Ib
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:58:54 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pombredanne@nexb.com>)
	id 1eRKI9-00047e-A7
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:58:53 -0500
Received: by mail-wm0-x241.google.com with SMTP id f9so4666772wmh.0
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 07:58:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1513685879-21823-2-git-send-email-wei.w.wang@intel.com>
References: <1513685879-21823-1-git-send-email-wei.w.wang@intel.com>
	<1513685879-21823-2-git-send-email-wei.w.wang@intel.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Tue, 19 Dec 2017 16:58:10 +0100
Message-ID: <CAOFm3uHJF1X93iALES6njXrkpsk5bSsuXqcKQMWP4HGT0S8qeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v20 1/7] xbitmap: Introduce xbitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mawilcox@microsoft.com
Cc: virtio-dev@lists.oasis-open.org, LKML <linux-kernel@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, Andrew Morton <akpm@linux-foundation.org>, david@redhat.com, penguin-kernel@i-love.sakura.ne.jp, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

Matthew,

On Tue, Dec 19, 2017 at 1:17 PM, Wei Wang <wei.w.wang@intel.com> wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
>
> The eXtensible Bitmap is a sparse bitmap representation which is
> efficient for set bits which tend to cluster.  It supports up to
> 'unsigned long' worth of bits, and this commit adds the bare bones --
> xb_set_bit(), xb_clear_bit() and xb_test_bit().

<snip>

> --- /dev/null
> +++ b/include/linux/xbitmap.h
> @@ -0,0 +1,49 @@
> +/*
> + * eXtensible Bitmaps
> + * Copyright (c) 2017 Microsoft Corporation <mawilcox@microsoft.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of the
> + * License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * eXtensible Bitmaps provide an unlimited-size sparse bitmap facility.
> + * All bits are initially zero.
> + */

Would you mind using the new SPDX tags documented in Thomas patch set
[1] rather than this fine but longer legalese?

And if you could spread the word to others in your team this would be very nice.

Thank you!

[1] https://lkml.org/lkml/2017/12/4/934

-- 
Cordially
Philippe Ombredanne
