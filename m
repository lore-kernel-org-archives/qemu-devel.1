Received: from eggs.gnu.org ([2001:4830:134:3::10]:59783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f3CMb-0003NQ-DD
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 23:12:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f3CMW-000558-U3
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 23:12:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44470 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f3CMW-00054j-Ox
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 23:11:56 -0400
Date: Tue, 3 Apr 2018 11:11:48 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180403031147.GC6839@lemon.usersys.redhat.com>
References: <CAEMkAmGoPm8p0MKumctDPodaD4PCUYi4X=ovs+kMO9xTKGkLeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEMkAmGoPm8p0MKumctDPodaD4PCUYi4X=ovs+kMO9xTKGkLeQ@mail.gmail.com>
Subject: Re: [Qemu-devel] Loadable block drivers?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lindsay Mathieson <lindsay.mathieson@gmail.com>
Cc: qemu-devel@nongnu.org

On Tue, 04/03 12:59, Lindsay Mathieson wrote:
> Hi all, was looking at developing a block driver for qemu - have examined
> the drivers at:
> 
>   https://github.com/qemu/qemu/tree/master/block
> 
> And it seems straightforward enough.
> 
> One thing that is unclear - all the drivers appear to be compiled directly
> into qemu. Is there no way to load them dynamically as .so modules?

'./configure --enable-modules' will enable building block drivers as .so
objects, and they are loaded dynamically. These are in-tree .so modules;
out-of-tree modules like in Linux kernel are intentionally forbidden.

Fam
