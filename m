Received: from eggs.gnu.org ([2001:4830:134:3::10]:50774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cgUtt-0006db-IR
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:16:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cgUtp-0003vw-Iw
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:16:01 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cgUtp-0003vs-CU
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:15:57 -0500
Received: by mail-wr0-x242.google.com with SMTP id z61so1057197wrc.3
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 03:15:57 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <589C7E96.9060905@huawei.com> <589D83CE.1090803@huawei.com>
	<589DDC05.9010807@windriver.com> <58AA51D6.6020508@huawei.com>
	<1487565495.3740.27.camel@intel.com> <58AD0094.90304@windriver.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4dd92012-626a-2d80-9adb-0be398f73eb1@redhat.com>
Date: Wed, 22 Feb 2017 12:15:54 +0100
MIME-Version: 1.0
In-Reply-To: <58AD0094.90304@windriver.com>
Content-Type: text/plain; charset=utf-8
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
To: Chris Friesen <chris.friesen@windriver.com>, "Han, Huaitong" <huaitong.han@intel.com>, "hangaohuai@huawei.com" <hangaohuai@huawei.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "fangying1@huawei.com" <fangying1@huawei.com>, "herongguang.he@huawei.com" <herongguang.he@huawei.com>, "xudong.hao@linux.intel.com" <xudong.hao@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wangxinxin.wang@huawei.com" <wangxinxin.wang@huawei.com>, "kai.huang@linux.intel.com" <kai.huang@linux.intel.com>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "guangrong.xiao@linux.intel.com" <guangrong.xiao@linux.intel.com>



On 22/02/2017 04:08, Chris Friesen wrote:
> On 02/19/2017 10:38 PM, Han, Huaitong wrote:
>> Hi, Gaohuai
>>
>> I tried to debug the problem, and I found the indirect cause may be that
>> the rmap value is not cleared when KVM mmu page is freed. I have read
>> code without the root cause. Can you stable reproduce the the issue?
>> Many guesses need to be verified.
> 
> In both cases it seems to have been triggered by repeatedly
> live-migrating a KVM virtual machine between two hypervisors with
> Broadwell CPUs running the latest CentOS 7.
> 
> It's a race of some sort, it doesn't happen every time.

Can you reproduce it with kernel 4.8+?  I'm suspecting commmit
4e59516a12a6 ("kvm: vmx: ensure VMCS is current while enabling PML",
2016-07-14) to be the fix.

Paolo
