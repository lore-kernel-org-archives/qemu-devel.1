Received: from eggs.gnu.org ([2001:4830:134:3::10]:58272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUc14-00041H-6b
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUc0z-0002x1-Jo
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:58:34 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:36000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUc0z-0002we-Az
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:58:29 -0400
Received: by mail-wr0-f179.google.com with SMTP id c11so146668131wrc.3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 09:58:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170704144859.17644-1-alex.bennee@linaro.org>
References: <20170704144859.17644-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jul 2017 17:57:07 +0100
Message-ID: <CAFEAcA-HtfOXe-w74YOGD51-Cso9U5uXHm8==_3QpjxqY79X1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH 00/11] Misc fixes,
 documentation and patterns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 4 July 2017 at 15:48, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Hi Peter,
>
> A bit of a mixed set of patches here for you to pick from as you
> will. The first 2 are additional tracing fixes including a fix for
> segfaulting when generating a trace.
>
> The next two are documentation patches as requested.
>
> Then two minor tweaks, one to risu.el and a indent failure of risugen.
>
> While I've been working through the half-precision stuff I've been
> finding the --pattern approach a bit inflexible as you basically end
> up eyeballing the risu file to build up the regexs. I've added a
> little syntactic suger to the risu file to enable grouping. This makes
> slicing a subset a lot easier, e.g.:
>
>   ./risugen --group AdvSIMDAcrossVector --not-pattern ".*_RES" aarch64.ri=
su
>
> You can specify multiple groups in the risu file as the matching is
> string based, e.g.:
>
>   @Integer,Logic,Immediate
>
> And then:
>
>   ./risugen --group Logic aarch64.risu foo.bin
>
> What do you think?
>
> Alex Benn=C3=A9e (11):
>   risu: make match status take tracing into account
>   reginfo.c: always return 1 on OP_TESTEND
>   README: document --static builds
>   README: document record/replay support
>   risu.el: derive from text-mode
>   risugen: fix bad indent

I've pushed these first six to risu master.

>   risugen: support @GroupName in risu files

I think this is OK, but can we document the change in
risu file syntax in the readme, please?

>   aarch64.risu: document naming conventions
>   aarch64.risu: remove duplicate AdvSIMD Scalar 3 same block
>   aarch64.risu: remove duplicate AdvSIMD scalar 2 reg misc block
>   aarch64.risu: update AdvancedSIMD across lanes

Some of these seem to be doing multiple things at once,
which in some cases makes them a bit confusing (eg the
first one says it's removing a duplicate block, but it's
also adding a group name.)

thanks
-- PMM
