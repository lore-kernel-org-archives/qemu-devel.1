Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70576C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 09:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C3292087E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 09:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3292087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht7DW-0002ts-Gx
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 05:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35528)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1ht7D7-0002T6-FV
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 05:17:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ht7D6-0003Ad-A9
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 05:17:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56768)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ht7D6-000390-4q
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 05:17:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 61BC53084248;
 Thu,  1 Aug 2019 09:17:19 +0000 (UTC)
Received: from localhost (ovpn-116-232.ams2.redhat.com [10.36.116.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA7175D6A7;
 Thu,  1 Aug 2019 09:17:16 +0000 (UTC)
Date: Thu, 1 Aug 2019 10:17:15 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190801091715.GC15179@stefanha-x1.localdomain>
References: <20190731161006.9447-1-stefanha@redhat.com>
 <20190731161006.9447-2-stefanha@redhat.com>
 <20190731184538.GO3203@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
In-Reply-To: <20190731184538.GO3203@work-vm>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 01 Aug 2019 09:17:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/5] virtiofsd: take lo->mutex around
 lo_add_fd_mapping()
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
Cc: virtio-fs@redhat.com, Liu Bo <bo.liu@linux.alibaba.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2019 at 07:45:38PM +0100, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > The lo_add_fd_mapping() function assumes lo->mutex is held, so we should
> > acquire it.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Thanks, applied
>=20
> Would it make sense for me to squash this into:
>     virtiofsd: passthrough_ll: add fd_map to hide file descriptors=20
>=20
> ?

Yes, please.

Feel free to squash any of my virtio-fs patches as you see fit in order
to produce a nice clean patch series for upstream.  I don't mind if
fine-grained authorship information is lost, but please keep my
Signed-off-by.

Stefan

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1CrhsACgkQnKSrs4Gr
c8iCLAgAj3LmlRPxvClrlyjC+/CAF3ji80jd/ZWOtfY9Yv4iEaoUqX2uGXkrrqiW
NC15SlMWL0miyf7zIOKSjW84ZoPRMFIsz3RioF07UkdvtOuAFu//8aemqGj+Wt2m
IVFmLMULG3Ur/1A52PezhyQcfgIKcejZY624g0MeXv4aB6Hzqm/9emh6YTjoUGUD
wwy1u6sCLcCZPKIwwdtAARos8jc8h6RYr1UOLMbdcl8FrlnMtEuFHwmYdlNCGKiT
NgLmz78Tap+N6sc8ETVkQOkczAe9zEqmszLYoFZmyrslC6GJXnnCIW4EBQ3sAS4i
N9fjX5rshqiV1qC1AaAUemYQ9lgcCA==
=/9cz
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--

