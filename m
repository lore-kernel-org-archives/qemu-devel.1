Received: from eggs.gnu.org ([2001:4830:134:3::10]:55389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPmj4-0005o4-DN
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPmj3-0003RI-KC
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:24:02 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:35457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dPmj3-0003Q5-EC
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:24:01 -0400
Received: by mail-wr0-x233.google.com with SMTP id k67so155516463wrc.2
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 02:23:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <edfd8638-6c23-871d-8cbd-10fea7670a06@twiddle.net>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
	<149838119390.6497.17430428991952287717.stgit@frigg.lan>
	<87fuenxdh2.fsf@linaro.org> <878tke9al6.fsf@frigg.lan>
	<CAFEAcA99y-RL4KtXHmuotsXSRuthWNsmVC-f8WZV2Zc2LJtfUg@mail.gmail.com>
	<edfd8638-6c23-871d-8cbd-10fea7670a06@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2017 10:23:38 +0100
Message-ID: <CAFEAcA_4zXThyRYw8mSTAV1sCt_2wkRdysCuS12YqsXYiSaZpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 04/26] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 27 June 2017 at 04:22, Richard Henderson <rth@twiddle.net> wrote:
> On 06/26/2017 11:21 AM, Peter Maydell wrote:
>>
>> x86 definitely gets this totally wrong. I would be unsurprised
>> to find that other variable-length-insn targets do too.
>
>
> For x86, doing this optimally is difficult.  We *could* fix it simply by
> single-stepping when executing within the last 15 bytes of the page.

My feeling is that the "longjump out of translate.c on insn aborts"
approach is pretty confusing and ideally we should get rid of that
entirely in favour of having the translate code handle an error
return from the "load byte/short/word" functions it calls. That might
then make it easier to bail out on page-crossing instructions.

thanks
-- PMM
