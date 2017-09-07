Received: from eggs.gnu.org ([2001:4830:134:3::10]:49092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpseK-0000OG-05
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpseJ-0003P9-Bg
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:59:00 -0400
Received: from mail-lf0-x22a.google.com ([2a00:1450:4010:c07::22a]:38786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpseJ-0003JK-3c
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:58:59 -0400
Received: by mail-lf0-x22a.google.com with SMTP id q132so22975868lfe.5
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 01:58:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170905180602.28698-1-f4bug@amsat.org>
References: <20170905180602.28698-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Sep 2017 09:58:37 +0100
Message-ID: <CAFEAcA_iaNVc_L+HDwQONuj44f+mOQA_KEO7t9S2Th=URBP=6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] vhost-user: disable the *broken*
 subprocess tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: "Daniel P . Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 5 September 2017 at 19:06, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> tests/vhost-user-test keeps failing on build-system since Aug 15:
>
>   ERROR:tests/vhost-user-test.c:835:test_flags_mismatch: child process (/=
i386/vhost-user/flags-mismatch/subprocess [4836]) failed unexpectedly
> ...
>   ERROR:tests/vhost-user-test.c:807:test_connect_fail: child process (/x8=
6_64/vhost-user/connect-fail/subprocess [58910]) failed unexpectedly
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v3: only disable tests using glib subprocess,
>     migrate/multiqueue/guest-mem are still tested.
>
> v2: remove unuseful warning

Applied, thanks.

-- PMM
