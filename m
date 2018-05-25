Received: from eggs.gnu.org ([2001:4830:134:3::10]:50001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fMBzG-0007Y4-1U
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fMBzD-0000UN-VJ
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:38:26 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:40951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fMBzD-0000Te-MU
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:38:23 -0400
Received: by mail-oi0-x242.google.com with SMTP id c203-v6so4430035oib.7
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 05:38:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180525153236-mutt-send-email-mst@kernel.org>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
	<1527086545-68024-8-git-send-email-mst@redhat.com>
	<CAFEAcA9JwWR29YSBKGS1fmmOE=wrSQY+OeJxQc4kmAEHRXUzWQ@mail.gmail.com>
	<CAFEAcA9mAMCznsf1hao2PFziXnATrCxa8Of33NckUGXxFU6yEQ@mail.gmail.com>
	<20180525151719-mutt-send-email-mst@kernel.org>
	<CAFEAcA_bDdefEuy183ma4oso5bZ2QxheDs9oOObBCKPL2hx+Uw@mail.gmail.com>
	<20180525152433-mutt-send-email-mst@kernel.org>
	<CAFEAcA9M5c=R004dH2NR7-2yA2Mz13urCmj8Bs=uCAumHP8kMA@mail.gmail.com>
	<20180525153236-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 May 2018 13:38:02 +0100
Message-ID: <CAFEAcA9Y2pWkotwiwE7bb6t6jWt+YJ_RVrfvTuSQqTd9FbBGRg@mail.gmail.com>
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

On 25 May 2018 at 13:35, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Fri, May 25, 2018 at 01:30:00PM +0100, Peter Maydell wrote:
>> On 25 May 2018 at 13:27, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > I see.  I guess you did all the work already, do you still need help
>> > or will you just go ahead and post it? Or even commit directly,
>> > it's a trivial enough patch.
>>
>> I'll send a series later this afternoon that does an update
>> to 4.17-rc6; it has a couple of other prerequisites in it,
>> to handle __aligned_u64 in the update script (patch already
>> posted this morning, but I'll put it in the series), and to deal
>> with the kernel headers not yet defining VIRTIO_GPU_CAPSET_VIRGL2.
>
>
> You mean like this:
> http://patchwork.ozlabs.org/patch/907121/
>
> ?

Yes; I missed that (found a mail thread pointing out the problem
but not the patch with the fix); I'll pick it up for the series.

thanks
-- PMM
