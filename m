Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F8AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F98E207D4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBw+i5vG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F98E207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqzXm-0007PP-I9
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqzSW-0008BW-05
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:41:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59567
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqzST-0001UB-B2
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593697256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tAgrdSpMFwxnmyvQg1pAHnpwHWv7zoT+JVLIjvPhfiE=;
 b=FBw+i5vGSxxbzjGg9ekE9icosQfz9TMsRPG7Qm9pF+fdeFUCupuFGXLK578vzcIsnsqi2A
 UStbWnnZFigikpQT2lYQ+R8zS7WlZAlqx40kBgw+m/tQREwSNr6l2epio/YzrxdQ6e/TZF
 j5Mdy7WkUDusYhRmZHoPDbj4eSjMZeo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-trPudBfjNVq2QBXYJ9NMdg-1; Thu, 02 Jul 2020 09:40:51 -0400
X-MC-Unique: trPudBfjNVq2QBXYJ9NMdg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E130F107ACF5;
 Thu,  2 Jul 2020 13:40:49 +0000 (UTC)
Received: from localhost (ovpn-114-216.ams2.redhat.com [10.36.114.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2A4073FD4;
 Thu,  2 Jul 2020 13:40:43 +0000 (UTC)
Date: Thu, 2 Jul 2020 14:40:42 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v7 00/21] Initial support for multi-process qemu
Message-ID: <20200702134042.GG152912@stefanha-x1.localdomain>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <cover.1593273671.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="O8XZ+2Hy8Kj8wLPZ"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:00:43
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--O8XZ+2Hy8Kj8wLPZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2020 at 10:09:22AM -0700, elena.ufimtseva@oracle.com wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> This is the v7 of the patchset.

I have completed the review and left comments on the patches.

I'm glad it was possible to simplify this feature. The overall approach
makes sense to me and I see how it forms the base on which
VFIO-over-socket and smaller remote program builds using Kconfig can be
developed.

My main concern is that the object lifecycle has not been fully
implemented in the proxy and remote device. Error handling is
incomplete, resources are leaked, and hot unplug does not work. Thinking
through the lifecycle is very important so that additional work can
build on top of this later. I have tried to point out these issues in
the individual patches.

--O8XZ+2Hy8Kj8wLPZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7949oACgkQnKSrs4Gr
c8jr3gf/a4L69UBz0dbilcxr2i6liwxCVXZPG4oma3MTrgxsPMaC1D0RiX8WcLRD
M9umtF1Y+A7Sd7WHC531kCytxgF/I/wnWmyPFEAHwL9m+HFqVTWsoPkc32eKXxlH
2vkm17vFJIO63mOKqWcShUqMajwjS6FJR8wK8jVkj5QrA3YEAXEOPN8ISJ9isqO+
37OQOoCqXkN77pBq7A0iiWKHewh+wEs1F3cUa3tYN70jQ0DHBxeQ3dxi4BTtTeBk
srnBqAg69UjOL3KAcfC/46yCNxkch0pTIFE8/IBaQpSzsnINBoIiKlFkz9Grf1gZ
bJk0O/dlrdihnYwFNf/XRw/0/KZHHA==
=c7mI
-----END PGP SIGNATURE-----

--O8XZ+2Hy8Kj8wLPZ--


