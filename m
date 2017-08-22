Received: from eggs.gnu.org ([2001:4830:134:3::10]:38400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dk9wS-0000QP-76
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dk9wP-0007AW-1W
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:14:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dk9wO-00079v-OS
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:14:00 -0400
Date: Tue, 22 Aug 2017 22:13:54 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170822141354.GG3210@lemon>
References: <20170822044155.2451-1-famz@redhat.com>
	<20170822044155.2451-11-famz@redhat.com>
	<20170822133827.GA5398@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822133827.GA5398@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3 10/10] tests: Add README for vm tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, pbonzini@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

Thanks for the grammar corrections! All make sense.

On Tue, 08/22 14:38, Stefan Hajnoczi wrote:
> On Tue, Aug 22, 2017 at 12:41:55PM +0800, Fam Zheng wrote:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  tests/vm/README | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >  create mode 100644 tests/vm/README
> > 
> > diff --git a/tests/vm/README b/tests/vm/README
> > new file mode 100644
> > index 0000000000..a18b285507
> > --- /dev/null
> > +++ b/tests/vm/README
> > @@ -0,0 +1,63 @@
> > +=== VM test suite to run build in guests ===
> > +
> > +== Intro ==
> > +
> > +This test suite contains scripts that bootstrap various guest images that has
> 
> s/that has/that have/ (because "images" is plural)

Yes.

> 
> > +necessary packages to build QEMU. The basic usage is documented in Makefile
> > +help which is displayed with "make vm-test".
> > +
> > +== Quick start ==
> > +
> > +Run "make vm-test" to list available make targets.
> > +
> > +== Manual invocation ==
> > +
> > +Each guest script is an executable script with the same uage. For example to
> 
> s/uage/usage/
> 
> I would say "command-line options" instead though.

"Command-line options" sounds better.

> 
> > +work with the netbsd guest, use $QEMU_SRC/tests/vm/netbsd:
> > +
> > +    $ cd $QEMU_SRC/tests/vm
> > +
> > +    # To bootstrap the image
> > +    $ ./netbsd --build-image --image /var/tmp/netbsd.img
> > +    <...>
> > +
> > +    # To run an arbitrary command in guest (the output will not be echoed unless
> > +    # --debug is added)
> > +    $ ./netbsd --debug --image /tmp/netbsd.img uname -a
> > +
> > +    # To build QEMU in guest
> > +    $ ./netbsd --debug --image /tmp/netbsd.img --build-qemu $QEMU_SRC
> > +
> > +    # To get to an interactive shell
> > +    $ ./netbsd --interactive --image /tmp/netbsd.img sh
> > +
> > +== Adding new guests ==
> > +
> > +Please look at existing guest scripts for how to add new guests.
> > +
> > +Most importantly, create a subclass of BaseVM and implement build_image()
> > +method and define BUILD_SCRIPT, then finally call basevm.main() from the
> > +scripts main().
> 
> s/scripts/script's/ (possessive form)

Little finger is feeling lazy. :)

> 
> > +
> > +  - Usually in build_image(), a template image is downloaded from a predefined
> > +    URL. BaseVM._download_with_cache() takes care of cache the checksum, so
> 
> s/cache/caching/ (verb)

I intended to say "caching and the checksum".

> 
> > +    consider using it.
> > +
> > +  - Once the image is downloaded, users, SSH server and QEMU build deps should
> > +    be set up:
> > +
> > +    * Root password set to BaseVM.ROOT_PASS
> > +    * User BaseVM.GUEST_USER is create, and password set to BaseVM.GUEST_PASS
> 
> s/create/created/ (participle)

Yes.

> 
> > +    * SSH service is enabled and started on boot, BaseVM.SSH_PUB_KEY is added
> > +      to authorized_keys of both root and the normal user
> > +    * DHCP client service is enabled and started on boot, so that it can
> > +      automatically configure the virtio-net-pci NIC and communicate with QEMU
> > +      user net (10.0.2.2)
> > +    * Necessary packages are installed to untar the source tarball and build
> > +      QEMU
> > +
> > +  - Write a proper BUILD_SCRIPT template, which should be a shell script that
> > +    untars a raw virtio-blk block device, which is the tarball data blob of the
> > +    QEMU source tree, then configure/build it. Running "make check" is also
> > +    recommended.
> > +
> > -- 
> > 2.13.5
> > 

Fam
