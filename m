Received: from eggs.gnu.org ([2001:4830:134:3::10]:38710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eqp4a-0005UZ-Kz
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 18:54:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eqp4Z-0003FX-75
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 18:54:16 -0500
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:43597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eqp4Y-0003EN-Tz
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 18:54:15 -0500
Received: by mail-wr0-x229.google.com with SMTP id u49so536406wrc.10
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 15:54:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <CAJSP0QUMA7v=-qX-CNCi30aoH-HzXC9i75EpLWP_TmFuDzpTQQ@mail.gmail.com>
	<CAKmqyKPk69_d-iYGekoS9WBM1fnzav1iFAQEXQq_jLOW9_Dt3w@mail.gmail.com>
	<CAJSP0QVd70uAiG3vyOjO-qOdt1YbEccYydJvz4igg7_bBiW+5A@mail.gmail.com>
	<CAKmqyKP2cQGXSmPvaGt3AwDz6zewJ6HH=vVTSnk6GVAQAhW5uA@mail.gmail.com>
	<20180115125933.GA11737@stefanha-x1.localdomain>
	<CAKmqyKMoqyyr2oBWyEarZhxxBS+F_=zCJARdVvpFkyPv+L3xJQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <768cc6c1-bc98-413e-0362-080b4c22fa00@amsat.org>
Date: Tue, 27 Feb 2018 20:54:11 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMoqyyr2oBWyEarZhxxBS+F_=zCJARdVvpFkyPv+L3xJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Call for GSoC & Outreachy 2018 mentors & project
 ideas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, Jailhouse <jailhouse-dev@googlegroups.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philippe@mathieu-daude.net>

On 02/14/2018 04:00 PM, Alistair Francis wrote:
> On Mon, Jan 15, 2018 at 4:59 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> On Thu, Jan 11, 2018 at 03:25:56PM -0800, Alistair Francis wrote:
>>> On Wed, Jan 10, 2018 at 4:52 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>>> On Tue, Jan 9, 2018 at 9:45 PM, Alistair Francis <alistair23@gmail.com> wrote:
>>>>> Can anyone who has done this before chime in.
>>>>>
>>>>> What do you think about getting someone to cleanup and improve the GDB
>>>>> support in QEMU? Would that be the right difficulty of task for a GSoC
>>>>> project?
>>>>
>>>> There is not enough information to give feedback on whether this
>>>> project idea is suitable.  What are the specific tasks you'd like the
>>>> student to work on?
>>>>
>>>> In general, I'm sure there are well-defined 12-week project ideas
>>>> around the GDB stub.  New features are easy to propose and are usually
>>>> well-defined (e.g. implement these commands that are documented in the
>>>> GDB protocol documentation).  Cleaning up code is less clear and it
>>>> would depend on exactly what needs to be done.  Interns will not have
>>>> a background in the QEMU codebase and may not be able to make
>>>> judgements about how to structure things, so I would be more careful
>>>> about refactoring/cleanup projects.
>>>>
>>>> Please see my talk about QEMU GSoC for guidelines on project ideas:
>>>> https://www.youtube.com/watch?v=xNVCX7YMUL8&t=19m11s
>>>> http://vmsplice.net/~stefan/stefanha-kvm-forum-2016.pdf
>>>
>>> That helps a lot, thanks for that.
>>>
>>> So for a more concrete solution, how would adding support for multi
>>> CPU support to the GDB server sound?
>>>
>>> This would allow GDB debugging for the A53 and the R5 on the Xilinx
>>> ZynqMP for example. This is something we have in the Xilinx tree, but
>>> it is in no state to go upstream and really needs to be re-write to be
>>> upstreamable and more generic.
>>
>> Excellent.  Then they'll already have an idea of "how" it can be
>> achieved but have the freedom to write code that is most suitable for
>> upstream.  That is a good starting point for a project.
>>
>> Here is the project idea template:
>>
>> === TITLE ===
>>
>>  '''Summary:''' Short description of the project
>>
>>  Detailed description of the project.
>>
>>  '''Links:'''
>>  * Wiki links to relevant material
>>  * External links to mailing lists or web sites
>>
>>  '''Details:'''
>>  * Skill level: beginner or intermediate or advanced
>>  * Language: C
>>  * Mentor: Email address and IRC nick
>>  * Suggested by: Person who suggested the idea
>>
>> Once you have written down the project idea, please post it under
>> Internships/ProjectIdeas/MultiCPUGDBStub and then add it to the
>> Google_Summer_of_Code_2018 wiki page using the
>> "{{:Internships/ProjectIdeas/MultiCPUGDBStub}}" inlining syntax.
>>
>> Or if you prefer, just reply with the project idea to this email and
>> I'll post it on the wiki for you.
>>
>> Can you think of a co-mentor who would be willing to participate?  It
>> makes internships easier when there are multiple mentors - less stress
>> for mentors, faster communication for students.
> 
> Yep, here is my proposal. I don't have wiki access, so I can't add it myself.
> 
> I think Philippe would be a good co-mentor, if he is happy to. I am
> also welcome to mentor other ideas, it doesn't have to be this one.

I'm very happy to co-mentor with Alistair, I can manage at least 2h/w on it.

> 
> === Multi-CPU cluster support for GDB server in QEMU ===
> 
> There are many examples in modern computing where multiple CPU
> clusters are grouped together in a single SoC. This is common in the
> ARM world especially. There are numerous examples such as ARM's
> big.LITTLE implementations and Xilinx's 4xA53s and 2xR5s on the ZynqMP
> SoC. The goal of this task is to add support to the GDB server to
> allow users to debug across these clusters.
> 
> This is another step towards single binary QEMU as well.
> 
>  Detailed description of the project.
> 
> Xilinx has an out of tree implementation that can be used as a
> starting point. Work will need to be done on top of this to prepare it
> for upstream submission and to ensure the implementation is more
> generic.
> 
> This will mostly involve extending GDB server to tell GDB about
> different architectures and then allow the user to swap between them.
> 
> The Xilinx implementation can be seen here:
> https://github.com/Xilinx/qemu/blob/master/gdbstub.c
> There has been some steps in preparing the work to go upstream, which
> can be seen here:
> https://github.com/Xilinx/qemu/tree/mainline/alistair/gdb
> 
>  '''Details:'''
>  * Skill level: advanced
>  * Language: C
>  * Mentor: alistair23@gmail.com, Philippe?
>  * Suggested by: Alistair Francis
> 
>>
>> Stefan
