Received: from eggs.gnu.org ([2001:4830:134:3::10]:42976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dvmw3-0005JV-1U
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 12:05:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dvmvz-0003MA-OE
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 12:05:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:45613)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dvmvz-0003HV-Gh
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 12:05:39 -0400
References: <alpine.DEB.2.10.1706271456310.24648@sstabellini-ThinkPad-X260>
	<1498601083-11799-1-git-send-email-sstabellini@kernel.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <8717f8c6-69e4-558e-64d2-f4361cd98594@msgid.tls.msk.ru>
Date: Sat, 23 Sep 2017 19:05:28 +0300
MIME-Version: 1.0
In-Reply-To: <1498601083-11799-1-git-send-email-sstabellini@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] xen/disk: don't leak stack data via response ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>, stefanha@gmail.com
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, Jan Beulich <jbeulich@suse.com>, anthony.perard@citrix.com, xen-devel@lists.xenproject.org

28.06.2017 01:04, Stefano Stabellini wrote:
> Rather than constructing a local structure instance on the stack, fill
> the fields directly on the shared ring, just like other (Linux)
> backends do. Build on the fact that all response structure flavors are
> actually identical (aside from alignment and padding at the end).
> 
> This is XSA-216.
> 
> Reported by: Anthony Perard <anthony.perard@citrix.com>
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Reportedly, after this patch, HVM DomUs running with qemu-system-i386
(note i386, not x86_64), are leaking memory and host is running out of
memory rather fast.  See for example https://bugs.debian.org/871702

I've asked for details, let's see...

For one, I've no idea how xen hvm works, and whenever -i386 version
can be choosen in config or how.

Thanks,

/mjt
