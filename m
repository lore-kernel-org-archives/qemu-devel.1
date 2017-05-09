Received: from eggs.gnu.org ([2001:4830:134:3::10]:43437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d85xr-000321-RL
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d85xr-0003qF-0q
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:18:11 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:34108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d85xq-0003q7-Sn
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:18:10 -0400
Received: by mail-qt0-x22a.google.com with SMTP id j29so1843798qtj.1
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 07:18:10 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170509132736.10071-1-berrange@redhat.com>
	<040c1e25-224f-1a8a-9f60-7238e6ad5df6@twiddle.net>
	<20170509141336.GF27432@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7132960a-9a76-b8ee-ec15-f3cfe58a29c1@twiddle.net>
Date: Tue, 9 May 2017 07:18:07 -0700
MIME-Version: 1.0
In-Reply-To: <20170509141336.GF27432@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/2] Support CPUID signature for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 05/09/2017 07:13 AM, Richard W.M. Jones wrote:
> On Tue, May 09, 2017 at 07:05:51AM -0700, Richard Henderson wrote:
>>> Daniel P. Berrange (2):
>>>    i386: rewrite way CPUID index is validated
>>>    i386: expose "TCGTCGTCGTCG" in the 0x40000000 CPUID leaf
>>
>> I probably should have commented earlier but...  what's the point?
>>
>> If you want the guest os to actually do anything with this, what do
>> you gain for advertising TCG over KVM?
> 
> I can see this being useful from virt-what, since it would allow
> vendors to diagnose problems being caused by TCG ...

Thanks, that's an excellent point.


r~
