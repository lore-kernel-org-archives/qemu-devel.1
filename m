Received: from eggs.gnu.org ([2001:4830:134:3::10]:33416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXSJD-0008Jb-9U
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:49:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXSJC-0006xi-Eo
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:49:51 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXSJA-0006tZ-TZ
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:49:49 -0500
Received: by mail-ot1-x341.google.com with SMTP id f18so2092148otl.11
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 06:49:48 -0800 (PST)
MIME-Version: 1.0
References: <1544708743.4811.30.camel@rwth-aachen.de>
In-Reply-To: <1544708743.4811.30.camel@rwth-aachen.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:49:36 +0000
Message-ID: <CAFEAcA-p-LC2swC8-AQt60QBhQN=PNJvBjbGXrtdvvvDd-74QA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] Warning when DTB memory nodes are noped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lukas.juenger@rwth-aachen.de
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>

On Thu, 13 Dec 2018 at 14:42, J=C3=BCnger, Lukas
<lukas.juenger@rwth-aachen.de> wrote:
>
> Hi all,
>
> If I understand correctly, all memory nodes contained in a DTB passed
> via the -dtb option are noped in hw/arm/boot.c:556-568.
> I did not expect this to happen and only figured it out by debugging
> the kernel.
> Do you think a warning should be issued if a DTB contains memory
> regions that are noped?

No, because generally we expect that to happen: the DTB will
have a memory node for whatever the stock amount of RAM on the
target board is, but we want to delete that so we can replace
it with a memory node saying that the system has however much
RAM the user asked for on the command line.

Was the deletion of the memory node actually wrong in your case?
If so we should look at fixing the wrong behaviour, rather than
just being noisier about what we're doing...

thanks
-- PMM
