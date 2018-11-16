Received: from eggs.gnu.org ([2001:4830:134:3::10]:41470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gNh9a-0007QL-Fx
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:39:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gNh9Z-0002km-Ri
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:39:34 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:45945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gNh9Z-0002kJ-JF
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:39:33 -0500
Received: by mail-wr1-x42a.google.com with SMTP id v6so3657222wrr.12
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 08:39:32 -0800 (PST)
MIME-Version: 1.0
References: <CAGxU2F658=XjoHnF6Qq5FqBZAE68BBtMFt-6HcKp_PVxTynOnw@mail.gmail.com>
In-Reply-To: <CAGxU2F658=XjoHnF6Qq5FqBZAE68BBtMFt-6HcKp_PVxTynOnw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 16 Nov 2018 16:39:20 +0000
Message-ID: <CAJSP0QVKVktawsab4pPb3qdGuh9D1zBZOucN+K2B=nrkdW2_qQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] SeaBIOS booting time optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>, robert.bradford@intel.com
Cc: SeaBIOS <seabios@seabios.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, sgarzare@redhat.com

On Fri, Nov 16, 2018 at 4:21 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> I'm investigating the SeaBIOS booting time, to understand if we can reduce
> the boot time in some cases (e.g. legacy hardware is not needed). I think
> this
> can be interesting also for NEMU developers.

Questions for NEMU folks:

qboot isn't part of the virt-x86 NEMU tree and is only mentioned in
one or two places.  Is NEMU focussing exclusively on OVMF guest
firmware instead of qboot?

Are there other boot time optimizations in NEMU that are a candidate
for upstreaming?

Stefan
