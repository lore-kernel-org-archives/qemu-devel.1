Received: from eggs.gnu.org ([2001:4830:134:3::10]:33412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1co4K7-0005le-1j
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1co4K3-0008QN-Ug
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:30:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1co4K3-0008Pv-OO
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:30:19 -0400
Message-ID: <1489566616.15659.29.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 15 Mar 2017 09:30:16 +0100
In-Reply-To: <20170314172947.GP2445@work-vm>
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
	<20170314081312.GB13140@stefanha-x1.localdomain>
	<CAFEAcA9F2BPexRieaEhu+UpJxoOdEfw8eggW8b2SjuoMMTNgog@mail.gmail.com>
	<87wpbstesf.fsf@secure.mitica> <20170314160113.GM2445@work-vm>
	<CAFEAcA9Ogy_XnpaaGWHsuAQC=CYNQsT0ESCZ68tn4bg4GFi7LQ@mail.gmail.com>
	<20170314172947.GP2445@work-vm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] KVM call for 2017-03-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>

On Di, 2017-03-14 at 17:29 +0000, Dr. David Alan Gilbert wrote:
> * Peter Maydell (peter.maydell@linaro.org) wrote:
> > On 14 March 2017 at 17:01, Dr. David Alan Gilbert <dgilbert@redhat.com>=
 wrote:
> > > I also do a FreeBSD VM
> >=20
> > Do you have repro instructions for how to conveniently set
> > this up?
>=20
> No, but given that it's the first time I've set up a BSD in ~20 years
> it can't have been that hard.
> It's just a guest with IDE disk, rtl8139 ether.

freebsd ships at least virtio-blk and virtio-net drivers too (not sure
about virtio-scsi), so no need to go with emulated devices.

cheers,
  Gerd
