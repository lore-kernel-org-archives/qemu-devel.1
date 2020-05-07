Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0C0C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904EE20747
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTuKIU6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904EE20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWcLB-0005hV-IH
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 04:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jWcKB-00052I-Ru
 for qemu-devel@nongnu.org; Thu, 07 May 2020 04:56:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56323
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jWcKB-0002vP-8j
 for qemu-devel@nongnu.org; Thu, 07 May 2020 04:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588841769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ZcFMBSO2r6I2l7gmQUhlE6T3RNoSNKtmoo+A8a9WFk=;
 b=JTuKIU6+e0sEE/cRoF0LupBV1ljReHiZeLA8/y/Tuo9/ZBY7DQXkFwrSbnrELS+nn301ZN
 hEKnoDE0LCvP0LuJ6tZ7cUFVwYxhj8gU14mTw0LZijVxLLoIfoh4oiE/5O3JTDpA+JKSGx
 rrLr7Kk0ZEMzN0OVeNr20Ji0S6QyNsY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-t2J2uWtfM7CUb0WfTkg20A-1; Thu, 07 May 2020 04:56:07 -0400
X-MC-Unique: t2J2uWtfM7CUb0WfTkg20A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6598F100CCC1;
 Thu,  7 May 2020 08:56:06 +0000 (UTC)
Received: from localhost (ovpn-114-212.ams2.redhat.com [10.36.114.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9FDB63F90;
 Thu,  7 May 2020 08:56:05 +0000 (UTC)
Date: Thu, 7 May 2020 09:56:04 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 3/6] sysemu/block-backend: Document blk_read()/blk_pwrite()
Message-ID: <20200507085604.GC34079@stefanha-x1.localdomain>
References: <20200504094641.4963-1-philmd@redhat.com>
 <20200504094641.4963-4-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504094641.4963-4-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:15:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, Keith Busch <keith.busch@intel.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2020 at 11:46:38AM +0200, Philippe Mathieu-Daud=E9 wrote:
> +
> +/**
> + * blk_pread:
> + *
> + * @blk - the block backend where the buffer content is going to be read=
 from

s/ - /: /

> +
> +/**
> + * blk_pwrite:
> + *
> + * @blk - the block backend where the buffer content is going to be writ=
ten to

s/ - /: /

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6zzSQACgkQnKSrs4Gr
c8iKWgf9FoP34Es1I2wjfxBv1UiWFDRU9JMvdT50mtz1aklvaic1YH/Fcr34aWWY
UHkF/ld4yUSb0VUCow4TqPe1sRFCxc4swejfkrT280Cxd0mFmzcs7lfW4hs/rz2D
yB+kxciWBnWtEfOJyA4frU4p1JaENItLXaRM4M11bfY81mTTdqwlpHL0GEzSXKaW
qkEN3cxtdPJ+kyd8HM+LvLUZX8Dftc9OMNUS4hAymPfqkS2fJPpSe6sqWMuw9kt1
cYXf4eVcvuoMiKiW4x7Jqx2jzJz9215nmR94C3/a+YoooqlN9HjhU3fL4zft8paw
PeC/7tAhP/kqvl3kP7KC95qVDon1Dg==
=TNyJ
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--


