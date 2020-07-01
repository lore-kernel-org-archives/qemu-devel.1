Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220D0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4FB9206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnBVZMNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FB9206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqf3T-0003mI-6H
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqezC-0006EQ-1e
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:49:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30261
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqezA-00017y-JI
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593618559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NLQant1KrBIZMDf7zUmnSCuITPj8QX5hg0iDvuzyH2s=;
 b=BnBVZMNHvS+rXx5UMYFb+t9+2nm+6Ie5B6hvK8a+67BbQ4gfkHZGklKTjxRzApCdRQa5t+
 Ee77xGGI+12+tf0WrrALrbnoTlOkNr4UAaixdYKhTIPyWPin4VjpZtlbXCCUUFe/z3gs/q
 aYA6c6GWhcbu2cemari+nx5vD1RdJCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-nnvqiiepONWo72T2dvogWw-1; Wed, 01 Jul 2020 11:49:15 -0400
X-MC-Unique: nnvqiiepONWo72T2dvogWw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 160501B2C983;
 Wed,  1 Jul 2020 15:48:59 +0000 (UTC)
Received: from localhost (ovpn-113-121.ams2.redhat.com [10.36.113.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9DC898ACE2;
 Wed,  1 Jul 2020 15:48:58 +0000 (UTC)
Date: Wed, 1 Jul 2020 16:48:57 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 02/12] block/nvme: Avoid further processing if trace
 event not enabled
Message-ID: <20200701154857.GO126613@stefanha-x1.localdomain>
References: <20200630191318.30021-1-philmd@redhat.com>
 <20200630191318.30021-3-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200630191318.30021-3-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1bhFRg6vL9BT9osV"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
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

--1bhFRg6vL9BT9osV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2020 at 09:13:08PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Avoid further processing if TRACE_NVME_SUBMIT_COMMAND_RAW is
> not enabled. This is an untested intend of performance optimization.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--1bhFRg6vL9BT9osV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl78sGkACgkQnKSrs4Gr
c8jAxQgArYh0xjCWQf3aMSvTFox352lla0p77bkLKNb4PxDvZ0JIlxyB9DzXgRh8
+bGrtS4KqyxqiEJTzKMAId4Adbu85UvAXuCd7Eny9aB0+gy05UceG2ixWeJdDoLT
PzA+UFv4KHvR3KJivDaMV/WXRHc5wPXIcqiXbSEMI02V88qip1sL2P4wv3UVChBQ
7+vhp4ChC/phi6jkVjgePUb1Vk3jfxAaczVDvNI3Pynkz3AurzyFPuAtVIXSxDco
8jDEY7F1++ZkDwSM+p3cKd4Id1eqcVhGoR4mtMGcloLEN/TcBtR9OkDP2T2yf88t
nvWPAiQX0lYdXIjAGAkUd5gpTL/wvA==
=eFBI
-----END PGP SIGNATURE-----

--1bhFRg6vL9BT9osV--


