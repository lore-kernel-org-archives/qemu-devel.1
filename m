Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85774CA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 14:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53AD9214AF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 14:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrTNDwCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AD9214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOjrw-00082M-Ax
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 10:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iOjmV-0001yi-4b
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 10:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iOjmU-0002lJ-2a
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 10:44:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53577
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iOjmT-0002l4-V4
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 10:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572187473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a5P8lZ1ce73cBY/x9uxy7NB3AcS76A8MHVol1yKQH0k=;
 b=KrTNDwCPrB7/lE7CYk3uhvTpAGA564flicBaIw4/YXMe1LKGaJYP29SZl9K0GjAz1BUC6Q
 +U9qyNxxWBTvIiq0dQGBWA5rKbm/s0AZXF824gpp3AWD8zGj29AQcUEHE3oI3bjk1pNylw
 3xUwCYWHEgZ9qJONLDszQqatSrmEd/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-ISkRu73YOmSVTB0wjalYsw-1; Sun, 27 Oct 2019 10:44:26 -0400
X-MC-Unique: ISkRu73YOmSVTB0wjalYsw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A95B1800DCB
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2019 14:44:25 +0000 (UTC)
Received: from localhost (ovpn-116-99.ams2.redhat.com [10.36.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4DD4854561;
 Sun, 27 Oct 2019 14:44:18 +0000 (UTC)
Date: Sun, 27 Oct 2019 13:36:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 1/3] WIP virtiofsd: import Linux <fuse.h> header file
Message-ID: <20191027123623.GO4472@stefanha-x1.localdomain>
References: <20191025100152.6638-1-stefanha@redhat.com>
 <20191025100152.6638-2-stefanha@redhat.com>
 <20191026174745-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191026174745-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HFD/Dq8JdnjNvyuv"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--HFD/Dq8JdnjNvyuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2019 at 05:49:11PM -0400, Michael S. Tsirkin wrote:
> On Fri, Oct 25, 2019 at 12:01:50PM +0200, Stefan Hajnoczi wrote:
> > tests/vhost-user-fs-test.c needs fuse.h.  The private copy that
> > virtiofsd has can be replaced with a properly imported file using
> > update-linux-headers.sh.
> >=20
> > TODO rerun update-linux-headers.sh with upstream kernel tree!
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> OK I would just add this with the virtiofsd patchset.

Yes, I'll talk to David.

Stefan

--HFD/Dq8JdnjNvyuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl21j0cACgkQnKSrs4Gr
c8j6ugf/SwP+Qyw7qmyQInH0iArUl4QbSR98SvctUVw066Vw109WHPpDr8v3LFbE
xJ90vnF6s+yaKbvMeFCtJMpJ0nRosEhjc20XjrpfINvvlUQANgkPl4NUpqD3gxeg
daqXIoOux2Yi5gi5m/VyQdNf71u/Y4VU4mImXN+0WnFUfko4VkH28N+JTwT4Bkng
NjspBEVSTDMfqS2BPPwT8tvITpOFlVNb2skkR8qngT0Dq3bEp5NelxKVMdGgMA8x
4D1AvV52BU2pRyiWocCjelJXsXRCKDOX+LYNt15c2GIeVPDOmaCa+1fvzxdHYMOT
eoC+xLolTWudUHY6b1etEmQGHqwRXg==
=RCds
-----END PGP SIGNATURE-----

--HFD/Dq8JdnjNvyuv--


