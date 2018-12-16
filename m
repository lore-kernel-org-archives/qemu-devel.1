Received: from eggs.gnu.org ([2001:4830:134:3::10]:45986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gYcl0-0002T1-No
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 15:11:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gYckw-00013D-AY
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 15:11:22 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gYckr-00011M-CK
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 15:11:15 -0500
Received: by mail-pg1-x544.google.com with SMTP id t13so5051814pgr.11
	for <qemu-devel@nongnu.org>; Sun, 16 Dec 2018 12:11:11 -0800 (PST)
References: <20181214031923.29527-1-richard.henderson@linaro.org>
	<CAFEAcA-7irqz__ZywybEORVtZiZgRGESFJaxdZShrKruuOACGw@mail.gmail.com>
	<6b3c561e-44d4-b15c-f6a9-e436ad47638f@linaro.org>
	<CAFEAcA9ruCb+aiUc2LSrSJ4wJSW5e4ui7xmzZGoPMwsELawW-A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <66629a63-ad82-a7c6-6372-3266329e4945@linaro.org>
Date: Sun, 16 Dec 2018 12:11:07 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9ruCb+aiUc2LSrSJ4wJSW5e4ui7xmzZGoPMwsELawW-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/32] tcg patch queue
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

On 12/16/18 4:43 AM, Peter Maydell wrote:
> On Sun, 16 Dec 2018 at 07:03, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 12/15/18 1:18 PM, Peter Maydell wrote:
>>> This didn't pass 'make check' on sparc64 host.
>>> It looks like the handful of tests that exercise TCG
>>> in the process of doing what they do failed, and there
>>> was a tcg assert in there too:
>> ...
>>> qemu-system-x86_64: /home/pm215/qemu/tcg/sparc/tcg-target.inc.c:319:
>>> patch_reloc: Assertion `check_fit_ptr(value, 13)' failed.
>>
>> If there were extra asserts, they should have been outside tcg/foo/*.  Any
>> extra asserts inside I cannot explain.  Unfortunately, sparc and s390 are two
>> that I cannot test directly.
> 
> You have access to the gcc compile farm, right? The sparc
> tests run on gcc202.fsffrance.org.

Ah.  I thought that machine had gone away.

That assertion turns out to be an existing bug.  I'm not sure what within this
patch set triggers it, but my solution in the short term will be to revert
ab20bdc1162.

Would you like me to re-send the pull request with this fixed, or may I address
this in the next patch set?


r~
