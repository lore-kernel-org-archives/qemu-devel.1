Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600F8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:00:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 297FD20853
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAwlgGNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297FD20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqFru-0006mg-Ds
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqFrG-0006Fj-Bq
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:59:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55523
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqFrE-0008HJ-GX
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593521967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bMmnpo0vBad4fXkVdX6TjjyI2d2+tZNN9mnRh9Cj1vQ=;
 b=KAwlgGNiDz2V0QImld2PkJ0DkjiXMtyssFQIlVg8fD97B86Gl7EvUqvf0BSXVBYnMPD0/Q
 otAxK+ckCk+GvyUVc1v5d0QfzGK/YNKYChFTCiTXH6E1ikLyjBpe8Sp3XUv8cKCNOOovyg
 kMVzByEKNxcAPJU5hdzEcKTpPYaNflA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-Svo0wrXTNXuhceJAs-YLLw-1; Tue, 30 Jun 2020 08:59:22 -0400
X-MC-Unique: Svo0wrXTNXuhceJAs-YLLw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5F9D800597;
 Tue, 30 Jun 2020 12:59:21 +0000 (UTC)
Received: from localhost (ovpn-115-106.ams2.redhat.com [10.36.115.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35CB26106A;
 Tue, 30 Jun 2020 12:59:17 +0000 (UTC)
Date: Tue, 30 Jun 2020 13:59:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH v2 0/3] trace: Add a trace backend for the recorder library
Message-ID: <20200630125916.GG91444@stefanha-x1.localdomain>
References: <20200626162706.3304357-1-dinechin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200626162706.3304357-1-dinechin@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="m972NQjnE83KvVa/"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:34:33
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
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--m972NQjnE83KvVa/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2020 at 06:27:03PM +0200, Christophe de Dinechin wrote:
> The recorder library implements low-cost always-on tracing, with three
> usage models:
>=20
> 1. Flight recorder: Dump information on recent events in case of crash
> 2. Tracing: Individual traces can be enabled using environment variables
> 3. Real-time graphing / control, using the recorder_scope application
>=20
> This short series introduces a new "recorder" back-end which connects
> to the recorder. Traces using the recorder are intentionally "always on".
> An example is given of how the recorder can also be used separately
> from generated traces. This can be useful if you want to enable
> multiple related traces for a particular topic.
>=20
> This series requires a small makefile fix submitted earlier, included
> here for convenience.
>=20
> Christophe de Dinechin (3):
>   Makefile: Compute libraries for libqemuutil.a and libvhost-user.a
>   trace: Add support for recorder back-end
>   trace: Example of "centralized" recorder tracing

Please add a build to .travis.yml that enables recorder. That way we'll
catch build failures.

Thanks,
Stefan

--m972NQjnE83KvVa/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl77NyQACgkQnKSrs4Gr
c8hgFAf/X7MbazUJx/usGDy9V6mIfcT67H+OrBZ4dEMLu2sOvQqlXMQJVQKu5AI5
b081Oj5mYnaaHC/19qYCKGg+bMN+32kSKptzlupwSRkRcPJPwj966SDzzzunRQd3
L93QbGgr1g9HubOYhU73GVwiDzDWazGRIJNlasQ6Gqw6T45VDsjL675du14tj+g2
YPiWvXp6ySpV67BXImysjDsButeEDzXa3ma23VH+G1jOMTL3rXhJcdMjvu9ZCaSi
J+37YxfIQmw/La7xjhWJZEkby2UPViGKtli4GXsB1GDitAGtnpMwrf6MFBfexlk1
k6OE/QxppCIZl5R2E+ordZcJFnSCyw==
=xzGt
-----END PGP SIGNATURE-----

--m972NQjnE83KvVa/--


