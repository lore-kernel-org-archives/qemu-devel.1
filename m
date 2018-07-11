Received: from eggs.gnu.org ([2001:4830:134:3::10]:55707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fdFUU-0000e0-Au
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:49:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fdFUT-0007gP-Ac
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:49:10 -0400
Date: Wed, 11 Jul 2018 15:48:58 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180711134858.GO18181@paraplu>
References: <20180704150256.408d4a07.cohuck@redhat.com>
	<20180704133440.GE4334@localhost.localdomain>
	<CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
	<20180706131103.4e713911.cohuck@redhat.com>
	<20180706145645.GB3939@localhost.localdomain>
	<20180709072953.GE7755@andariel.pipo.sk>
	<87k1q3ljgs.fsf@dusky.pond.sub.org>
	<20180710162208.7b1b5cdc.cohuck@redhat.com>
	<20180710143931.GQ1148@andariel.pipo.sk>
	<20180710170122.427ce3a4.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710170122.427ce3a4.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>

On Tue, Jul 10, 2018 at 05:01:22PM +0200, Cornelia Huck wrote:

[...]

> Who is, in general, testing which libvirt version? I can think of:
> - libvirt developers, which will probably run libvirt current git, but
>   more likely a released QEMU?
> - QEMU (and other related tools) developers, who will probably use QEMU
>   current git, but a released libvirt
> - normal (technical) users and (integration) testers, who will probably
>   use released versions of libvirt and QEMU

There is another kind of integration tester -- e.g. FWIW, in Nova I've
been advocating to create a CI job that would do the following:

    - QEMU from Git
    - libvirt from Git
    - Nova from Git

Along with:

    - Latest QEMU release
    - Latest libvirt release
    - Nova from Git

With the aim of seeing what explodes in Nova and file bugs (for the
relevant low-leve components) and coordinate with relevant upstream
accordingly.

    * * *

Further, Nova's libvirt driver defines several version constants.  The
following two are set to a version that is available across a set of
"Linux distributions that matter"[*]

    MIN_LIBVIRT_VERSION = (1, 3, 1)
    MIN_QEMU_VERSION = (2, 5, 0)

(The above are the minimum required versions _today_.)

And at the start of each development cycle (lasts 6 months), we evaluate
what versions are available and update the version matrix[*]:

    NEXT_MIN_LIBVIRT_VERSION = (3, 0, 0)
    NEXT_MIN_QEMU_VERSION = (2, 8, 0)

(The above will be the versions for the _upcoming_ development cycle --
sometime end of this year.)

https://wiki.openstack.org/wiki/LibvirtDistroSupportMatrix


-- 
/kashyap
