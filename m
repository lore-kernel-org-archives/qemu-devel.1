Received: from eggs.gnu.org ([2001:4830:134:3::10]:60946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiaoguangrong.eric@gmail.com>) id 1cyuO6-00078j-Ro
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 02:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiaoguangrong.eric@gmail.com>) id 1cyuO3-0006k9-OB
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 02:07:18 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <xiaoguangrong.eric@gmail.com>)
	id 1cyuO3-0006io-JZ
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 02:07:15 -0400
Received: by mail-pg0-x241.google.com with SMTP id g2so15070996pge.2
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 23:07:15 -0700 (PDT)
References: <20170412095111.11728-1-xiaoguangrong@tencent.com>
	<cdce9f8e-ec58-d210-3be2-932359e0dcf7@redhat.com>
	<d684319d-afb7-62ea-8486-80c1bee23744@gmail.com>
	<d59e2de5-959d-0b94-6030-264b2310c9e1@gmail.com>
	<474b3e70-8f09-5080-3bf5-f72da04d7080@redhat.com>
From: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Message-ID: <a0eb5d1c-f275-89d1-06fd-27551bc7c2fd@gmail.com>
Date: Fri, 14 Apr 2017 14:07:11 +0800
MIME-Version: 1.0
In-Reply-To: <474b3e70-8f09-5080-3bf5-f72da04d7080@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] mc146818rtc: fix Windows VM clock
 faster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, mst@redhat.com, mtosatti@redhat.com
Cc: Xiao Guangrong <xiaoguangrong@tencent.com>, yunfangtai@tencent.com, qemu-devel@nongnu.org, kvm@vger.kernel.org



On 04/14/2017 01:09 PM, Paolo Bonzini wrote:
>
>
> On 13/04/2017 16:52, Xiao Guangrong wrote:
>> On 04/13/2017 04:39 PM, Xiao Guangrong wrote:
>>> On 04/13/2017 02:37 PM, Paolo Bonzini wrote:
>>>> However, I think that the above should be exactly how the RTC should
>>>> work.  The original RTC circuit had 22 divider stages (see page 13 of
>>>> the datasheet[1], at the bottom right), and the periodic interrupt taps
>>>> the rising edge of one of the dividers (page 16, second paragraph).  The
>>>> datasheet also never mentions a comparator being used to trigger the
>>>> periodic interrupts.
>>>>
>>>
>>> That was my thought before, however, after more test, i am not sure if
>>> re-configuring RegA changes these divider stages internal...
>
> It's unlikely because there is a separate divider reset command.  But
> Hailiang found the same problem, and Bochs does the same implementation
> as you.
>

Happy to see the same approach is being used in Bochs. Thanks for your
check. :)
