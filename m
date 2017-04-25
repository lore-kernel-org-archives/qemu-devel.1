Received: from eggs.gnu.org ([2001:4830:134:3::10]:42151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d326A-00066Q-Cq
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d3267-000258-5c
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:09:50 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:36760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d3266-00024N-Uv
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:09:47 -0400
Received: by mail-wr0-x231.google.com with SMTP id l50so36826394wrc.3
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 08:09:46 -0700 (PDT)
References: <CAFEAcA8xJ11azOh-sQhzpsb0b++EGT+hML-fvvKRSkyOirB1PQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA8xJ11azOh-sQhzpsb0b++EGT+hML-fvvKRSkyOirB1PQ@mail.gmail.com>
Date: Tue, 25 Apr 2017 16:10:12 +0100
Message-ID: <87d1c0bk17.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] QEMU travis builds: can we move the preseed
 tarball to qemu.org ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jeff Cody <jcody@redhat.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> Hi; a recent travis build failure made me notice that our .travis.yml
> config references a preseed tarball from here:
> http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz
>
> I think this is a bit less than ideal -- we should really be hosting
> this on qemu.org. Can we arrange to move it?

Sure - it was more out of convince than anything else. It is basically
the .git/modules/ subtree from a full checkout that has been tarred up.
Given how long ago it was generated it is probably worth updating the
seed anyway to speed up the submodule initialisation step.

Should we script it up on the qemu.org server or just upload a
hand-created seed?

--
Alex Bennée
