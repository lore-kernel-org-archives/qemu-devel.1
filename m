Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D789C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:34:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1197F20731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1197F20731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioWGl-00082c-VN
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 12:34:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ioWDt-0005UR-JV
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:31:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ioWDs-0003H7-Bj
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:31:25 -0500
Received: from 2.mo178.mail-out.ovh.net ([46.105.39.61]:36409)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ioWDs-0003CX-4V
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:31:24 -0500
Received: from player694.ha.ovh.net (unknown [10.108.35.119])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 7189A8B0AE
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 18:31:21 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player694.ha.ovh.net (Postfix) with ESMTPSA id 82297DD2ABD3;
 Mon,  6 Jan 2020 17:31:15 +0000 (UTC)
Date: Mon, 6 Jan 2020 18:31:14 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH] 9p: init_in_iov_from_pdu can truncate the size
Message-ID: <20200106183114.6b1a4de4@bahia.lan>
In-Reply-To: <2163433.xPYm55Bgvh@silver>
References: <20191219004251.23763-1-sstabellini@kernel.org>
 <20200106144254.79920ae7@bahia.lan> <2163433.xPYm55Bgvh@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7991919016024119616
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehtddguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.39.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: anthony.perard@citrix.com, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-devel@nongnu.org, Stefano Stabellini <stefano.stabellini@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 06 Jan 2020 16:24:18 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Montag, 6. Januar 2020 14:42:54 CET Greg Kurz wrote:
> > > diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> > > index 775e8ff766..68873c3f5f 100644
> > > --- a/hw/9pfs/virtio-9p-device.c
> > > +++ b/hw/9pfs/virtio-9p-device.c
> > > @@ -145,19 +145,15 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu,
> > > size_t offset,> 
> > >  }
> > >  
> > >  static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec
> > >  **piov,
> > > 
> > > -                                        unsigned int *pniov, size_t size)
> > > +                                        unsigned int *pniov, size_t
> > > *size)
> > > 
> > >  {
> > >  
> > >      V9fsState *s = pdu->s;
> > >      V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
> > >      VirtQueueElement *elem = v->elems[pdu->idx];
> > >      size_t buf_size = iov_size(elem->in_sg, elem->in_num);
> > > 
> > > -    if (buf_size < size) {
> > > -        VirtIODevice *vdev = VIRTIO_DEVICE(v);
> > > -
> > > -        virtio_error(vdev,
> > > -                     "VirtFS reply type %d needs %zu bytes, buffer has
> > > %zu", -                     pdu->id + 1, size, buf_size);
> > > +    if (buf_size < *size) {
> > > +        *size = buf_size;
> > > 
> > >      }
> > 
> > As suggested by Christian in some other mail, it could still make sense to
> > raise the error if there isn't even enough space to pack a 9p message
> > header.
> 
> Another option: Instead of handling this as a hard error (which they probably 
> try to avoid in their use case): putting the handler asleep for a while by 
> calling qemu_co_sleep_ns_wakeable() in this case. Then a bit later transport 
> would eventually have the required buffer size and handler could continue the 
> request without an error.
> 

Waiting for an arbitrary amount of time (how much?) and retrying doesn't give
any guarantee either that things will go smoothly. If anything, I'd rather have
the transport to wake up the request when more buffer space gets available.

> But this would require more care. For instance subsequent request handlers 
> would need to check if there was already an event handler asleep, and if so it 
> would either need to wake it up or put itself asleep as well to prevent the 
> request order being processed by server being messed up.
> 

And so on... ie. we would need to handle a queue of sleeping requests IIUC.
Not really fan to go this way to address what looks like a corner case.

> Best regards,
> Christian Schoenebeck
> 
> 


