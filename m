Received: from eggs.gnu.org ([2001:4830:134:3::10]:52647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1da1r8-0000he-9c
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1da1r7-00009p-JX
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:34:42 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:37004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1da1r7-00009P-Bx
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:34:41 -0400
Received: by mail-wr0-x22b.google.com with SMTP id 33so64164009wrz.4
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 08:34:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170725152052.GP23343@stefanha-x1.localdomain>
References: <20170721093416.17816-1-stefanha@redhat.com>
	<CAFEAcA_+ffmyvExhFvm2JTmoipum6GeWiFPP5kuxRKb9+ezRzA@mail.gmail.com>
	<20170725152052.GP23343@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jul 2017 16:34:19 +0100
Message-ID: <CAFEAcA9J=m+aVWH1piHA=dzXU_ND9O1=whkpis9mb=WM8m_40g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-iotests: add a "how to"
 to ./README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On 25 July 2017 at 16:20, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Mon, Jul 24, 2017 at 11:20:44AM +0100, Peter Maydell wrote:
>> Should ./check be run from the source tree, or the build tree? The
>> existing README text doesn't say and I don't think your additions
>> do either.
>
> It doesn't matter, both should work.  The script detects both
> possibilities and rejigs itself to compensate.

Does that mean
 if you run it from the source tree in a tree configured
 for out of tree build it will:
 (a) pollute your source tree with test output and binaries
 (b) give you a helpful message about what to do
 (c) magically find the build tree somehow
 (d) not need to write any binaries/test output/temp files at all

?

thanks
-- PMM
