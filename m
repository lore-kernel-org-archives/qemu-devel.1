Received: from eggs.gnu.org ([2001:4830:134:3::10]:59738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhvKG-0000CG-JV
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 06:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhvKC-0004nu-5j
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 06:13:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dhvKB-0004nW-W3
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 06:13:20 -0400
Date: Wed, 16 Aug 2017 18:13:14 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170816101314.GB8396@lemon>
References: <20170816072104.24420-1-famz@redhat.com>
	<9ad5fa6c-a7c1-e701-12e9-6e6d5372b16c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ad5fa6c-a7c1-e701-12e9-6e6d5372b16c@gmx.com>
Subject: Re: [Qemu-devel] [PATCH RFC 0/9] tests: Add VM based build tests
 (for non-x86_64 and/or non-Linux)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, stefanha@redhat.com, pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Kamil Rytarowski <kamil@netbsd.org>

On Wed, 08/16 11:24, Kamil Rytarowski wrote:
> On 16.08.2017 09:20, Fam Zheng wrote:
> > Build tests in one 32 bit Linux guest and three BSD images are defined in this
> > series. This is a more managable way than the manually maintained virtual
> > machines in patchew. Also, one big advantage of ephemeral VMs over long running
> > guests is the reduced RAM usage of host, which makes it possible to have one
> > host test all these BSD variants and probably more.
> > 
> 
> Thank you for your work on this!
> 
> > The BSD guest templates are manually prepared following
> > 
> > https://wiki.qemu.org/Hosts/BSD
> > 
> > as it is not easy to automate. (The ideal approach is like the ubuntu.i386
> > script, which configures the guest on top of an official released image, fully
> > automatically.)
> > 
> 
> For the reference, inside the NetBSD infrastructure we use homegrown Anita:
> 
> http://pkgsrc.se/misc/py-anita

Looks cool. Is it suitable for using to implement tests/vm/netbsd? Is there a
user documentation?

Fam
