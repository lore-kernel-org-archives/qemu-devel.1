Received: from eggs.gnu.org ([2001:4830:134:3::10]:42343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dKjGB-0003Vm-7l
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dKjG6-0003Iz-9l
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:41:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dKjG6-0003Ii-3n
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:41:14 -0400
Message-ID: <1497350473.8068.7.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 13 Jun 2017 12:41:13 +0200
In-Reply-To: <CAFEAcA9+194DyFJ=grKX6o9LAUeXHAJgX92gc419+Aa64_PHig@mail.gmail.com>
References: <20170608070716.2954-1-kraxel@redhat.com>
	<CAFEAcA9+194DyFJ=grKX6o9LAUeXHAJgX92gc419+Aa64_PHig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/7] ui patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> This causes configure to barf warnings in my build logs on half
> my build machines:
> 
> WARNING: Support for gtk2 will be dropped in future releases.
> WARNING: Please consider using gtk3 instead.
> 
> I don't think it is yet possible to drop gtk2.

I certainly don't plan to drop it now, we need at least one or two
releases with that patch in to see what the feedback is.  But I want
start pushing people to the newer versions, so they get used more and
people will report possible regressions from the older versions.  Not
that I expect many, fedora builds distro packages with SDL2 + gtk3 for
quite a while already.

Which systems are failing?  Any chance this is just gtk3-devel missing?
gtk 3.0 was released more than five years ago, pretty much every distro
should have packages meanwhile ...

cheers,
  Gerd
