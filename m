Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F0AC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 322BF208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwTM/Yft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322BF208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJDe9-0007l0-AF
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 06:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kJDdR-0006vH-Eg
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:28:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38735)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kJDdP-0004KN-MM
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600424934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5IfLLJlXMNab81YY4p5LCGHmuIzHxYvGIMXwqMiEowo=;
 b=HwTM/YftsYLC7TwB40nGE8eVWwGlsSomJhamXMu5tFJSV9FtCHvuhemvv/fdP4IGZUBKuW
 nk+BVC9gPeRKFrLmbsDrDCXPPm+nxT0CDBFR60j9pL0hiQdB7sBOZy0F74Id7uzfEDhNKs
 9dcA2eaHnCaYz66NAUgYXUawMO5AQi0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-t4Ju0ghSObKajhz8A5Tzbw-1; Fri, 18 Sep 2020 06:28:50 -0400
X-MC-Unique: t4Ju0ghSObKajhz8A5Tzbw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01C6110A7AE2;
 Fri, 18 Sep 2020 10:28:49 +0000 (UTC)
Received: from localhost (ovpn-114-253.ams2.redhat.com [10.36.114.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9AC247EEA7;
 Fri, 18 Sep 2020 10:28:48 +0000 (UTC)
Date: Fri, 18 Sep 2020 11:28:47 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v10 2/7] libvhost-user: remove watch for kick_fd when
 de-initialize vu-dev
Message-ID: <20200918102847.GA870103@stefanha-x1.localdomain>
References: <20200918080912.321299-1-coiby.xu@gmail.com>
 <20200918080912.321299-3-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200918080912.321299-3-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2020 at 04:09:07PM +0800, Coiby Xu wrote:
> When the client is running in gdb and quit command is run in gdb,
> QEMU will still dispatch the event which will cause segment fault in
> the callback function.
>=20
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9ki98ACgkQnKSrs4Gr
c8hVQwf+JCf8Kx74zuRtmnWJfotyKtbnLscZdNWmOf8jEkO+M/tvlNtMErAskLtG
JNRQfIb4KUL8C8HGtGbmSKIEbQJacqL/4Hb2ZNzPhEf7JwOIIVqS1LZUkfFVcEi7
X+x/ncAg8lC4bexVN1OQ9v+j5caLfbQ0gq8dMaU9FW5ZgPZCkWb/9qeFF9DJfyWG
Ouh0eQKTe82JL+c58EtUzMgSGRfl/6Trep03FnKSjEt3td2keF1uPcxwXVSvmhYV
Erz9iXTMewGFZgbYlEET9zuwdXBzh7/UYsKCz/I3MJS25tOEB7TdeEkJjdGsIbFp
aprPqXUKaKZkDd4k8ds89Dbfn5vNoA==
=ayJ3
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--


