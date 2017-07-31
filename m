Received: from eggs.gnu.org ([2001:4830:134:3::10]:57092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dc4lH-0000Ug-JP
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 03:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dc4lE-0004Qh-Db
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 03:05:07 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dc4lD-0004NX-Q9
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 03:05:04 -0400
References: <1500522569-10760-1-git-send-email-jianjay.zhou@huawei.com>
	<20170721094943.GC2133@work-vm> <5971F246.5080000@huawei.com>
	<20170724153521.GD2127@work-vm> <5976EE99.5050401@huawei.com>
	<20170725103426.GC2099@work-vm>
From: Jay Zhou <jianjay.zhou@huawei.com>
Message-ID: <597ED67B.4000904@huawei.com>
Date: Mon, 31 Jul 2017 15:04:27 +0800
MIME-Version: 1.0
In-Reply-To: <20170725103426.GC2099@work-vm>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration: optimize the downtime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: pbonzini@redhat.com, rkrcmar@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com, armbru@redhat.com, arei.gonglei@huawei.com, zhang.zhanghailiang@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, aarcange@redhat.com, jdenemar@redhat.com

Hi Dave,

On 2017/7/25 18:34, Dr. David Alan Gilbert wrote:
>> After checking the codes of the newest libvirt, I think it is the same
>> in the qemuMigrationWaitForCompletion function, which is used to poll
>> qemu every 50ms.
>
> Checking with Jiri Denemark (added to cc), newer libvirt should use
> events when available - but that polling code is there to cope with
> older qemu's.  So with a newer qemu, i think it should spot the
> COMPLETED event.
>

I do tests on the newest libvirt(v3.6.0) + newest qemu(v2.9.90,
v2.10.0-rc0-29-ga588c49-dirty). The log added indicates that the source
side libvirt spots the COMPLETE event after the cleanup of the source side
qemu, i.e. 300ms still exists.

BTW, I'm not very familiar with libvirt, if there is something special to
configure or I'm missing something, please let me know.

Thanks,
Jay
