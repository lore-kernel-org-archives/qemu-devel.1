Received: from eggs.gnu.org ([2001:4830:134:3::10]:35631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d0U6O-0000an-MC
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d0U6K-00048j-Fp
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:27:32 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d0U6K-00048U-AY
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:27:28 -0400
Received: by mail-pf0-x241.google.com with SMTP id i5so30829464pfc.3
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 07:27:28 -0700 (PDT)
Date: Tue, 18 Apr 2017 23:27:23 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170418142723.GD2599@lianli.shorne-pla.net>
References: <cover.1492384862.git.shorne@gmail.com>
	<fae2ac85b7226ec28c8419f488cd9947bb6142a0.1492384862.git.shorne@gmail.com>
	<2b6eee7d-e83d-5d0f-c1ef-a8a85236807d@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b6eee7d-e83d-5d0f-c1ef-a8a85236807d@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 7/7] target/openrisc: Implement full
 vmstate serialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, y@lianli.shorne-pla.net
Cc: qemu-devel@nongnu.org, openrisc@lists.librecores.org

On Tue, Apr 18, 2017 at 01:14:19AM -0700, Richard Henderson wrote:
> On 04/16/2017 04:23 PM, Stafford Horne wrote:
> > Previously serialization did not persist the tlb, timer, pic and other
> > key state items.  This meant snapshotting and restoring a running os
> > would crash. After adding these I am able to take snapshots of a
> > running linux os and restore at a later time.
> > 
> > I am currently not trying to maintain capatibility with older versions
> > as I do not believe this really worked before or anyone used it.
> 
> That's fine, but you still have to bump the version numbers.

Actually, I bumped the version in the previous patch.  Ill make that more
clear an do that in this patch instead.

-Stafford

> r~
> 
