Received: from eggs.gnu.org ([2001:4830:134:3::10]:60284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2h4f-0003Fe-JA
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2h4c-0005ao-GP
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:42:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d2h4c-0005ak-9S
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:42:50 -0400
Date: Mon, 24 Apr 2017 17:42:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170424164244.GJ2362@work-vm>
References: <830bfc39-56c7-a901-9ebb-77d6e7a5614c@huawei.com>
	<874lxeovrg.fsf@secure.mitica>
	<7cd332ec-48d4-1feb-12e2-97b50b04e028@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cd332ec-48d4-1feb-12e2-97b50b04e028@huawei.com>
Subject: Re: [Qemu-devel] About QEMU BQL and dirty log switch in Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Hongyang <yanghongyang@huawei.com>
Cc: quintela@redhat.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Huangzhichao <huangzhichao@huawei.com>, wangxinxin.wang@huawei.com, pbonzini@redhat.com, "Gonglei (Arei)" <arei.gonglei@huawei.com>

* Yang Hongyang (yanghongyang@huawei.com) wrote:
> 
> 
> On 2017/4/24 20:06, Juan Quintela wrote:
> > Yang Hongyang <yanghongyang@huawei.com> wrote:
> >> Hi all,
> >>
> >> We found dirty log switch costs more then 13 seconds while migrating
> >> a 4T memory guest, and dirty log switch is currently protected by QEMU
> >> BQL. This causes guest freeze for a long time when switching dirty log on,
> >> and the migration downtime is unacceptable.
> >> Are there any chance to optimize the time cost for dirty log switch operation?
> >> Or move the time consuming operation out of the QEMU BQL?
> > 
> > Hi
> > 
> > Could you specify what do you mean by dirty log switch?
> > The one inside kvm?
> > The merge between kvm one and migration bitmap?
> 
> The call of the following functions:
> memory_global_dirty_log_start/stop();

I suppose there's a few questions;
  a) Do we actually need the BQL - and if so why
  b) What actually takes 13s?  It's probably worth figuring
out where it goes,  the whole bitmap is only 1GB isn't it
even on a 4TB machine, and even the simplest way to fill
that takes way less than 13s.

Dave

> 
> > 
> > Thanks, Juan.
> > 
> 
> -- 
> Thanks,
> Yang
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
