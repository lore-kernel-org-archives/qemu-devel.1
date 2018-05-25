Received: from eggs.gnu.org ([2001:4830:134:3::10]:46616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fMBrX-0004Ur-Db
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fMBrR-0005Ep-Nk
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:30:27 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:42034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fMBrR-0005DF-5e
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:30:21 -0400
Received: by mail-oi0-x233.google.com with SMTP id t27-v6so4409321oij.9
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 05:30:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180525152433-mutt-send-email-mst@kernel.org>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
	<1527086545-68024-8-git-send-email-mst@redhat.com>
	<CAFEAcA9JwWR29YSBKGS1fmmOE=wrSQY+OeJxQc4kmAEHRXUzWQ@mail.gmail.com>
	<CAFEAcA9mAMCznsf1hao2PFziXnATrCxa8Of33NckUGXxFU6yEQ@mail.gmail.com>
	<20180525151719-mutt-send-email-mst@kernel.org>
	<CAFEAcA_bDdefEuy183ma4oso5bZ2QxheDs9oOObBCKPL2hx+Uw@mail.gmail.com>
	<20180525152433-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 May 2018 13:30:00 +0100
Message-ID: <CAFEAcA9M5c=R004dH2NR7-2yA2Mz13urCmj8Bs=uCAumHP8kMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 07/28] x86/cpu: use
 standard-headers/asm-x86.kvm_para.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm-devel <kvm@vger.kernel.org>

On 25 May 2018 at 13:27, Michael S. Tsirkin <mst@redhat.com> wrote:
> I see.  I guess you did all the work already, do you still need help
> or will you just go ahead and post it? Or even commit directly,
> it's a trivial enough patch.

I'll send a series later this afternoon that does an update
to 4.17-rc6; it has a couple of other prerequisites in it,
to handle __aligned_u64 in the update script (patch already
posted this morning, but I'll put it in the series), and to deal
with the kernel headers not yet defining VIRTIO_GPU_CAPSET_VIRGL2.

thanks
-- PMM
