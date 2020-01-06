Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4720C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:42:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DCA320731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="WlS0tY7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DCA320731
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioUWA-0002Iq-Ou
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:42:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1ioUEx-0001n7-KL
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:24:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1ioUEw-0005A3-BZ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:24:23 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:40921)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1ioUEv-00058f-TZ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=jChDevm7+FSSnpvZooTOApF3ckawxX62n9bXQo0ypqw=; b=WlS0tY7lhZB/XkcM8Nb6BraZru
 Y1w1iMZcufQ7BdbUExR4lC7A+vi8/r8sw1eXxwVhoGTCZO09oBfS0C2/T9URLSWz4bTa5UPsPrcXE
 c2OU+oqMUlBGYwk7UqszQOgUjIJ9YuVRaaND9fhuveFGCok6Vpi1OSrFc+QP3ku9y5LpLen1+3KVe
 quf+RFB1J3liRl7sCfE+5Zg0Hnu+WA/ckh+Gq3kMq1fvC7xT1+bx0S6o6zz7S9pz6fxmkNaaWBkFN
 HQdyL6inG7LkXXQVw1pXdaMWDCyj7RQhdBviVmCaVizbyh7iYlmgTldBgg6uEZCwIMHqAUKVt/PuA
 NDn+rDTkF7IusQ5gAFWIOFaK+SELfQhyaKB9m7FtbLUjH6athhvkdKWauYCOFJzpxbqCP1r3kTa2b
 rTqkQL23Jn/UCTdlG2CWxVyoXKJjcfL1INCEiqN/bp4i5oybcwQ7gQnyGjpwfG3Mx4l5xnCHzWbDg
 z49Kwr8i9JTGSKHnBD9my0LFVnrRn+qmxeS6eu+amOSN4eCiSTHYuV1dZwGP9dHb/8D3zbWfcGV08
 Sv5AOeiwx7Kz2TQYtiNZ9th9zGPD6VGUzDT/yNXXdOy93dpWKRQSIwE+bc1HyAnMoxl3m69Vu/Moa
 5i+KWE2Pe0Bp7VTpAjCy7WsU3muPvq7jUOuruYK1Y=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Stefano Stabellini <sstabellini@kernel.org>,
 anthony.perard@citrix.com, Stefano Stabellini <stefano.stabellini@xilinx.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH] 9p: init_in_iov_from_pdu can truncate the size
Date: Mon, 06 Jan 2020 16:24:18 +0100
Message-ID: <2163433.xPYm55Bgvh@silver>
In-Reply-To: <20200106144254.79920ae7@bahia.lan>
References: <20191219004251.23763-1-sstabellini@kernel.org>
 <20200106144254.79920ae7@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.189.157.229
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Montag, 6. Januar 2020 14:42:54 CET Greg Kurz wrote:
> > diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> > index 775e8ff766..68873c3f5f 100644
> > --- a/hw/9pfs/virtio-9p-device.c
> > +++ b/hw/9pfs/virtio-9p-device.c
> > @@ -145,19 +145,15 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu,
> > size_t offset,> 
> >  }
> >  
> >  static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec
> >  **piov,
> > 
> > -                                        unsigned int *pniov, size_t size)
> > +                                        unsigned int *pniov, size_t
> > *size)
> > 
> >  {
> >  
> >      V9fsState *s = pdu->s;
> >      V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
> >      VirtQueueElement *elem = v->elems[pdu->idx];
> >      size_t buf_size = iov_size(elem->in_sg, elem->in_num);
> > 
> > -    if (buf_size < size) {
> > -        VirtIODevice *vdev = VIRTIO_DEVICE(v);
> > -
> > -        virtio_error(vdev,
> > -                     "VirtFS reply type %d needs %zu bytes, buffer has
> > %zu", -                     pdu->id + 1, size, buf_size);
> > +    if (buf_size < *size) {
> > +        *size = buf_size;
> > 
> >      }
> 
> As suggested by Christian in some other mail, it could still make sense to
> raise the error if there isn't even enough space to pack a 9p message
> header.

Another option: Instead of handling this as a hard error (which they probably 
try to avoid in their use case): putting the handler asleep for a while by 
calling qemu_co_sleep_ns_wakeable() in this case. Then a bit later transport 
would eventually have the required buffer size and handler could continue the 
request without an error.

But this would require more care. For instance subsequent request handlers 
would need to check if there was already an event handler asleep, and if so it 
would either need to wake it up or put itself asleep as well to prevent the 
request order being processed by server being messed up.

Best regards,
Christian Schoenebeck



