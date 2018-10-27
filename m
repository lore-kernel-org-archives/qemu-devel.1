Received: from eggs.gnu.org ([2001:4830:134:3::10]:41030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gGKgI-0005gD-FE
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 05:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gGKgF-0006kF-5a
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 05:14:54 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gGKgE-0006jL-Mn
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 05:14:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id t10-v6so3563243wrn.10
	for <qemu-devel@nongnu.org>; Sat, 27 Oct 2018 02:14:50 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025151103.GA19931@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025151103.GA19931@flamenco>
Date: Sat, 27 Oct 2018 10:14:47 +0100
Message-ID: <878t2j21ko.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [RFC v4 00/71] per-CPU locks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, James Hogan <jhogan@kernel.org>, Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Filippov <jcmvbkbc@gmail.com>, Michael Clark <mjc@sifive.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Andrzej Zaborowski <balrogg@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Fabien Chouteau <chouteau@adacore.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Alistair Francis <alistair23@gmail.com>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>


Emilio G. Cota <cota@braap.org> writes:

> [I forgot to add the cover letter to git send-email; here it is]
>
> v3: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg04179.html
>
> "Why is this an RFC?" See v3 link above. Also, see comment at
> the bottom of this message regarding the last patch of this series.

I'm also seeing his hang on check-tcg, specifically qemu-aarch64 ./tests/li=
nux-test

<snip>

--
Alex Benn=C3=A9e
