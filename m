Received: from eggs.gnu.org ([2001:4830:134:3::10]:48364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dMubt-0006SC-MI
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 07:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dMubs-0003zW-VL
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 07:12:45 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:38262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dMubs-0003z8-Nv
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 07:12:44 -0400
Received: by mail-wm0-x22c.google.com with SMTP id u195so58461609wmd.1
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 04:12:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <874lvcutv9.fsf@linaro.org>
References: <20170616161334.7492-1-f4bug@amsat.org>
	<20170616161334.7492-6-f4bug@amsat.org> <874lvcutv9.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2017 12:12:23 +0100
Message-ID: <CAFEAcA-GKYXrA1uEkS-kav_H_B4e2nfoVZLNMz_mjhfrJNjOSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/11] travis: build tests objects in
 parallel, then run tests sequentially
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

On 19 June 2017 at 11:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>
>> tests are run sequentially to avoid mixed results output.
>
> I'm not so sure we are worried about mixed results output. I don't think
> anyone can compare the entire log and they tend to scroll to the end
> where the error will be.

Indeed, and make's --output-sync flag should be enough to keep
individual test output distinct.

What is perhaps a problem is that I'm not sure our tests all support
being run in parallel with each other without tripping each other up by
using the same temporary file / TCP port / etc at once. To the
extent that this doesn't work it's a bug, but we should start
by doing a solid soak test of the test suite to make sure -j<bignum>
works reliably.

thanks
-- PMM
