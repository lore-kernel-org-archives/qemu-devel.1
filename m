Received: from eggs.gnu.org ([2001:4830:134:3::10]:41682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctbhS-0005vK-8M
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctbhR-0002Ut-AZ
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:09:22 -0400
Received: from mail-lf0-x236.google.com ([2a00:1450:4010:c07::236]:34818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ctbhR-0002UZ-33
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:09:21 -0400
Received: by mail-lf0-x236.google.com with SMTP id j90so29264174lfk.2
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 08:09:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a08258bf-9da9-7d90-bcfd-5e4156805557@amsat.org>
References: <1490694017-7532-1-git-send-email-peter.maydell@linaro.org>
	<a08258bf-9da9-7d90-bcfd-5e4156805557@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Mar 2017 16:08:59 +0100
Message-ID: <CAFEAcA_VSavXRVr=z1kDuxUu6Jy3OG6DKQJ_xrify_OMT7TeEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] tests/bios-tables-test: Don't
 pass addresses of packed struct fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 28 March 2017 at 14:30, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> should we add some comment like /* local variable used to avoid alignment
> issues */ in case later one find it clever to save few bytes on stack
> without reading git history?

Hmm. There's no obvious single place where that could be put,
and I tend to think that if you're going to use packed structures
then "caution needed" is implicit. When we have these bug fixes
in then the plan is to add sparc to the set of standard merge
build tests, which will catch accidental reversions of this
fix (and eventually clang 4 will be more widespread which will
warn about this.)

thanks
-- PMM
