Received: from eggs.gnu.org ([2001:4830:134:3::10]:53869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eySqS-0005sr-Ei
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 21:47:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eySqN-0000Aa-JY
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 21:47:16 -0400
Date: Wed, 21 Mar 2018 09:46:57 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180321014657.GC12771@lemon.usersys.redhat.com>
References: <20180319215335.1119213-1-eblake@redhat.com>
	<56ec7ba5-a6e1-2268-3313-8babc640c024@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56ec7ba5-a6e1-2268-3313-8babc640c024@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] rdma: Fix 32-bit compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Yuval Shaia <yuval.shaia@oracle.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Tue, 03/20 12:30, Marcel Apfelbaum wrote:
> Hi Eric,
> 
> On 19/03/2018 23:53, Eric Blake wrote:
> > Use the correct printf formats, so that a 32-bit compile doesn't
> > spit out lots of warnings about %lx being incompatible with uint64_t.
> > Broken since initial commit ef6d4ccd.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> > 
> > I don't know if 'make vm-build-ubuntu.i368' would catch this (it failed
> > for me for other reasons); I found it via a 32-bit rawhide VM.
> > 
> 
> I couldn't run 'make vm-build-ubuntu.i368' either. (Stuck on "Booting from Hard Disk...")
> 
> I run make docker-test-build@debian-win32-cross to be sure it compiles on 32bit arch,
> however I found out the docker configuration results in 'RDMA support no', so it will not help.

Cc'ing Phil and Alex who know this image better than me. Meanwhile I'll take a
look at why make vm-build-ubuntu.i386 is broken. Thanks.

Fam
