Received: from eggs.gnu.org ([2001:4830:134:3::10]:44048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDvEj-0005bk-6e
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDvEg-0000Ov-4V
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:03:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dDvEf-0000Oi-Vc
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:03:38 -0400
References: <20170525031936.8449-1-xiaoguangrong@tencent.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <210485b2-c6f5-2f57-f196-dc1b25bbe243@redhat.com>
Date: Thu, 25 May 2017 18:03:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170525031936.8449-1-xiaoguangrong@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qtest: add rtc periodic timer test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Xiao Guangrong <xiaoguangrong@tencent.com>



On 25/05/2017 05:19, guangrong.xiao@gmail.com wrote:
> 
> Note: as qemu needs a precise timer to drive its rtc timer callbacks,
> that means clock=vm is not suitable for us as it's driven by icount
> for qtest, so that we use clock=host instead, it is why we put the
> periodic timer test separately without mixing with rtc-test

I'm not sure I understand.  Why would clock_step(1000) not be a good
replacement for nsleep(1000)?

Thanks,

Paolo
