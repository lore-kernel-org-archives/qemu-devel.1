Received: from eggs.gnu.org ([2001:4830:134:3::10]:40937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epFDz-0003eH-Oy
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epFDy-00045d-Tk
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:25:27 -0500
Date: Fri, 23 Feb 2018 16:25:08 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180223152508.GC3470@localhost.localdomain>
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-28-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221135404.27598-28-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 27/36] sheepdog: QAPIfy "redundacy"
 create option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

Am 21.02.2018 um 14:53 hat Kevin Wolf geschrieben:
> The "redundacy" option for Sheepdog image creation is currently a string
> that can encode one or two integers depending on its format, which at
> the same time implicitly selects a mode.
> 
> This patch turns it into a QAPI union and converts the string into such
> a QAPI object before interpreting the values.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

s/redundacy/redundancy/

Both in the subject line and the commit message. Autocompletion is
great, it helps to apply typos consistently.

Kevin
