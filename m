Received: from eggs.gnu.org ([2001:4830:134:3::10]:36867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoCtE-0006Ku-H4
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:43:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoCtD-00014b-P6
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:43:44 -0500
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:46598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eoCtD-00014Q-IH
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:43:43 -0500
Received: by mail-ot0-x235.google.com with SMTP id 41so7208594otd.13
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 10:43:43 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Feb 2018 18:43:22 +0000
Message-ID: <CAFEAcA887ukS-r6ECRG7rrCMzXO8PpJqjevR=sELc_LNfRazLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Moving seabios-hppa git submodule to use a qemu.org
 mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, BALATON Zoltan <balaton@eik.bme.hu>

I just noticed that we seem to have acquired another git
submodule that isn't pointing to a qemu.org git url:

[submodule "roms/seabios-hppa"]
        path = roms/seabios-hppa
        url = git://github.com/hdeller/seabios-hppa.git

Jeff, could we set up so we can mirror this repo on qemu.org?
Then we can send a patch to update the .gitmodules to point to it.

(There's also a patchset on list that wants to add a
submodule for git://github.com/zbalaton/u-boot-sam460ex
but I don't know if that will go in or not yet. Should
we insist that we set up the mirror first for new
submodules, or allow them in and fix things up after?
By default we're doing the latter at the moment; the
former seems cleaner but makes it more painful for
contributors to get things added which need new
submodules.)

thanks
-- PMM
