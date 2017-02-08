Received: from eggs.gnu.org ([2001:4830:134:3::10]:52072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cbaS1-0007S6-BF
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 17:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cbaRy-0003Tj-4O
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 17:10:57 -0500
Received: from hera.aquilenet.fr ([141.255.128.1]:34896)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cbaRx-0003TR-TX
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 17:10:54 -0500
Date: Wed, 8 Feb 2017 23:10:50 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170208221050.GP2955@var.home>
References: <CAJSP0QWT14J-cqwLqPCr0iC95pSLaiZJgPkqr1VBU=pqYF6kqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QWT14J-cqwLqPCr0iC95pSLaiZJgPkqr1VBU=pqYF6kqQ@mail.gmail.com>
Subject: Re: [Qemu-devel] libslirp and QEMU slirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: renzo@cs.unibo.it, virtualsquare@cs.unibo.it, thuth@redhat.com, jasowang@redhat.com, Jan Kiszka <jan.kiszka@web.de>, peter.maydell@linaro.org, qemu-devel <qemu-devel@nongnu.org>

Hello,

Stefan Hajnoczi, on Mon 06 Feb 2017 11:55:05 +0000, wrote:
> I'm proposing this topic for discussion because there might be common
> ground for Samuel from QEMU and the VDE folks to collaborate.
> 
> Samuel: Should QEMU join forces with libslirp?

Well, there are not that many forces from the QEMU side :)

Personally, I'm fine with seeing slirp move to a separate playground
that qemu would depend on and others could contribute to.  It just needs
to be integrated to distros so that qemu can get it.

That being said, the integration of slirp and qemu is not so loose,
notably on the top of my head:

- we are using timers for icmp announcements
- qemu needs to be able to save/restore state, with compatibility with
previous versions

We'd need to see how that can be expressed as a library.

Samuel
