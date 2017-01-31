Received: from eggs.gnu.org ([2001:4830:134:3::10]:55582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cYVXI-0007oO-DY
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 05:19:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cYVXF-0000Ws-AL
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 05:19:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cYVXF-0000We-4e
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 05:19:37 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170131100528.GC2395@work-vm> (David Alan Gilbert's message of
	"Tue, 31 Jan 2017 10:05:29 +0000")
References: <1485327241-15104-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1485327241-15104-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170131100528.GC2395@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 31 Jan 2017 11:19:31 +0100
Message-ID: <87shnzcz0s.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] savevm: Add new helpers to process the
 different stages of loadvm/savevm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org, amit.shah@redhat.com, xuquan8@huawei.com, Li Zhijian <lizhijian@cn.fujitsu.com>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
>> There are several stages during loadvm/savevm process. In different stage,
>> migration incoming processes different types of sections.
>> We want to control these stages more accuracy, it will benefit COLO
>> performance, we don't have to save type of QEMU_VM_SECTION_START
>> sections everytime while do checkpoint, besides, we want to separate
>> the process of saving/loading memory and devices state.
>> 
>> So we add three new helper functions: qemu_loadvm_state_begin(),
>> qemu_load_device_state() and qemu_savevm_live_state() to achieve
>> different process during migration.
>> 
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> I don't think this one can go in without the patch that follows which
> uses these functions; we don't normally add functions
> without the patch that uses them.

Agreed.  If you want to add functions, you need new code that use them,
or make old code use them.  It is up to you.

Thanks, Juan.
