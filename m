Received: from eggs.gnu.org ([2001:4830:134:3::10]:50924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhg6d-0006od-H2
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhg6c-0006qA-PH
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:02:51 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:45296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fhg6c-0006q1-HN
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:02:50 -0400
Received: by mail-oi0-x241.google.com with SMTP id q11-v6so3043647oic.12
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 12:02:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <763fe1d3-e2ac-a3e6-69e7-edee07f3c578@redhat.com>
References: <20180723184752.22150-1-peter.maydell@linaro.org>
	<763fe1d3-e2ac-a3e6-69e7-edee07f3c578@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jul 2018 20:02:29 +0100
Message-ID: <CAFEAcA-v_ntRi9rvAHP8_S+y45T5u02TVY4KdFVii6u6QJi=yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.0] tests/libqtest: Improve
 kill_qemu() assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "patches@linaro.org" <patches@linaro.org>

On 23 July 2018 at 19:59, Eric Blake <eblake@redhat.com> wrote:
> In other words, why are we special-casing death-by-coredump, when ALL
> non-zero exit status (whether or not a core dump was involved) is contrary
> to the assumptions of the testsuite?

Because we're trying to get as much actual information
as we have out into the logs, not merely "die so the test
fails"...

thanks
-- PMM
