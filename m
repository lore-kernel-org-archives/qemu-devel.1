Received: from eggs.gnu.org ([2001:4830:134:3::10]:46878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ek6x1-0003qa-Dk
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:34:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ek6wy-0001Y3-Ar
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:34:43 -0500
Received: from 7.mo3.mail-out.ovh.net ([46.105.57.200]:48701)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ek6wy-0001NH-37
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:34:40 -0500
Received: from player758.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 0DEE1195CCC
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 12:34:31 +0100 (CET)
Date: Fri, 9 Feb 2018 12:33:42 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180209123342.11b17062@bahia.lan>
In-Reply-To: <5A7D4976.6060407@huawei.com>
References: <5A7D4976.6060407@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [V9fs-developer] [RFC] we should solve
 create-unlink-getattr idiom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jiangyiwen <jiangyiwen@huawei.com>
Cc: Eric Van Hensbergen <ericvh@gmail.com>, v9fs-developer@lists.sourceforge.net, qemu-devel@nongnu.org, aneesh.kumar@linux.vnet.ibm.com, Ron Minnich <rminnich@sandia.gov>, Latchesar Ionkov <lucho@ionkov.net>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Veaceslav Falico <veaceslav.falico@huawei.com>

On Fri, 9 Feb 2018 15:10:46 +0800
jiangyiwen <jiangyiwen@huawei.com> wrote:

> Hi Eric and Greg,
> 
> I encountered the similar problem with create-unlink-getattr idiom.
> I use the testcase that create-unlink-setattr idiom, and I see the
> bug is reported at https://bugs.launchpad.net/qemu/+bug/1336794.
> Then I also see you already fix the issue and push the patch to upstream.
> https://github.com/ericvh/linux/commit/eaf70223eac094291169f5a6de580351890162a2
> http://patchwork.ozlabs.org/patch/626194/
> 
> Unfortunately, the two patches are not merged into master, I don't know
> the reason, so I suggest if the patche can be merged into master, and
> it will solve the create-unlink-getattr idiom.
> 

I had tried to go a bit further and address the general issue of f*() syscalls
versus unlinked files:

QEMU:
http://lists.gnu.org/archive/html/qemu-devel/2016-06/msg07586.html

Linux 9p driver:
https://sourceforge.net/p/v9fs/mailman/message/35175775/

I remember that some issues were then reported during review of the
linux patches, and I never got bandwidth to investigate further...

But if you'd like to resurrect these threads, please do. :)

> Thanks,
> Yiwen
> 

Cheers,

--
Greg
