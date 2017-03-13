Received: from eggs.gnu.org ([2001:4830:134:3::10]:47017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnTHd-0005Ws-4r
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnTHZ-0006JK-As
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:57:21 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cnTHZ-0006I6-3b
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:57:17 -0400
Received: by mail-wr0-x241.google.com with SMTP id u108so20841660wrb.2
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 09:57:15 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <589C7E96.9060905@huawei.com> <589D83CE.1090803@huawei.com>
	<589DDC05.9010807@windriver.com> <58AA51D6.6020508@huawei.com>
	<1487565495.3740.27.camel@intel.com> <58AD0094.90304@windriver.com>
	<4dd92012-626a-2d80-9adb-0be398f73eb1@redhat.com>
	<58AD92AE.6040502@windriver.com>
	<6c5567f4-192d-aefd-90e4-89f53479c24e@redhat.com>
	<58AF9921.6060201@huawei.com> <58B04CD3.7010304@windriver.com>
	<7fdf2551-3d55-1bd9-2848-720a880cc93e@redhat.com>
	<58B0E191.6040108@huawei.com>
	<50916996-297e-a794-38e8-5c7ca9389419@linux.intel.com>
	<a865b1b0-558f-900f-06d7-ceace1c46afb@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d6172fb7-ab1c-0faf-ed71-18fd74781671@redhat.com>
Date: Mon, 13 Mar 2017 17:57:13 +0100
MIME-Version: 1.0
In-Reply-To: <a865b1b0-558f-900f-06d7-ceace1c46afb@huawei.com>
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
To: fangying <fangying1@huawei.com>, "Huang, Kai" <kai.huang@linux.intel.com>, "Herongguang (Stephen)" <herongguang.he@huawei.com>, Chris Friesen <chris.friesen@windriver.com>, "Han, Huaitong" <huaitong.han@intel.com>, "hangaohuai@huawei.com" <hangaohuai@huawei.com>, stable@vger.kernel.org
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "xudong.hao@linux.intel.com" <xudong.hao@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wangxinxin.wang@huawei.com" <wangxinxin.wang@huawei.com>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "guangrong.xiao@linux.intel.com" <guangrong.xiao@linux.intel.com>, linux-kernel@vger.kernel.org



On 13/03/2017 15:58, fangying wrote:
> Hi, Huang Kai
> 
> After weeks of intensive testing, we think the problem is solved and
> this issue can be closed.

Thanks for the update.  We got to the same conclusion.

Paolo
