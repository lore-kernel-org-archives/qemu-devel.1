Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB4BC352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B7A20715
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfGy96Gk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B7A20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Cb0-0001jd-KH
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 12:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j1CWW-0005db-Hl
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:07:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j1CWU-0006ty-5i
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:07:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46732
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j1CWT-0006ry-Da
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581354420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uSy1lI2nx5MJ6FTmAGhu+XLLRL0CzeIUMCYV1fx0Cd4=;
 b=FfGy96Gkw05d0A0e0kLpsRpZnc5i3OjgHu52EbTcEYLMmHFCWezaFJO1W9cpfyj0FbqlHw
 SzFm0cRqZjXrqgPOrMm0vXCO/mg4oYHUId2uoO9vNC4QNslpV6wElmUdfjT05kwCg4oTK2
 /8cKzsO3Xhqtaq7lLFGOK7ix2b7SSY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-EjBaRISHPI6DVvOaUr9fkQ-1; Mon, 10 Feb 2020 12:06:47 -0500
X-MC-Unique: EjBaRISHPI6DVvOaUr9fkQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5F35800D41;
 Mon, 10 Feb 2020 17:06:45 +0000 (UTC)
Received: from localhost (unknown [10.36.118.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51C3C5C1D6;
 Mon, 10 Feb 2020 17:06:42 +0000 (UTC)
Date: Mon, 10 Feb 2020 17:06:41 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 2/4] virtio: increase virtuqueue size for virtio-scsi
 and virtio-blk
Message-ID: <20200210170641.GJ411895@stefanha-x1.localdomain>
References: <20200129140702.5411-1-dplotnikov@virtuozzo.com>
 <20200129140702.5411-3-dplotnikov@virtuozzo.com>
 <20200130145840.GH180311@stefanha-x1.localdomain>
 <92f392e9-eb05-5c85-4d50-208110720a22@virtuozzo.com>
 <20200205111905.GE58062@stefanha-x1.localdomain>
 <683b80a8-0d40-7f14-e3f4-628d2b38037f@virtuozzo.com>
 <20200209024650-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200209024650-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PEkEgRdBLZYkpbX2"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, mreitz@redhat.com,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, pbonzini@redhat.com,
 den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--PEkEgRdBLZYkpbX2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2020 at 02:49:09AM -0500, Michael S. Tsirkin wrote:
> On Fri, Feb 07, 2020 at 11:48:05AM +0300, Denis Plotnikov wrote:
> > On 05.02.2020 14:19, Stefan Hajnoczi wrote:
> > > On Tue, Feb 04, 2020 at 12:59:04PM +0300, Denis Plotnikov wrote:
> > > > On 30.01.2020 17:58, Stefan Hajnoczi wrote:
> > > > > On Wed, Jan 29, 2020 at 05:07:00PM +0300, Denis Plotnikov wrote:
> > So, what about changing the queue sizes just for virtio-blk-device and
> > virtio-scsi-device?
>=20
> Hmm that would break ability to migrate between userspace and vhost
> backends, would it not?

I think live and offline migration between them would still work as long
as the queue size is manually specified.

Stefan

--PEkEgRdBLZYkpbX2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5BjaEACgkQnKSrs4Gr
c8hzvggAw60KVXEYRyUpisr4WQc9+pW0PKQVEIi9N5oC9Tt9nkSExq9wHuOxjvzc
v6RwrKxnE3F1Vzqi4l7oppOPo9wyJysUF05EXgauio7gIquL5QwMrzzhSbCx6Sce
WIkOwi3rnt0fA7hyOGu6EBzZ7/xVA8PU7M3MOY4GdjeORH6lX6cBGD3FjvseB3JL
jjLqR7KbrA/A7eXeYG13JUWVJFFVGw9TXWbr3nXeatDr5Vl1JXxMvx4ZoGQFe2nA
KbD0WSGJjRFi8dru0jXOrTccFKA3VTFEKrZPliaGJdErmxQx0cWJmBVRw44qZH0A
Tingo4ps8F8gTafZlHSQ3x/l7jtMyA==
=NoXG
-----END PGP SIGNATURE-----

--PEkEgRdBLZYkpbX2--


