Received: from eggs.gnu.org ([2001:4830:134:3::10]:45058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fo6n3-0000ze-5q
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fo6my-0006qB-6p
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:45:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48038 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fo6my-0006on-1g
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:45:08 -0400
References: <20180809160011.17225-1-peter.maydell@linaro.org>
	<19a9c0c6-03eb-d368-d8c8-fb62102556a4@redhat.com>
	<CAFEAcA_rRW7qbtiM4c-sBVmQhFMSuKnVqU6+oXsdXPwJ3GKv6A@mail.gmail.com>
	<9da04e7f-bd0c-9d50-fb7c-026b5aaa674c@redhat.com>
	<CAFEAcA_4M195VD57LyNVyWTLos140v2e7ymvuiY+rtJ4ZTCXwg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <14a92c80-4aec-bd60-68fd-d6a68c8a63b6@redhat.com>
Date: Fri, 10 Aug 2018 14:45:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_4M195VD57LyNVyWTLos140v2e7ymvuiY+rtJ4ZTCXwg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Thomas Huth <thuth@redhat.com>

On 10/08/2018 11:10, Peter Maydell wrote:
>> So my proposal, which is actually consistent with what QEMU is doing, =
is
>> the following:
>>
>> 1) the first line of a file should always be "/*", otherwise warn
>>
>> 2) a comment that starts with "/**" should have it on a lone line
>>
>> 3) every other multiline comment should start with
>> "/*<whitespace><something>"
> Personally I would prefer your suggestion, but as I say, there
> was no consensus in the thread for it, and there was consensus
> for "use the kernel's style here". I don't think we gain much
> from reopening the debate at this point.

What we lose is that 3000 more new warnings appear.  So if we make an
exception and convert all of the comments, I'm okay.

But otherwise, at least Eric, you, me (only now I admit), Thomas
expressed a preference for the other style; on the other side it's
Markus, Stefan, Conny and Alex, some of whom were okay with applying
maintainer discretion; John and rth wanted a third one but disagreed on
their second choice.  I appreciate your writing the patch, but I'm not
sure that's consensus...

Paolo
