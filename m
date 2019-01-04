Received: from eggs.gnu.org ([208.118.235.92]:52590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gfKO6-0004gf-4D
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 02:59:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gfKO2-00046k-7x
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 02:59:25 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:38788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gfKO1-0003tn-PI
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 02:59:21 -0500
Received: by mail-wm1-f41.google.com with SMTP id m22so400624wml.3
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 23:59:19 -0800 (PST)
References: <1545395783-39040-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9FwFg9zsg3xLhOs9C=XJHjAo+ACd1=g22YtPaax6N0YQ@mail.gmail.com>
	<42d8a1b8-6c33-8e22-b5d9-35f42f6b928e@redhat.com>
	<CAFEAcA9UqiaiKa_4EWfBHbRS0H=trHfJiArHOJkW6=vKoGvRpQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bc564647-0550-df53-7a17-7760489b8c45@redhat.com>
Date: Fri, 4 Jan 2019 08:59:17 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9UqiaiKa_4EWfBHbRS0H=trHfJiArHOJkW6=vKoGvRpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v4 00/35] Misc patches for 2018-12-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 03/01/19 19:37, Peter Maydell wrote:
> On Sat, 22 Dec 2018 at 08:41, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 21/12/18 22:09, Peter Maydell wrote:
>>> I don't really understand what's going on here, or why
>>> it only happens with this one system (my main x86-64
>>> Linux Ubuntu 16.04.5 box) and not the various others I'm
>>> running test builds on. But it does seem to be 100%
>>> reliable with any of these pullreqs with the new test
>>> driver in them :-(
>>
>> I'm afraid something in your setup is causing make's stdout to have
>> O_NONBLOCK set.  Make doesn't use O_NONBLOCK at all, so it must be
>> something above it.  I also checked Perl with strace and, at least here,
>> it doesn't set O_NONBLOCK.
> 
> Interestingly, I have today run into "make: write error: stdout"
> with the existing make check infrastructure. [...]
> I presume that something in one of the tests we're running,
> likely QEMU itself, ends up setting stdout to non-blocking.
> This while rune *used* to be entirely reliable, so maybe
> something recent has changed ?

I don't know... I tried running make check under "strace -e fcntl" and I
didn't find any occurrences of fcntl(1, O_SETFL, ...|O_NONBLOCK).
Perhaps you can add a check after every invocation of a test executable.

Are you going to apply the pull request since the bug is preexisting?

Thanks,

Polo
