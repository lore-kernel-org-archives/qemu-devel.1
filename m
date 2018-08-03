Received: from eggs.gnu.org ([2001:4830:134:3::10]:52210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1flU3L-0002Zr-PK
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 02:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1flU3I-0006cx-O5
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 02:59:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55304 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1flU3I-0006aU-JC
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 02:59:08 -0400
Date: Fri, 3 Aug 2018 08:59:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180803065905.GB4380@localhost.localdomain>
References: <CAB3eZfudS9D3G-JSNcaeZO_vWYBQytSbSLzDSLd+abGU9mLeoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB3eZfudS9D3G-JSNcaeZO_vWYBQytSbSLzDSLd+abGU9mLeoA@mail.gmail.com>
Subject: Re: [Qemu-devel] Can I create img more thant 16TB?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lampahome <pahome.chen@mirlab.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Am 03.08.2018 um 06:46 hat lampahome geschrieben:
> There's file size maximum in ext4 and it's 16TB
> 
> Can I create qcow2 ex:32TB and write more than 16TB?

qcow2 images can be larger than 16 TB, but if you actually write that
much data to them, you can't store them on ext4, because obviously they
are still just files and the filesystem limit applies.

Kevin
