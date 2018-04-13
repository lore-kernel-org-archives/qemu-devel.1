Received: from eggs.gnu.org ([2001:4830:134:3::10]:36096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6yQJ-0000ZS-BV
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6yQD-0006St-Ky
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:07:27 -0400
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:46441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6yQD-0006SM-Eq
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:07:21 -0400
Received: by mail-ot0-x232.google.com with SMTP id v64-v6so9759500otb.13
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 06:07:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180324192455.12254-1-mdavidsaver@gmail.com>
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 14:07:00 +0100
Message-ID: <CAFEAcA8TG331YT_YuTmO2SQTOxABfjoLoOFayt_0L14X8LMzuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/14] Generalize Dallas/Maxim I2C RTC
 devices v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>

On 24 March 2018 at 19:24, Michael Davidsaver <mdavidsaver@gmail.com> wrote:
> This series generalizes the ds1338 model to also support the ds1375.
> As previously, only the time of day registers are modeled.  This
> series is largely a do-over wrt. my previous series.  This time I
> started with incremental changes from the existing ds1338 model, and only
> add support for the ds1375 (which I care about).
>
> I've added a more thorough test of the time of day function, covering
> reading and setting in both 12 and 24 hour mode.  This corrects two
> (practically inconsequential) bugs with the handling of 12 hour mode,
> and day of the week.
>
> In an attempt to address concerns about false positive test failures
> in CI builds, instead of comparing the parts of 'struct tm' seperately
> I've changed the logic of the tests to compare the difference between
> the expected and actual time in seconds.  The threshold is 30 seconds
> when run with 'gtester -m quick', and 1 second otherwise.
>
> Comparision of day of the week is still exact, so there is a chance of
> a false positive if the test is running across midnight UTC.

Hi; sorry it took me a while to get to reviewing this patchset.
I think I've now reviewed all the non-testcase parts of it.

thanks
-- PMM
