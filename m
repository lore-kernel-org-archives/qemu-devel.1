Received: from eggs.gnu.org ([2001:4830:134:3::10]:38895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dS3Zc-0001Rz-Si
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dS3ZZ-0001qC-R3
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:47:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dS3ZZ-0001oN-Ku
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:47:37 -0400
References: <20170620091526.4287-1-xiaoguangrong@tencent.com>
	<4dffc169-5cf2-8f37-bd99-9941bef50825@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6db0c80d-2ae2-9e89-356e-35acd241fdc5@redhat.com>
Date: Mon, 3 Jul 2017 17:47:30 +0200
MIME-Version: 1.0
In-Reply-To: <4dffc169-5cf2-8f37-bd99-9941bef50825@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/7] KVM: MMU: fast write protect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>, mtosatti@redhat.com, avi.kivity@gmail.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong@tencent.com>



On 03/07/2017 16:39, Xiao Guangrong wrote:
> 
> 
> On 06/20/2017 05:15 PM, guangrong.xiao@gmail.com wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> Changelog in v2:
>> thanks to Paolo's review, this version disables write-protect-all if
>> PML is supported
> 
> Hi Paolo,
> 
> Do you have time to have a look at this new version? ;)
> Or I should wait until the patchset of dirty ring-buffer is merged?

I will look at it soon, but I still plan to merge dirty ring buffer first.

Thanks for your understanding,

Paolo
