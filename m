Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0405FC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 15:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 408DA223BF
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 15:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ngc4SzaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408DA223BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVcZb-0001o8-8c
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 11:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVcYA-0000V1-9J
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 11:30:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVcY7-00057d-BM
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 11:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603380637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eUWKfedgC1ygmqLT7h5HFqwAMkcl40Lvw3KztGO5oog=;
 b=Ngc4SzaBSAzoBu9j36dutfmL0Q8Ys28mSoLpLhbtEJJcBbAY2aTTagPkXDVeG8SDTO5nF6
 8gW+lzsXQLEYaNg2eXw1wNDuHYKbAodo3MeFgbMXGJC9oVUOJIXW2b37fXgc6o+ijLO1u9
 g4oOylTBvr1CxJ6uc0Ub8Kb/IX12Wx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-YRZ2g234MomzxUkD19RLNw-1; Thu, 22 Oct 2020 11:30:32 -0400
X-MC-Unique: YRZ2g234MomzxUkD19RLNw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7995A18CB720;
 Thu, 22 Oct 2020 15:30:30 +0000 (UTC)
Received: from localhost (ovpn-114-229.ams2.redhat.com [10.36.114.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3E235D9F1;
 Thu, 22 Oct 2020 15:30:29 +0000 (UTC)
Date: Thu, 22 Oct 2020 16:30:28 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Cover "block/nvme.h" file
Message-ID: <20201022153028.GS761187@stefanha-x1.localdomain>
References: <20200701140634.25994-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200701140634.25994-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8DtChEGCcMdSgkU2"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:33:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Keith Busch <kbusch@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--8DtChEGCcMdSgkU2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2020 at 04:06:34PM +0200, Philippe Mathieu-Daud=E9 wrote:
> The "block/nvme.h" header is shared by both the NVMe block
> driver and the NVMe emulated device. Add the 'F:' entry on
> both sections, so all maintainers/reviewers are notified
> when it is changed.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
> Cc: Fam Zheng <fam@euphon.net>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
> Cc: Klaus Jensen <its@irrelevant.dk>
> Cc: Klaus Jensen <k.jensen@samsung.com>
> Cc: Maxim Levitsky <mlevitsk@redhat.com>
> Cc: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
> Cc: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)

Thanks, applied to my block-next tree:
https://gitlab.com/stefanha/qemu/commits/block-next

Stefan

--8DtChEGCcMdSgkU2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+RpZQACgkQnKSrs4Gr
c8gt8Qf/aCSIIrYna9feywyGSCpxcw8+qHPGO2qTz2SYK9iCkypfivJPC+MmuYe5
M8zQUKAzBqepB+QmBbEBnrRtHGmCicUfgPRaiWQpAnn0ne/2LqP2KZ7osnAifsZ2
Nfc/HPQ3432UjCHzf920LByLzLS+XYQW9nSudoxgLn+cr6oWqbl4m5lnDwmWSbEg
QLLYBDk8ZrIw/6oVphv1LVquxzKoUfDkZ0KLVt9pJilFAxwS2nCzridXx6Yp4n/A
czXWRH4CHJyV4WXyUkF6buUg2EDEJIVr12thJ7npNf9fxINTpEYEyVe17l/77VXU
NoEn9KegpS2y5CjAxIWOpfjXKW56hA==
=Ree6
-----END PGP SIGNATURE-----

--8DtChEGCcMdSgkU2--


