Received: from eggs.gnu.org ([2001:4830:134:3::10]:43050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cgY9A-0003tl-Ba
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cgY97-00014y-0O
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:44:00 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cgY96-00014r-Qe
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:43:56 -0500
Received: by mail-wr0-x244.google.com with SMTP id s27so642485wrb.0
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 06:43:56 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <589C7E96.9060905@huawei.com> <589D83CE.1090803@huawei.com>
	<589DDC05.9010807@windriver.com> <58AA51D6.6020508@huawei.com>
	<1487565495.3740.27.camel@intel.com> <58AD0094.90304@windriver.com>
	<4dd92012-626a-2d80-9adb-0be398f73eb1@redhat.com>
	<58AD92AE.6040502@windriver.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6c5567f4-192d-aefd-90e4-89f53479c24e@redhat.com>
Date: Wed, 22 Feb 2017 15:43:54 +0100
MIME-Version: 1.0
In-Reply-To: <58AD92AE.6040502@windriver.com>
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



On 22/02/2017 14:31, Chris Friesen wrote:
>>>
>>
>> Can you reproduce it with kernel 4.8+?  I'm suspecting commmit
>> 4e59516a12a6 ("kvm: vmx: ensure VMCS is current while enabling PML",
>> 2016-07-14) to be the fix.
> 
> I can't easily try with a newer kernel, the software package we're using
> has kernel patches that would have to be ported.
> 
> I'm at a conference, don't really have time to set up a pair of test
> machines from scratch with a custom kernel.

Hopefully Gaohuai and Rongguang can help with this too.

Paolo
