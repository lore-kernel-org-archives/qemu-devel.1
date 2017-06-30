Received: from eggs.gnu.org ([2001:4830:134:3::10]:45387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dQm2v-00071B-HA
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 22:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dQm2s-0001QE-F6
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 22:52:37 -0400
Received: from [59.151.112.132] (port=35725 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dQm2r-0001Iv-4i
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 22:52:34 -0400
References: <1496736776-19852-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<20170629103604.GB2399@work-vm>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <071f38fc-2b94-0197-c143-5e8164679f08@cn.fujitsu.com>
Date: Fri, 30 Jun 2017 10:54:12 +0800
MIME-Version: 1.0
In-Reply-To: <20170629103604.GB2399@work-vm>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH V3 0/3] COLO-compare: Make COLO-compare
 support remote COLO-frame
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: zhangchen.fnst@cn.fujitsu.com, qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 06/29/2017 06:36 PM, Dr. David Alan Gilbert wrote:
> * Zhang Chen (zhangchen.fnst@cn.fujitsu.com) wrote:
>> This series focus on COLO-proxy remote colo-frame support.
>> Xen COLO-frame is the first user. We add a new chardev socket
>> in colo-compare as the way of communicate with remote COLO-frame.
>> And remote COLO-frame notify colo-proxy part depend on this serise:
>> https://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg03904.html
> Can you explain a bit more about how the 'remote colo-frame' works?
> Is this the comparison that's separate or what?

COLO consists of three modules, colo-frame, colo-proxy, block-replication.
If we use qemu/kvm COLO, the three parts all in qemu side.
If we use Xen COLO, the colo-frame in Xen side(the remote COLO-frame),
and colo-proxy,block-replication in qemu side. So, in this case,
remote colo-frame need use qmp command and socket connect to 
block-replication
and colo-proxy finish COLO job.
KVM COLO and Xen COLO use the same colo-proxy to compare net packet.

Thanks
Zhang Chen

>
> Dave
>
>> I will send another part of this series after depend patchset have
>> been merged.
>>
>> V3:
>>   - Fix codestyle.
>>
>> V2:
>>   - Rename this series.
>>   - Change communication way to remote colo-frame.
>>   - Some bugfix.
>>   - Split the main function, anther part wait depend patchset.
>>
>>
>> Zhang Chen (3):
>>    COLO-compare: Add new parameter for communicate with remote colo-frame
>>    COLO-compare: Add remote checkpoint notify chardev socket handler
>>      frame
>>    COLO-compare: Add remote initialization and checkpoint notification
>>
>>   net/colo-compare.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>   qemu-options.hx    | 41 ++++++++++++++++++++----
>>   2 files changed, 124 insertions(+), 8 deletions(-)
>>
>> -- 
>> 2.7.4
>>
>>
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>
>

-- 
Thanks
Zhang Chen
