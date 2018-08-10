Received: from eggs.gnu.org ([2001:4830:134:3::10]:55775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo7Kh-0004CE-QS
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo7Ke-0004O4-HN
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:19:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43006 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fo7Ke-0004Nb-B9
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:19:56 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180809160011.17225-1-peter.maydell@linaro.org>
	<19a9c0c6-03eb-d368-d8c8-fb62102556a4@redhat.com>
	<CAFEAcA_rRW7qbtiM4c-sBVmQhFMSuKnVqU6+oXsdXPwJ3GKv6A@mail.gmail.com>
	<9da04e7f-bd0c-9d50-fb7c-026b5aaa674c@redhat.com>
	<87ftzmr21p.fsf@dusky.pond.sub.org>
	<190f6353-c2ab-aa77-825b-fbaed0b821ab@redhat.com>
Date: Fri, 10 Aug 2018 15:19:53 +0200
In-Reply-To: <190f6353-c2ab-aa77-825b-fbaed0b821ab@redhat.com> (Paolo
	Bonzini's message of "Fri, 10 Aug 2018 14:44:59 +0200")
Message-ID: <874lg2nyti.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 10/08/2018 11:41, Markus Armbruster wrote:
>>> Lone "/*" or "/**": 9986 cases
>>> 	of which in the first column: 7617
>>> 	of which the first line in the file (license headers): 2834
>>> 	regex: ^[ \t]*/\*\*?[ \t]*$
>>>
>>> "/*" with the first line of the comment: 11246
>>> 	of which in the first column: 4985
>>> 	of which the first line in the file: 97
>>> 	regex: ^[ \t]*/\*\*?+(?:(?!\*/).)+?$
>>>
>>> License headers almost always have the "lone /*" format.  Apart from
>>> license headers, 63% of the comments have the now-deprecated format.
>>>
>>> Inside functions, 73% of the comments have the now-deprecated format.
>>> Outside functions it's 50-50.  That's because there are 2024 doc
>>> comments, which in turn are 50% of the comments that are 1) outside the
>>> functions 2) using a lone "/*".
>>>
>>> So my proposal, which is actually consistent with what QEMU is doing, is
>>> the following:
>>>
>>> 1) the first line of a file should always be "/*", otherwise warn
>>>
>>> 2) a comment that starts with "/**" should have it on a lone line
>>>
>>> 3) every other multiline comment should start with
>>> "/*<whitespace><something>"
>> (3) is not consistent with what QEMU is doing in this case, since
>> according to your data there is no consistency in what QEMU is doing.
>
> 65-35, and 75-25 inside functions (comments outside should be doc
> comments so that's again a different story) is pretty consistent
> actually.  So no patch would be better in your opinion?

I'm fine with Peter's patch as is.  I'd also be fine with a tree-wide
conversion of comments to the preferred style on top.

I'd prefer not to reopen the debate.

If we reopen it, and reach a different consensus, we need a patch
enforcing it.

If we reopen it, and fail to reach consensus, there's nothing for a
patch to enforce.

Note that "always wing both ends, and star every line in between" and
"wing only the end, not the start, unless file's first line or /** doc
comment, and star every line in between" are not the only options.  A
weaker style rule would be "may wing the start, must wing the end, must
star every line in between".

That said, I reiterate my preference not to reopen the debate :)
