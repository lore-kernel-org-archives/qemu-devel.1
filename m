Received: from eggs.gnu.org ([2001:4830:134:3::10]:41631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXgyc-00049J-I7
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 01:29:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXgyZ-0006Zi-Bt
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 01:29:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXgyZ-0006O4-1m
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 01:29:31 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181213175552.14857-1-wainersm@redhat.com>
	<CAFEAcA86SDLGyqL3rG-fEDFsEj8-nz-Uqn5Mb9EeLqiFPeKZfA@mail.gmail.com>
	<cccf3c43-0e51-bbbc-3676-17286b11ec99@redhat.com>
	<CAFEAcA9CpR=JGt74=xaUddYhf5SCOoeHH_v+O1L+rrTygZ7quQ@mail.gmail.com>
	<860b98f8-02d0-4c96-ccf2-d582ca295b95@redhat.com>
Date: Fri, 14 Dec 2018 07:29:27 +0100
In-Reply-To: <860b98f8-02d0-4c96-ccf2-d582ca295b95@redhat.com> (Paolo
	Bonzini's message of "Thu, 13 Dec 2018 23:23:44 +0100")
Message-ID: <871s6kfwoo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/1] checkpatch: checker for comment block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 13/12/18 19:21, Peter Maydell wrote:
>> On Thu, 13 Dec 2018 at 18:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> On 13/12/18 19:01, Peter Maydell wrote:
>>>> I sent a patch to do this a little while back:
>>>>  https://patchwork.kernel.org/patch/10561557/
>>>>
>>>> It didn't get applied because Paolo disagreed with having
>>>> our tools enforcing what our style guide says.
>>>
>>> I didn't disagree with that---I disagreed with having a single style in
>>> the style guide, because unlike most other blatant violations of the
>>> coding style (eg. braces), this one is pervasive in maintained code and
>>> I don't want code that I maintain to mix two comment styles.
>>>
>>> So I proposed two alternatives:
>>>
>>> - someone fixes all the comment blocks which are "starred" but don't
>>> have a lone "/*" at the beginning, and then we can commit that patch;
>>>
>>> - we allow "/* foo" on the first line, except for doc comments and for
>>> the first line of the file (author/license block), and fix the style
>>> guide accordingly.
>> 
>> We came to a consensus on the comment style when we discussed
>> the patch which updated CODING_STYLE. I'm not personally
>> a fan of the result (I used to use "/* foo"), but what we have in the
>> doc is what we achieved consensus for. I'm not going to reopen
>> the "what should block comments look like" style debate.
>
> Sure, I don't want to do that either.  I accept the result of the
> discussion; I don't accept introducing a new warning that will cause
> over 700 files to become inconsistent sooner or later.

By design, checkpatch.pl only checks *patches*.  Existing code doesn't
trigger warnings until it gets touched.  And then it should arguably be
made to conform to CODING_STYLE.  So, what's the problem again?  :)

>                                                         Therefore, the
> only way to enforce the result of the discussion is to change the
> existing comments,

I support cleaning up comment style wholesale[*].

>                    for example by having a script that maintainers can
> use to change the existing comments in their files.  Having each of us
> come up with their own script or doing it by hand is probably not a good
> use of everyone's time.

Sharing tools is good. 

> Alternatively, fixing the style guide can also mean "explain why /* foo
> is allowed by checkpatch even though it does not match the coding
> style", without rehashing the discussion.
>
> (BTW it may actually be a good idea to fix _some_ instances of bad
> coding style, in particular the space-tab sequences and the files where
> there are maybe 2 or 3 tabs that ended up there by mistake.  That's a
> different topic).

You've since posted patches for that.  Thanks.

>>>> Personally I think we should just commit my patch, and then
>>>> we can stop having people manually pointing out where
>>>> submitters' patches don't match CODING_STYLE.

Concur.  It has my R-by, modulo a commit message tweak.


[*] Same for other style violations.  Yes, it's churn, and yes, it'll
mess up git-blame some, but I'm convinced the presence of numerous bad
examples costs us more.  CODING_STYLE was committed almost a decade ago.
If we had cleaned up back then, the churn and the blame would be long
forgotten, and we would've spared ourselves plenty of review cycles and
quite a few style discussions.  It's late, but never too late.
