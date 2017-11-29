Received: from eggs.gnu.org ([2001:4830:134:3::10]:38307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eK1qB-0006B4-OH
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:51:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eK1qB-00045k-1u
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:51:51 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:37687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eK1qA-00045W-SY
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:51:50 -0500
Received: by mail-ot0-x243.google.com with SMTP id s4so2912146ote.4
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 04:51:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f79f9db0-20c0-aeee-6283-f912131dc551@adacore.com>
References: <CAGC02hTe8SijuwrM0ZGg04=To0GBnPUrC23iKuc-pao65vAAUQ@mail.gmail.com>
	<b36b0c95-4ddc-b818-522c-1bbec52138e8@adacore.com>
	<CAGC02hT7OvR1nbyD=AkOqPvxbNPz957=CPZsUxf1FJ73O8W52g@mail.gmail.com>
	<CAFEAcA8eDeKBnLW45=fPt3NeApMkvkiJzFEshvep_5qmwZKGXA@mail.gmail.com>
	<f79f9db0-20c0-aeee-6283-f912131dc551@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Nov 2017 12:51:29 +0000
Message-ID: <CAFEAcA_0-CczAFiFnKHVZWeoez6YLB6j0ffeoA=uK556U_NTOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 645662] x87 fpu emulation not accurate enough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: william lin <wlsaidhi@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 29 November 2017 at 12:47, KONRAD Frederic
<frederic.konrad@adacore.com> wrote:
> Maybe a little hack might work for x86 on x86 though.
> Something like hardcoding the helper with an inline assembly
> code?

The set of people who want to emulate x86 on x86 is surely
even smaller than the already tiny set of people who want to
emulate x86 at all. I don't think it makes sense to add
inline assembly hacks for that: QEMU should (as far as
is reasonably possible) behave the same on all hosts.

thanks
-- PMM
