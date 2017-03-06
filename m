Received: from eggs.gnu.org ([2001:4830:134:3::10]:60643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckpMx-0003xS-8f
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:55:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckpMw-0005ux-A6
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:55:55 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ckpMw-0005uU-2e
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:55:54 -0500
Received: by mail-wm0-x233.google.com with SMTP id n11so59229873wma.1
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 01:55:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4a30ecb4-77d0-795f-bf61-378546a8b034@redhat.com>
References: <cover.1488504063.git.balaton@eik.bme.hu>
	<cc6a20fc4a2748f24920c03ce64ae34af0f61799.1488504063.git.balaton@eik.bme.hu>
	<d5475df8-290b-07d4-d177-979d78850615@redhat.com>
	<CAFEAcA90FRxghG0ZdH7H9y2bDk2U9XO1TUJgx0MN+N=7LzO5pQ@mail.gmail.com>
	<4a30ecb4-77d0-795f-bf61-378546a8b034@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Mar 2017 09:55:32 +0000
Message-ID: <CAFEAcA8oWmN8tE66XsviXnBxtP5w+WLijXxsGk+6RwRquRo9Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 13/13] ppc: Add SM501 device in config
 for ppc and ppcemb targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 6 March 2017 at 09:52, Thomas Huth <thuth@redhat.com> wrote:
> I guess we could do something like that on ppc, too (and ppc-softmmu.mak
> should likely include ppcemb-softmmu.mak), but
> that's something for QEMU 2.10 / 3.0 / whichever version will be next.

Yeah, definitely 2.10 material (so is this whole series, but
let's not tangle it up with an unrelated cleanup).

Minor caution: I forget whether we successfully fixed all
the annoying makefile bugs that meant that changing something
inside foo.mak didn't cause binaries that used bar.mak
that includes foo.mak to update. I *think* we caught all
those, though...

thanks
-- PMM
