Received: from eggs.gnu.org ([209.51.188.92]:46535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hGIis-0006o4-Ka
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hGIir-0007oi-At
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:41:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hGIiq-0007ne-Uv
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:41:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so23969060wmf.5
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 00:41:39 -0700 (PDT)
Date: Tue, 16 Apr 2019 09:41:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190416074135.qo4l3vra2g6n2rts@steredhat.homenet.telecomitalia.it>
References: <CAMo8BfLCON2wbQ36dkVQ92tcVPWoPdje12CqySFnJyoYDDOdDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfLCON2wbQ36dkVQ92tcVPWoPdje12CqySFnJyoYDDOdDg@mail.gmail.com>
Subject: Re: [Qemu-devel] recent QEMU-w64 does not load multiboot kernels by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>

On Mon, Apr 15, 2019 at 03:20:42PM -0700, Max Filippov wrote:
> Hello,
> 
> recent qemu-system-i386 for w64 (e.g. one installed from
> https://qemu.weilnetz.de/w64/qemu-w64-setup-20190218.exe )
> refuses to load multiboot kernel by default:
> 
>   "C:\Program Files\qemu\qemu-system-i386.exe" -kernel p:\tmp\kernel
>   C:\Program Files\qemu\qemu-system-i386.exe: Error loading
> uncompressed kernel without PVH ELF Note
> 
> Adding -M pc-i440fx-3.1 (as well as most other machines, but not
> pc-i440fx-4.0) fixes that. On linux host the same kernel gets loaded
> either way (with or without -M).

Hi Max,
there was an issue when we introduced PVH support and we fixed it. [1]
Maybe the build that you used (20190218) was compiled before the merge of
that fix (20190311).

Can you try to build the 4.0-rc3?

Cheers,
Stefano


[1] https://patchwork.ozlabs.org/patch/1042337/
