Received: from eggs.gnu.org ([2001:4830:134:3::10]:50571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWggu-0003dx-7v
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 06:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWggn-0007Wi-2f
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 06:59:05 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gWggj-0007Ui-Qp
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 06:58:58 -0500
Received: by mail-wm1-x343.google.com with SMTP id r24so8837072wmh.0
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 03:58:57 -0800 (PST)
References: <20181210152829.29271-1-alex.bennee@linaro.org>
	<20181210152829.29271-8-alex.bennee@linaro.org>
	<CAMo8BfJHo=6VJXbrnAYn+PiQECA6-Hj_rCOVPc12rPiKfc3u=Q@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAMo8BfJHo=6VJXbrnAYn+PiQECA6-Hj_rCOVPc12rPiKfc3u=Q@mail.gmail.com>
Date: Tue, 11 Dec 2018 11:58:55 +0000
Message-ID: <87tvjk1dhc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 07/13] tests/tcg/xtensa: enable system
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Aurelien Jarno <aurelien@aurel32.net>, amarkovic@wavecomp.com, Stafford Horne <shorne@gmail.com>


Max Filippov <jcmvbkbc@gmail.com> writes:

> On Mon, Dec 10, 2018 at 7:28 AM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/tcg/xtensa/Makefile                | 93 ------------------------
>>  tests/tcg/xtensa/Makefile.softmmu-target | 43 +++++++++++
>>  2 files changed, 43 insertions(+), 93 deletions(-)
>>  delete mode 100644 tests/tcg/xtensa/Makefile
>
> That Makefile provides a few nice goals for guest and host debugging

I could certainly add a rule like:

gdb-%: %
	gdb --args $(QEMU) $(QEMU_OPTS) $<

> and a way to run tests on Tensilica ISS, it would be nice to keep it.

I can restore some xtensa specific rules:

xt-run-%: %
        xt-run --xtensa-core=3DDC_B_232L --exit_with_target_code $<

What are EXTFLAGS used for?

--
Alex Benn=C3=A9e
