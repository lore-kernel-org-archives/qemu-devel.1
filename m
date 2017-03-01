Received: from eggs.gnu.org ([2001:4830:134:3::10]:35674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj3k1-0005Am-01
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:52:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj3k0-0001Go-Bd
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:52:25 -0500
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:33973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cj3k0-0001Gf-5V
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:52:24 -0500
Received: by mail-wr0-x233.google.com with SMTP id l37so29434812wrc.1
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 04:52:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <877f492ppx.fsf@linaro.org>
References: <CAFEAcA_KVG19uhPuBUNx4ySmebnL1Hit6=HUX9ug0FkBFMwasg@mail.gmail.com>
	<877f492ppx.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Mar 2017 12:52:02 +0000
Message-ID: <CAFEAcA-NgyYcDn5_bX8Qoxhxt97geNk2hun1MTr9ZiALEm3V+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] intermittent make check failure:
 "tcg_handle_interrupt: assertion failed: (qemu_mutex_iothread_locked())"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1 March 2017 at 11:36, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> What will be useful for all these reports is the backtrace. Then it's
> fairly simple to identify the thing triggering the interrupt and
> identify the correct place for the locking.

Unfortunately all I get for build tests is the log output
from 'make check'. I dunno if there's a way to get asserts
to print backtraces automatically.

thanks
-- PMM
