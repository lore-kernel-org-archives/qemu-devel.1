Received: from eggs.gnu.org ([2001:4830:134:3::10]:44025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fp7mr-0002th-Km
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 04:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fp7mo-0000Kq-Hj
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 04:01:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38194 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fp7mo-0000K6-BK
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 04:01:10 -0400
References: <20180809160011.17225-1-peter.maydell@linaro.org>
	<19a9c0c6-03eb-d368-d8c8-fb62102556a4@redhat.com>
	<CAFEAcA_rRW7qbtiM4c-sBVmQhFMSuKnVqU6+oXsdXPwJ3GKv6A@mail.gmail.com>
	<9da04e7f-bd0c-9d50-fb7c-026b5aaa674c@redhat.com>
	<CAFEAcA_4M195VD57LyNVyWTLos140v2e7ymvuiY+rtJ4ZTCXwg@mail.gmail.com>
	<14a92c80-4aec-bd60-68fd-d6a68c8a63b6@redhat.com>
	<4a1a3e8d-8ab7-7a10-cb53-8383495f1cd2@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c5e4389e-b102-a829-8f9a-e41c0a301501@redhat.com>
Date: Mon, 13 Aug 2018 10:01:06 +0200
MIME-Version: 1.0
In-Reply-To: <4a1a3e8d-8ab7-7a10-cb53-8383495f1cd2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts/checkpatch.pl: Enforce multiline
 comment syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 13/08/2018 08:18, Thomas Huth wrote:
> On 08/10/2018 02:45 PM, Paolo Bonzini wrote:
>> On 10/08/2018 11:10, Peter Maydell wrote:
>>>> So my proposal, which is actually consistent with what QEMU is doing=
, is
>>>> the following:
>>>>
>>>> 1) the first line of a file should always be "/*", otherwise warn
>>>>
>>>> 2) a comment that starts with "/**" should have it on a lone line
>>>>
>>>> 3) every other multiline comment should start with
>>>> "/*<whitespace><something>"
>>> Personally I would prefer your suggestion, but as I say, there
>>> was no consensus in the thread for it, and there was consensus
>>> for "use the kernel's style here". I don't think we gain much
>>> from reopening the debate at this point.
>>
>> What we lose is that 3000 more new warnings appear.  So if we make an
>> exception and convert all of the comments, I'm okay.
>=20
> Why do you want to enforce to convert all of them in one go? For exampl=
e
> we still have also some TABs in some source files, and nobody cares
> about converting them all in one go. If we enforce the comments in new
> code, that should IMHO be good enough. Or make it a BiteSizeTask for th=
e
> next GSoC maybe.

Because TABs are usually very few in a file and crept in by mistake (100
files have 5 or fewer TABs).  If there are many, it's almost always in
files that nobody touches (exception: linux-user/syscall.c and
linux-user/syscall_defs.h).  For what it's worth, I'd be in favor of
changing TABs to spaces in files that only have a few of them or in
those two linux-user files.

The 3-line comment style is in files that are actively developed and
would become inconsistent over a very short time.

Paolo
