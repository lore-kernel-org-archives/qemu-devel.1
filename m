Received: from eggs.gnu.org ([2001:4830:134:3::10]:35686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGo4L-0000gT-PR
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGo4L-0002Oj-3W
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:00:53 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:36513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGo4K-0002OX-QT
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:00:53 -0400
Received: by mail-wr0-x22f.google.com with SMTP id v111so1808903wrc.3
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 08:00:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8b782ee5-3545-3cb5-3b09-209fcffee7e4@redhat.com>
References: <1493314727-6951-1-git-send-email-wei@redhat.com>
	<CAFEAcA-KKvhspYza=8TNNuFtqzco=ChhtS6Aa5hnn8=Cb036-Q@mail.gmail.com>
	<4dbaaea9-7576-9acf-5327-b22db6f00ed2@redhat.com>
	<CAFEAcA8K9DENSPqJD2Okqjqyi7T8RhSBmhCa3ztooJK5xdcZVg@mail.gmail.com>
	<8b782ee5-3545-3cb5-3b09-209fcffee7e4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Jun 2017 16:00:30 +0100
Message-ID: <CAFEAcA8GY3yqZCVHihcFaFS-EkmEy+FRJ9+Kq_xRRdzD7+6DnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix compilation dependency issues of
 CONFIG_ARM_V7M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 28 April 2017 at 14:58, Wei Huang <wei@redhat.com> wrote:
> Using #ifdef is indeed a cleaner solution. However I can't use "#ifdef
> CONFIG_ARM_V7M" & co inside target/arm/cpu.c file because CONFIG_xxx
> aren't available as preprocessor directives. From what I saw the
> CONFIG_xxx options can only control compiling source file. One solution
> is to extract out all v7M code into separate files and use
> CONFIG_ARM_V7M to direct compilation. A bit messy though. Any other
> suggestions?

We seem to run into "CONFIG_FOO is defined for make but not
for the C preprocessor" from time to time, so maybe we should
fix that?

thanks
-- PMM
