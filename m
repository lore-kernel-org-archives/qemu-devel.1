Received: from eggs.gnu.org ([2001:4830:134:3::10]:33374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eFNCc-0005EU-SF
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:39:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eFNCZ-0008De-4z
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:39:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:12922)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eFNCY-0008AC-7i
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:39:43 -0500
Date: Thu, 16 Nov 2017 09:43:46 +0800
From: Zhong Yang <yang.zhong@intel.com>
Message-ID: <20171116014346.GA16015@yangzhon-Virtual>
References: <8E78D212B8C25246BE4CE7EA0E645FE501B557EA@dggeml511-mbs.china.huawei.com>
	<d344052d-ac24-2ce0-38bc-b8008c895946@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d344052d-ac24-2ce0-38bc-b8008c895946@redhat.com>
Subject: Re: [Qemu-devel] [Question] Qemu's Heap Becomes Very Large and
 Never Reduce Down
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, yang.zhong@intel.com, anthony.xu@intel.com, stefanha@redhat.com, berrange@redhat.com, stone.xulei@huawei.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, zhang.zhanghailiang@huawei.com, liujunjie23@huawei.com

On Wed, Nov 15, 2017 at 02:18:55PM +0100, Paolo Bonzini wrote:
> On 15/11/2017 04:14, Xulei (Stone) wrote:
> > Hi, guys
> > 
> > I met a strange problem, with qemu 2.8.1:
> > qemu consumes too many heap memory after several operations and can not
> > release them anymore: 
> > hot pulg/unplug disk & net, vnc connect/disconnect, guestOS reboot, etc.
> 
> Try with newer QEMU; until recently we used a lot of memory at startup,
> but it was improved in 2.11.
> 
> However, I think Anthony also had a patch adding a malloc_trim call in
> the RCU thread, which improved memory usage.  Anthony, do you know if
> this is still necessary in 2.11?
>
  Hello Paolo,

  Last time, when you traveled in BeiJing, we talked about this malloc_trim() 
  solution in RH office. At that time, you asked me to send this patch to upstream.
  I can try this patch in the newest Qemu version if you regard this solution is
  suitable.

  I also want to look for other more better solution, but there are some urgency 
  tasks interrupt me.

  In fact, Anthony also have some other solutions for heap memory deduction in
  our intel ClearContainer.
 
  Regards,

  Yang Zhong
 
> Thanks,
> 
> Paolo
