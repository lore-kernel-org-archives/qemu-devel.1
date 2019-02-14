Received: from eggs.gnu.org ([209.51.188.92]:34510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1guC6w-0004wE-Pp
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1guC6s-0001D1-N0
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:11:07 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:48902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1guC6q-00010i-M8
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:11:06 -0500
Date: Thu, 14 Feb 2019 09:10:57 +0100
From: Sven Schnelle <svens@stackframe.org>
Message-ID: <20190214081056.GB22159@t470p.stackframe.org>
References: <20190211181907.2219-2-svens@stackframe.org>
	<20190211181907.2219-5-svens@stackframe.org>
	<0d209109-b242-45f2-2132-4d8e196898fc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d209109-b242-45f2-2132-4d8e196898fc@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 4/5] target/hppa: fix sed conditions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Richard Henderson <rth@twiddle.net>

Hi Richard,


On Mon, Feb 11, 2019 at 08:27:32PM -0800, Richard Henderson wrote:
> On 2/11/19 10:19 AM, Sven Schnelle wrote:
> > -    f = (orig & 4) / 4;
> > -
> > -    return do_log_cond(c * 2 + f, res);
> 
> Given that this used to reference do_log_cond, and you've fixed do_log_cond,
> why is there any reason for a change here?

You're right, this patch can be dropped.

Regards
Sven
