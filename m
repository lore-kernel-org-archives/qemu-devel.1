Received: from eggs.gnu.org ([2001:4830:134:3::10]:52620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dsu5e-0004wo-8s
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dsu5b-0002Gw-3Z
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:07:42 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:46607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dsu5a-0002ET-Sr
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:07:39 -0400
Received: by mail-wm0-f51.google.com with SMTP id i189so9964855wmf.1
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 10:07:38 -0700 (PDT)
References: <35eda6a9-086e-f899-e131-288f2346effe@wiesinger.com>
	<ce477c53-25bc-e6dd-3e05-c74af1f33c2d@wiesinger.com>
	<3e1f41a8-faff-1858-6f0d-154694dff02d@wiesinger.com>
	<CABgObfYzngJPgS9agXMrRENVD_e+3Hm=y+KD5dp9na8jNwuumw@mail.gmail.com>
	<CABgObfZFwJMpU_D8SMkuiEhb0qBokHL0jpwmuzdE73TReHMFkg@mail.gmail.com>
	<0e69cbad-f658-03be-0191-1b6fe588147b@wiesinger.com>
	<CABgObfaw_bMQ=Dpfs=vh_AweaidqCZSBy4bDtsddk5DSKpRP8A@mail.gmail.com>
	<1b37b04c-349f-28f7-fb6c-fbbbe8415b33@wiesinger.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7757e373-c892-2824-d710-27ca57d479c4@redhat.com>
Date: Fri, 15 Sep 2017 19:07:35 +0200
MIME-Version: 1.0
In-Reply-To: <1b37b04c-349f-28f7-fb6c-fbbbe8415b33@wiesinger.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] kvm_intel fails to load on Conroe CPUs running
 Linux 4.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerhard Wiesinger <lists@wiesinger.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>

On 15/09/2017 16:43, Gerhard Wiesinger wrote:
> On 27.08.2017 20:55, Paolo Bonzini wrote:
>>
>>
>> Il 27 ago 2017 4:48 PM, "Gerhard Wiesinger" <lists@wiesinger.com
>> <mailto:lists@wiesinger.com>> ha scritto:
>>
>>     On 27.08.2017 14 <tel:27.08.2017%2014>:03, Paolo Bonzini wrote:
>>
>>
>>         We will revert the patch, but 4.13.0 will not have the fix.
>>         Expect it in later stable kernels (because vacations).
>>
>>
>>     Thnx. Why will 4.13.0 NOT have the fix?
>>
>>
>> Because maintainers are on vacation! :-)
>>
>>
> 
> Hello Paolo,
> 
> Any update on this for 4.12 and 4.13 kernels?

A late fix is better than a wrong fix.  Hope to get to it next week!

Paolo
