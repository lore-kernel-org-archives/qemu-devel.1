Received: from eggs.gnu.org ([2001:4830:134:3::10]:44601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <loseweigh@gmail.com>) id 1fTGYa-0007Fe-WA
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 20:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <loseweigh@gmail.com>) id 1fTGYa-0006ZY-5g
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 20:56:09 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:53289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <loseweigh@gmail.com>) id 1fTGYZ-0006ZL-VW
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 20:56:08 -0400
Received: by mail-it0-x242.google.com with SMTP id a195-v6so6171899itd.3
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 17:56:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180612143554-mutt-send-email-mst@kernel.org>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
	<fcefe501-b410-f1ec-829c-68199edcdbef@intel.com>
	<20180605152344-mutt-send-email-mst@kernel.org>
	<CADGSJ21Qf6KpLzr+og5DOFjMPqu69n6dWRLvvj1FGAR5kVRNew@mail.gmail.com>
	<20180606002650-mutt-send-email-mst@kernel.org>
	<CADGSJ21AMp02vV+qxa+DuyvAUCCsXUFwV7wjzQ1Vy1jKV=n1HA@mail.gmail.com>
	<20180612143554-mutt-send-email-mst@kernel.org>
From: Siwei Liu <loseweigh@gmail.com>
Date: Wed, 13 Jun 2018 17:56:06 -0700
Message-ID: <CADGSJ21gEYTMQv+-nOxXiwKmFp0c5EDqfCXHqy2EbF3iLZfuXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On Tue, Jun 12, 2018 at 4:47 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Jun 05, 2018 at 03:09:26PM -0700, Siwei Liu wrote:
>> The thing is cloud service provider might prefer sticking to the same
>> level of service agreement (SLA) of keeping VF over migration,
>
> That requirement is trivially satisfied by just a single VF :) If your
> SLA does not require live migration, you should do just that.

The requirement is enable live migration by default without getting
user too much attention. Migration should be attempted if guest is
live migratable. If not, present a single VF to legacy guest.

You seem to think it's not a valid use case? Or impossible to do so?
What if I have something in mind that can support my theory as well?

-Siwei

>
> --
> MST
