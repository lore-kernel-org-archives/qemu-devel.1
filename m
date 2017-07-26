Received: from eggs.gnu.org ([2001:4830:134:3::10]:43340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1daJTy-0004Vm-RJ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1daJTv-0001Rc-K6
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:23:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1daJTv-0001R0-As
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:23:55 -0400
Date: Wed, 26 Jul 2017 11:17:01 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170726101701.GJ20914@redhat.com>
References: <1499952476-3454-1-git-send-email-armbru@redhat.com>
	<1499952476-3454-7-git-send-email-armbru@redhat.com>
	<20170717101906.GC5301@noname.redhat.com>
	<87a842b9yo.fsf@dusky.pond.sub.org>
	<87bmoauz2s.fsf@dusky.pond.sub.org>
	<5b194736-15ba-7f62-cc8b-46cf03777644@redhat.com>
	<20170725190818.GQ2757@localhost.localdomain>
	<CAKmqyKP5OYjXto=zRd_xvjUgniscX_jsDg-+ai6Xxv7YJSDUxQ@mail.gmail.com>
	<CAKmqyKO9zzv=YYyB2f0a9ERbp8BYdtXjo_c12fmiq6WLzO5Jog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKO9zzv=YYyB2f0a9ERbp8BYdtXjo_c12fmiq6WLzO5Jog@mail.gmail.com>
Subject: Re: [Qemu-devel] Slow tests on "make check" (was Re: [PULL 6/9]
 Convert error_report() to warn_report())
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <jcody@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Rob Herring <robh@kernel.org>, Josh Durgin <jdurgin@redhat.com>, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Jason Wang <jasowang@redhat.com>, Peter Lieven <pl@kamp.de>, Greg Kurz <groug@kaod.org>, Peter Chubb <peter.chubb@nicta.com.au>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Max Reitz <mreitz@redhat.com>, "An eesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Igor Mammedov <imammedo@redhat.com>

On Tue, Jul 25, 2017 at 04:26:32PM -0700, Alistair Francis wrote:
> Actually, what about to avoid duplication we can add a make check-slow
> that runs all the slow tests that make check doesn't run. Then make
> check-all can run both make check and make check-slow.
> 
> That way you can run make check for a quick sanity test and then run
> make check-slow to test everything, without duplicating tests.

FWIW libguestfs does this.

It also has:

  make check-root      For tests which require root privs.
  make check-release   All tests required to pass before we release
                       any new upstream version.

and many more:

  http://libguestfs.org/guestfs-hacking.1.html#testing-your-changes

In libguestfs it's all done using automake so the implementation is
not directly relevant to qemu.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
