Received: from eggs.gnu.org ([209.51.188.92]:45777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ggnX1-0001UW-Px
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 04:18:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ggnX1-0006uy-0s
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 04:18:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ggnX0-0006pn-Qn
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 04:18:42 -0500
Date: Tue, 8 Jan 2019 10:18:36 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190108101836.48313b3e.cohuck@redhat.com>
In-Reply-To: <3857c98f-66ff-0c7f-e588-b5e098626267@gmail.com>
References: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
	<20181222095036.29743-3-marcel.apfelbaum@gmail.com>
	<20190103113414.503eed8b.cohuck@redhat.com>
	<bed8bcb6-67ca-b8c5-ffbe-684241fe2b70@gmail.com>
	<20190107185417.6d6dbe59.cohuck@redhat.com>
	<3857c98f-66ff-0c7f-e588-b5e098626267@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH PULL 02/31] contrib/rdmacm-mux: Add
 implementation of RDMA User MAD multiplexer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, yuval.shaia@oracle.com, pjp@fedoraproject.org

On Tue, 8 Jan 2019 10:41:38 +0200
Marcel Apfelbaum <marcel.apfelbaum@gmail.com> wrote:

> On 1/7/19 7:54 PM, Cornelia Huck wrote:
> > On Mon, 7 Jan 2019 19:28:10 +0200
> > Marcel Apfelbaum <marcel.apfelbaum@gmail.com> wrote:
> >  
> >> On 1/3/19 12:34 PM, Cornelia Huck wrote:  

> >>> clang-6.0: error: -libumad: 'linker' input unused [-Werror,-Wunused-command-line-argument]  
> >> Is really strange, the rdma-mux is part of the contrib directory
> >> and is not even compiled by default.
> >>  
> >>> Explicitly passing --disable-pvrdma to configure disables the offending
> >>> code.
> >>>
> >>> Let me know if you need more information.  
> >> Can you please send the exact steps you are using to configure and
> >> compile QEMU,
> >> are you compiling on a x86 machine?  
> > Yes, this is on my laptop (up-to-date F28). I can reproduce on current
> > master, configured with
> >
> > ../configure --target-list="s390x-softmmu s390x-linux-user i386-softmmu x86_64-softmmu cris-softmmu arm-softmmu ppc64-softmmu" --enable-linux-aio --enable-virtfs --enable-trace-backends=simple --cc=clang --enable-rdma --enable-pvrdma
> >
> > It compiles if I pass --disable-pvrdma instead. It also compiles if I
> > drop --cc=clang.
> >
> > I'm building in a build subdirectory; I have already tried purging it
> > before rebuilding, without luck.
> >
> > clang --version says
> >
> > clang version 6.0.1 (tags/RELEASE_601/final)
> > Target: x86_64-unknown-linux-gnu
> > Thread model: posix
> > InstalledDir: /usr/bin  
> 
> Thanks for the information, I will look into it.
> Marcel

Thanks.

Another data point: I see the same on a Fedora 29 on s390x, so this
does not seem to be a broken local setup (unless I managed to mess up
both systems in the same way...) clang --version says

clang version 7.0.0 (Fedora 7.0.0-2.fc29)
Target: s390x-ibm-linux
Thread model: posix
InstalledDir: /usr/bin
