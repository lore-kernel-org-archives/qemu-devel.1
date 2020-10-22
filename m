Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59740C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 15:35:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D7EC2463D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 15:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glf8IF/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7EC2463D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVccy-0004gE-CP
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 11:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVcYd-0001Jk-RD
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 11:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVcYc-0005HN-5x
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 11:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603380673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BjODGfKgO1AJcnTO84ymmjC8s/l5l002arq+MPuz0Q0=;
 b=glf8IF/9ejgfg5Ersz8MFcdyIW41fSM1Gm/ViQHqW4MRJp7gRn+9CSMD6K5y5X20lmRgxK
 00VGtIaf8ZUvJ0q1x0ArsbpZy9AU/QoPanMDK/fY3Mb2th1Nr6znxtLsosQ2Bby+3AiYyX
 HGUqamY0cdgHarVSBDbxG8vXoTw2UKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-IDoW-0YaNyKu2cGoKn2Yew-1; Thu, 22 Oct 2020 11:31:04 -0400
X-MC-Unique: IDoW-0YaNyKu2cGoKn2Yew-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1061118FE860;
 Thu, 22 Oct 2020 15:31:03 +0000 (UTC)
Received: from localhost (ovpn-114-229.ams2.redhat.com [10.36.114.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A66235B4A1;
 Thu, 22 Oct 2020 15:31:02 +0000 (UTC)
Date: Thu, 22 Oct 2020 16:31:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH] MAINTAINERS: Update nvme entries
Message-ID: <20201022153101.GT761187@stefanha-x1.localdomain>
References: <20201022090045.158261-1-its@irrelevant.dk>
MIME-Version: 1.0
In-Reply-To: <20201022090045.158261-1-its@irrelevant.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VjP/dwTbBl6I9PQk"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:09:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--VjP/dwTbBl6I9PQk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2020 at 11:00:45AM +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Make sure that maintainers of both the nvme block driver and the
> emulated nvme device is notified about changes to the shared nvme.h.
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)

Thanks, Klaus! I have applied the earlier patch you mentioned to my
block-next tree.

Stefan

--VjP/dwTbBl6I9PQk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+RpbUACgkQnKSrs4Gr
c8jVEQf+NtNKpcS9wNf0mC0X2qTYl4Vah63PPE59joxR7+HXDoN3Y66C7jLPIgfO
B6RsMNdoWlErMoZxjCcHREeT0nMW/UixHIAb5JNUa6UGzb3jOuk0nnkNjzTlqMiv
BrB0t/rIykeIRULqI7FaIb+VYZLjR5eNb3y2aQtN4cZjAJtV85u3QhTTLgQ90ChA
5RmwjggTKx1qMOQQJ2cOyNbacpwfqIfYPvCa/PZW/2fRWJp7RGTIGfWlh8cWpTDg
6TX0FdOZ+sAbZnhjksWCgAcuceox4BsrUla+1UmwK8Fo1Ibl0K/TIjqEoEHLBQyq
7idqJz5BfvTUtXjbMwzB6TbM2ig6IQ==
=RVUI
-----END PGP SIGNATURE-----

--VjP/dwTbBl6I9PQk--


