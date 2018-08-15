Received: from eggs.gnu.org ([2001:4830:134:3::10]:33261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpmxn-0001V6-2H
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpmxc-0000z3-0U
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:59:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56828 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpmxb-0000yS-PU
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:59:03 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <153358448492.29549.3601216229452882398.malonedeb@chaenomeles.canonical.com>
	<153414808571.8168.1723488818633453757.malone@wampee.canonical.com>
	<5B71D4C8.7060006@gmx.com>
	<CAFEAcA91Pj5WFfWtu+_OtpC86xeR003wx897jDJKo0cpdJAc6Q@mail.gmail.com>
	<5B7314EF.5090005@gmx.com>
	<CAFEAcA_EJpR6YT2gjpTrRxz9mbRfSTyZKh30Q5bchEXmb6CznA@mail.gmail.com>
Date: Wed, 15 Aug 2018 05:59:00 +0200
In-Reply-To: <CAFEAcA_EJpR6YT2gjpTrRxz9mbRfSTyZKh30Q5bchEXmb6CznA@mail.gmail.com>
	(Peter Maydell's message of "Tue, 14 Aug 2018 19:17:08 +0100")
Message-ID: <878t58s2kb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BBug_1785698=5D_Re=3A_Solaris_build_err?=
 =?utf-8?b?b3I6IHVua25vd24gdHlwZSBuYW1lIOKAmGdjcnlfZXJyb3JfdOKAmQ==?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Bug 1785698 <1785698@bugs.launchpad.net>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 14 August 2018 at 18:44, Michele Denber <1785698@bugs.launchpad.net> wrote:
>> On 08-14-2018 4:42 AM, Peter Maydell wrote:
>>>
>>> We do assume a posix shell and that that shell is /bin/sh.
>>> We may have bugs where we assume non-posix behaviour
>>> from it, since almost all users are going to be on systems
>>> where /bin/sh is bash or dash or whatever the BSD /bin/sh is.
>> Apparently Solaris is different in that regard (among others).
>
> Yeah. I'm not sure how much I care about supporting OSes that
> decide to be totally different from everybody else, to be honest.
> It's the 21st century and POSIX is a thing.

Setting

    SHELL=/usr/xpg4/bin/sh PATH=/usr/xpg6/bin:/usr/xpg4/bin:$PATH

should make it a thing even on Solaris:
https://docs.oracle.com/cd/E86824_01/html/E54776/standards-5.html

A quick git-grep shows several hardcoded /bin/sh, so setting SHELL might
not stick.  Whether they're in the way of building I can't say.


[...]
