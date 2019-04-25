Received: from eggs.gnu.org ([209.51.188.92]:39540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJiTf-00059t-DL
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJiTe-0005Fa-EC
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:48:07 -0400
Date: Thu, 25 Apr 2019 14:48:02 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190425174802.GQ18406@habkost.net>
References: <1555315185-16414-1-git-send-email-like.xu@linux.intel.com>
	<1555315185-16414-3-git-send-email-like.xu@linux.intel.com>
	<20190416212003.GB2272@habkost.net>
	<87ftqh1ae5.fsf@dusky.pond.sub.org>
	<20190417171059.GC25134@habkost.net>
	<3fc39df9-9c4e-219c-e7dc-c93754fd1315@linux.intel.com>
	<20190424172143.GC18406@habkost.net>
	<a8aa414d-b393-83a7-61dd-01b15b27d93d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8aa414d-b393-83a7-61dd-01b15b27d93d@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] core/qdev: refactor
 qdev_get_machine() with type assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Like Xu <like.xu@linux.intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, like.xu@intel.com, Igor Mammedov <imammedo@redhat.com>

On Thu, Apr 25, 2019 at 11:12:29AM +0800, Like Xu wrote:
> On 2019/4/25 1:21, Eduardo Habkost wrote:
[...]
> > 
> > I think we all agree that qdev_get_machine() should eventually be
> > available in softmmu only.
> 
> I think we need to make it happen to avoid calling qdev_get_machine()
> in user-only mode.

Agreed.  My point is that we we shouldn't need a
qdev_get_machine_unchecked() function at all if we first get rid
of all user-only qdev_get_machine() calls.

> > 
> > But I don't think we agree when it would be appropriate to call
> > qdev_get_machine_unchecked() instead of qdev_get_machine().
> > 
> > On both examples in your patch, the code checks for TYPE_MACHINE
> > immediately after calling qdev_get_machine_unchecked().  If that
> > code is only useful in softmmu mode, when would anybody want to
> > call qdev_get_machine_unchecked() in user-only mode?
> > 
> > 

-- 
Eduardo
