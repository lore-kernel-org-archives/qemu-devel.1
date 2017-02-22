Received: from eggs.gnu.org ([2001:4830:134:3::10]:38396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1cgNI3-00006R-Vj
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:08:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1cgNI0-0001C4-RU
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:08:27 -0500
Received: from mail5.windriver.com ([192.103.53.11]:54856 helo=mail5.wrs.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Chris.Friesen@windriver.com>)
	id 1cgNI0-0001Bs-J7
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:08:24 -0500
Message-ID: <58AD0094.90304@windriver.com>
Date: Tue, 21 Feb 2017 21:08:04 -0600
From: Chris Friesen <chris.friesen@windriver.com>
MIME-Version: 1.0
References: <589C7E96.9060905@huawei.com> <589D83CE.1090803@huawei.com>	
	<589DDC05.9010807@windriver.com> <58AA51D6.6020508@huawei.com>
	<1487565495.3740.27.camel@intel.com>
In-Reply-To: <1487565495.3740.27.camel@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] kvm bug in __rmap_clear_dirty during live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Han, Huaitong" <huaitong.han@intel.com>, "hangaohuai@huawei.com" <hangaohuai@huawei.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "fangying1@huawei.com" <fangying1@huawei.com>, "herongguang.he@huawei.com" <herongguang.he@huawei.com>, "xudong.hao@linux.intel.com" <xudong.hao@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "wangxinxin.wang@huawei.com" <wangxinxin.wang@huawei.com>, "kai.huang@linux.intel.com" <kai.huang@linux.intel.com>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "guangrong.xiao@linux.intel.com" <guangrong.xiao@linux.intel.com>

On 02/19/2017 10:38 PM, Han, Huaitong wrote:
> Hi, Gaohuai
>
> I tried to debug the problem, and I found the indirect cause may be that
> the rmap value is not cleared when KVM mmu page is freed. I have read
> code without the root cause. Can you stable reproduce the the issue?
> Many guesses need to be verified.

In both cases it seems to have been triggered by repeatedly live-migrating a KVM 
virtual machine between two hypervisors with Broadwell CPUs running the latest 
CentOS 7.

It's a race of some sort, it doesn't happen every time.

Chris
