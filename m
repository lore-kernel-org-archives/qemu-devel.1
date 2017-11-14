Received: from eggs.gnu.org ([2001:4830:134:3::10]:33445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEWy0-0005Ae-Op
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:53:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEWxz-0002Ss-VS
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:53:12 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:53980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEWxz-0002S6-Mb
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:53:11 -0500
Received: by mail-wr0-x22e.google.com with SMTP id u40so16773481wrf.10
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 00:53:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b4c558f5-3b8e-52f0-4b66-c40519bc0500@twiddle.net>
References: <CAFEAcA95abAHYQ=FpS_n4Aqiui7uQCF=ONEPkUCXGOv-joSDtw@mail.gmail.com>
	<b4c558f5-3b8e-52f0-4b66-c40519bc0500@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Nov 2017 08:52:50 +0000
Message-ID: <CAFEAcA9rELYend1C3SJOpgb55UQ4NKSeyBg8JDKo_JtnPjDa9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] how do we determine correct guest PC for segfaults
 in atomic helpers for linux-user mode?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Emilio G. Cota" <cota@braap.org>

On 13 November 2017 at 23:31, Richard Henderson <rth@twiddle.net> wrote:
> On 11/13/2017 08:59 PM, Peter Maydell wrote:
>> Am I misreading my debugger entrails (entirely possible)? How is this
>> code intended to get the right guest PC for segfaults in these helpers?
>
> It looks like we can't.
>
> We get it right for system mode, but not linux-user.

How does it work for system mode?

thanks
-- PMM
