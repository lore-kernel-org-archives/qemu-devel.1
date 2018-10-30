Received: from eggs.gnu.org ([2001:4830:134:3::10]:43326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHTlA-0007oG-Qi
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHTl5-0000zR-DT
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:08:40 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHTl5-0000ye-0G
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:08:35 -0400
Received: by mail-oi1-x242.google.com with SMTP id v83-v6so4344905oia.5
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 06:08:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_JvsqWPgauPmtp_jdgNOwi2zwcHexPSiLE-Eka+PcDTA@mail.gmail.com>
References: <20181030125005.28151-1-peter.maydell@linaro.org>
	<CAFEAcA_JvsqWPgauPmtp_jdgNOwi2zwcHexPSiLE-Eka+PcDTA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 13:08:13 +0000
Message-ID: <CAFEAcA91k6jx=XY5VbnA1JFWh+0Qv0T-zA9kcdid-jRtnh=s1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] configure: symlink directories,
 not wildcarded files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 30 October 2018 at 13:01, Peter Maydell <peter.maydell@linaro.org> wrote:
> ...having sent this out and moved on to something else, I have
> discovered a problem with it. If you configure a build tree
> using this, and then switch back to a git branch which has
> the older configure, then that configure will end up trashing
> all the tests/acpi-test-data and tests/hex-loader-check-data
> files in the source tree by replacing them with symlinks to
> themselves... This is fixable by doing "git checkout tests"
> but it's a bit of a landmine for bisection :-(

Maybe we should standardize on having all data files for tests
be in tests/data, which is and has always been a symlink to
a directory. That would avoid this problem with old versions
of configure mangling the source directory by accident.

thanks
-- PMM
