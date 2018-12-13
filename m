Received: from eggs.gnu.org ([2001:4830:134:3::10]:43851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gXVOx-0003tM-Hf
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:08:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gXVOu-0001Sk-EK
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:07:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gXVOu-0001PD-4c
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:07:56 -0500
References: <20181213175552.14857-1-wainersm@redhat.com>
	<CAFEAcA86SDLGyqL3rG-fEDFsEj8-nz-Uqn5Mb9EeLqiFPeKZfA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cccf3c43-0e51-bbbc-3676-17286b11ec99@redhat.com>
Date: Thu, 13 Dec 2018 19:07:46 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA86SDLGyqL3rG-fEDFsEj8-nz-Uqn5Mb9EeLqiFPeKZfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/1] checkpatch: checker for comment block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 13/12/18 19:01, Peter Maydell wrote:
> On Thu, 13 Dec 2018 at 17:57, Wainer dos Santos Moschetta
> <wainersm@redhat.com> wrote:
>>
>> Eduardo Habkost pointed out a malformed block of comments on my
>> patch [1] that I had ran checkpatch.pl and no warn/error was
>> reported. Then I realized the script does not catch such as
>> case (or it had a bug).
>>
>> It turns out that checkpatch.pl does not parse comment blocks (If I understood
>> its code correctly...). So I implemented a checker that warns about:
>> 1. block doesn't begin on its own line.
>> Example:
>>   /* blah blah
>>    * and blah blah
>>    */
> 
> I sent a patch to do this a little while back:
>  https://patchwork.kernel.org/patch/10561557/
> 
> It didn't get applied because Paolo disagreed with having
> our tools enforcing what our style guide says.

I didn't disagree with that---I disagreed with having a single style in
the style guide, because unlike most other blatant violations of the
coding style (eg. braces), this one is pervasive in maintained code and
I don't want code that I maintain to mix two comment styles.

So I proposed two alternatives:

- someone fixes all the comment blocks which are "starred" but don't
have a lone "/*" at the beginning, and then we can commit that patch;

- we allow "/* foo" on the first line, except for doc comments and for
the first line of the file (author/license block), and fix the style
guide accordingly.

Paolo
