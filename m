Received: from eggs.gnu.org ([2001:4830:134:3::10]:40170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gOWCm-00079r-1c
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 18:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gOWCi-0006YE-TJ
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 18:10:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:1667)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gOWCi-0006Uw-Lw
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 18:10:12 -0500
Date: Mon, 19 Nov 2018 00:09:32 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181118230932.GA9556@caravaggio.hotspot.internet-for-guests.com>
References: <CAGxU2F658=XjoHnF6Qq5FqBZAE68BBtMFt-6HcKp_PVxTynOnw@mail.gmail.com>
	<CAJSP0QVKVktawsab4pPb3qdGuh9D1zBZOucN+K2B=nrkdW2_qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QVKVktawsab4pPb3qdGuh9D1zBZOucN+K2B=nrkdW2_qQ@mail.gmail.com>
Subject: Re: [Qemu-devel] SeaBIOS booting time optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: robert.bradford@intel.com, SeaBIOS <seabios@seabios.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, sgarzare@redhat.com

Hi Stefan,

On Fri, Nov 16, 2018 at 04:39:20PM +0000, Stefan Hajnoczi wrote:
> On Fri, Nov 16, 2018 at 4:21 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > I'm investigating the SeaBIOS booting time, to understand if we can reduce
> > the boot time in some cases (e.g. legacy hardware is not needed). I think
> > this
> > can be interesting also for NEMU developers.
> 
> Questions for NEMU folks:
> 
> qboot isn't part of the virt-x86 NEMU tree and is only mentioned in
> one or two places.  Is NEMU focussing exclusively on OVMF guest
> firmware instead of qboot?
Initally we were only focusing on OVMF, but we added support for qboot
[1] as we were not happy with the OVMF boot latencies we measured,
especially in the Kata containers context. Rob was about to start
looking at seabios support as well.

We are going to upstream a cleaner version of the virt support to qboot
very soon now.

> Are there other boot time optimizations in NEMU that are a candidate
> for upstreaming?

We did not add anything specific, but when comparing PC+qboot with
virt+qboot, we're seeing interesting overall boot time improvements. We
assume the simpler virt machine type explains the difference.

Cheers,
Samuel.

[1] https://github.com/rbradford/qboot/commit/dbcaaa1f6921064cd46f330a3625eb01e44aa4df
