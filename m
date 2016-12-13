Received: from eggs.gnu.org ([2001:4830:134:3::10]:54270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cGchC-0000fp-Ne
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 21:19:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cGch7-0003Mq-Vj
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 21:19:58 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cGch7-0003Dz-Rd
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 21:19:53 -0500
Received: by mail-oi0-f49.google.com with SMTP id b126so109077766oia.2
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 18:19:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87k2b5tlyy.fsf@linaro.org>
References: <87lgvm1dvz.fsf@gmail.com>
	<CAFEAcA9qiEK+Z3TBFxebTjqdm-4TeeZLQm2uewMHQUsmtCvL=g@mail.gmail.com>
	<CAJhHMCAvd0+PNFF-PfMVP2aSpN2V9B7XbV59qh-FaXtLGemQmg@mail.gmail.com>
	<87k2b5tlyy.fsf@linaro.org>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 12 Dec 2016 21:17:59 -0500
Message-ID: <CAJhHMCA4G6E1BLAoPWha84Phw0JVnD9_6qSJEc+ftew7TWS8vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] aarch64-linux-user compilation error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Alex,

On Mon, Dec 12, 2016 at 6:39 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
> Sounds like it. How did you ensure you had your QEMU build dependencies
> installed on your system?
>

I did:

$ sudo apt-get build-dep qemu

to get all the build dependencies. I must have recently installed
oss4-dev through some other package which overwrote soundcard.h. It
was working fine earlier.

--=20
Pranith
