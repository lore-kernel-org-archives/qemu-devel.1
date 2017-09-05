Received: from eggs.gnu.org ([2001:4830:134:3::10]:52563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpAKh-0007gl-Av
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpAKc-0007Nq-Qu
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:39:47 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:38170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpAKc-0007NN-K5
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:39:42 -0400
Received: by mail-wr0-x236.google.com with SMTP id 108so7312032wra.5
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 02:39:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4aa4042a-1fa5-958e-6bc9-5666c5e56d3a@amsat.org>
References: <20170508233918.9043-1-f4bug@amsat.org>
	<20170508233918.9043-4-f4bug@amsat.org>
	<2ad7eaf6-3691-f9f1-4d09-204444adbd19@redhat.com>
	<4aa4042a-1fa5-958e-6bc9-5666c5e56d3a@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 10:39:20 +0100
Message-ID: <CAFEAcA_SEHpVBMrU02R4FwsV8vVZO8TEp+gUD=xo1a59CKb_jQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/11] hw/misc: add missing includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

On 5 September 2017 at 10:35, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> I'm not sure this kind of mistake happens often enough, but it might wort=
h
> add a such test in checkpatch.pl (easier to say than to implement :p)

It doesn't run automatically, but you can run scripts/clean-includes
on your new files to remove unneeded includes and add osdep.h if it's
missing.

thanks
-- PMM
