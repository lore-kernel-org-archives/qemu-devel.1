Received: from eggs.gnu.org ([2001:4830:134:3::10]:41410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yanghongyang@huawei.com>) id 1d2csP-00055C-Ug
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yanghongyang@huawei.com>) id 1d2csK-0006ax-35
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:13:57 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3473
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <yanghongyang@huawei.com>) id 1d2csJ-0006Zs-Na
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:13:52 -0400
References: <830bfc39-56c7-a901-9ebb-77d6e7a5614c@huawei.com>
	<874lxeovrg.fsf@secure.mitica>
From: Yang Hongyang <yanghongyang@huawei.com>
Message-ID: <7cd332ec-48d4-1feb-12e2-97b50b04e028@huawei.com>
Date: Mon, 24 Apr 2017 20:13:27 +0800
MIME-Version: 1.0
In-Reply-To: <874lxeovrg.fsf@secure.mitica>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] About QEMU BQL and dirty log switch in Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Huangzhichao <huangzhichao@huawei.com>, wangxinxin.wang@huawei.com, pbonzini@redhat.com, "Gonglei (Arei)" <arei.gonglei@huawei.com>



On 2017/4/24 20:06, Juan Quintela wrote:
> Yang Hongyang <yanghongyang@huawei.com> wrote:
>> Hi all,
>>
>> We found dirty log switch costs more then 13 seconds while migrating
>> a 4T memory guest, and dirty log switch is currently protected by QEMU
>> BQL. This causes guest freeze for a long time when switching dirty log on,
>> and the migration downtime is unacceptable.
>> Are there any chance to optimize the time cost for dirty log switch operation?
>> Or move the time consuming operation out of the QEMU BQL?
> 
> Hi
> 
> Could you specify what do you mean by dirty log switch?
> The one inside kvm?
> The merge between kvm one and migration bitmap?

The call of the following functions:
memory_global_dirty_log_start/stop();

> 
> Thanks, Juan.
> 

-- 
Thanks,
Yang
