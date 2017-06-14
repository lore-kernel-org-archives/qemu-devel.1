Received: from eggs.gnu.org ([2001:4830:134:3::10]:45082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLBj1-00065S-Vi
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLBj0-0003wM-TA
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:04:59 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:36066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dLBj0-0003vH-Lg
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:04:58 -0400
Received: by mail-wr0-x230.google.com with SMTP id 36so8975118wry.3
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 10:04:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7de47a0f-baad-d849-eebd-87c86dae16c1@redhat.com>
References: <1497369290-20401-1-git-send-email-peter.maydell@linaro.org>
	<1497369290-20401-2-git-send-email-peter.maydell@linaro.org>
	<f279fd6d-d32f-79e8-66e3-62edc0e425a8@amsat.org>
	<937b2871-7380-4bfc-9a3b-997e496633ff@redhat.com>
	<7b7e4b38-923d-b928-ab09-716b2140273b@amsat.org>
	<7de47a0f-baad-d849-eebd-87c86dae16c1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Jun 2017 18:04:36 +0100
Message-ID: <CAFEAcA8y1GaZ7f-zf5BZQaJkCXNz+t5mD4hkJAB2eCVx7eYr4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/3] travis: install more library
 dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, "patches@linaro.org" <patches@linaro.org>, Fam Zheng <famz@redhat.com>

On 14 June 2017 at 17:49, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Well, trusty is 3 years old by now... I wouldn't call that bleeding
> edge, and it seems like Travis is suggesting using Docker images for
> those who want to use a newer distro.  This patch and patch 2 are
> useful, but I think I'd rather get full coverage, either with Shippable
> or by keeping on doing manual builds, than to rush things and switch to
> CI when it's not ready.

Yes, I overall agree that we maybe don't want to use Travis
for this, but I would like us to automate it somehow.
(I was about 50/50 on whether to tag the patchset as RFC.)

> First, I don't think it's accurate to say that scans have been often
> weeks or months apart:
>
>                         #days   #commits
>         2017-06-05      4       123
>         2017-06-01      14      214
>         2017-05-18      3       108
>         2017-05-15      8       262
>         2017-05-07      12      149
>         2017-04-25      24      317

Yes, but this one (I think) only happened because I got fed
up enough of the build being out of date to go and find out
how to rebuild it and do an upload. I think I also did the
1st June one by hand, maybe?

The reason I put this patch set together is because I didn't
want to have to do a manual build a third time :-)

> In the last eight months, there was exactly one case where the builds
> were more than one month apart and one more case where the builds were
> more than two weeks apart.  Both of them coincided with the two most
> recent hard freeze periods (2.8 and 2.9).

I'm more likely to look at coverity during freeze periods
than less, because bugs coverity notices are more likely
than not to be candidates for being worth fixing before
releases, and I don't have my plate full with feature work.
So I'd rather have the build be as up to date as possible
during a release so we can catch any bugs that snuck in
before we hit the last release candidate.

> Second, I don't even think that CI is particularly useful when someone
> must actively consume those scans: triage newly-reporte defects, inform
> the authors of the patch, and so on.  Too many Coverity reports can be a
> burden because you cannot use e.g. the "All newly detected" view.

You can do triage at any frequency you want, because bugs stay
in the "new" state until you move them, whether they were
detected in the most recent scan or not.

Conversely, if we don't do scans very frequently then the
"outstanding defects" view gets hard to use because it's
still showing things we've already fixed and isn't showing
new things we've introduced but not scanned yet.

thanks
-- PMM
