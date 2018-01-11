Received: from eggs.gnu.org ([2001:4830:134:3::10]:38988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eZmEu-0001vq-Va
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 18:26:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eZmEt-0001HP-Sr
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 18:26:28 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:41182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eZmEt-0001GI-MF
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 18:26:27 -0500
Received: by mail-wr0-x234.google.com with SMTP id o7so3766808wro.8
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 15:26:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJSP0QVd70uAiG3vyOjO-qOdt1YbEccYydJvz4igg7_bBiW+5A@mail.gmail.com>
References: <CAJSP0QUMA7v=-qX-CNCi30aoH-HzXC9i75EpLWP_TmFuDzpTQQ@mail.gmail.com>
	<CAKmqyKPk69_d-iYGekoS9WBM1fnzav1iFAQEXQq_jLOW9_Dt3w@mail.gmail.com>
	<CAJSP0QVd70uAiG3vyOjO-qOdt1YbEccYydJvz4igg7_bBiW+5A@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 11 Jan 2018 15:25:56 -0800
Message-ID: <CAKmqyKP2cQGXSmPvaGt3AwDz6zewJ6HH=vVTSnk6GVAQAhW5uA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, Jailhouse <jailhouse-dev@googlegroups.com>

On Wed, Jan 10, 2018 at 4:52 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Tue, Jan 9, 2018 at 9:45 PM, Alistair Francis <alistair23@gmail.com> wrote:
>> Can anyone who has done this before chime in.
>>
>> What do you think about getting someone to cleanup and improve the GDB
>> support in QEMU? Would that be the right difficulty of task for a GSoC
>> project?
>
> There is not enough information to give feedback on whether this
> project idea is suitable.  What are the specific tasks you'd like the
> student to work on?
>
> In general, I'm sure there are well-defined 12-week project ideas
> around the GDB stub.  New features are easy to propose and are usually
> well-defined (e.g. implement these commands that are documented in the
> GDB protocol documentation).  Cleaning up code is less clear and it
> would depend on exactly what needs to be done.  Interns will not have
> a background in the QEMU codebase and may not be able to make
> judgements about how to structure things, so I would be more careful
> about refactoring/cleanup projects.
>
> Please see my talk about QEMU GSoC for guidelines on project ideas:
> https://www.youtube.com/watch?v=xNVCX7YMUL8&t=19m11s
> http://vmsplice.net/~stefan/stefanha-kvm-forum-2016.pdf

That helps a lot, thanks for that.

So for a more concrete solution, how would adding support for multi
CPU support to the GDB server sound?

This would allow GDB debugging for the A53 and the R5 on the Xilinx
ZynqMP for example. This is something we have in the Xilinx tree, but
it is in no state to go upstream and really needs to be re-write to be
upstreamable and more generic.

Alistair

>
> Hope this helps,
> Stefan
