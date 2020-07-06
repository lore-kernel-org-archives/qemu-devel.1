Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30784C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF01C2073E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZEfINC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF01C2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsOS0-0005fi-8P
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 06:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsOQK-0004EF-18
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:32:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22266
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsOQI-0000EY-0L
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594031548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tck+FYb3MzmUZGZImWPXD/wpFI9mFcNKufwgm2E/s88=;
 b=BZEfINC0NAQ+J+z8LggmmMxnx87GjushtsUo5Fj0yNoR5WptW3283+fsMXPSNpUuyQdFay
 2qQi7l3aG6f82pR6ijiKVvMLG1+XiuiWREOOAvC+0eyekfonCq8WBKzYez/Ebtz5Cyov/P
 IQVvVbr2Jil6V56YE0mLLHsBwisP+KU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-F-tit_QYNtyNGSupqdATNQ-1; Mon, 06 Jul 2020 06:32:26 -0400
X-MC-Unique: F-tit_QYNtyNGSupqdATNQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 411318015CB;
 Mon,  6 Jul 2020 10:32:25 +0000 (UTC)
Received: from localhost (ovpn-114-217.ams2.redhat.com [10.36.114.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB9321A912;
 Mon,  6 Jul 2020 10:32:24 +0000 (UTC)
Date: Mon, 6 Jul 2020 11:32:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 05/16] block/nvme: Improve error message when IO queue
 creation failed
Message-ID: <20200706103223.GA342708@stefanha-x1.localdomain>
References: <20200704213051.19749-1-philmd@redhat.com>
 <20200704213051.19749-6-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704213051.19749-6-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:59:39
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 04, 2020 at 11:30:40PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Do not use the same error message for different failures.
> Display a different error whether it is the CQ or the SQ.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8C/bcACgkQnKSrs4Gr
c8h56wgAhlRadzVTbXh2OYgHpSFLN71mn/titI8drL6VSTYtAuZqkQd/INn7zbyc
F9TK41z3mPJMtSUv85PB/vHAA+UDrIDgHamnjIklYZXVoJLdk+2VP4JMwXd8KC3V
D2g/sTIVEUyurP25QN7Iz5w+NJAugPq9I+FYV6ivmZOljoDQibjTnDPTKs4ka4z5
0g1LZ1hl3L6vT3e7+WtohUgIFAYA6FA+C3/B/Ey7YTQrEDB91qY6vXoGd/jcpAm+
430C5hWc097H/lHDGsxRU/tC9jkAiI85Y8R4F2g/qyOfyFEUKXNYsTZQSmG38Yst
8vzn8gBZcfJ39BlxTDnWLQ4Amm07Mw==
=r/mC
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--


