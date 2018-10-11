Received: from eggs.gnu.org ([2001:4830:134:3::10]:44072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1gAbu1-0007Sh-R5
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1gAbu0-0003KD-40
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:25:25 -0400
Received: from speedy.comstyle.com ([2001:470:1d:8c::2]:39076
	helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1gAbty-0003IZ-JJ
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:25:23 -0400
References: <20181007153731.GA32288@humpty.home.comstyle.com>
	<a43190b8-ad91-01dc-621c-377a80e3f3ea@gmx.com>
	<CAFEAcA_9+bhPHsHDNi+Jwgbf76m=vDzAWMQ7f5mPg-A_M61bPg@mail.gmail.com>
	<933be526-741f-28a7-dab4-11789db7c4ba@gmx.com>
	<a67f0c2c-5a5b-7a78-141b-2e829304e72e@comstyle.com>
	<CAFEAcA9rJZNeRJdjLU724qgr6PEyVE-8hOn_gk_uU+mYSxuxDw@mail.gmail.com>
	<cae2d61f-c643-5be7-4200-fcafd2f92cc5@gmx.com>
From: Brad Smith <brad@comstyle.com>
Message-ID: <486f95ef-db10-e0f2-e9a8-dd3eff0d3200@comstyle.com>
Date: Thu, 11 Oct 2018 10:25:18 -0400
MIME-Version: 1.0
In-Reply-To: <cae2d61f-c643-5be7-4200-fcafd2f92cc5@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Use MAP_STACK in
 qemu_alloc_stack() on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10/11/2018 5:41 AM, Kamil Rytarowski wrote:

> On 11.10.2018 11:36, Peter Maydell wrote:
>> On 11 October 2018 at 00:55, Brad Smith <brad@comstyle.com> wrote:
>>> And from FreeBSD...
>>>
>>>       MAP_STACK MAP_STACK implies MAP_ANON, and offset of 0.  The fd
>>> argument must be -1 and prot must include at least
>>> PROT_READ and PROT_WRITE.
>>>
>>> This option creates a memory region that grows to at
>>> most len bytes in size, starting from the stack top
>>> and growing down.  The stack top is the starting
>>> address returned by the call, plus len bytes.  The
>>> bottom of the stack at maximum growth is the starting
>>> address returned by the call.
>>>
>>> Stacks created with MAP_STACK automatically grow.
>>> Guards prevent inadvertent use of the regions into
>>> which those stacks can grow without requiring mapping
>>> the whole stack in advance.
>> Hmm. That "automatically growing" part sounds like
>> behaviour we definitely do not want for our use case.
>> So we're going to need to make this OS-specific :-(
>>
> I propose to restrict MAP_STACK it to OpenBSD (with a comment in the
> code). Once it will be needed by someone else will be able to enable it
> for other OSes.

I was going to propose doing something like that but you had replied 
before I did.
What sort of comment did you have in mind?
