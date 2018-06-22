Received: from eggs.gnu.org ([2001:4830:134:3::10]:58526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWI7e-0000HL-0y
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWI7d-0005Ha-6u
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:12:49 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:35264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWI7d-0005HG-0s
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:12:49 -0400
Received: by mail-ot0-x242.google.com with SMTP id q17-v6so6758199otg.2
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 02:12:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180622021546.18178-1-f4bug@amsat.org>
References: <20180622021546.18178-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 10:12:27 +0100
Message-ID: <CAFEAcA-pt4yUYvAoHJfGmBCyO2eCQWVRRjMXP1=WqNBNUwQLnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] travis: Do not waste time cloning
 unused submodules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 22 June 2018 at 03:15, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Builds only require:
> - dtc
> - keycodemapdb
> - capstone
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Some tests might require ROMs. Can they clone submodules only when requir=
ed?

In general the ROM blobs should be in the main git repo; the submodules
are only the source for recompiling the blobs, I think.

thanks
-- PMM
