Received: from eggs.gnu.org ([2001:4830:134:3::10]:48319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dX0S8-0003Z1-Vj
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 03:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dX0S5-0004MC-RR
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 03:28:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1dX0S5-0004Ld-Kc
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 03:28:21 -0400
References: <1499964378-24344-1-git-send-email-mst@redhat.com>
	<c491c6ee-67ed-e7a0-4294-b128f63d6841@redhat.com>
	<415ee774-cab4-f48a-c081-c2158de35b50@redhat.com>
	<1689390822.16456651.1500013233018.JavaMail.zimbra@redhat.com>
	<20170714173646-mutt-send-email-mst@kernel.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <374a73f0-b83a-1b1f-d28f-65610cffe364@redhat.com>
Date: Mon, 17 Jul 2017 09:28:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170714173646-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests: switch pxe and vm gen id tests to
 use kvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Ben Warren <ben@skyportsystems.com>

On 14/07/2017 16:37, Michael S. Tsirkin wrote:
> On Fri, Jul 14, 2017 at 02:20:33AM -0400, Paolo Bonzini wrote:
>>
>>> NACK.
>>>
>>> It's not that simple. If you do it like this, you then suddenly get
>>> these ugly '"kvm" accelerator not found' messages during "make check"
>>> which we really should avoid.
>>
>> You're right, I thought these were shut up before with Laurent's patch.
>> I think we should print a single message at the end, like
>>
>>    qemu: -machine accel=kvm:xen: No accelerator found
>>
>> Paolo
> 
> That's exactly Laurent's patch, isn't it?
> 

Do you want I send an updated and a more formal patch?

Thanks,
Laurent
