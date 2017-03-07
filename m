Received: from eggs.gnu.org ([2001:4830:134:3::10]:55427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1clA8x-0005i8-VL
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 03:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1clA8u-0001Xj-Oi
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 03:06:51 -0500
References: <CABLmASHDwFx9LLVB2nWQ=TPLE_MJ-NPx38GLX+jRaHcWjA4_dA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5f75feb4-56a2-d34b-6ead-602952404ee0@redhat.com>
Date: Tue, 7 Mar 2017 09:06:40 +0100
MIME-Version: 1.0
In-Reply-To: <CABLmASHDwFx9LLVB2nWQ=TPLE_MJ-NPx38GLX+jRaHcWjA4_dA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] BUG: qemu-system-ppc boots Mac OS
 9.2.1/9.2.2 iso's extremely slow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Howard Spoelstra <hsp.cat7@gmail.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 06.03.2017 22:49, Howard Spoelstra wrote:
> Hi,
> 
> I noticed qemu-system-ppc currently has difficulty booting Mac OS
> 9.2.1/9.2.2 iso's. Even after 5 minutes the happy mac hasn't appeared.
> This does not happen with 9.0.4 or 9.1 iso's, or PPC OS X versions.
> 
> I bisected to this commit:
> 
> 95ed56939eb2eaa4e2f349fe6dcd13ca4edfd8fb is the first bad commit
> commit 95ed56939eb2eaa4e2f349fe6dcd13ca4edfd8fb
> Author: Li Qiang <liqiang6-s@360.cn>
> Date:   Tue Feb 7 02:23:33 2017 -0800
> 
>     usb: ohci: limit the number of link eds
> 
>     The guest may builds an infinite loop with link eds. This patch
>     limit the number of linked ed to avoid this.
> 
>     Signed-off-by: Li Qiang <liqiang6-s@360.cn>
>     Message-id: 5899a02e.45ca240a.6c373.93c1@mx.google.com
>     Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> After reverting boot time is ~20 seconds.
> 
> It seems setting "#define ED_LINK_LIMIT 4" in hw/usb/hcd-ohci.c to a
> higher limit solves this issue.

Could you maybe find out the lowest value for that define which is still
working fine with that version of Mac OS ?

 Thanks,
  Thomas
