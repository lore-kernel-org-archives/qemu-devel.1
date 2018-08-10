Received: from eggs.gnu.org ([2001:4830:134:3::10]:44971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fo6mx-0000nx-H6
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fo6ms-0006fR-Gw
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:45:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fo6ms-0006eH-9n
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:45:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id b15-v6so8165290wrv.10
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 05:45:02 -0700 (PDT)
References: <20180809160011.17225-1-peter.maydell@linaro.org>
	<19a9c0c6-03eb-d368-d8c8-fb62102556a4@redhat.com>
	<CAFEAcA_rRW7qbtiM4c-sBVmQhFMSuKnVqU6+oXsdXPwJ3GKv6A@mail.gmail.com>
	<9da04e7f-bd0c-9d50-fb7c-026b5aaa674c@redhat.com>
	<87ftzmr21p.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <190f6353-c2ab-aa77-825b-fbaed0b821ab@redhat.com>
Date: Fri, 10 Aug 2018 14:44:59 +0200
MIME-Version: 1.0
In-Reply-To: <87ftzmr21p.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 10/08/2018 11:41, Markus Armbruster wrote:
>> Lone "/*" or "/**": 9986 cases
>> 	of which in the first column: 7617
>> 	of which the first line in the file (license headers): 2834
>> 	regex: ^[ \t]*/\*\*?[ \t]*$
>>
>> "/*" with the first line of the comment: 11246
>> 	of which in the first column: 4985
>> 	of which the first line in the file: 97
>> 	regex: ^[ \t]*/\*\*?+(?:(?!\*/).)+?$
>>
>> License headers almost always have the "lone /*" format.  Apart from
>> license headers, 63% of the comments have the now-deprecated format.
>>
>> Inside functions, 73% of the comments have the now-deprecated format.
>> Outside functions it's 50-50.  That's because there are 2024 doc
>> comments, which in turn are 50% of the comments that are 1) outside the
>> functions 2) using a lone "/*".
>>
>> So my proposal, which is actually consistent with what QEMU is doing, is
>> the following:
>>
>> 1) the first line of a file should always be "/*", otherwise warn
>>
>> 2) a comment that starts with "/**" should have it on a lone line
>>
>> 3) every other multiline comment should start with
>> "/*<whitespace><something>"
> (3) is not consistent with what QEMU is doing in this case, since
> according to your data there is no consistency in what QEMU is doing.

65-35, and 75-25 inside functions (comments outside should be doc
comments so that's again a different story) is pretty consistent
actually.  So no patch would be better in your opinion?

Paolo
