Received: from eggs.gnu.org ([2001:4830:134:3::10]:44310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etZn2-0005W2-UC
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:11:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etZmy-0006QD-VS
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:11:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49208 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1etZmy-0006Ps-Qm
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:11:28 -0500
Date: Wed, 7 Mar 2018 15:11:18 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180307141118.cbgvj55p4wcrphyw@sirius.home.kraxel.org>
References: <CAFEAcA8Wz4q=+HDpSG_pFHB7xKMez6hCPFodoOxoTgr1FOy5nA@mail.gmail.com>
	<20180305103307.GL17368@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305103307.GL17368@redhat.com>
Subject: Re: [Qemu-devel] QEMU fails to configure on non-x86 hosts with
 recent SDL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> > Any suggestions for how to do a workaround?
> 
> Drop -Wundef when running the configiure test, or override it with -Wno-undef
> 
> If the actual ui/sdl* files fail for same reason, we could use a gcc
> pragma top disable -Wundef in just those files, or set -Wno-undef in
> CFLAGS on a per-.o file basis in Makefile.objs

What is the status here?  Could you try this peter?  Don't have a test
box with SDL 2.0.8 at hand ...

Any reaction from debian/upstream?  Given that this probably affects
pretty much any SDL user and 2.0.8 is a few days old only a quick 2.0.9
bugfix release would be the best solution I guess.

cheers,
  Gerd
