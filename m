Received: from eggs.gnu.org ([2001:4830:134:3::10]:55912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fp6BH-0004CV-V1
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 02:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fp6BE-00081u-QK
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 02:18:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44478 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fp6BE-00081j-JZ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 02:18:16 -0400
References: <20180809160011.17225-1-peter.maydell@linaro.org>
	<19a9c0c6-03eb-d368-d8c8-fb62102556a4@redhat.com>
	<CAFEAcA_rRW7qbtiM4c-sBVmQhFMSuKnVqU6+oXsdXPwJ3GKv6A@mail.gmail.com>
	<9da04e7f-bd0c-9d50-fb7c-026b5aaa674c@redhat.com>
	<CAFEAcA_4M195VD57LyNVyWTLos140v2e7ymvuiY+rtJ4ZTCXwg@mail.gmail.com>
	<14a92c80-4aec-bd60-68fd-d6a68c8a63b6@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4a1a3e8d-8ab7-7a10-cb53-8383495f1cd2@redhat.com>
Date: Mon, 13 Aug 2018 08:18:13 +0200
MIME-Version: 1.0
In-Reply-To: <14a92c80-4aec-bd60-68fd-d6a68c8a63b6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 08/10/2018 02:45 PM, Paolo Bonzini wrote:
> On 10/08/2018 11:10, Peter Maydell wrote:
>>> So my proposal, which is actually consistent with what QEMU is doing, is
>>> the following:
>>>
>>> 1) the first line of a file should always be "/*", otherwise warn
>>>
>>> 2) a comment that starts with "/**" should have it on a lone line
>>>
>>> 3) every other multiline comment should start with
>>> "/*<whitespace><something>"
>> Personally I would prefer your suggestion, but as I say, there
>> was no consensus in the thread for it, and there was consensus
>> for "use the kernel's style here". I don't think we gain much
>> from reopening the debate at this point.
> 
> What we lose is that 3000 more new warnings appear.  So if we make an
> exception and convert all of the comments, I'm okay.

Why do you want to enforce to convert all of them in one go? For example
we still have also some TABs in some source files, and nobody cares
about converting them all in one go. If we enforce the comments in new
code, that should IMHO be good enough. Or make it a BiteSizeTask for the
next GSoC maybe.

> But otherwise, at least Eric, you, me (only now I admit), Thomas
> expressed a preference for the other style;

No, wait, you've got that wrong. I said that I don't like the asymetric
style that you're now trying to propagate again, but I'm fine with either

 /* dense comments
  * on multiple lines */

or

 /*
  * no dense comments
  * on multiple lines
  */

> on the other side it's
> Markus, Stefan, Conny and Alex, some of whom were okay with applying
> maintainer discretion; John and rth wanted a third one but disagreed on
> their second choice.  I appreciate your writing the patch, but I'm not
> sure that's consensus...

Count me in for the consensus on this other side, I really don't want
the asymetric style.

 Thomas
