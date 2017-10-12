Received: from eggs.gnu.org ([2001:4830:134:3::10]:34625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2a9R-0000Mx-Cb
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2a9Q-0007Er-Oj
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:51:37 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:51079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2a9Q-0007Dy-Gl
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:51:36 -0400
Received: by mail-wm0-x230.google.com with SMTP id u138so11541972wmu.5
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 02:51:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507800626.26812.13.camel@redhat.com>
References: <20171011083604.11820-1-kraxel@redhat.com>
	<CAFEAcA9uXw7XYOBu9cKY+B=OWNbS=cRp7BKcXacLTaRLx9RWdA@mail.gmail.com>
	<20171011154951.GA6163@redhat.com>
	<CAFEAcA8OZALycKmsrC=MrftfF0YytXzRxGrzbetmSvddfTVf1g@mail.gmail.com>
	<20171012082456.GB16125@redhat.com>
	<1507800626.26812.13.camel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 10:51:14 +0100
Message-ID: <CAFEAcA8dD8kDnTbT5UEnNuY049p8UyNEdhq2_TMNPKTYsc+hLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/10] Ui 20171011 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 12 October 2017 at 10:30, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Indeed.  Is this openbsd?  They are a bit paranoid, possibly the usual
> ca bundle (from nss/mozilla IIRC) isn't installed by default.

No, it's an Ubuntu chroot. ca-certificates is "Priority: optional",
so on a small thing like a chroot which only has a bare minimum
set of packages needed for builds, it might not be present.

thanks
-- PMM
