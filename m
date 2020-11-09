Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC793C55ABD
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:43:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D0320719
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0XP2LIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D0320719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3iP-0002rT-Qa
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:43:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kc3hL-00021M-1J
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:42:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59135)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kc3hF-0001qk-Cg
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604914964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aPaTnidmVZl9q40qao8iD7a21PtuTj7Ia90GvQchCuA=;
 b=W0XP2LIARkfL7IPF50AinPM1DJlSc0urhi/GxlyEUuTXLQSYrzh9DQx+qXc47YpUiuTHui
 CymQGGTyqGoO9pgqZo3khTWZXAFuCAYvi5H/3ptwiUTR6YRuTgxVpxMVsMjBveK5u+XaU4
 ohF3JYX4YtfpPnzHR63FTqMbA+43irA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-Jus-ioMzMmOb4G6lN9CluA-1; Mon, 09 Nov 2020 04:42:42 -0500
X-MC-Unique: Jus-ioMzMmOb4G6lN9CluA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FF6B1007468;
 Mon,  9 Nov 2020 09:42:40 +0000 (UTC)
Received: from localhost (ovpn-114-110.ams2.redhat.com [10.36.114.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC59D5C26B;
 Mon,  9 Nov 2020 09:42:33 +0000 (UTC)
Date: Mon, 9 Nov 2020 09:42:32 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-6.0 v4 13/17] tests/docker: Install lttng-ust-devel
 package in Fedora image
Message-ID: <20201109094232.GB783516@stefanha-x1.localdomain>
References: <20201108204535.2319870-1-philmd@redhat.com>
 <20201108204535.2319870-14-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201108204535.2319870-14-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 08, 2020 at 09:45:31PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Install the lttng-ust-devel package to be able to
> build QEMU using the User-Space Tracer trace backend
> (configure --enable-trace-backends=3Dust).
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Daniel P . Berrange <berrange@redhat.com>
> ---
>  tests/docker/dockerfiles/fedora.docker | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+pDwgACgkQnKSrs4Gr
c8j38AgAtD+ocMgFiaQ5hjQt/If06x4swEED4NGbpAIAvoW5exdqZ4LFGS23cr+X
YQibC3xbk02OImR0LkfxiVuuHEaIq/wyHMJKzN6SJCjWhqEfX2OkwS32J3d/Gbmy
BlmUVN0U4vUHMcHnYUcUohpvmK12QPucsUG8bit1G9Kws1aPApXhTcK48VmO/FSS
/HWgGQGCIufUohkbBPl9CdVt2kEqkZuLAeYPH92ONw6vsohfZ+b2Z0j0jBW9gdPw
1euSvt7W98l0ike9MeoyBrcnqmI2GafdXejuOLH/spSAYHjtOTk4VjXIh178SFxu
paFrfEWfGwq+E7VywjItuZBXVkF1lQ==
=EPm2
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--


