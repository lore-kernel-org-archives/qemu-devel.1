Received: from eggs.gnu.org ([2001:4830:134:3::10]:49924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e0QIt-0000Xc-Pn
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e0QIr-0003Id-7l
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:56:27 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:49295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e0QIq-0003H8-Ux
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:56:25 -0400
Received: by mail-wr0-x232.google.com with SMTP id p10so10971749wrc.6
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 03:56:24 -0700 (PDT)
References: <1502149958-23381-1-git-send-email-cota@braap.org>
	<20171005234831.GB23670@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20171005234831.GB23670@flamenco>
Date: Fri, 06 Oct 2017 11:56:21 +0100
Message-ID: <87a814y27e.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/22] tcg: tb_lock removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>


Emilio G. Cota <cota@braap.org> writes:

> On Mon, Aug 07, 2017 at 19:52:16 -0400, Emilio G. Cota wrote:
>> This series applies on top of the "multiple TCG contexts" series, v4:
>>   https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06769.html
> (snip)
>> Please review!
>
> Turns out this patchset breaks icount, even after fixing the patchset
> it is based on (see [1]).

Isn't icount only used in single-threaded mode though?

>
> The last good patch in the series is patch 10:
> "translate-all: work page-by-page in tb_invalidate_phys_range_1".
> I have no time to look into fixing that, so if you end up reviewing
> this set, please review only patches 1-10.
>
> The good news is that patches > 10 get really hairy, so this should
> reduce the review burden substantially.
>
> Thanks,
>
> 		Emilio
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg01198.html


--
Alex Benn=C3=A9e
