Received: from eggs.gnu.org ([2001:4830:134:3::10]:39707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dqJf5-0005Yf-2X
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:49:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dqJf2-0003q7-0e
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:49:35 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:46183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dqJf1-0003pJ-Pf
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:49:31 -0400
Received: by mail-wm0-x22e.google.com with SMTP id i189so5289354wmf.1
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 06:49:31 -0700 (PDT)
References: <20170817230114.3655-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170817230114.3655-1-richard.henderson@linaro.org>
Date: Fri, 08 Sep 2017 14:49:29 +0100
Message-ID: <87zia5gv12.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/8] TCG vectorization and example
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> When Alex and I started talking about this topic, this is the direction
> I was thinking.  The primary difference from Alex's version is that the
> interface on the target/cpu/ side uses offsets and not a faux temp.  The
> secondary difference is that, for smaller vector sizes at least, I will
> expand to inline host vector operations.  The use of explicit offsets
> aids that.
<snip>

OK I think this is a lot more complete than my pass. I'm done with my
review for now, I look forward to the next version. It looks like most
of the pre-requisites are merged now?

--
Alex Bennée
