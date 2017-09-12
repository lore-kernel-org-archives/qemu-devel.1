Received: from eggs.gnu.org ([2001:4830:134:3::10]:41730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drm7K-0007Md-Fh
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drm7J-0002om-Ly
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:24:46 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:46644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1drm7J-0002nx-E6
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:24:45 -0400
Received: by mail-wm0-x22c.google.com with SMTP id i189so58578608wmf.1
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 07:24:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170912141910.GJ17633@redhat.com>
References: <20170912123744.14730-1-berrange@redhat.com>
	<1505223994.31639.20.camel@redhat.com>
	<20170912141910.GJ17633@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 15:24:22 +0100
Message-ID: <CAFEAcA-tdbzXBkyxXW_e15hVcbcfqSfKqke0PX6y-Cg6A62DzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 00/12] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 12 September 2017 at 15:19, Daniel P. Berrange <berrange@redhat.com> wrote:
> My POV is that we should a) never check generated files into GIT, and
> we should use the submodule in such a way that it is indistinguish
> from the content of the submodule being part of the main GIT repo.

AFAICT this is impossible in that git submodules are broken
(checking out a different commit in the top level repo doesn't
check out the correct version of the submodule to go with it).
We put up with it for our current uses of submodules because
the submodule contents don't change very often...

I agree that checking generated files into git is a bad idea
if we can avoid it.

thanks
-- PMM
