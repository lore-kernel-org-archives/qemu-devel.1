Received: from eggs.gnu.org ([2001:4830:134:3::10]:49281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMBww-0006lO-Ug
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMBws-0007iZ-2V
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:36:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39276 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fMBwr-0007hq-VQ
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:35:58 -0400
Date: Fri, 25 May 2018 15:35:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180525153236-mutt-send-email-mst@kernel.org>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
	<1527086545-68024-8-git-send-email-mst@redhat.com>
	<CAFEAcA9JwWR29YSBKGS1fmmOE=wrSQY+OeJxQc4kmAEHRXUzWQ@mail.gmail.com>
	<CAFEAcA9mAMCznsf1hao2PFziXnATrCxa8Of33NckUGXxFU6yEQ@mail.gmail.com>
	<20180525151719-mutt-send-email-mst@kernel.org>
	<CAFEAcA_bDdefEuy183ma4oso5bZ2QxheDs9oOObBCKPL2hx+Uw@mail.gmail.com>
	<20180525152433-mutt-send-email-mst@kernel.org>
	<CAFEAcA9M5c=R004dH2NR7-2yA2Mz13urCmj8Bs=uCAumHP8kMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9M5c=R004dH2NR7-2yA2Mz13urCmj8Bs=uCAumHP8kMA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm-devel <kvm@vger.kernel.org>

On Fri, May 25, 2018 at 01:30:00PM +0100, Peter Maydell wrote:
> On 25 May 2018 at 13:27, Michael S. Tsirkin <mst@redhat.com> wrote:
> > I see.  I guess you did all the work already, do you still need help
> > or will you just go ahead and post it? Or even commit directly,
> > it's a trivial enough patch.
> 
> I'll send a series later this afternoon that does an update
> to 4.17-rc6; it has a couple of other prerequisites in it,
> to handle __aligned_u64 in the update script (patch already
> posted this morning, but I'll put it in the series), and to deal
> with the kernel headers not yet defining VIRTIO_GPU_CAPSET_VIRGL2.


You mean like this:
http://patchwork.ozlabs.org/patch/907121/

?

> thanks
> -- PMM
