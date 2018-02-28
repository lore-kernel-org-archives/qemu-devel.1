Received: from eggs.gnu.org ([2001:4830:134:3::10]:33624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqz8Y-0007Hw-C6
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 05:39:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqz8X-0004gZ-A7
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 05:39:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44434 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eqz8X-0004fE-50
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 05:39:01 -0500
References: <CAFEAcA8Pu=SkYCPwCnRdKTEFPScsZhj4vJm0dTs+jV1jTWOAog@mail.gmail.com>
	<0304e590-ab51-649b-7cee-bb7c5be6f5e4@redhat.com>
	<8c93c12e-f794-d0ea-c393-55131ba4ad25@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d7fad9ae-95f0-077e-313f-161c6a243a07@redhat.com>
Date: Wed, 28 Feb 2018 11:38:40 +0100
MIME-Version: 1.0
In-Reply-To: <8c93c12e-f794-d0ea-c393-55131ba4ad25@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Deprecate tilegx ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Chen Gang <chengang@emindsoft.com.cn>, Chen Gang <gang.chen.5i5j@gmail.com>, Anthony Green <green@moxielogic.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Chen Gang <xili_gchen_5257@hotmail.com>, Richard Henderson <rth@twiddle.net>

On 28.02.2018 08:17, Paolo Bonzini wrote:
> On 28/02/2018 07:11, Thomas Huth wrote:
>> On 27.02.2018 12:51, Peter Maydell wrote:
>>> I propose that we deprecate and plan to remove the unicore32 code:
>> [...]
>>> Essentially, it seems to be a largely-inactive university R&D project,
>>> it's costing us in maintenance effort every time we have to touch it,
>>> and I don't think it has any real users.
>>>
>>> Does anybody disagree?
>>>
>>> If we go ahead with deprecating then we should:
>>>  * add a note to Changelog that we're deprecating the target
>>>  * ditto qemu-doc.texi's deprecation section
>>>  * patch hw/unicore32/puv3.c to warn on startup that it's deprecated
>>>  * remove it entirely for the 2.14 release
>>>
>>> We could also remove linux-user/unicore32 immediately, since
>>> the linux-user target has been disabled for some time.
>>
>> Sounds reasonable to me, but let's wait a week or two for feedback from
>> Guan Xuetao.
> 
> Sounds good---thought I would consider dropping unicore32 now with no
> formal deprecation period...
> 
>>> Possibly there are other target architectures we could reasonably
>>> deprecate-and-remove (though none of the other ones Linux is dropping
>>> in this round are ones we support)...
>>
>> I'd vote for marking tilegx as deprecated, too, since we even do not
>> have an active maintainer for that CPU core (at least I did not spot one
>> in our MAINTAINERS file). Opinions?
> 
> Tilegx has been last modified in 2015, so it's a little more alive than
> unicore32.
> 
> Another one is moxie.  Anthony?

For moxie, we've got at least a maintainer in MAINTAINERS, and there is
still a proper project page online
(http://moxielogic.org/blog/pages/architecture.html). And since we've
now also got a mini Moxie TCG test in tests/boot-serial-test.c, the CPU
code is at least still basically working fine. So IMHO there's no urgent
need to mark the moxie CPU as deprecated yet.

 Thomas
