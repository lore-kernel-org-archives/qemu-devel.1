Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E08C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE82A20720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PY91f7/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE82A20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsUg-0005uf-41
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 08:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jtsTz-0005Qn-7W
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:50:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39026
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jtsTx-0007BH-O2
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594385424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O9uk1YEQkSGeb3X+mw8Vu/iL9x7qAn7jB1eIWXkTdic=;
 b=PY91f7/Grhmd101jP5yIOlb/EdKQZ+DHXDJ43s0aofUhKTt/Qh5uOthGNTMcFTjn2+7xwn
 YwvCbsx41Z4uusuoSP/jYSOKc1YdbBh4SRzNQuAstHSqqL3Hr2BHojUo/54oO/ctpLWSIK
 /7U7s1ULX+fei0gKuONYa804k7Ny6UU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-0ngP4ucKM-OzeHWuRtzspw-1; Fri, 10 Jul 2020 08:50:22 -0400
X-MC-Unique: 0ngP4ucKM-OzeHWuRtzspw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54F241902EA1;
 Fri, 10 Jul 2020 12:50:21 +0000 (UTC)
Received: from localhost (ovpn-114-251.ams2.redhat.com [10.36.114.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C36E1CA;
 Fri, 10 Jul 2020 12:50:17 +0000 (UTC)
Date: Fri, 10 Jul 2020 13:50:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] Remove the CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE switch
Message-ID: <20200710125016.GA8433@stefanha-x1.localdomain>
References: <20200710045515.25986-1-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200710045515.25986-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 23:35:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 06:55:15AM +0200, Thomas Huth wrote:
> GCC supports "#pragma GCC diagnostic" since version 4.6, and
> Clang seems to support it, too, since its early versions 3.x.
> That means that our minimum required compiler versions all support
> this pragma already and we can remove the test from configure and
> all the related #ifdefs in the code.
>=20
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Keep the !defined(__clang__) in coroutine-ucontext.c
>=20
>  configure                 | 29 -----------------------------
>  include/ui/gtk.h          |  4 ----
>  include/ui/qemu-pixman.h  |  4 ----
>  scripts/decodetree.py     | 12 ++++--------
>  ui/gtk.c                  |  4 ----
>  util/coroutine-ucontext.c |  4 ++--
>  6 files changed, 6 insertions(+), 51 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8IZAYACgkQnKSrs4Gr
c8iD0gf8DHhkLqQFH2xcybKvp5+098mzmQbNNysxUaAS2mK6pJg5fUX3sb2YDtpF
GT16MPe7tWgyc01c/YLzrfp9vs2yZ8mkfBXW7bzdjw71qN9W+u4AwMKGUNb+RWFW
BVw5gwU8Wy/bBVhzvenV0nqY43WiOFdi9mtEtLKD35blSz9ZqNeHDRPVGF44SslZ
436TENXB/ZnonOZFOkHSiYUPnYSSVlCo/ECbufiQnXXezzncRMPQ/xk5UICpvmL4
K2uiiqJaK//0JzJYUKTNOlPGRy1lsmcIHjOf4mk4sfvY70O2mhcbyGiJRr2M4yWs
oeQfTi6PiAWfXJn3DAQ7y33tqUn1vQ==
=Po3J
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--


