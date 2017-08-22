Received: from eggs.gnu.org ([2001:4830:134:3::10]:59120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dk9VJ-00020G-G0
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dk9VG-0005eQ-Su
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:46:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dk9VG-0005cR-KN
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:45:58 -0400
Date: Tue, 22 Aug 2017 14:45:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170822134553.GB5398@stefanha-x1.localdomain>
References: <20170822044155.2451-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822044155.2451-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/10] tests: Add VM based build tests
 (for non-x86_64 and/or non-Linux)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, pbonzini@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On Tue, Aug 22, 2017 at 12:41:45PM +0800, Fam Zheng wrote:
> v3: Drop RFC.
>     Add Stefan's and Kamil's reviewed-bys.
>     Use optparse. [Stefan]
>     Drop the VGA patch. [Paolo, Stefan]
>     Improve exit/exit code/doc. [Stefan]
>     Drop unused line from basevm.py. [Stefan]
>     Drop "--target-list" form Makefile.
>     More intelligent '-j'.
>     Add README. [Stefan]
> 
> v2: - Add docstring. [Stefan]
>     - Call self._load_io_lod. [Stefan]
>     - Use "info usernet" and dynamic ssh_port forwarding. [Stefan]
>     - Add image checksum.
>     - Use os.rename() and os.makedirs(). [Stefan]
>     - Fix NetBSD URL. [Kamil]
> 
> Build tests in one 32 bit Linux guest and three BSD images are defined in this
> series. This is a more managable way than the manually maintained virtual
> machines in patchew. Also, one big advantage of ephemeral VMs over long running
> guests is the reduced RAM usage of host, which makes it possible to have one
> host test all these BSD variants and probably more.
> 
> The BSD guest templates are manually prepared following
> 
> https://wiki.qemu.org/Hosts/BSD
> 
> as it is not easy to automate. (The ideal approach is like the ubuntu.i386
> script, which configures the guest on top of an official released image, fully
> automatically.)
> 
> Need for help: "gmake check" in the added OpenBSD image fails with -ENOMEM
> errors, even if I change "-m 2G" to "-m 8G" when starting VM. Ideas? And there
> is a warning from ./configure about OpenBSD going to be unsupported in coming
> releases, is it still the case?
> 
> Fam
> 
> Fam Zheng (10):
>   gitignore: Ignore vm test images
>   qemu.py: Add "wait()" method
>   tests: Add vm test lib
>   tests: Add ubuntu.i386 image
>   tests: Add FreeBSD image
>   tests: Add NetBSD image
>   tests: Add OpenBSD image
>   Makefile: Add rules to run vm tests
>   MAINTAINERS: Add tests/vm entry
>   tests: Add README for vm tests
> 
>  .gitignore                |   2 +
>  MAINTAINERS               |   1 +
>  Makefile                  |   2 +
>  configure                 |   2 +-
>  scripts/qemu.py           |   7 ++
>  tests/vm/Makefile.include |  40 +++++++
>  tests/vm/README           |  63 +++++++++++
>  tests/vm/basevm.py        | 278 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/vm/freebsd          |  45 ++++++++
>  tests/vm/netbsd           |  45 ++++++++
>  tests/vm/openbsd          |  46 ++++++++
>  tests/vm/ubuntu.i386      |  88 +++++++++++++++
>  12 files changed, 618 insertions(+), 1 deletion(-)
>  create mode 100644 tests/vm/Makefile.include
>  create mode 100644 tests/vm/README
>  create mode 100755 tests/vm/basevm.py
>  create mode 100755 tests/vm/freebsd
>  create mode 100755 tests/vm/netbsd
>  create mode 100755 tests/vm/openbsd
>  create mode 100755 tests/vm/ubuntu.i386

Aside from the comments I posted:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
