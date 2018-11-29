Received: from eggs.gnu.org ([2001:4830:134:3::10]:35292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSQeu-0002Ro-Al
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 13:03:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSQeq-0000g7-Dm
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 13:03:28 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:43160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gSQeq-0000cE-5p
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 13:03:24 -0500
Received: by mail-pl1-x643.google.com with SMTP id gn14so1408186plb.10
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 10:03:22 -0800 (PST)
References: <1543412590-29716-1-git-send-email-stefan.markovic@rt-rk.com>
	<1543412590-29716-2-git-send-email-stefan.markovic@rt-rk.com>
	<3ef23076-d0b4-4df3-d023-bf18ba33aade@redhat.com>
	<266d7143-54e7-86d7-e29b-64cb923edceb@wavecomp.com>
	<CAFEAcA937xXC2mHpM=wmjrU8Rx-dAG6_duAGM9jTzgEScq7PUg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <74d3ca4d-2331-6f70-0503-6cc732664747@linaro.org>
Date: Thu, 29 Nov 2018 10:03:18 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA937xXC2mHpM=wmjrU8Rx-dAG6_duAGM9jTzgEScq7PUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-doc: Add nanoMIPS ISA information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Stefan Markovic <stefan.markovic@rt-rk.com>, QEMU Developers <qemu-devel@nongnu.org>, Paul Burton <pburton@wavecomp.com>, James Hogan <jhogan@kernel.org>, Thomas Huth <huth@tuxfamily.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>

On 11/29/18 2:23 AM, Peter Maydell wrote:
> On Thu, 29 Nov 2018 at 10:18, Stefan Markovic <smarkovic@wavecomp.com> wrote:
>> I'll investigate further running with  --enable-debug option to fix this
>> issue.
>>
>> In the meantime, we could note enable-debug as 'To Be Done/Work In
>> Progress' for nanoMIPS in qemu docs .
> 
> This isn't just "--enable-debug doesn't work", it means there's a
> definite bug because you've tripped an assert (that's only enabled
> in the debug config). It's quite possible that the code will misbehave
> at runtime even on the non-debug config...

Definitely.

The assert says that two different exits are using the same
TranslationBlock.jmp_target_arg entry.  Which means that, by definition, one of
them must branch to the wrong location.


r~
