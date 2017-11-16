Received: from eggs.gnu.org ([2001:4830:134:3::10]:41514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gandalf.corvotempesta@gmail.com>) id 1eFH4k-0006Ql-0n
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:07:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gandalf.corvotempesta@gmail.com>) id 1eFH4j-0002Rm-56
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:07:13 -0500
MIME-Version: 1.0
In-Reply-To: <20171116100102.GE2450@redhat.com>
References: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
	<c2ecae32-f999-9f1e-46a6-37cdab2a62e3@redhat.com>
	<CAJH6TXhBAaBE9gBSxksWZqNywWmencRaGyeY-oN3jbKdgUettQ@mail.gmail.com>
	<0e6cc220-814a-17fd-4fd7-7b0665d34e81@redhat.com>
	<CAJH6TXh2v-F=yqxQbUUawk_Ctq-sgFefGp1XvMsC=syX_5jEqA@mail.gmail.com>
	<30b54865-2255-d13d-a054-afcf5bbd06b2@redhat.com>
	<20171115202440.GJ19514@redhat.com>
	<7b11bb2b-b93d-e8ff-f396-703c93549d0d@redhat.com>
	<20171115202938.GN2787@redhat.com>
	<CAJH6TXiPuLu62-+o2+PrUGpstrks_5pLotFEe1bAOmsbn20otw@mail.gmail.com>
	<20171116100102.GE2450@redhat.com>
From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Date: Thu, 16 Nov 2017 11:07:10 +0100
Message-ID: <CAJH6TXiVz1Xu94mFSaeSesLBZ_jViS9WL6B7T3T8ufF1nXxtfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Libguestfs] [qemu-img] support for XVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: libguestfs <libguestfs@redhat.com>, qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

2017-11-16 11:01 GMT+01:00 Richard W.M. Jones <rjones@redhat.com>:
> As mentioned before you can use this to do a qemu-img convert using
> captive nbdkit:
>
>   $ nbdkit -U - \
>       perl script=./xva-reader.pl file=./debian8cloud.xva size=4294967296 \
>       --run 'qemu-img convert -f raw $nbd -O qcow2 /var/tmp/output.qcow2 -p'


What if XVA is hosting 2 or more partitions ? Which partition are you
converting with this command ?
