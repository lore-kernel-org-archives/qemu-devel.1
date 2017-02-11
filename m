Received: from eggs.gnu.org ([2001:4830:134:3::10]:37183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccXWF-00045C-4N
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 08:15:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccXWD-0004zO-VE
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 08:15:15 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:34802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ccXWD-0004yg-MF
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 08:15:13 -0500
Received: by mail-wr0-x235.google.com with SMTP id o16so125596636wra.1
	for <qemu-devel@nongnu.org>; Sat, 11 Feb 2017 05:15:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8737flj70j.fsf@linaro.org>
References: <20170210210857.47893-1-marcinch7@gmail.com>
	<8737flj70j.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 11 Feb 2017 13:14:50 +0000
Message-ID: <CAFEAcA-_wAWiewc2NX7RrfBN3UFc=9dY2tDri-rkNTs2=pFs2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2] target-arm: Implement
 BCM2835 hardware RNG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Marcin Chojnacki <marcinch7@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 11 February 2017 at 11:34, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:

> I know we are running under emulation but is rand() the right call to
> feed data to the guest? There is the virtio rng and PPC spar RNG which
> both use rng_backend_request_entropy() to collect random data. We should
> probably make the Pi RNG as good as the other guests.

See discussion on v1 of this patch -- the rng backend is probably
the right idea but its API is a huge pain in the neck. I suggested
Marcin do a v2 which still uses rand() so we can get everything
else reviewed, and then deal with the rng stuff separately.

(Notably I think that for the rng backend you have to on the
command line create and wire up a backend, which is a lot
of pain. There doesn't seem to be any kind of "use a sane
default" available :-( )

thanks
-- PMM
