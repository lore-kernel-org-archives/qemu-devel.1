Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E18C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C693B206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xqt3jft+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C693B206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqBnr-0001X8-1f
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqBnF-00017l-Au
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:39:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35589
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqBnD-0007DB-Mb
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593506343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=55VDS0ZaYF9Ddii1YNKH2hwf3l8Wu4gPFj7yP3dtqLI=;
 b=Xqt3jft+7B4IuN4TZjOocVLclyUnIW5G2V8H3vlqDs76I52jFO4X61eTm3cGKGHsxURLvL
 8StrjGR4qma7PANuHPs7zOkvof+9O+S/+G1mm1/Pg2ugluW6qvZqXNnSWH7Oh2JlqQIsST
 Rs+h2m0e8icm5ZY4gJ8CwrAf5e5gAO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-ySwNzzszM2-w7Mwhf5qnlA-1; Tue, 30 Jun 2020 04:39:00 -0400
X-MC-Unique: ySwNzzszM2-w7Mwhf5qnlA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B16211005512
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 08:38:59 +0000 (UTC)
Received: from localhost (ovpn-115-106.ams2.redhat.com [10.36.115.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81D165D9C9;
 Tue, 30 Jun 2020 08:38:56 +0000 (UTC)
Date: Tue, 30 Jun 2020 09:38:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 0/3] virtiofsd capability changes and addition
Message-ID: <20200630083855.GA81930@stefanha-x1.localdomain>
References: <20200629115420.98443-1-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200629115420.98443-1-dgilbert@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 01:11:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2020 at 12:54:17PM +0100, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Hi,
>   This is a set of changes relating to the capability restirctions
> introduced in virtiofsd back in a59feb483b8.
> =20
> The first one is a potentially important fix; the missing terminator
> could mean extra capabilities are added based on junk on the stack;
> although that's not been seen in practice.
> =20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>=20
> v2
>   Pass a copy of the parameter list into setup_capabilities
>=20
> Dr. David Alan Gilbert (3):
>   virtiofsd: Terminate capability list
>   virtiofsd: Check capability calls
>   virtiofsd: Allow addition or removal of capabilities
>=20
>  docs/tools/virtiofsd.rst         |  5 +++
>  tools/virtiofsd/helper.c         |  2 +
>  tools/virtiofsd/passthrough_ll.c | 71 +++++++++++++++++++++++++++++---
>  3 files changed, 73 insertions(+), 5 deletions(-)
>=20
> --=20
> 2.26.2
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl76+h8ACgkQnKSrs4Gr
c8gLwQgArIw3xavDwZLGTWzfsj7jBPmkfDBkYOacWFPI0orGa/FZDpKBH5f+O/rd
YlWz8odZFfnZWRIy9/q79jb77TNwxJztODXYJ342w1JU2RXA+ctAZvvQ41tgaGEe
xIVaBwILlJlzTP6r0S3dfXmN2s2uep3BS1RT5RIsrhatuZsjZFaKBHvhXsAgWu9h
yXX0F942J4XxSpYtAGb1uY4V+pLzFB2ikIP1y+Rje/blOkY8uZNy28I6JVwUz8gm
V7z6Iz7wIq04A8VjmNh99zzGmp1Mo0AJful88ASpdQOVF6UAgynFDST+bOgnwWIP
6cLHdC6fXhzgtuB1HNK/MbgCr0txdA==
=zVdw
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--


