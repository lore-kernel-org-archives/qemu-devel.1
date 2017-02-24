Received: from eggs.gnu.org ([2001:4830:134:3::10]:55946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1chHZV-0004B5-Ol
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:14:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1chHZQ-0001cF-Pw
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:14:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1chHZQ-0001c3-Jk
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:14:08 -0500
References: <589C7E96.9060905@huawei.com> <589D83CE.1090803@huawei.com>
	<589DDC05.9010807@windriver.com> <58AA51D6.6020508@huawei.com>
	<1487565495.3740.27.camel@intel.com> <58AD0094.90304@windriver.com>
	<4dd92012-626a-2d80-9adb-0be398f73eb1@redhat.com>
	<58AD92AE.6040502@windriver.com>
	<6c5567f4-192d-aefd-90e4-89f53479c24e@redhat.com>
	<58AF9921.6060201@huawei.com> <58B04CD3.7010304@windriver.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7fdf2551-3d55-1bd9-2848-720a880cc93e@redhat.com>
Date: Fri, 24 Feb 2017 16:14:03 +0100
MIME-Version: 1.0
In-Reply-To: <58B04CD3.7010304@windriver.com>
Content-Type: text/plain; charset=utf-8
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
To: Chris Friesen <chris.friesen@windriver.com>, "Herongguang (Stephen)" <herongguang.he@huawei.com>, "Han, Huaitong" <huaitong.han@intel.com>, "hangaohuai@huawei.com" <hangaohuai@huawei.com>, stable@vger.kernel.org
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "fangying1@huawei.com" <fangying1@huawei.com>, "xudong.hao@linux.intel.com" <xudong.hao@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wangxinxin.wang@huawei.com" <wangxinxin.wang@huawei.com>, "kai.huang@linux.intel.com" <kai.huang@linux.intel.com>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "guangrong.xiao@linux.intel.com" <guangrong.xiao@linux.intel.com>, linux-kernel@vger.kernel.org



On 24/02/2017 16:10, Chris Friesen wrote:
> On 02/23/2017 08:23 PM, Herongguang (Stephen) wrote:
>=20
>> On 2017/2/22 22:43, Paolo Bonzini wrote:
>=20
>>> Hopefully Gaohuai and Rongguang can help with this too.
>>>
>>> Paolo
>>
>> Yes, we are looking into and testing this.
>>
>> I think this can result in any memory corruption, if VM1 writes its
>> PML buffer into VM2=E2=80=99s VMCS (since sched_in/sched_out notifier =
of VM1
>> is not registered yet), then VM1 is destroyed (hence its PML buffer
>> is freed back to kernel), after that, VM2 starts migration, so CPU
>> logs VM2=E2=80=99s dirty GFNS into a freed memory, results in any memo=
ry
>> corruption.
>>
>> As its severity, this commit
>> (http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D4e59516a12a6ef6dcb660cb3a3f70c64bd60cfec)
>>
>> is eligible to back port to kernel stable.
>=20
> Are we expecting that fix to resolve the original issue, or is it a
> separate issue that needs fixing in stable?

It should be the original issue.

Paolo
