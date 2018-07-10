Received: from eggs.gnu.org ([2001:4830:134:3::10]:36039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <loseweigh@gmail.com>) id 1fcxoN-0004cL-Gs
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <loseweigh@gmail.com>) id 1fcxoM-0004to-Mm
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:56:31 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:36340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <loseweigh@gmail.com>) id 1fcxoM-0004te-Gz
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:56:30 -0400
Received: by mail-io0-x241.google.com with SMTP id k3-v6so21351856iog.3
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 11:56:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180710045614-mutt-send-email-mst@kernel.org>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
	<20180702161404.GA2339@rkaganb.sw.ru>
	<449f1449-ddf6-cd95-976c-14d04d8d503a@oracle.com>
	<20180703095825.GC30904@rkaganb.sw.ru>
	<d5db37d0-5eaf-8942-8ab7-d73057a67e6f@oracle.com>
	<20180709130035.GA6271@rkaganb.sw.ru>
	<9136094e-a510-4201-7c71-d1c49226fa5f@oracle.com>
	<20180710045614-mutt-send-email-mst@kernel.org>
From: Siwei Liu <loseweigh@gmail.com>
Date: Tue, 10 Jul 2018 11:56:28 -0700
Message-ID: <CADGSJ21sjds8h4Djvu221WeEnyVCbo0WbL9a_SUkntUvx5_S2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v3 0/3] Use of unique
 identifier for pairing virtio and passthrough devices...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: si-wei liu <si-wei.liu@oracle.com>, Roman Kagan <rkagan@virtuozzo.com>, Venu Busireddy <venu.busireddy@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Netdev <netdev@vger.kernel.org>

On Mon, Jul 9, 2018 at 6:58 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Jul 09, 2018 at 06:11:53PM -0700, si-wei liu wrote:
>> What do we buy
>> for using a random address during initial discovery and requiring VF to
>> complete the handshake?
>
> I don't see advantages to using a random address that is then
> changed either: changing a MAC causes network downtime for most users.
>
Definitely.

I see Linux host stack fundamentally different with Windows, it's
non-sense to duplicate what Hyper-V is doing especially if there's no
extra benefit.

>> Less network downtime during datapath switching?
>> Sorry but that's not a key factor at all for our main goal - live migration.
>
> Isn't avoiding downtime what makes the migration "live"?
> If you don't care about it at all just remove the device
> and migrate without all these tricks.

Apparently this downtime is not avoidable even if guest initiates the
switch-over when it is done on Linux host stack. Unless the NIC
supports adding duplicate MAC filters with one has higher priority
than the other when both are present. I feel there's very little or
perhaps zero improvement for the downtime if moving to a
guest-initiated datapath switching model.

However, since this downtime is intermittent and generally
unnoticeable with a few packet drops, network should be resilient in
recovering from the drops. My point is that unless we can move to a
datapath switching model with zero downtime theoretically, this kind
of minor optimization offers very little help in general.

Regards,
-Siwei



>
>
> --
> MST
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
