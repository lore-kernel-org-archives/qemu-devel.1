Received: from eggs.gnu.org ([2001:4830:134:3::10]:55212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1chHW4-00011C-WD
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1chHW0-0000Le-09
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:10:40 -0500
Received: from mail5.windriver.com ([192.103.53.11]:42344 helo=mail5.wrs.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Chris.Friesen@windriver.com>)
	id 1chHVz-0000KZ-MH
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:10:35 -0500
Message-ID: <58B04CD3.7010304@windriver.com>
Date: Fri, 24 Feb 2017 09:10:11 -0600
From: Chris Friesen <chris.friesen@windriver.com>
MIME-Version: 1.0
References: <589C7E96.9060905@huawei.com> <589D83CE.1090803@huawei.com>
	<589DDC05.9010807@windriver.com> <58AA51D6.6020508@huawei.com>
	<1487565495.3740.27.camel@intel.com> <58AD0094.90304@windriver.com>
	<4dd92012-626a-2d80-9adb-0be398f73eb1@redhat.com>
	<58AD92AE.6040502@windriver.com>
	<6c5567f4-192d-aefd-90e4-89f53479c24e@redhat.com>
	<58AF9921.6060201@huawei.com>
In-Reply-To: <58AF9921.6060201@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] kvm bug in __rmap_clear_dirty during live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Herongguang (Stephen)" <herongguang.he@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, "Han, Huaitong" <huaitong.han@intel.com>, "hangaohuai@huawei.com" <hangaohuai@huawei.com>, stable@vger.kernel.org
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "fangying1@huawei.com" <fangying1@huawei.com>, "xudong.hao@linux.intel.com" <xudong.hao@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wangxinxin.wang@huawei.com" <wangxinxin.wang@huawei.com>, "kai.huang@linux.intel.com" <kai.huang@linux.intel.com>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "guangrong.xiao@linux.intel.com" <guangrong.xiao@linux.intel.com>, linux-kernel@vger.kernel.org

On 02/23/2017 08:23 PM, Herongguang (Stephen) wrote:

> On 2017/2/22 22:43, Paolo Bonzini wrote:

>> Hopefully Gaohuai and Rongguang can help with this too.
>>
>> Paolo
>>
>> .
>>
> Yes, we are looking into and testing this.
>
> I think this can result in any memory corruption, if VM1 writes its
> PML buffer into VM2=E2=80=99s VMCS (since sched_in/sched_out notifier o=
f VM1
> is not registered yet), then VM1 is destroyed (hence its PML buffer
> is freed back to kernel), after that, VM2 starts migration, so CPU
> logs VM2=E2=80=99s dirty GFNS into a freed memory, results in any memor=
y corruption.
>
> As its severity, this commit
> (http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/=
?id=3D4e59516a12a6ef6dcb660cb3a3f70c64bd60cfec)
>
> is eligible to back port to kernel stable.
>

Are we expecting that fix to resolve the original issue, or is it a separ=
ate=20
issue that needs fixing in stable?

Chris
