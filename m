Received: from eggs.gnu.org ([2001:4830:134:3::10]:51529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCpGa-00036P-CN
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCpGL-0007zX-5C
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:05:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gCpGK-0007fF-No
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:05:36 -0400
References: <1539795177-21038-1-git-send-email-peng.hao2@zte.com.cn>
	<1539795177-21038-2-git-send-email-peng.hao2@zte.com.cn>
	<87woqgr4wp.fsf@vitty.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0ced3ef9-f58e-18dd-0959-c69b96d27c4a@redhat.com>
Date: Wed, 17 Oct 2018 19:05:12 +0200
MIME-Version: 1.0
In-Reply-To: <87woqgr4wp.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V6 1/5] target/i386 : add coalesced pio
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Peng Hao <peng.hao2@zte.com.cn>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, rkrcmar@redhat.com, mst@redhat.com, ehabkost@redhat.com

On 17/10/2018 17:04, Vitaly Kuznetsov wrote:
>> +	union {
>> +		__u32 pad;
>> +		__u32 pio;
>> +	};
>>  };
> I was just passing by, but what's the point in keeping 'pad'?
> 

Backwards compatibility.  QEMU does have a couple instances of "x.pad =
0", so...

Paolo
