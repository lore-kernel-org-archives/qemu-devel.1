Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510F3CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 15:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D44A2084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 15:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3bE1am7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D44A2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMwC3-0002tx-7r
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 11:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iMwAz-00026b-WF
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iMwAx-00026z-Eq
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:34:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47252
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iMwAx-00025r-0I
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571758461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TXj/iPyhWiM5jQxHtiCk1al0+4goGyb5lNbZvAQxEEw=;
 b=C3bE1am7nhGIFKdEUyndJgMuXFf8uZBzigO9ul1TOPQCHBDAViVhcKNtmeYOs6yXzIVcxf
 dfuTdni9gx0zEGYxjTx6Qm94GoEiazRgQCY78b/se66wl/tvYM509jQjJAqfAv614hj0SK
 KIfCTZyQG8XgNPMxJjO9zAaJfcAyG+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-dCoiFZQtPxmE52j5anrcJA-1; Tue, 22 Oct 2019 11:34:13 -0400
X-MC-Unique: dCoiFZQtPxmE52j5anrcJA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44CAC800D49;
 Tue, 22 Oct 2019 15:34:12 +0000 (UTC)
Received: from localhost (ovpn-117-153.ams2.redhat.com [10.36.117.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 625DE60A9F;
 Tue, 22 Oct 2019 15:34:08 +0000 (UTC)
Date: Tue, 22 Oct 2019 16:34:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Liu, Changpeng" <changpeng.liu@intel.com>
Subject: Re: [PATCH] vhost-user-scsi: implement handle_output
Message-ID: <20191022153407.GC32186@stefanha-x1.localdomain>
References: <20191017163859.23184-1-felipe@nutanix.com>
 <CAONzpcbR+OjcrfavTnFXVopG-YsTdnFCT=no0eFei4oanfmj1Q@mail.gmail.com>
 <17B5A7A6-F790-4D10-8921-06A83DA18077@nutanix.com>
 <CAONzpcYDDUde0PLVtGYuwGm79RvU-VubXqDs=4F_8yp+-pz-Zg@mail.gmail.com>
 <B53729BD-5A55-4D27-88BE-F8ED2A39D41F@nutanix.com>
 <FF7FC980937D6342B9D289F5F3C7C2625B873307@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B873307@SHSMSX103.ccr.corp.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yongji Xie <elohimes@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 21, 2019 at 08:19:59AM +0000, Liu, Changpeng wrote:
> There is some logic in vhost_user_blk_handle_output() for now, it's not empty as vhost-user-scsi.

The purpose of the vhost_user_blk_handle_output() code is to deal with
legacy drivers that violate the VIRTIO spec by accessing virtqueues
before VIRTIO Device Initialization is complete.  It needs to stay.

The patch I posted should work together with
vhost_user_blk_handle_output() though and handle the case that Felipe
discovered.

Stefan

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2vIW8ACgkQnKSrs4Gr
c8i7/Af/etq9TWOdabUfTlbjSqg4uSWqITpN4wwR9AVES13HxdBmiEp6eYUInVjX
JhP1Ja942vjcq3vlw5M9t72iZDf2R2YbuL10hU19S71RxoLQZAijLbETWdqu9a03
r8EpG63FbVmw70LqiPzw8PhwTYTN+1m/5HZPKUCDLwa826sSjB7QQBnk5e7gfBYl
TJKTHCHbAUuZT2N6Bc96etKq2Y2eu7LCb8GUqyePpcY2mz1s+YzacRHMZowndAJF
uQlPnrEuNhkfqDgXwd8OCvh5skCAJXEuoAqqyV+ZiiZFezhDYwMJ0znvJdqkMItj
OMUHHsE6JRFGjZI402AFCzUbVZ/3wA==
=4IRO
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--


