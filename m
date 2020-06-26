Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11063C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0C682078D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnI6tUry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C682078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jonaX-0005ug-2E
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 08:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jonZ6-0004Qt-CT
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:34:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21476
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jonZ3-0007Jt-KG
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593174881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eEoyBE6G06cr+2oVaK+MhtrccPq+DIAdo2+pklKZCM0=;
 b=MnI6tUryRvGhG2WY9TphadT65lg/CrtH+xbNGAhkJZdSvckoUXjmbWqdO6hEaJi+36NBXh
 YWNpfIzdiuekbImQvCILC9hRN4Q51IJbms50lzxREdSp+P8sK/t1046ouMxA/rsg+EbwYN
 BTNOUYLH74NoTmEXpTVtLDwpMwZW1Ao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-EpN9obpTOUy1aP4E87efKA-1; Fri, 26 Jun 2020 08:34:38 -0400
X-MC-Unique: EpN9obpTOUy1aP4E87efKA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F20418585AA;
 Fri, 26 Jun 2020 12:34:37 +0000 (UTC)
Received: from localhost (ovpn-114-181.ams2.redhat.com [10.36.114.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D758A121B80;
 Fri, 26 Jun 2020 12:34:36 +0000 (UTC)
Date: Fri, 26 Jun 2020 13:34:35 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 13/17] block/nvme: Simplify completion trace events
Message-ID: <20200626123435.GT281902@stefanha-x1.localdomain>
References: <20200625184838.28172-1-philmd@redhat.com>
 <20200625184838.28172-14-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200625184838.28172-14-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HjGz34yYE1BNnn/x"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:23:21
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--HjGz34yYE1BNnn/x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 08:48:34PM +0200, Philippe Mathieu-Daud=E9 wrote:
> The queues are tied to the hardware, logging the block
> driver using them is irrelevant.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c       | 6 +++---
>  block/trace-events | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)

This patch also needs to wait until there is a hardware state pointer
that can be included in the trace event.

--HjGz34yYE1BNnn/x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7161sACgkQnKSrs4Gr
c8hb7gf+OvK9oV3scqPQvSnMLy2oZJWOuVleQjYRtGnuYWuhZjjKBEWlkkd9Qt/X
qn0EeI5oJzeSgCIbS/SYiSVuQiYRYfaHweyp03xIUXHrXoJ/bAwtATWPzU2AJ8EQ
nkuK+Ddwfpbi/Gh5VC67J2gwdj3QmIYjgBcL87an3y+pvOUOCq8GiG+jkJbB0nIN
g3zKD5z/dg55BGueoM1SRrxJlycLhhcSo36DF+tKU0OnG/ObMBgkbZZPnVogSX7z
vhajES6+zShPzoKaqs34bPYh7WjLtcy4VEVvNhqfgffpGflYzFhD4uE6Y7D8zvQ1
fTP+5UKQemWozuxVSKOv9cBYboN0qg==
=kWdn
-----END PGP SIGNATURE-----

--HjGz34yYE1BNnn/x--


