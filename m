Received: from eggs.gnu.org ([2001:4830:134:3::10]:58002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eb7u7-00062w-6w
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:46:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eb7u3-0003VR-6k
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:46:35 -0500
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:47066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eb7u2-0003Ua-W5
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:46:31 -0500
Received: by mail-pg0-x22f.google.com with SMTP id s9so6400203pgq.13
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 08:46:30 -0800 (PST)
References: <1515562748-32287-1-git-send-email-rth@twiddle.net>
	<CAFEAcA8TxNTjvsqeHss=7BEm6SzwLHZ54UqDmOPMWA5z0oTsUA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ab082406-b0f9-8c82-93b6-53c38ac1d047@linaro.org>
Date: Mon, 15 Jan 2018 08:46:26 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8TxNTjvsqeHss=7BEm6SzwLHZ54UqDmOPMWA5z0oTsUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/arm: Fix double-word comparisons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 01/15/2018 06:27 AM, Peter Maydell wrote:
> (may be worth mentioning
> in particular how "rIM" differs from "rINK" -- I think the answer is that
> we want to say "valid-immediate OR (valid-if-inverted AND valid-if-negated)",
> whereas 'rINK' is "valid-immediate OR valid-if-inverted OR valid-if-negated".)

I also just realized that N & K is only true for -256 thru -1.  Which is
certainly a simpler test to go with that verbiage.


r~
