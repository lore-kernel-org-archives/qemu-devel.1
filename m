Received: from eggs.gnu.org ([209.51.188.92]:41101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glZ99-0000fa-Ad
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:57:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glZ97-0000yJ-01
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:57:46 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:37891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glZ95-0000p7-LW
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:57:43 -0500
Received: by mail-oi1-x22b.google.com with SMTP id a77so14433084oii.5
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 04:57:29 -0800 (PST)
MIME-Version: 1.0
References: <154107832062.28716.3850477436321808708.malonedeb@soybean.canonical.com>
	<154807353706.28438.6153701841246987263.malone@chaenomeles.canonical.com>
In-Reply-To: <154807353706.28438.6153701841246987263.malone@chaenomeles.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 12:57:16 +0000
Message-ID: <CAFEAcA9uJ7+T64u1HSztCweJhqEDpctmohFnmCyKRD8B_sLnzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 1801073] Re: util/zbin.c:390:37: error:
 absolute value function 'abs' given an argument of type 'long int' but has
 parameter of type 'int' which may cause truncation of value
 [-Werror=absolute-value]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1801073 <1801073@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Mon, 21 Jan 2019 at 12:47, Martin Liska <mliska@suse.cz> wrote:
>
> Should be fixed here:
> http://git.ipxe.org/ipxe.git/commitdiff/956f6a722
>
> Btw. how do you pull changes from ipxe into qemu repo?

The next step is a QEMU patch which updates our git submodule
to point at a version of IPXE with the fix and also has the
pre-built binaries corresponding to that new version.

Gerd, it looks like you did the last IPXE update -- could
we do another one with this fix in it?

thanks
-- PMM
