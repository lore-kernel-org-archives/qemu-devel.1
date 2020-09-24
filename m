Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF65CC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BCB02395B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgQ9tkcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BCB02395B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLPR6-0003HA-51
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLPNE-0006PW-1p
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:25:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32518)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLPNA-0004fQ-Sy
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600946711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k+wQ+OIRsqJkypaQ3tYxlrKKy4H6UiUJI+kMDREEbEM=;
 b=XgQ9tkcAx2GtDzwKsaZhzXrlipB4oyHqFM1nBdQbP0dJbJ6TbW9xWvePJQUZjzgyeQJ1oG
 k9lS0hiFC8+Vo0+KtOf7B4trnuRO3JotjK8Fk+AlYGm/mREBPikzhZUPGBVtzZK3/bZRjD
 +NQKT6lcVNAF15tFqk3kpyy6Du6UEIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-Ar7fjCsxO2io9NktLmKMnA-1; Thu, 24 Sep 2020 07:25:07 -0400
X-MC-Unique: Ar7fjCsxO2io9NktLmKMnA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04AFD1009443;
 Thu, 24 Sep 2020 11:25:06 +0000 (UTC)
Received: from localhost (ovpn-114-5.ams2.redhat.com [10.36.114.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A024C7882C;
 Thu, 24 Sep 2020 11:25:05 +0000 (UTC)
Date: Thu, 24 Sep 2020 12:25:04 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v8 3/7] block: declare some coroutine functions in
 block/coroutines.h
Message-ID: <20200924112504.GV62770@stefanha-x1.localdomain>
References: <20200915164411.20590-1-vsementsov@virtuozzo.com>
 <20200915164411.20590-4-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200915164411.20590-4-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="o3Y+93sjbn8Tp8J9"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--o3Y+93sjbn8Tp8J9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 07:44:07PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> We are going to keep coroutine-wrappers code (structure-packing
> parameters, BDRV_POLL wrapper functions) in separate auto-generated
> files. So, we'll need a header with declaration of original _co_
> functions, for those which are static now. As well, we'll need
> declarations for wrapper functions. Do these declarations now, as a
> preparation step.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/coroutines.h | 67 ++++++++++++++++++++++++++++++++++++++++++++++
>  block.c            |  8 +++---
>  block/io.c         | 34 +++++++++++------------
>  3 files changed, 88 insertions(+), 21 deletions(-)
>  create mode 100644 block/coroutines.h

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--o3Y+93sjbn8Tp8J9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9sghAACgkQnKSrs4Gr
c8iROgf+KlQZovPdLemWHP5cqcPyuoqJ1Ck/MjeWQ4lUDvPgtcmXypKOFb77Bn/P
0ahV2aHSFdxSAYTvoPdQm2gVlNAfxqW+9ZTHkUg8iopZaiPyuia3jBJTMBbKbvjR
htrrrH/9KcyRBeIUHQtHLUP/tSHeDNrqrc+Jt+xmOgLxafQfZLPzMBVLZeNvmbSf
t4d/O725LzFnGQus6CFJeuXVBINq/oxxHEvGbG6PLnvrrGs18hioyaMSxKHpGLga
xR56e4Kv5Hrr6dIUOqnexbS/7G162HT6f9mzTOsM7X0okjTQxuvnH9AdDFVME8KR
Fw0JOmwX394qHMunYnwEWKgAixRrUQ==
=HLfI
-----END PGP SIGNATURE-----

--o3Y+93sjbn8Tp8J9--


