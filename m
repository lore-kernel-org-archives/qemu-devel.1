Received: from eggs.gnu.org ([2001:4830:134:3::10]:39923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gL4nM-0006yO-0k
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:17:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gL4nG-0006AO-UT
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:17:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:20911)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gL4nC-00061I-PM
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:17:40 -0500
Date: Fri, 9 Nov 2018 12:17:31 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181109111731.vxdmqmkorblcnntx@sirius.home.kraxel.org>
References: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
Subject: Re: [Qemu-devel] List of files containing devices which have not
 been QOMified
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

> I am also suspicious about hw/bt/ but don't know enough
> about that subsystem to say if it could benefit from
> using QOM objects more.

I'm wondering whenever anyone would even notice if we just rm -rf hw/bt

Looking through the changelog for the last five years (after hw/ split)
the only thing I see is fixing warnings from compiler or coverity,
adapting to changes in other systems (chardev for example) and treewide
changes.  Not a *single* patch specific to bluetooth ...

cheers,
  Gerd
