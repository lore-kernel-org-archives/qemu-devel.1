Received: from eggs.gnu.org ([2001:4830:134:3::10]:38193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2cl0-00018r-I8
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2ckx-0003fm-Cx
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:06:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d2ckx-0003fU-6u
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:06:15 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <830bfc39-56c7-a901-9ebb-77d6e7a5614c@huawei.com> (Yang
	Hongyang's message of "Mon, 24 Apr 2017 19:46:19 +0800")
References: <830bfc39-56c7-a901-9ebb-77d6e7a5614c@huawei.com>
Reply-To: quintela@redhat.com
Date: Mon, 24 Apr 2017 14:06:11 +0200
Message-ID: <874lxeovrg.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Huangzhichao <huangzhichao@huawei.com>, wangxinxin.wang@huawei.com, pbonzini@redhat.com, "Gonglei (Arei)" <arei.gonglei@huawei.com>

Yang Hongyang <yanghongyang@huawei.com> wrote:
> Hi all,
>
> We found dirty log switch costs more then 13 seconds while migrating
> a 4T memory guest, and dirty log switch is currently protected by QEMU
> BQL. This causes guest freeze for a long time when switching dirty log on,
> and the migration downtime is unacceptable.
> Are there any chance to optimize the time cost for dirty log switch operation?
> Or move the time consuming operation out of the QEMU BQL?

Hi

Could you specify what do you mean by dirty log switch?
The one inside kvm?
The merge between kvm one and migration bitmap?

Thanks, Juan.
