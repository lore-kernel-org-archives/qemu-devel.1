Received: from eggs.gnu.org ([2001:4830:134:3::10]:37865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1e5nWd-0008Ij-VO
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 02:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1e5nWa-0006G7-RS
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 02:44:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1e5nWa-0006Ft-Ku
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 02:44:48 -0400
Date: Sat, 21 Oct 2017 07:44:45 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171021064444.GJ30459@redhat.com>
References: <6968797c-f64c-69ff-2fa6-79c4fb3440c9@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6968797c-f64c-69ff-2fa6-79c4fb3440c9@mail.uni-paderborn.de>
Subject: Re: [Qemu-devel] [sw-dev] [RFC] RISC-V Decoder generator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V SW Dev <sw-dev@groups.riscv.org>

On Fri, Oct 20, 2017 at 03:46:54PM +0200, Bastian Koppelmann wrote:
> I asked you for feedback some while ago regarding a modular RISC-V QEMU
> target (see discussion [1]). I tried getting it to work with the good
> old C preprocessor and quickly realized that it is too limiting. Instead
> I created a data-driven decoder generator written in python (see the
> code on github [2]) using YAML as a description language.
> 
> I'd like to get some feedback whether this is acceptable to be
> upstreamed to QEMU or if you have any suggestions for improvements.
> Right now only RV32I instruction are implemented in this scheme.

My suggestion would be to reimplement (part of) the s390x decoder
using this scheme.  That would give us a direct comparison of how your
scheme is better or worse than the existing macros.

Will you be at the KVM Forum next week?

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
