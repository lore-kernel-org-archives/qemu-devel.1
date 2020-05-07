Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7D8C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D42D2075E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTN1IAFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D42D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWcNN-0007ku-PL
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 04:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jWcMN-0006U1-Qf
 for qemu-devel@nongnu.org; Thu, 07 May 2020 04:58:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35893
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jWcMM-0004Xy-LZ
 for qemu-devel@nongnu.org; Thu, 07 May 2020 04:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588841906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=walFX1WbzW0pK8fby1JmdvvX574fA8AW042JipgWDRM=;
 b=YTN1IAFhHuQOucjzrygVIMyE/CpBl+TrsX98O/72CKGRfoZ1y0j/gD5JCsFsGnEf8FmLTO
 JoXUQ9PzBAsTkbLyrx12Y4u3yFazpM/aPyXG06Zw4oYHJNg7m5xL97icEktlP8+zID5B+E
 qfwOCULdTdTQ2VEL2M7bnvhyymcgXfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-m4a5jWMiNNGlevMqGIWzbQ-1; Thu, 07 May 2020 04:58:23 -0400
X-MC-Unique: m4a5jWMiNNGlevMqGIWzbQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C40C835B46;
 Thu,  7 May 2020 08:58:22 +0000 (UTC)
Received: from localhost (ovpn-114-212.ams2.redhat.com [10.36.114.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B62355C221;
 Thu,  7 May 2020 08:58:21 +0000 (UTC)
Date: Thu, 7 May 2020 09:58:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 2/6] qemu/bitmap: Document bitmap_new() returned pointer
Message-ID: <20200507085820.GE34079@stefanha-x1.localdomain>
References: <20200504094641.4963-1-philmd@redhat.com>
 <20200504094641.4963-3-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504094641.4963-3-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2020 at 11:46:37AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  include/qemu/bitmap.h | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6zzawACgkQnKSrs4Gr
c8jbAQgApCFKuAS7ftivtUaMLB2zeHhdT2tejvyvekFdlLU3h94edra4CE16/4Ks
HoBJfeH3q6SNQL45aXh5gJ8kLE0ZvxzNs3cFemwB8/7rufpUyRYJLsc6WSYNSx4t
UPj2st5VDTNcA987Hpvwa2qH0gKBW4dTPjFqfi5Qvmn28eiJxyTxm1blY1vH12et
xHO/0h2HoktKz3iq4cT8Sw6jZb2UKXa3y83oMsuzPS1U8o5y9OtKEoI4b/VsIFup
XEnnCf9ZtrvqYhle/8W+CNcACY1EmKPb4dmtyv5OjOVqRmwq5KVbfiCjQ/njAsRa
Si99utxiUb609Dq1fgLBG0Saox80kQ==
=A07w
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--


