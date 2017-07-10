Received: from eggs.gnu.org ([2001:4830:134:3::10]:60685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUZa7-0004ww-1N
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUZa6-0002YI-3v
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:22:35 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:36751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUZa5-0002Xf-SW
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:22:34 -0400
Received: by mail-wr0-x229.google.com with SMTP id c11so140961630wrc.3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 07:22:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87r2xo9y1e.fsf@linaro.org>
References: <20170621144814.15324-1-alex.bennee@linaro.org>
	<CAFEAcA91jcDezunfEKwB+DBdzrEAFYWHKRyFmPyCNYSs_4N4JA@mail.gmail.com>
	<6152fff6-f4db-b0c2-bf20-181364544412@amsat.org>
	<87wp84rr6h.fsf@linaro.org>
	<CAAdtpL6tLfG1dUO8nmGvb2vAtX-OTkoFKWQt=MdxUULyonE8AA@mail.gmail.com>
	<CAAdtpL7kaQSm_Kbn+DrD9Kkzj3JH47pM+-RxXYB=_fyEb+7NxQ@mail.gmail.com>
	<87r2xo9y1e.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jul 2017 15:22:11 +0100
Message-ID: <CAFEAcA_g1116nDH3E3s=ZKFABgN8pXPAA1bc7r9hbqDaZq3a1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/21] Docker and shippable updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 10 July 2017 at 15:17, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>> I don't think full patchew reports are useful in a mailbox.
>
> I disagree. They could certainly be made terser but I think the general
> workflow of posting automated testing reports to patch series is a
> useful one.

Agreed. What we want is a mode for the makefile where
it doesn't even print the "   CC foo.o" lines (except
perhaps for the case where it's going to print an error
message, if possible, but that might not be doable), and
then we can use that for patchew emails and also maybe
for the Travis builds, whose logs are currently too long
for the web viewer to cope with (might run into issues with
travis thinking the build has stalled though.)

Is there a standard-ish convention for a really-silent
build we can borrow from the linux kernel or somewhere?

thanks
-- PMM
