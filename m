Received: from eggs.gnu.org ([2001:4830:134:3::10]:60422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cbple-0003RR-DH
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:32:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cbplb-00072O-BY
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:32:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1cbplb-00072A-68
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:32:11 -0500
Date: Thu, 9 Feb 2017 09:32:08 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170209143208.GL27752@localhost.localdomain>
References: <1486617814-5420-1-git-send-email-Ashish.Mittal@veritas.com>
	<20170209062928.GI27752@localhost.localdomain>
	<CAAo6VWNGtLvbN4ktxRQ9SsobNCgJWcaa_zvdA-9q2Pp3YK27gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAo6VWNGtLvbN4ktxRQ9SsobNCgJWcaa_zvdA-9q2Pp3YK27gg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v8 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ashish mittal <ashmit602@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <ashish.mittal@veritas.com>, Stefan Hajnoczi <stefanha@gmail.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>

On Thu, Feb 09, 2017 at 01:24:58AM -0800, ashish mittal wrote:
> On Wed, Feb 8, 2017 at 10:29 PM, Jeff Cody <jcody@redhat.com> wrote:
> > On Wed, Feb 08, 2017 at 09:23:33PM -0800, Ashish Mittal wrote:
> >> From: Ashish Mittal <ashish.mittal@veritas.com>
> >>
> >> Source code for the qnio library that this code loads can be downloaded from:
> >> https://github.com/VeritasHyperScale/libqnio.git
> >>
> >> Sample command line using JSON syntax:
> >> ./x86_64-softmmu/qemu-system-x86_64 -name instance-00000008 -S -vnc 0.0.0.0:0
> >> -k en-us -vga cirrus -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x5
> >> -msg timestamp=on
> >> 'json:{"driver":"vxhs","vdisk-id":"c3e9095a-a5ee-4dce-afeb-2a59fb387410",
> >> "server":{"host":"172.172.17.4","port":"9999"}}'
> >>
> >> Sample command line using URI syntax:
> >> qemu-img convert -f raw -O raw -n
> >> /var/lib/nova/instances/_base/0c5eacd5ebea5ed914b6a3e7b18f1ce734c386ad
> >> vxhs://192.168.0.1:9999/c6718f6b-0401-441d-a8c3-1f0064d75ee0
> >>
> >
> > I don't know if I am using the qnio_server test server correctly or not, but
> > when I run qemu-io from the command line I get an i/o error.  When I run the
> > qemu-iotests, I get a segfault.
> >
> > Were you able to run qemu-iotests with these patches?
> >
> > Here is how I am invoking qnio_server:
> >
> > # qnio_server  -d /home/jcody/work/redhat/upstream/qemu-kvm/tests/qemu-iotests/scratch -v
> >
> >
> 
> I ran full qemu-iotests and qemu-io manually with the test server on
> version 7 patches. Ran qemu-io manually with the test server on
> version 8, but the libvxhs code is undergoing a lot of checkins. Will
> test again tomorrow and get back.
>

Does my invocation above look correct, for running the qemu-iotests?
