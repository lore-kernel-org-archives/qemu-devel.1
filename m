Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A29C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 711CE20717
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRq3q35w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711CE20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxrW9-0007MS-O3
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jxrVC-0005xP-HV
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:36:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56084
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jxrVA-00040K-UD
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595334967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g/nNtDUeeIaIv45Rj+2Bwd+zkwGmMx5pund/ggIstso=;
 b=RRq3q35wFudH+xHzoGvCy8roIOK5ulk0ZzZ4spvP6PWJJ/ZsvfY/mN+089gIvXKHUjByYh
 yl7aC1HgUVWSUGFJ3A0bsc02ImmWT8XMpfJKO5A24LyVx/wq2RSECx9X6P9wt4wIuzsWkg
 vtqxg6p/XZm8WtDfsomQby1UJB0SvrE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-ScpfG2sGP_u6hw_ZXknAZQ-1; Tue, 21 Jul 2020 08:36:05 -0400
X-MC-Unique: ScpfG2sGP_u6hw_ZXknAZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CCC0800473;
 Tue, 21 Jul 2020 12:36:04 +0000 (UTC)
Received: from localhost (ovpn-114-133.ams2.redhat.com [10.36.114.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6CA272688;
 Tue, 21 Jul 2020 12:36:03 +0000 (UTC)
Date: Tue, 21 Jul 2020 13:36:02 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH v2 0/4] Add dtrace support on macOS
Message-ID: <20200721123602.GE183198@stefanha-x1.localdomain>
References: <20200717093517.73397-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
In-Reply-To: <20200717093517.73397-1-r.bolshakov@yadro.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="orO6xySwJI16pVnm"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:46:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--orO6xySwJI16pVnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 12:35:13PM +0300, Roman Bolshakov wrote:
> Hi,
>=20
> This is a small series that enables dtrace tracing backend on macOS.
> Whether or not it should go to 5.1 is up to discretion of tracing
> maintainers.

Thanks for the patches. I would like to apply them for QEMU 5.2.

I have reviewed patches 1-3 and will wait for discussion to finish on
patch 4.

Stefan

--orO6xySwJI16pVnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8W4TIACgkQnKSrs4Gr
c8jXTgf/YDuCmjD/VQen1HBH5aGPEo5Tcwt+orRO2lfTw7vaKITNTqXozcCIgE76
0PIK+BuVRxNA75Hq+H+k3kNF77PP6qiW7SPrm6ww74btY7cSC4M3jORv1LplnYW8
YRuA8x6kV9wYcHe+qa5qpNrta57UD8seC1CauCTWXk7YyBhnM6ao7ouebFKjVkR5
AQD6BkUS3n53Z0lwLZQUfpPAItLT9jR/cS7nUpM/bpc1cycyVqM1BKgJjvQo3Vcf
gNEa8BBSlojr/m5AL9/d0BNs6HuQ8xEqHp/iBkIK8RM3+eGEN0JMljA1ccIyopLS
FOdm9uWQC7jgrnr8GguXkZyoceE7Bg==
=Z1ni
-----END PGP SIGNATURE-----

--orO6xySwJI16pVnm--


